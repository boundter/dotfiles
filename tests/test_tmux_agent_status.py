"""Regression coverage for the terminal UI signatures used by the status helper.

Run with: python3 -m unittest discover -s tests -p 'test_tmux_agent_status.py'
"""

import importlib.machinery
import importlib.util
from pathlib import Path
import unittest
from unittest.mock import patch


loader = importlib.machinery.SourceFileLoader(
    "agent_status", str(Path(__file__).resolve().parents[1] / "bin/tmux-agent-status")
)
spec = importlib.util.spec_from_loader(loader.name, loader)
status = importlib.util.module_from_spec(spec)
loader.exec_module(status)

KIRO_IDLE = """
• Done.
▸ Credits: turn 3.27 • session 21.28 | Time: 1m 21s
─────────────────────────────
Default · auto · ◔ 14%                  ~/code/project · (main)

›  ask a question or describe a task ↵
          /sessions to resume · /copy to clipboard
"""
KIRO_BUSY = """
• Shell pytest
    running tests
  esc to cancel
─────────────────────────────
Default · auto · ◑ 38%                  ~/code/project · (main)
›  Kiro is working · 56s · Type to steer · Ctrl+S to queue
"""
CODEX_IDLE = """
• Finished the change.
› Ask Codex to do anything
  GPT-6.1-Sol medium · Context 91% left · ~/code/project · main
  ? for shortcuts
"""
CODEX_BUSY = """
• Working (1m 30s • esc to interrupt)
  └ Tip: Use /permissions to control when Codex asks for confirmation.

› Ask Codex to do anything
  GPT-6.1-Sol medium · Context 91% left · ~/code/project · main
  ? for shortcuts
"""
KIRO_APPROVAL = """
Summarize the issue requires approval
shell → jira issue view TEST-123 --raw
❯ Allow
  Always allow
  Deny
  Always deny
─────────────────────────────
esc to close · ↑↓ to navigate · ↵ to select · Tab to edit
"""
KIRO_SUBAGENT_APPROVAL = """
• Orchestrating (1 agent)
  esc to cancel
  ctrl+g open agent monitor
  • Re-review cycle 3: confirm… general-task-execution Read ⚠ tool approval needed
─────────────────────────────
⚠ 1 tool approval pending
❯ (a) Approve all pending
  (f) Approve all pending and auto-approve future subagent requests
  (c) Configure individually (agent monitor)
  (x) Exit (cancel subagents)
"""


class PromptTests(unittest.TestCase):
    def test_idle_agents(self):
        for agent, screen in [("kiro", KIRO_IDLE), ("codex", CODEX_IDLE)]:
            with self.subTest(agent=agent):
                self.assertTrue(status.waiting(agent, screen))

    def test_busy_agents_have_editable_composers_but_are_not_waiting(self):
        for agent, screen in [("kiro", KIRO_BUSY), ("codex", CODEX_BUSY)]:
            with self.subTest(agent=agent):
                self.assertFalse(status.waiting(agent, screen))

    def test_typed_drafts_are_still_waiting(self):
        self.assertTrue(status.waiting("kiro", KIRO_IDLE.replace(
            "ask a question or describe a task ↵", "Please review the diff"
        )))
        self.assertTrue(status.waiting("codex", CODEX_IDLE.replace(
            "Ask Codex to do anything", "Please review the diff"
        )))

    def test_kiro_approval_takes_precedence_over_busy_composer(self):
        screen = KIRO_BUSY + "\n[y] allow once · [t] trust scope · [n] deny · [tab] add note\n"
        self.assertTrue(status.waiting("kiro", screen))

    def test_kiro_allow_deny_approval_picker(self):
        for choice in ("Allow", "Always allow", "Deny", "Always deny"):
            with self.subTest(choice=choice):
                lines = [line.strip().removeprefix("❯ ") for line in KIRO_APPROVAL.splitlines()]
                menu = "\n".join("❯ " + line if line == choice else line for line in lines)
                self.assertTrue(status.waiting("kiro", KIRO_BUSY + menu))

    def test_kiro_old_approval_picker_does_not_mark_running_agent_waiting(self):
        self.assertFalse(status.waiting("kiro", KIRO_APPROVAL + KIRO_BUSY))

    def test_kiro_allow_deny_prose_without_picker_footer_is_not_approval(self):
        self.assertFalse(status.waiting("kiro", "❯ Allow\nAlways allow\nDeny\nAlways deny"))

    def test_kiro_subagent_approvals_override_orchestration_status(self):
        for count in (1, 3):
            with self.subTest(count=count):
                screen = KIRO_SUBAGENT_APPROVAL.replace(
                    "1 tool approval pending", f"{count} tool approval{'s' if count > 1 else ''} pending"
                )
                self.assertTrue(status.waiting("kiro", screen))

    def test_kiro_subagent_approval_clears_after_resume(self):
        # The previous panel may still be in the visible output after resume.
        self.assertFalse(status.waiting("kiro", KIRO_SUBAGENT_APPROVAL + KIRO_BUSY))

    def test_kiro_task_run_approval_variants(self):
        for label in ("Approve once", "Approve these 3 requests"):
            with self.subTest(label=label):
                screen = KIRO_SUBAGENT_APPROVAL.replace("Approve all pending", label)
                self.assertTrue(status.waiting("kiro", screen))

    def test_kiro_subagent_approval_banner_requires_live_actions(self):
        self.assertFalse(status.waiting("kiro", "⚠ 1 tool approval pending"))

    def test_codex_approval(self):
        screen = """
Would you like to run the following command?
$ make test
› 1. Yes, proceed (y)
  2. No, and tell Codex what to do differently (esc)
Press enter to confirm or esc to cancel
"""
        self.assertTrue(status.waiting("codex", screen))

    def test_structured_questions(self):
        self.assertTrue(status.waiting("kiro", "Which option?\n↑/↓ to navigate · ↵ to submit"))
        self.assertTrue(status.waiting("codex", "Which option?\n› 1. A\nEnter to submit"))

    def test_old_prompts_do_not_mark_busy_agents_waiting(self):
        padding = "unrelated output\n" * 30
        self.assertFalse(status.waiting("kiro", KIRO_IDLE + padding + KIRO_BUSY))
        self.assertFalse(status.waiting("codex", CODEX_IDLE + padding + CODEX_BUSY))

    def test_prose_and_empty_screens_do_not_count(self):
        for agent in ("kiro", "codex"):
            self.assertFalse(status.waiting(agent, ""))
            self.assertFalse(status.waiting(agent, "How would you like to land these?"))


