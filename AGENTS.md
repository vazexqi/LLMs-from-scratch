# Repository guidance

## Environment

- Use the Nix development shell defined in `flake.nix`.
- With direnv enabled, run `direnv allow` once; subsequent directory entries
  load the shell and synchronize `.venv` automatically.
- Without direnv, use `nix develop path:.`, followed by
  `uv sync --all-groups --locked` when dependencies have changed.
- Run Python tools through the activated `.venv` or explicitly with `uv run`.
- Start notebooks with `jupyter lab` or
  `jupyter lab path/to/notebook.ipynb`.

## Dependencies

- Treat `pyproject.toml` as the source of truth for Python dependencies.
- Put dependencies needed by the main chapters in `project.dependencies`,
  development-only tools in the `dev` group, and optional chapter materials in
  the `bonus` group.
- After dependency changes, run `uv lock --python 3.12` and commit `uv.lock`.
- Keep Nix tooling in `flake.nix`; refresh `flake.lock` intentionally with
  `nix flake update`.

## Project layout and changes

- Chapter code and notebooks live under `ch02` through `ch07`; appendices live
  under `appendix-*`; the installable package and its tests live under
  `pkg/llms_from_scratch`.
- Keep examples readable and aligned with the educational style of nearby
  chapter material.
- Avoid committing generated models, datasets, notebook checkpoints, caches,
  or experiment outputs covered by `.gitignore`.
- Do not rewrite notebook outputs unless the task requires it.

## Validation

- Run the narrowest relevant test first, for example
  `uv run pytest path/to/test_file.py`.
- Run package tests with `uv run pytest pkg/llms_from_scratch/tests/` when
  shared package code changes.
- Run `uv run ruff check .` for Python changes.
- Validate environment changes with `nix flake check` and
  `uv sync --all-groups --locked`.
