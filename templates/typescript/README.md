# PROJECT_NAME

PROJECT_DESCRIPTION

## 🚀 Quick Start

### Prerequisites

- Node.js 20+
- pnpm 8+

### Installation

```bash
pnpm install
```

### Development

```bash
# Start development server
pnpm dev

# Build for production
pnpm build

# Run tests
pnpm test

# Run tests with coverage
pnpm test:coverage

# Run linter
pnpm lint

# Run formatter
pnpm format

# Run type checker
pnpm typecheck

# Run all checks
pnpm check
```

### Git Hooks

Git hooks are automatically installed via Husky. Pre-commit hooks will:
- Format code with Biome
- Lint code with Biome
- Type check with TypeScript

## 📁 Project Structure

```
PROJECT_NAME/
├── src/
│   ├── domain/              # Domain layer (entities, repositories)
│   ├── usecase/             # Use case layer (business logic)
│   ├── adapter/             # Adapter layer (controllers, presenters)
│   └── infrastructure/      # Infrastructure layer (database, external APIs)
├── tests/
│   ├── unit/                # Unit tests
│   ├── integration/         # Integration tests
│   └── e2e/                 # End-to-end tests
├── docs/                    # Documentation
└── package.json             # Project configuration
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
