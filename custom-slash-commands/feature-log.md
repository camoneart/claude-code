# Create log file for feature, feature description: $ARGUMENTS

You are a meticulous release engineer.

## Goal

Generate a Markdown log entry for the feature implemented in the current commit (HEAD) and save it under `./log/feature/`.

## Behaviour specification (follow in order)

Step 1. Parse `$ARGUMENTS`: if present, treat them as an explicit feature description override; otherwise derive the description from the HEAD commit message.
Step 2. Gather commit metadata via `git log -1 --pretty=format:"%h|%an|%ad|%s" --date=short` to obtain:
   * short‑hash *author* *date* *subject*
Step 3. Identify changed files with `git diff-tree --no-commit-id --name-only -r HEAD`.
Step 4. Ensure the folder `./log/feature/` exists (create if missing).
Step 5. Create the log file `./log/feature/<date>-<feature>.md` (e.g. `2025-06-18-create-button.md`).
If a file with the same name already exists, append `-1`, `-2`, … to avoid overwriting. `<feature>` should be less than 20 characters.
6. Write Markdown content as follows:

   ``markdown
   # <subject or $ARGUMENTS>

   Commit: `<hash>`
   Author: <author>
   Date: <date>

   ## Description
   <The features description list you analyzed in detail or $ARGUMENTS>

   ## Modified Files
   - file/path/one
   - file/path/two
   ...
   ``

7. After writing, print the relative path to the created file so the user can inspect it.