# PROJECT_NAME

PROJECT_DESCRIPTION

## 🚀 Quick Start

### Prerequisites

- Python 3.11+
- [uv](https://github.com/astral-sh/uv) (recommended) or pip

### Installation

```bash
# Using uv (recommended)
uv sync

# Or using pip
pip install -e ".[dev]"
```

### Development

```bash
# Run tests
uv run pytest

# Run tests with coverage
uv run pytest --cov

# Run linter
uv run ruff check .

# Run formatter
uv run ruff format .

# Run type checker
uv run pyright
```

### Pre-commit Hooks

```bash
# Install pre-commit hooks
uv run pre-commit install

# Run manually
uv run pre-commit run --all-files
```

## 📁 Project Structure

```
PROJECT_NAME/
├── src/
│   └── PROJECT_NAME/
│       ├── domain/              # Domain layer (entities, repositories)
│       ├── usecase/             # Use case layer (business logic)
│       ├── adapter/             # Adapter layer (controllers, presenters)
│       └── infrastructure/      # Infrastructure layer (database, external APIs)
├── tests/
│   ├── unit/                    # Unit tests
│   ├── integration/             # Integration tests
│   └── e2e/                     # End-to-end tests
├── docs/                        # Documentation
└── pyproject.toml               # Project configuration
```

## 🏗️ Architecture

This project follows Clean Architecture principles:

- **Domain Layer**: Core business entities and repository interfaces
- **Use Case Layer**: Application-specific business rules
- **Adapter Layer**: Interface adapters (controllers, presenters)
- **Infrastructure Layer**: External interfaces (database, APIs, frameworks)

Dependencies flow inward: Infrastructure → Adapter → Use Case → Domain

## 📚 Documentation

- [Project Wiki](../../wiki)
- [API Documentation](../../wiki/API-Design)
- [Architecture Decision Records](../../wiki/ADR)

## 🧪 Testing

- Unit tests: 80%+ coverage required
- Integration tests: 60%+ coverage required
- E2E tests: Critical user scenarios

## 🔒 Security

- Report security vulnerabilities via GitHub Security Advisories
- See [Security Policy](SECURITY.md)

## 📄 License

[LICENSE TYPE] - See [LICENSE](LICENSE) file for details
