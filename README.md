# pi-my-pick

One-shot installers for my commonly-used pi extensions.

## Why these?

These are the extensions I install on every machine. They don't depend on each
other — you could pick and choose — but together they cover the four things I
care about most: **safety**, **Python ergonomics**, **UI polish**, and
**recovery from mistakes**.

---

## Extensions

### `@jerryan/pi-bash-wrap`

Replaces the built-in `bash` tool with one that runs commands inside `bubblewrap`, a lightweight sandbox. The agent still sees normal `bash` output and exit codes, but the command executes in an isolated mount/user namespace with restricted filesystem access.

**Why:** On Linux, this is the simplest way to keep the agent from accidentally writing outside the project. Most commands auto-approve silently; it only intervenes when a command tries to escape the sandbox, at which point it can ask or deny (configurable). Lower friction than a guardrail extension, stronger than nothing.
### `@jerryan/pi-sanity`

A configurable safety net that stays **out of the way** most of the time. Unlike most guardrail extensions, Pi-Sanity is designed for low friction: it lets the agent get on with normal work and only asks for confirmation on genuinely suspicious actions — writing outside the project, reading credential files, or force-deleting things. Not a whitelist or a sandbox; just a light tap on the shoulder when something looks off.

**Why:** On Windows (and other platforms without a cheap sandbox), this gives a backstop for the one time in a hundred where the agent reaches somewhere it shouldn't, without turning every session into a click-through.


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

### `@thinkscape/pi-status`

A configurable status bar that lives in your terminal tab title while pi is
working. Shows a spinner, the π symbol, session name, working directory, and
whatever else you want (model, thinking level, tokens, git branch, current
tool). Also drives Ghostty's native OSC 9;4 progress bar for a visual pulse
while the agent runs.

**Why:** When I have multiple pi sessions in different terminal tabs, I need to
know which is which at a glance. The progress bar is a nice bonus for long
runs.

### `@jerryan/pi-hashline-edit`
Replace the built-in `read` and `edit` tools with a hash-anchored workflow. Every line returned by `read` carries a short content hash (`LINE#HASH:`). When the agent edits, it references these hashes instead of reciting the exact text. If the file has changed since the last `read`, the edit is rejected with fresh anchors for immediate retry.

**Why:** Agents no longer need to reproduce every newline and space in the to-be-replaced text — they just drop a hash reference. That cuts the failure rate on edits, and on longer multi-line changes it saves a noticeable chunk of output tokens. No silent relocations, no editing stale content.

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