class PaneTests(unittest.TestCase):
    def test_multiple_subagent_approvals_count_as_one_pane(self):
        screen = KIRO_SUBAGENT_APPROVAL.replace("1 tool approval pending", "3 tool approvals pending")
        panes = "%10\t0\tkiro-cli\t/dev/pts/1\t0\n"
        with patch.object(status, "run", side_effect=[panes, screen]):
            self.assertEqual(status.waiting_panes("@7"), ["0"])

    def test_pane_indicator_does_not_count_its_neighbours(self):
        panes = "%10\t0\tcodex\t/dev/pts/1\t0\n%11\t1\tkiro-cli\t/dev/pts/2\t0\n"
        with patch.object(status, "run", side_effect=[panes, KIRO_IDLE]):
            self.assertEqual(status.waiting_panes("%11"), ["1"])

    def test_counts_all_panes_in_target_window_and_skips_dead_panes(self):
        def run(*args):
            if args[1] == "list-panes":
                self.assertIn("@7", args)
                return (
                    "%10\t0\tcodex\t/dev/pts/1\t0\n"
                    "%11\t1\tkiro-cli\t/dev/pts/2\t0\n"
                    "%12\t2\tcodex\t/dev/pts/3\t0\n"
                    "%13\t3\tzsh\t/dev/pts/4\t0\n"
                    "%14\t4\tcodex\t/dev/pts/5\t1\n"
                )
            return {"%10": CODEX_IDLE, "%11": KIRO_IDLE, "%12": CODEX_BUSY}[args[-1]]

        with patch.object(status, "run", side_effect=run):
            self.assertEqual(status.waiting_panes("@7"), ["0", "1"])

    def test_node_launcher_and_unrelated_node_process(self):
        with patch.object(status, "run", return_value="node node /srv/server.js\n"):
            self.assertIsNone(status.agent_for_pane("node", "/dev/pts/1"))
        with patch.object(status, "run", return_value="codex /opt/codex/codex\n"):
            self.assertEqual(status.agent_for_pane("node", "/dev/pts/1"), "codex")
        with patch.object(status, "run", return_value="bun bun /home/user/.local/share/kiro-cli/tui.js\n"):
            self.assertEqual(status.agent_for_pane("bun", "/dev/pts/1"), "kiro")

    def test_invalid_window_or_missing_tmux_server_is_quiet(self):
        self.assertEqual(status.waiting_panes("invalid"), [])
        with patch.object(status, "run", return_value=""):
            self.assertEqual(status.waiting_panes("@7"), [])


if __name__ == "__main__":
    unittest.main()
