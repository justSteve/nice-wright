# Claude Code Namespace Permissions

## Overview

This workspace implements namespace isolation for Claude Code agents. Each subdirectory has its own `.claude/settings.json` file that grants full read/write access to ONLY that specific project directory.

## How It Works

When an agent session starts in a subdirectory (e.g., `c:\myStuff\myDSPy`), the `.claude/settings.json` file pre-authorizes access to that directory and all its children, but **not** to sibling directories.

## Generated Structure

```
c:\myStuff/
├── Bitwarden/
│   └── .claude/
│       └── settings.json       # Grants access to Bitwarden/ only
├── IDEasPlatform/
│   └── .claude/
│       └── settings.json       # Grants access to IDEasPlatform/ only
├── myDSPy/
│   └── .claude/
│       └── settings.json       # Grants access to myDSPy/ only
└── tooling/
    └── .claude/
        └── settings.json       # Grants access to tooling/ only
```

## Benefits

1. **Namespace Isolation**: Agents working in Judge0 cannot accidentally modify DSPy files
2. **No Permission Prompts**: Pre-authorized access eliminates runtime permission requests
3. **Security**: Limits blast radius of agent actions to the specific project
4. **Clarity**: Clear boundaries for what each agent session can access

## Regenerating Permissions

If you add new subdirectories to `c:\myStuff`, run:

```powershell
.\generate-permissions.ps1
```

This will create `.claude/settings.json` files for any new subdirectories.

## Configuration Format

Each `.claude/settings.json` contains:

```json
{
    "permissions": {
        "additionalDirectories": [
            "../"
        ]
    }
}
```

The `../` path is relative to the `.claude/` directory, so it grants access to the parent directory (the project root).

## Testing Namespace Isolation

To verify isolation is working:

1. Start a Claude Code session in `c:\myStuff\myDSPy`
2. Ask the agent to list files in that directory (should succeed)
3. Ask the agent to read a file in `c:\myStuff\Bitwarden` (should fail or prompt for permission)

## Modifying Permissions

To modify permissions for a specific project:

1. Edit the `.claude/settings.json` file in that project directory
2. Add additional directories if needed, or use `allow`/`deny` rules for fine-grained control

See [Claude Code IAM Documentation](https://code.claude.com/docs/en/iam.md) for advanced permission patterns.
