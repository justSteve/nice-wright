# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is the root workspace for a composite system of applications, learning environments, and research projects. All projects are organized as siblings under this `c:\myStuff\` root directory and backed by GitHub repositories under `github.com/justSteve`.

## GitHub Context

- **GitHub user**: `justSteve`
- **Permissions**: Read access to all repositories in this namespace
- **Write access**: Per-repository basis for each individual app
- **Repository structure**: Each project in `c:\myStuff\[app]` syncs to `github.com/justSteve/[app]`

## Workspace Structure

The workspace follows a three-layer architecture for each project:

1. **Implementation**: Conventional application programming targeting specific features
2. **Sandbox/Learning**: Environments for experimentation, training, and exploring the domain
3. **Context/Marketing**: Research, backgrounders, and marketing material for the domain

## Active Projects

### IDEasPlatform (`c:\myStuff\IDEasPlatform\`)
Exploration of VS Code UI control mechanisms with TypeScript/Node.js.

**Key components**:
- `ui-probe/`: VS Code extension for real-time UI event logging
- `.agent/rules/github-home.md`: GitHub namespace configuration

**Technology**: Node.js, TypeScript, VS Code Extension API

### myDSPy (`c:\myStuff\myDSPy\`)
Learning and experimentation environment for the DSPy framework.

**Important**: This is NOT a fork for contribution. The purpose is personal training and courseware development, progressing from "Hello World" examples to mid-level use cases. Focus on scripting interactions with LLMs rather than chat interfaces.

**Key directories**:
- `dspy/`: Main DSPy source (has its own `CLAUDE.md`)
- `dspy_sandbox/`: Experimental workspace
- `myLearning/`: Personal learning materials
- `docs/`: DSPy documentation

**Technology**: Python, uv package manager

**Development commands**:
```bash
cd myDSPy
uv sync --extra dev          # Install dependencies
cd docs && mkdocs serve      # Documentation preview
```

**See**: `c:\myStuff\myDSPy\dspy\CLAUDE.md` for detailed DSPy-specific guidance.

### Bitwarden (`c:\myStuff\Bitwarden\`)
Migration toolkit and secret synchronization system.

**Two main components**:
1. RoboForm → Bitwarden migration tool (Python/PyQt6)
2. Bitwarden ↔ Azure Key Vault bidirectional sync (TypeScript/Python)

**Key files**:
- `roboform_to_bitwarden.py`: Conversion engine
- `bitwarden_ui.py`: PyQt6 GUI editor
- `bitwarden-azure-sync/`: TypeScript sync package (Docker-ready)

**Technology**: Python 3.8+, TypeScript, Docker, Azure SDK

**Common commands**:
```bash
cd Bitwarden
python bitwarden_ui.py                    # Launch GUI editor
cd bitwarden-azure-sync && npm run sync:dev  # Sync dev secrets
```

**See**: `c:\myStuff\Bitwarden\CLAUDE.md` for comprehensive migration and sync documentation.

### Judge0 Tooling (`c:\myStuff\tooling\Judge0\`)
Code execution API management for DSPy workflows, deployed on Azure Windows VM.

**Purpose**: Manage Judge0 deployment (60+ language code execution) and provide Python client for DSPy integration.

**Key components**:
- `scripts/`: PowerShell automation for Azure VM updates and restarts
- `.dspy/lib/judge0_client/`: Python client library
- Enhanced v2 versions ready for production integration

**Technology**: Ruby (Judge0), Python (client), PowerShell (automation), Docker

**Status**: 2 features complete, enhanced versions created, ready for integration decision.

**See**: `c:\myStuff\tooling\Judge0\4THENEXTAGENT.README.md` for current project state and next steps.

## Cross-Project References

Always treat `c:\myStuff` as the root context. When referencing files across projects, use paths relative to this root.

**Example**: Referencing Judge0 client from DSPy learning materials:
```python
import sys
sys.path.append('c:/myStuff/tooling/Judge0/.dspy/lib')
from judge0_client import Judge0Client
```

## Project-Specific CLAUDE.md Files

Several projects have their own detailed CLAUDE.md files:
- `c:\myStuff\myDSPy\dspy\CLAUDE.md` - DSPy framework specifics
- `c:\myStuff\Bitwarden\CLAUDE.md` - Migration and sync system details

**Always check for and consult project-specific CLAUDE.md files when working within that project.**

## Agent Instruction Layer

The global instructions file at `C:\Users\steve\.claude\CLAUDE.md` contains a reference to the "learning layer":
- **Path**: `C:\myStuff\tooling\Judge0`
- **Purpose**: Rules and context for interactive learning environments

This context should only be applied when highly relevant to the current task.

## Common Patterns

### Version Control
All projects are Git repositories. Check for uncommitted changes before making modifications:
```bash
git status
```

### Python Projects
Most Python projects use modern tooling:
- **myDSPy**: Uses `uv` for dependency management
- **Bitwarden**: Uses traditional `pip` and `requirements.txt`

### Documentation Style
- Linter-compliant markdown (enforced in myDSPy)
- Avoid over-the-top superlatives or excessive praise
- Focus on technical accuracy and problem-solving

### Technology Stack
- **TypeScript/Node.js**: IDEasPlatform
- **Python**: myDSPy, Bitwarden migration, Judge0 client
- **Ruby/Docker**: Judge0 (infrastructure)
- **PowerShell**: Judge0 automation scripts
- **Azure**: Cloud infrastructure (Key Vault, VMs)

## Goals

The ultimate purpose of this composite system is to service:
- Code-based implementation
- Training and learning
- Consulting and knowledge sharing
