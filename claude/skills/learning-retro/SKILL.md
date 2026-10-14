---
name: learning-retro
description: Use at the end of a learning or practice session with Claude, e.g. "review the session", "what did I learn today", "wrap up", "log today's progress", or when the user says they're done for the day in a practice repo. Summarises what was done and learned, measures progress, flags what to change in the plan, and updates the notes and logs.
argument-hint: "[optional focus]"
---

# Learning retro

Close out a practice session so the next one starts in the right place and the plan gets better. Pairs with `learning-plan`.

## 1. Gather

From the conversation and the repo (git log since the session started, `notes.md`, `grades.md`):

- What got done: exercises, questions or tasks passed, what's still open
- **Attempts per task.** Count how many tries each one took. A falling count across the session is the clearest evidence of progress, so show it
- Concepts met for the first time, and which ones needed the most hints (hint level reached)
- Time sinks: where the time went that wasn't the skill (setup, tooling, write-ups, review rounds)
- How the learner felt, only from what they said. Don't invent sentiment

## 2. Judge, briefly

- **Clicked:** what they can now do unaided
- **Shaky:** what to revisit, and when (the next exercise that uses it)
- **Change the plan?** Too slow, too much ceremony, too many new ideas at once, a tool hiding errors. Name the change, and edit the practice repo's `README.md`/`CLAUDE.md` if the learner agrees
- If it was a hard session: point at the concrete evidence of progress. No pep talk without numbers

## 3. Write it down

Ask once which of these they want, defaulting to all:

- **Exercise `notes.md`:** an iterations section (each attempt, what was wrong, the lesson), if it isn't there yet
- **A handwritten-note summary** in chat: the core rules from the session, one notebook page, a worked example in the teaching domain (not the exercise)
- **Vault log:** a dated entry (Done, Decisions, Next) at the top of the relevant log, for example `ab/career/Job Search/Log.md`, and a progress line on the roadmap item. Follow that folder's `_Index` rules
- **Next session:** two to four concrete first steps

## 4. Commit

Offer to commit and push the practice repo and the vault. Stage only the files touched. In the vault, never `git add -A`.

## Don'ts

- No recap of things the learner can see in the diff
- Don't grade here. Grading lives in the practice repo's `CLAUDE.md`
- Don't copy facts between notes. Link to the note that owns them
