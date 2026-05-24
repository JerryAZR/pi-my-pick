# pi-my-pick

One-shot installers for my commonly-used pi extensions.

## Extensions

| Extension | Source |
|-----------|--------|
| `@jerryan/pi-pyvenv` | npm |
| `@jerryan/pi-todo-lite` | npm |
| `pi-wtf` | npm |
| `@thinkscape/pi-status` | npm |
| `pi-hashline-edit` | npm |
| `@jerryan/pi-subagent-lite` | npm |
| `@jerryan/pi-sanity` | npm |

## Usage

### Clone and run

#### Windows (PowerShell)
```powershell
.\install.ps1
```

#### Windows (CMD)
```cmd
install.cmd
```

#### macOS / Linux / WSL / Git Bash
```bash
bash install.sh
```

Install project-locally instead of globally:
```bash
bash install.sh -l
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

## Why scripts instead of a package?

No real dependencies exist between these extensions. A script keeps the list transparent, easy to edit, and avoids bundling headaches when you want to add/remove one later.
