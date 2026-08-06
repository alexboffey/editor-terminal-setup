#!/bin/bash
# WorktreeCreate hook: create worktrees in ~/CheckpointGG/.worktrees/<repo>/<name>
# instead of .claude/worktrees inside the repo. Stdout must be ONLY the path.
#
# Branches are created as `boff/<name>` (name = short branch description or Linear
# ticket, e.g. `boff/eng-6726` or `boff/rebrand-chart-palettes`). The worktree
# directory stays flat (just <name>) so a slash never nests directories.
set -euo pipefail

INPUT=$(cat)
CWD=$(jq -r '.cwd' <<<"$INPUT")
BASE_REF=$(jq -r '.base_ref // empty' <<<"$INPUT")
DETACH=$(jq -r '.detach // false' <<<"$INPUT")
NAME=$(basename "$(jq -r '.worktree_path' <<<"$INPUT")")

REPO=$(basename "$(git -C "$CWD" rev-parse --show-toplevel)")
DEST="$HOME/CheckpointGG/.worktrees/$REPO/$NAME"
[ -e "$DEST" ] && DEST="$DEST-$$"
mkdir -p "$(dirname "$DEST")"

# basename strips any path, so NAME is always a bare segment — prefix it.
BRANCH="boff/$NAME"

# git chatter must not land on stdout — only the path may
if [ "$DETACH" = "true" ]; then
    git -C "$CWD" worktree add --detach "$DEST" ${BASE_REF:+"$BASE_REF"} 1>&2
else
    # create boff/<name>; else attach an existing boff/<name>; else attach an
    # existing branch named <name> verbatim (e.g. a base branch passed by name)
    git -C "$CWD" worktree add -b "$BRANCH" "$DEST" ${BASE_REF:+"$BASE_REF"} 1>&2 \
        || git -C "$CWD" worktree add "$DEST" "$BRANCH" 1>&2 \
        || git -C "$CWD" worktree add "$DEST" "$NAME" 1>&2
fi

echo "$DEST"
