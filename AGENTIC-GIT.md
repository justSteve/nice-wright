# Agentic Git: Bot-Optimized GitHub Workflow

This repository implements an Orchestrator-Worker pattern for AI agent collaboration via GitHub. The system is designed to **serve bot operating efficiency** rather than constrain them.

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         HUMAN / UPSTREAM                         │
│                    Creates goal-XXX.json                        │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                        ORCHESTRATOR                              │
│  • Decomposes goals into atomic tasks                           │
│  • Writes task-XXX.json files                                   │
│  • Dispatches workers via repository_dispatch                   │
│  • Monitors approved PRs and merges to main                     │
└──────────────────────────────┬──────────────────────────────────┘
                               │
              ┌────────────────┼────────────────┐
              │                │                │
              ▼                ▼                ▼
┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
│    WORKER 1     │  │    WORKER 2     │  │    WORKER N     │
│  agent/task-001 │  │  agent/task-002 │  │  agent/task-N   │
└────────┬────────┘  └────────┬────────┘  └────────┬────────┘
         │                    │                    │
         └────────────────────┼────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                         CI WORKFLOW                              │
│  • Runs tests, lint, typecheck                                  │
│  • Updates task status in _meta/tasks/                          │
│  • On FAIL: Triggers worker retry (up to max_attempts)          │
│  • On PASS: Moves task to "review" status                       │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                        REVIEWER                                  │
│  • Validates CI passed                                          │
│  • Checks expected files modified                               │
│  • Scans for secrets/debug statements                           │
│  • APPROVE → Orchestrator merges                                │
│  • REQUEST_CHANGES → Worker retriggered                         │
└─────────────────────────────────────────────────────────────────┘
```

## Directory Structure

```
repo/
├── .github/workflows/
│   ├── orchestrator.yml    # Goal decomposition & PR merging
│   ├── worker-dispatch.yml # Task execution
│   ├── ci.yml              # Tests, lint, feedback loop
│   └── reviewer.yml        # PR gate
├── _meta/
│   ├── goals/              # High-level objectives (human-created)
│   │   └── goal-XXX.json
│   ├── tasks/              # Atomic work units (orchestrator-created)
│   │   └── task-XXX.json
│   ├── agents/
│   │   └── registry.json   # Agent capabilities & permissions
│   ├── logs/               # CI & review logs per task
│   │   └── task-XXX/
│   └── config/
│       └── workflow.json   # System configuration
└── src/                    # Your actual application code
```

## Communication Protocol

**Agents communicate via files, not PR comments.**

### Goal JSON (`_meta/goals/goal-XXX.json`)
```json
{
  "id": "goal-001",
  "title": "Implement Feature X",
  "status": "pending|in_progress|complete",
  "task_breakdown": [
    {
      "id": "task-001",
      "requirements": {
        "description": "What needs to be done",
        "acceptance_criteria": ["criterion 1", "criterion 2"],
        "files_to_modify": ["src/file.ts"],
        "dependencies": []
      }
    }
  ]
}
```

### Task JSON (`_meta/tasks/task-XXX.json`)
```json
{
  "id": "task-001",
  "parent_goal": "goal-001",
  "status": "pending|assigned|in_progress|review|blocked|complete",
  "branch": "agent/task-001",
  "requirements": { ... },
  "attempts": [
    {
      "attempt_number": 1,
      "commit_sha": "abc123",
      "ci_status": "passed|failed|pending"
    }
  ],
  "max_attempts": 5,
  "review": {
    "status": "pending|approved|changes_requested"
  }
}
```

## Workflow Triggers

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `orchestrator.yml` | Push to `_meta/goals/`, Schedule, Manual | Decompose goals, merge PRs |
| `worker-dispatch.yml` | `repository_dispatch` | Execute tasks |
| `ci.yml` | Push to `agent/*`, PR to main | Test & feedback loop |
| `reviewer.yml` | PR from `agent/*` | Automated code review |

## Task Lifecycle

```
1. Human creates goal-XXX.json with status: "pending"
                    │
                    ▼
2. Orchestrator decomposes goal into task-XXX.json files
   Each task gets status: "pending"
                    │
                    ▼
3. Orchestrator dispatches workers via repository_dispatch
                    │
                    ▼
4. Worker claims task (status: "assigned")
   Creates branch: agent/task-XXX
                    │
                    ▼
5. Worker implements requirements, pushes commit
   Task status: "in_progress", attempt recorded
                    │
                    ▼
6. CI runs tests/lint
   ├─ PASS → status: "review", PR created
   └─ FAIL → Worker retriggered (up to max_attempts)
                    │
                    ▼
7. Reviewer validates PR
   ├─ APPROVE → Orchestrator merges, status: "complete"
   └─ REQUEST_CHANGES → Worker retriggered
                    │
                    ▼
8. When all tasks complete → goal status: "complete"
```

## Safety Rails

### Attempt Limits
- Each task has `max_attempts` (default: 5)
- After exhaustion: `status: "blocked"`, human notified

### Circuit Breaker
- If 3 tasks fail consecutively within 30 minutes, system pauses
- Configurable in `_meta/config/workflow.json`

### Human Escalation
- Tasks can be marked `needs_human: true`
- GitHub Issues provide human visibility
- Humans can push directly to `agent/*` branches

## Branching Strategy

| Branch | Who Can Write | Purpose |
|--------|---------------|---------|
| `main` | Orchestrator only | Protected production code |
| `agent/task-XXX` | Workers | Isolated task work |

Workers **never** touch `main` directly. All changes go through PR → Review → Merge cycle.

## Extending the System

### Adding a New Agent Type

1. Add entry to `_meta/agents/registry.json`
2. Create workflow in `.github/workflows/`
3. Define trigger and permissions

### Custom Reviewer Checks

Edit `reviewer.yml` to add checks:
```yaml
- name: Custom validation
  run: |
    # Your validation logic
    if [ condition ]; then
      DECISION="REQUEST_CHANGES"
      FEEDBACK="$FEEDBACK\n- Custom check failed"
    fi
```

### Integrating LLM Agents

Replace the placeholder in `worker-dispatch.yml`:
```yaml
- name: Execute task (placeholder for actual agent logic)
  run: |
    # Call your LLM API here
    # Example with Claude:
    # curl https://api.anthropic.com/v1/messages \
    #   -H "x-api-key: $ANTHROPIC_API_KEY" \
    #   -d "{\"model\": \"claude-3-sonnet\", \"messages\": [{\"role\": \"user\", \"content\": \"$TASK_DESCRIPTION\"}]}"
```

## Configuration Reference

See `_meta/config/workflow.json` for all options:
- `worker.max_attempts`: Retry limit per task
- `reviewer.block_on_secrets`: Fail review if secrets detected
- `safety.circuit_breaker_threshold`: Consecutive failures before pause

## Getting Started

1. **Create a goal**: Add a JSON file to `_meta/goals/`
2. **Push to main**: Triggers orchestrator
3. **Watch agents work**: Monitor via GitHub Actions
4. **Review and merge**: Automated, or intervene if blocked

## Monitoring

- **Actions tab**: See all workflow runs
- **`_meta/tasks/*.json`**: Current state of all tasks
- **GitHub Issues**: Human-readable task tracking
- **`_meta/logs/`**: Detailed CI and review logs
