# Changelog

All notable changes to this project are tracked here. Dates come from commit history; newest changes appear first.

## 2025-12-11
- fix: remove redundant semicolon in the `kube` function for improved clarity.
- docs: refreshed README and added this changelog for quick update visibility.

## 2025-12-10
- feat: allow `fix-forbidden` to accept an optional service account parameter.

## 2025-11-26
- feat: fix small input handling issue.

## 2025-11-25
- feat: replace kubectl-admin with the consolidated `kube`/`kube.bat` entrypoint.
- feat: add `kube list` as a shortcut for `kubectl config get-contexts`.
- feat: define the `kube` command structure and update command references.
- feat: add default admin service account creation.
- feat: add fast admin-side kubectl helpers.
- Initial commit.
