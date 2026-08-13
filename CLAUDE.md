# Required Ricochet instructions

Before inspecting repository files, planning, editing, or running project commands, ensure the shared instructions are available.

1. Use `~/.cache/ricochet-rs/agent-instructions` as the shared checkout.
2. If the checkout is absent, clone `git@github.com:ricochet-rs/agent-instructions.git` there.
3. Fetch `origin/main` and check it out in detached-HEAD mode.
4. Verify that cached `HEAD` exactly matches `origin/main`.
5. Verify that `instructions/global.md`, `.codex-plugin/plugin.json`, and every selected `SKILL.md` exist.
6. Read `instructions/global.md`.
7. Read and follow `skills/development-flow/SKILL.md` for code changes.
8. Read the applicable language skills according to the repository manifests and files involved.

The shared skills may not appear in the startup skill catalog.
Read their `SKILL.md` files directly from the shared checkout and follow them for the current session.

If authentication, synchronization, HEAD validation, or a required read fails, stop before modifying the repository and report the failure clearly.
Do not silently continue with missing or stale shared instructions.
