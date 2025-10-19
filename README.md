# Sera Inc. Organization-Wide Configuration

This repository contains organization-wide templates, workflows, and automation for all Sera Inc. projects.

## 🚀 Quick Start

### For New Projects

Initialize a new project with all Sera Inc. standards:

```bash
curl -fsSL https://raw.githubusercontent.com/sera-inc/.github/main/setup-new-project.sh | bash
```

Or clone and run locally:

```bash
git clone https://github.com/sera-inc/.github.git
cd .github
./setup-new-project.sh
```

See [SETUP_GUIDE.md](./SETUP_GUIDE.md) for detailed instructions.

### For Existing Projects

Apply individual setup scripts:

```bash
# Project structure
./setup/setup-project-structure.sh . python my-project

# Development environment
./setup/setup-dev-environment.sh . python my-project

# Git hooks
./setup/setup-git-hooks.sh . python

# CI/CD workflows
./setup/setup-ci-workflows.sh . python

# GitHub labels
./setup/setup-labels.sh sera-inc my-repo ghp_xxxxx

# GitHub Wiki
./setup/setup-wiki.sh my-repo

# GitHub Projects
./setup/setup-projects.sh sera-inc my-repo ghp_xxxxx "My Project"
```

## 📁 Repository Structure

```
.github/
├── setup-new-project.sh         # Master initialization script
├── setup/                        # Individual setup scripts
│   ├── setup-labels.sh          # GitHub labels
│   ├── setup-wiki.sh            # GitHub Wiki
│   ├── setup-projects.sh        # GitHub Projects
│   ├── setup-ci-workflows.sh    # CI/CD workflows
│   ├── setup-git-hooks.sh       # Git hooks
│   ├── setup-project-structure.sh  # Project structure
│   └── setup-dev-environment.sh    # Development environment
├── templates/                    # Project templates
│   ├── python/                  # Python project templates
│   ├── typescript/              # TypeScript project templates
│   └── common/                  # Common templates
├── wiki-templates/               # Wiki page templates
├── workflows-templates/          # CI/CD workflow templates
├── ISSUE_TEMPLATE/              # Issue templates
├── workflows/                    # Organization workflows
├── pull_request_template.md     # PR template
├── SETUP_GUIDE.md               # Detailed setup guide
├── SETUP_INSTRUCTIONS.md        # Quick setup instructions
└── github-projects-setup.md     # GitHub Projects guide
```

## 🎯 What This Provides

### 1. Project Initialization System

Automatically sets up new projects with:

- **Clean Architecture**: 4-layer structure (Domain, Use Case, Adapter, Infrastructure)
- **Development Environment**: Configuration files for all tools
- **Git Hooks**: Pre-commit quality checks
- **CI/CD Workflows**: Automated testing, security scanning, deployment
- **GitHub Integration**: Labels, Wiki, Projects

### 2. Issue Templates

Standardized templates for:

- UI/UX Design Requests
- Feature Requirements
- Bug Reports
- Change Requests
- Security Issues

### 3. Automated Workflows

- **Weekly Reports**: Automated progress reports
- **Meeting Integration**: AI-powered meeting minutes
- **Auto-labeling**: Automatic PR labeling
- **Dependency Review**: Security vulnerability scanning
- **AI Summaries**: Automatic issue summaries

### 4. Setup Scripts

Individual scripts for:

- GitHub Labels (53 labels across 10 categories)
- GitHub Wiki (9 documentation pages)
- GitHub Projects (9 custom fields, 7 views)
- CI/CD Workflows (5 workflows)
- Git Hooks (pre-commit quality checks)
- Project Structure (Clean Architecture)
- Development Environment (configuration files)

## 📚 Documentation

- **[SETUP_GUIDE.md](./SETUP_GUIDE.md)**: Comprehensive setup guide
- **[SETUP_INSTRUCTIONS.md](./SETUP_INSTRUCTIONS.md)**: Quick setup instructions
- **[github-projects-setup.md](./github-projects-setup.md)**: GitHub Projects configuration
- **[Engineering Handbook](https://github.com/sera-inc/engineering-handbook)**: Complete development guidelines

## 🔧 Supported Project Types

### Python Projects

- Package manager: [uv](https://github.com/astral-sh/uv)
- Linter/Formatter: [Ruff](https://github.com/astral-sh/ruff)
- Type checker: [Pyright](https://github.com/microsoft/pyright)
- Test framework: [pytest](https://pytest.org/)
- Git hooks: [pre-commit](https://pre-commit.com/)

### TypeScript Projects

- Package manager: [pnpm](https://pnpm.io/)
- Linter/Formatter: [Biome](https://biomejs.dev/)
- Type checker: [TypeScript](https://www.typescriptlang.org/)
- Test framework: [Vitest](https://vitest.dev/)
- Git hooks: [Husky](https://typicode.github.io/husky/)

## 🏗️ Architecture

All projects follow Clean Architecture principles:

```
┌─────────────────────────────────────┐
│         Infrastructure              │  External interfaces
├─────────────────────────────────────┤
│            Adapter                  │  Interface adapters
├─────────────────────────────────────┤
│           Use Case                  │  Business logic
├─────────────────────────────────────┤
│            Domain                   │  Core entities
└─────────────────────────────────────┘
```

**Dependency Rule**: Dependencies point inward only.

## 🧪 Quality Standards

### Test Coverage

- Unit tests: 80%+ coverage required
- Integration tests: 60%+ coverage required
- E2E tests: Critical scenarios

### Code Quality

- Zero linting errors
- Zero type checking errors
- All tests passing
- Security scans passing

### CI/CD Gates

1. **Pre-commit**: Format, lint, type check, unit tests
2. **PR Creation**: All tests, security scan
3. **Pre-merge**: All checks must pass
4. **Pre-deployment**: E2E tests, performance tests

## 🔒 Security

- Automated dependency scanning
- SAST (Static Application Security Testing)
- Secrets scanning with Gitleaks
- Security issue template
- SECURITY.md in all projects

## 🤝 Contributing

See [CONTRIBUTING.md](./templates/common/CONTRIBUTING.md) template for contribution guidelines.

## 📖 Additional Resources

- [Engineering Handbook](https://github.com/sera-inc/engineering-handbook)
- [Clean Architecture Guide](https://github.com/sera-inc/engineering-handbook/blob/main/docs/05-architecture/clean-architecture.md)
- [Test Strategy](https://github.com/sera-inc/engineering-handbook/blob/main/docs/03-quality-assurance/test-strategy.md)
- [Git Workflow](https://github.com/sera-inc/engineering-handbook/blob/main/docs/02-development-process/git-workflow.md)

## 🆘 Getting Help

1. Check [SETUP_GUIDE.md](./SETUP_GUIDE.md)
2. Review [Engineering Handbook](https://github.com/sera-inc/engineering-handbook)
3. Search existing issues
4. Ask in team Slack
5. Create an issue

## 📄 License

Internal use only - Sera Inc.
