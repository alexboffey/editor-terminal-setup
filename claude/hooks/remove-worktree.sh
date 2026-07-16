#!/bin/bash
# WorktreeRemove hook: clean up worktrees created by create-worktree.sh
# (fire-and-forget; must never block)
WT=$(jq -r '.worktree_path')
case "$WT" in
    "$HOME/CheckpointGG/.worktrees/"*)
        git -C "$WT" worktree remove --force "$WT" 2>/dev/null || rm -rf "$WT"
        ;;
esac
exit 0
