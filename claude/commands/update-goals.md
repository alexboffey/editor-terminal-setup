Update my Goals Progress file at `/Users/alexboffey/Documents/Obsidian Vault/GEEIQ/1-1 Meetings & Goals/Goals Progress.md` with any new work not already recorded.

To find new work:
1. Query Linear for issues assigned to me (`assignee: me`) that have been completed since the most recent date in the Examples sections of the file.
2. Check git log on the engineering-handbook repo at `/Users/alexboffey/CheckpointGG/engineering-handbook` for new docs committed since that same date: `git -C /Users/alexboffey/CheckpointGG/engineering-handbook log --oneline --since="YYYY-MM-DD" --name-only --diff-filter=A`

Map findings to goal sections using this rubric:
- RFC / planning docs / risk docs / project planning tickets → **1.1 Planning & Organisation**
- AWS training / infrastructure tickets → **1.2 Learning About Infrastructure**
- Architecture, tests, stability work → **2.1 Frontend Stability**
- engineering-handbook markdown files / docs tickets → **2.2 Documentation**
- Storybook stories / chromatic / design system component work → **2.2 Better Use of Storybook**
- Code quality, reviews, design system, brand / rebrand work → **3.1 Increasing Frontend Quality**

Rules for updating the file:
- Only append new numbered examples under the `### Examples` heading of each relevant section - never edit existing content
- Date format: `(D/M/YY)` matching existing entries (e.g. `(9/4/26)`)
- Each entry format: `N. Description (D/M/YY): URL`
- Skip sections with no new work
- Update the `*Last edited: D/M/YY*` line at the top of the file to today's date
