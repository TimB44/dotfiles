#!/usr/bin/env -S uv run
# /// script
# dependencies = ["networkx"]
# ///
"""Generate bash commands for rebasing stacked branches.

Outputs bash script to stdout which is then executed.
Supports branches with single or multiple parents.
"""

import sys
import networkx as nx

# Branch DAG Configuration
BRANCH_DAG: dict[str, list[str]] = {
    "linux": ["main"],
    "master_trunk": ["main"],
    "work": ["linux", "master_trunk"],
}


def main(triggered_branch: str) -> None:
    """Generate rebase commands."""
    print("set -ex")
    print("echo 'Branch Stacking Auto-Rebase'")
    print()

    G = nx.DiGraph(
        (parent, child) for child, parents in BRANCH_DAG.items() for parent in parents
    )

    if triggered_branch not in G:
        print("echo 'No descendants to rebase'")
        print("exit 0")
        return

    descendants = list(nx.descendants(G, triggered_branch))
    if not descendants:
        print("echo 'No descendants to rebase'")
        print("exit 0")
        return

    sorted_branches = [b for b in nx.topological_sort(G) if b in descendants]
    branches_set = set(sorted_branches)

    for branch in sorted_branches:
        parents = BRANCH_DAG[branch]
        print()
        print(f"echo 'Rebasing {branch} onto {' + '.join(parents)}'")
        print(f"git checkout {branch}")

        if len(parents) == 1:
            # Single parent - git rebase handles merge-base automatically
            parent = parents[0]
            new_base = parent if parent in branches_set else f"origin/{parent}"
            print(f"git rebase {new_base} || (git rebase --abort && exit 1)")
        else:
            # Multi-parent - use last merge commit as OLD_BASE
            print(f"OLD_BASE=$(git log {branch} --merges -n 1 --format=%H)")
            print(
                f'[ -z "$OLD_BASE" ] && echo "Error: {branch} needs merge commit" && exit 1'
            )

            # Create new merge base (use origin/ for branches not rebased in this run)
            parent_refs = [p if p in branches_set else f"origin/{p}" for p in parents]
            print(f"git checkout -b temp-new-base {parent_refs[0]}")
            merge_targets = " ".join(parent_refs[1:])
            print(
                f"git merge --no-ff -m 'New merge base' {merge_targets} || (echo 'Merge conflict' && exit 1)"
            )

            # Checkout back to original branch and rebase
            print(f"git checkout {branch}")
            print(
                f"git rebase --onto temp-new-base $OLD_BASE || (git rebase --abort && exit 1)"
            )
            print(f"git branch -D temp-new-base")

    # Push all rebased branches atomically
    print()
    print("echo 'Pushing all rebased branches'")
    branches_str = " ".join(sorted_branches)
    print(f"git push --atomic --force origin {branches_str}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("echo 'Error: Branch name required'")
        print("exit 1")
        sys.exit(1)
    main(sys.argv[1])
