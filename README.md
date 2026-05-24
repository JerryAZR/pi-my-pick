# pi-my-pick

One-shot installers for my commonly-used pi extensions.

## Why these?

These are the extensions I install on every machine. They don't depend on each
other — you could pick and choose — but together they cover the four things I
care about most: **safety**, **Python ergonomics**, **task tracking**, and
**recovery from mistakes**.

---

## Extensions

### `@jerryan/pi-sanity`

A configurable safety net that stays **out of the way** most of the time.
Unlike most guardrail extensions, Pi-Sanity is designed for low friction: it
lets the agent get on with normal work and only asks for confirmation on
genuinely suspicious actions — writing outside the project, reading credential
files, or force-deleting things. Not a whitelist or a sandbox; just a light
tap on the shoulder when something looks off.

**Why:** I trust the agent's ability. I don't want an approval dialog for
every `rm` or `pip install`. What I want is a backstop for the one time in a
hundred where the agent reaches somewhere it shouldn't. This gives me that
without turning every session into a click-through.


### `@jerryan/pi-pyvenv`

Transparently ensures every `python`, `python3`, `pip`, and `pip3` invocation
resolves to a virtual environment — never to the system Python. It activates
`.venv/` or `venv/` if one exists in the current directory, or falls back to a
shared user-level venv. The activation happens once at the Node.js process
level, so all child processes inherit it automatically. No command rewriting, no
tool interception.

**Why:** Agents love running `pip install` against the system Python. This makes
that impossible without the agent even knowing it's happening. Pure
infrastructure.

### `@jerryan/pi-todo-lite`

A lightweight task tracker with 6 tools and no architectural weight. No
`in_progress` states, no dependency graphs, no subagent execution. Just
`subject` + `description` + `done`. A persistent overlay widget shows pending
tasks above the editor, and a periodic system-reminder nudges the agent to mark
tasks done when they've actually been completed.

**Why:** Heavier task trackers add ceremony that the LLM rarely uses correctly.
This one does exactly enough — track tasks, show them in the UI, and remind the
agent to clean up — without fighting for the LLM's attention with 7 competing
tools.

### `pi-wtf`

For the moment you realize you messed up.

- `/fuck` — Abort the current run, rewind to before your last prompt, and
  restore it in the editor so you can fix and resubmit.
- `/fuck?` — Same recovery, but checks for typos and suggests a correction.
- `/fuck!` — Destructively remove that prompt and its entire subtree from the
  session file. Keeps your `/tree` clean of obvious mistakes.

**Why:** I type prompts, hit enter, and immediately notice a typo or missing
word. Before this, I was navigating `/tree`, forking, or copy-pasting. Now it's
one command.

### `@thinkscape/pi-status`

A configurable status bar that lives in your terminal tab title while pi is
working. Shows a spinner, the π symbol, session name, working directory, and
whatever else you want (model, thinking level, tokens, git branch, current
tool). Also drives Ghostty's native OSC 9;4 progress bar for a visual pulse
while the agent runs.

**Why:** When I have multiple pi sessions in different terminal tabs, I need to
know which is which at a glance. The progress bar is a nice bonus for long
runs.

### `pi-hashline-edit`

Replaces the built-in `read` and `edit` tools with a hash-anchored workflow.
Every line returned by `read` carries a short content hash (`LINE#HASH:`). When
the agent edits, it references these hashes instead of reciting the exact text.
If the file has changed since the last `read`, the edit is rejected with fresh
anchors for immediate retry.

**Why:** Still evaluating, but early results are promising. Agents no longer need
to reproduce every newline and space in the to-be-replaced text — they just
drop a hash reference. That alone seems to cut the failure rate on edits, and on
longer multi-line changes it saves a noticeable chunk of output tokens (roughly
half in the cases I've measured). No silent relocations, no editing stale
content.


### `@jerryan/pi-subagent-lite`

Minimal subagent delegation with zero setup. Each subagent runs in an isolated
`pi` process with live turn-by-turn progress. Optional skills can be preloaded
via `--skill`. Long tasks (>4000 chars) are automatically spilled to a temp
file. Subagents cannot spawn further subagents.

**Why:** Sometimes I want the agent to explore or refactor in parallel without
corrupting my main session context. This does that with no agent definitions,
no model switching, and no configuration files — just `task` and optional
`skills`.

---

## Usage

### Clone and run

#### macOS / Linux / WSL / Git Bash
```bash
bash install.sh
```

Project-local install instead of global:
```bash
bash install.sh -l
```

#### Windows (PowerShell)
```powershell
.\install.ps1
```

#### Windows (CMD)
```cmd
install.cmd
```

### One-liner (no clone)

#### macOS / Linux / WSL / Git Bash
```bash
curl -fsSL https://raw.githubusercontent.com/JerryAZR/pi-my-pick/main/install.sh | bash
```

Project-local:
```bash
curl -fsSL https://raw.githubusercontent.com/JerryAZR/pi-my-pick/main/install.sh | bash -s -- -l
```

#### Windows (PowerShell)
```powershell
iwr -useb https://raw.githubusercontent.com/JerryAZR/pi-my-pick/main/install.ps1 | iex
```

#### Windows (CMD)
```cmd
curl -fsSL https://raw.githubusercontent.com/JerryAZR/pi-my-pick/main/install.cmd -o %TEMP%\pi-install.cmd && call %TEMP%\pi-install.cmd && del %TEMP%\pi-install.cmd
```

---

## Why scripts instead of a package?

No real dependencies exist between these extensions. A script keeps the list
transparent, easy to edit, and avoids bundling headaches when you want to
add/remove one later.
