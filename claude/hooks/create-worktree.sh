#!/bin/bash
# WorktreeCreate hook: create worktrees in ~/CheckpointGG/.worktrees/<repo>/<name>
# instead of .claude/worktrees inside the repo. Stdout must be ONLY the path.
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

# git chatter must not land on stdout — only the path may
if [ "$DETACH" = "true" ]; then
    git -C "$CWD" worktree add --detach "$DEST" ${BASE_REF:+"$BASE_REF"} 1>&2
else
    git -C "$CWD" worktree add -b "$NAME" "$DEST" ${BASE_REF:+"$BASE_REF"} 1>&2 \
        || git -C "$CWD" worktree add "$DEST" "$NAME" 1>&2
fi

echo "$DEST"
