# Project Initialization Setup Guide

## 📋 Overview

This guide explains how to use the Sera Inc. Project Initialization System to create new projects that follow all engineering handbook standards.

## 🎯 What This System Provides

The initialization system automatically sets up:

1. **Project Structure**: Clean Architecture with 4 layers (Domain, Use Case, Adapter, Infrastructure)
2. **Development Environment**: Configuration files for linters, formatters, type checkers, and test frameworks
3. **Git Hooks**: Pre-commit hooks for code quality checks
4. **CI/CD Workflows**: Automated testing, linting, security scanning, and deployment pipelines
5. **GitHub Labels**: Complete label taxonomy for issue and PR management
6. **GitHub Wiki**: Pre-populated documentation structure
7. **GitHub Projects**: Project board with custom fields and views

## 🚀 Quick Start

### Prerequisites

- Git installed
- GitHub account with repository access
- GitHub Personal Access Token with `repo` and `project` scopes
- For Python projects: [uv](https://github.com/astral-sh/uv) installed
- For TypeScript projects: [Node.js 20+](https://nodejs.org/) and [pnpm](https://pnpm.io/) installed

### One-Command Setup (Interactive)

```bash
curl -fsSL https://raw.githubusercontent.com/sera-inc/.github/main/setup-new-project.sh | bash
```

Or clone the repository first:

```bash
git clone https://github.com/sera-inc/.github.git
cd .github
./setup-new-project.sh
```

### Non-Interactive Setup

```bash
./setup-new-project.sh \
  --dir ./my-project \
  --type python \
  --name my-project \
  --owner sera-inc \
  --repo my-project \
  --token ghp_xxxxx
```

## 📚 Detailed Setup Steps

### Step 1: Create GitHub Repository

1. Go to https://github.com/sera-inc
2. Click "New repository"
3. Enter repository name
4. Choose visibility (public/private)
5. Do NOT initialize with README (we'll create it)
6. Click "Create repository"

### Step 2: Generate GitHub Personal Access Token

1. Go to https://github.com/settings/tokens
2. Click "Generate new token (classic)"
3. Select scopes:
   - `repo` (Full control of private repositories)
   - `project` (Full control of projects)
   - `admin:org` (if setting up organization-wide projects)
4. Click "Generate token"
5. Copy the token (you won't see it again!)

### Step 3: Run Initialization Script

#### Interactive Mode (Recommended)

```bash
./setup-new-project.sh
```

You'll be prompted for:
- Project type (Python or TypeScript)
- Project name
- GitHub owner/organization
- GitHub repository name
- GitHub personal access token

#### Non-Interactive Mode

```bash
./setup-new-project.sh \
  --dir ./my-project \
  --type python \
  --name my-project \
  --owner sera-inc \
  --repo my-project \
  --token ghp_xxxxx
```

#### Skip Certain Steps

```bash
./setup-new-project.sh \
  --type python \
  --name my-project \
  --owner sera-inc \
  --repo my-project \
  --token ghp_xxxxx \
  --skip-projects \
  --skip-wiki
```

Available skip options:
- `--skip-structure`: Skip project structure creation
- `--skip-env`: Skip development environment setup
- `--skip-hooks`: Skip Git hooks setup
- `--skip-workflows`: Skip CI/CD workflows setup
- `--skip-labels`: Skip GitHub labels setup
- `--skip-wiki`: Skip GitHub Wiki setup
- `--skip-projects`: Skip GitHub Projects setup

### Step 4: Initialize Git and Push

```bash
cd my-project
git init
git add .
git commit -m "chore: initial project setup"
git remote add origin git@github.com:sera-inc/my-project.git
git branch -M main
git push -u origin main
```

### Step 5: Configure GitHub Settings

#### Branch Protection Rules

1. Go to repository Settings → Branches
2. Add rule for `main` branch:
   - ✅ Require pull request reviews before merging
   - ✅ Require status checks to pass before merging
     - Select: `lint-and-test`, `security-scan`
   - ✅ Require linear history
   - ✅ Do not allow bypassing the above settings

#### GitHub Environments

1. Go to repository Settings → Environments
2. Create three environments:

**Development**:
- No protection rules
- Add secrets if needed

**Staging**:
- Required reviewers: 1 reviewer
- Wait timer: 0 minutes
- Add secrets if needed

**Production**:
- Required reviewers: 2 reviewers (including PM)
- Wait timer: 5 minutes
- Add secrets if needed

#### GitHub Secrets

1. Go to repository Settings → Secrets and variables → Actions
2. Add the following secrets:

**Optional but Recommended**:
- `CODECOV_TOKEN`: For code coverage reports
- `SLACK_WEBHOOK_URL`: For deployment notifications

**If Using AWS**:
- `AWS_ROLE_ARN`: IAM role for deployments
- `AWS_REGION`: AWS region (e.g., `ap-northeast-1`)

### Step 6: Customize Configuration

#### Python Projects

Edit `pyproject.toml`:
```toml
[project]
name = "my-project"
version = "0.1.0"
description = "Your project description"
dependencies = [
    # Add your dependencies here
]
```

Add dependencies:
```bash
uv add fastapi uvicorn  # Example
```

#### TypeScript Projects

Edit `package.json`:
```json
{
  "name": "my-project",
  "version": "0.1.0",
  "description": "Your project description",
  "dependencies": {
    // Add your dependencies here
  }
}
```

Add dependencies:
```bash
pnpm add express  # Example
```

### Step 7: Customize CI/CD Workflows

Edit `.github/workflows/deploy-*.yml` files to add your deployment commands:

```yaml
- name: Build and deploy
  run: |
    echo "🚀 Deploying to development environment..."
    # Add your deployment commands here
    docker build -t my-app:${{ github.sha }} .
    docker push my-app:${{ github.sha }}
    kubectl set image deployment/my-app my-app=my-app:${{ github.sha }}
```

## 🔧 Individual Setup Scripts

You can also run individual setup scripts separately:

### Project Structure

```bash
./setup/setup-project-structure.sh . python my-project
```

Creates Clean Architecture directory structure with all layers.

### Development Environment

```bash
./setup/setup-dev-environment.sh . python my-project
```

Copies configuration files and installs dependencies.

### Git Hooks

```bash
./setup/setup-git-hooks.sh . python
```

Sets up pre-commit hooks for code quality checks.

### CI/CD Workflows

```bash
./setup/setup-ci-workflows.sh . python
```

Copies CI/CD workflow templates to `.github/workflows/`.

### GitHub Labels

```bash
./setup/setup-labels.sh sera-inc my-project ghp_xxxxx
```

Creates complete label taxonomy in GitHub repository.

### GitHub Wiki

```bash
./setup/setup-wiki.sh my-project
```

Populates Wiki with documentation structure.

### GitHub Projects

```bash
./setup/setup-projects.sh sera-inc my-project ghp_xxxxx "My Project"
```

Displays instructions for setting up GitHub Projects (manual setup required).

## 📁 Project Structure

### Python Project

```
my-project/
├── src/
│   └── my_project/
│       ├── domain/              # Business entities and rules
│       ├── usecase/             # Application business logic
│       ├── adapter/             # Controllers and presenters
│       └── infrastructure/      # Database and external APIs
├── tests/
│   ├── unit/                    # Unit tests (80%+ coverage)
│   ├── integration/             # Integration tests (60%+ coverage)
│   └── e2e/                     # End-to-end tests
├── docs/                        # Documentation
├── .github/
│   └── workflows/               # CI/CD workflows
├── pyproject.toml               # Python configuration
├── pyrightconfig.json           # Type checker configuration
├── .pre-commit-config.yaml      # Pre-commit hooks
├── .gitignore
├── README.md
├── SECURITY.md
└── CONTRIBUTING.md
```

### TypeScript Project

```
my-project/
├── src/
│   ├── domain/                  # Business entities and rules
│   ├── usecase/                 # Application business logic
│   ├── adapter/                 # Controllers and presenters
│   └── infrastructure/          # Database and external APIs
├── tests/
│   ├── unit/                    # Unit tests (80%+ coverage)
│   ├── integration/             # Integration tests (60%+ coverage)
│   └── e2e/                     # End-to-end tests
├── docs/                        # Documentation
├── .github/
│   └── workflows/               # CI/CD workflows
├── .husky/                      # Git hooks
├── package.json                 # Node.js configuration
├── tsconfig.json                # TypeScript configuration
├── biome.json                   # Linter/formatter configuration
├── vitest.config.ts             # Test configuration
├── .gitignore
├── README.md
├── SECURITY.md
└── CONTRIBUTING.md
```

## 🧪 Testing the Setup

### Python

```bash
# Run all quality checks
uv run ruff format .
uv run ruff check .
uv run pyright
uv run pytest

# Test pre-commit hooks
git add .
git commit -m "test: verify hooks"
```

### TypeScript

```bash
# Run all quality checks
pnpm format
pnpm lint
pnpm typecheck
pnpm test

# Test Husky hooks
git add .
git commit -m "test: verify hooks"
```

## 🔄 CI/CD Workflows

### Workflows Created

1. **lint-and-test.yml**: Runs on push and PR
   - Code formatting check
   - Linting
   - Type checking
   - Unit and integration tests
   - Coverage reporting

2. **security-scan.yml**: Runs on push, PR, and weekly
   - Dependency vulnerability scanning
   - SAST (Static Application Security Testing)
   - Secrets scanning

3. **deploy-dev.yml**: Runs on push to `develop` branch
   - Deploys to development environment
   - Runs smoke tests

4. **deploy-staging.yml**: Runs on push to `staging` branch
   - Deploys to staging environment
   - Runs E2E tests
   - Runs performance tests

5. **deploy-production.yml**: Runs on push to `production` branch
   - Requires manual approval
   - Creates backup before deployment
   - Deploys to production
   - Runs smoke tests
   - Monitors deployment
   - Automatic rollback on failure

### Triggering Workflows

```bash
# Trigger lint-and-test
git checkout -b feature/my-feature
git push origin feature/my-feature
# Create PR on GitHub

# Trigger deploy-dev
git push origin develop

# Trigger deploy-staging
git push origin staging

# Trigger deploy-production
git push origin production
```

## 📊 GitHub Projects Setup

The system displays instructions for manual GitHub Projects setup. Follow these steps:

1. Go to https://github.com/orgs/sera-inc/projects
2. Click "New project"
3. Project name: `[Your Project] Project`
4. Template: "Team backlog"
5. Click "Create project"

Then configure:
- **9 Custom Fields**: Status, Priority, Component, Sprint, Story Points, Must/Want, Figma Link, Security Status, Review Status
- **7 Views**: Main Kanban, Sprint Board, Team Members, Priority View, Component View, Review Pipeline, Completed Tasks
- **3 Automation Rules**: Auto-add issues, Auto-add PRs, Auto-update on merge

See [github-projects-setup.md](./github-projects-setup.md) for detailed instructions.

## 🏷️ GitHub Labels

The system creates 53 labels across 10 categories:

- **Priority**: critical, high, medium, low
- **Type**: feature, enhancement, bug, hotfix
- **Component**: frontend, backend, database, infrastructure, ui-ux, api, security
- **Status**: needs-review, in-progress, blocked, approved
- **Requirement**: must-have, want-have
- **Story Points**: 1, 2, 3, 5, 8, 13, 21
- **Process**: design, requirement, change-request
- **Automation**: automated, from-meeting
- **Special**: escalation, technical-debt

## 📚 GitHub Wiki

The system populates the Wiki with:

1. **Home**: Navigation hub
2. **Project Overview**: KPIs, stakeholders, milestones
3. **Requirements**: Functional/non-functional requirements
4. **Team Info**: Contacts, meeting schedules
5. **Development Guide**: Coding standards, Git workflow, testing strategy
6. **Architecture**: Clean Architecture documentation
7. **API Design**: REST API conventions
8. **Test Plan**: Testing strategy and procedures
9. **ADR Template**: Architecture Decision Record template

## 🔒 Security Considerations

### Secrets Management

- Never commit secrets to the repository
- Use GitHub Secrets for sensitive data
- Use environment variables for configuration
- Review SECURITY.md for security policy

### Pre-commit Hooks

- Automatically run security checks
- Prevent committing sensitive data
- Enforce code quality standards

### CI/CD Security

- Dependency vulnerability scanning
- SAST (Static Application Security Testing)
- Secrets scanning with Gitleaks
- Regular security audits

## 🐛 Troubleshooting

### Git Hooks Not Running

```bash
# Python
uv run pre-commit install

# TypeScript
pnpm exec husky install
```

### CI/CD Workflows Failing

1. Check workflow logs in GitHub Actions
2. Verify all required secrets are set
3. Ensure branch protection rules are configured
4. Test locally before pushing

### Dependencies Not Installing

```bash
# Python
uv sync --reinstall

# TypeScript
pnpm install --force
```

### Type Checking Errors

```bash
# Python
uv run pyright --createstub <package>

# TypeScript
pnpm add -D @types/<package>
```

## 📖 Additional Resources

- [Engineering Handbook](https://github.com/sera-inc/engineering-handbook)
- [Clean Architecture Guide](https://github.com/sera-inc/engineering-handbook/blob/main/docs/05-architecture/clean-architecture.md)
- [Test Strategy](https://github.com/sera-inc/engineering-handbook/blob/main/docs/03-quality-assurance/test-strategy.md)
- [Git Workflow](https://github.com/sera-inc/engineering-handbook/blob/main/docs/02-development-process/git-workflow.md)
- [Code Review Guidelines](https://github.com/sera-inc/engineering-handbook/blob/main/docs/02-development-process/code-review.md)

## 🆘 Getting Help

If you encounter issues:

1. Check this guide and the engineering handbook
2. Search existing issues in the .github repository
3. Ask in the team Slack channel
4. Create an issue in the .github repository

## 🎉 Success!

You now have a fully configured project following all Sera Inc. engineering standards. Happy coding!
