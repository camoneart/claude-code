Find and fix issue #$ARGUMENTS. Follow these steps:

1. **FIRST** check if issue is open: `gh issue view $ARGUMENTS --json state -q .state` (must be "OPEN")
2. **IMMEDIATELY** create branch: `git checkout -b fix-issue-$ARGUMENTS` (DO THIS BEFORE ANY OTHER WORK!)
3. Now read issue details: `gh issue view $ARGUMENTS` to understand the issue
4. Locate the relevant code in our codebase
5. Implement a solution that addresses the root cause
6. Add appropriate tests if needed
7. Commit changes with proper commit message
8. Push the branch and create a PR using `gh pr create`
9. Prepare a concise PR description explaining the fix

**CRITICAL**: Always create the branch (step 2) immediately after confirming the issue is open. This prevents accidental commits to main branch.