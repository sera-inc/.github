# Contributing to PROJECT_NAME

Thank you for your interest in contributing to PROJECT_NAME! This document provides guidelines and instructions for contributing.

## 📋 Code of Conduct

By participating in this project, you agree to maintain a respectful and collaborative environment.

## 🚀 Getting Started

### Prerequisites

- Review the [README](../README.md) for project setup
- Familiarize yourself with the [Architecture](../../wiki/Architecture)
- Read the [Development Guide](../../wiki/Development-Guide)

### Development Environment

1. Clone the repository
2. Install dependencies (see README)
3. Set up pre-commit hooks
4. Run tests to verify setup

## 🔄 Development Workflow

### Branch Strategy

We follow GitLab Flow:

1. **Create a feature branch** from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes** following our coding standards

3. **Commit your changes** using Conventional Commits:
   ```bash
   git commit -m "feat: add new feature"
   ```

4. **Push your branch**:
   ```bash
   git push origin feature/your-feature-name
   ```

5. **Create a Pull Request** to `main`

### Commit Message Convention

We use Conventional Commits:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Test additions or modifications
- `chore:` Build process or auxiliary tool changes

Example:
```
feat: add user authentication

- Implement JWT token generation
- Add login endpoint
- Add password hashing
```

## 🧪 Testing Requirements

Before submitting a PR:

1. **Unit Tests**: 80%+ coverage required
2. **Integration Tests**: 60%+ coverage required
3. **E2E Tests**: For critical user scenarios
4. **All tests must pass**

Run tests locally:
```bash
# See README for specific commands
```

## 📝 Pull Request Guidelines

### Before Submitting

- [ ] Code follows project coding standards
- [ ] All tests pass
- [ ] Code is properly formatted
- [ ] Type checking passes
- [ ] Documentation is updated
- [ ] Commit messages follow convention

### PR Description

Use the provided PR template and include:

1. **Summary**: Brief description of changes
2. **Related Issue**: Link to issue (use `Closes #123`)
3. **Changes**: What was changed and why
4. **Test Results**: Evidence that tests pass
5. **Screenshots**: For UI changes

### Review Process

1. **Automated Checks**: CI/CD must pass
2. **Code Review**: At least one approval required
3. **Size Limit**: PRs should be under 400 lines
4. **Time Limit**: Reviews should take under 60 minutes

If your PR is too large, consider splitting it into smaller PRs.

## 🏗️ Coding Standards

### General Principles

1. **Clean Architecture**: Follow the 4-layer architecture
2. **Type Safety**: Use strict type checking
3. **Dependency Direction**: Dependencies flow inward
4. **Single Responsibility**: Each module has one purpose
5. **DRY**: Don't Repeat Yourself

### Language-Specific

#### Python
- Use `uv` for dependency management
- Format with `ruff format`
- Lint with `ruff check`
- Type check with `pyright`
- Use type hints on all public APIs
- Use `dataclass` for data structures
- Use `Protocol` for interfaces

#### TypeScript
- Use `pnpm` for dependency management
- Format with `biome format`
- Lint with `biome lint`
- Type check with `tsc`
- Enable `strict` mode
- Avoid `any` type
- Use discriminated unions for error handling

## 🐛 Reporting Bugs

Use the Bug Report issue template and include:

1. **Description**: Clear description of the bug
2. **Severity**: Critical/High/Medium/Low
3. **Steps to Reproduce**: Detailed steps
4. **Expected Behavior**: What should happen
5. **Actual Behavior**: What actually happens
6. **Environment**: OS, version, etc.

## 💡 Suggesting Features

Use the Feature Requirement issue template and include:

1. **Description**: Clear description of the feature
2. **Use Case**: Why is this needed?
3. **Priority**: Critical/High/Medium/Low
4. **Acceptance Criteria**: How to verify completion
5. **Mockups**: Visual designs if applicable

## 🎨 UI/UX Changes

Use the UI/UX Design Request issue template and include:

1. **Design Type**: New screen/modification/component/flow
2. **Target Screens**: Which screens are affected
3. **Requirements**: Design requirements
4. **Figma Link**: Link to design files

## 🔒 Security Issues

**Do not report security vulnerabilities in public issues.**

See [SECURITY.md](SECURITY.md) for reporting instructions.

## 📚 Documentation

Documentation improvements are always welcome:

- Fix typos or unclear explanations
- Add examples or tutorials
- Improve API documentation
- Update outdated information

## ❓ Questions

If you have questions:

1. Check the [Wiki](../../wiki)
2. Search existing [Issues](../../issues)
3. Ask in [Discussions](../../discussions)
4. Contact the maintainers

## 🙏 Thank You

Your contributions make this project better for everyone. We appreciate your time and effort!
