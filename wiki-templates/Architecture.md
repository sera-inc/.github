# Architecture

## Overview

This document describes the architecture of PROJECT_NAME, including design principles, layer structure, and key architectural decisions.

## Architecture Principles

### Clean Architecture

This project follows Clean Architecture principles with four distinct layers:

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

**Dependency Rule**: Dependencies point inward only. Inner layers never depend on outer layers.

### Layers

#### 1. Domain Layer

**Purpose**: Core business entities and repository interfaces

**Responsibilities**:
- Define business entities
- Define repository interfaces (using Protocol/Interface)
- Define domain exceptions
- Define value objects

**Rules**:
- No dependencies on other layers
- No I/O operations
- No framework dependencies
- Pure business logic only

**Example**:
```python
# Python
from dataclasses import dataclass
from typing import Protocol

@dataclass(frozen=True)
class User:
    id: str
    name: str
    email: str

class IUserRepository(Protocol):
    def find_by_id(self, user_id: str) -> User | None: ...
    def save(self, user: User) -> None: ...
```

```typescript
// TypeScript
interface User {
  readonly id: string;
  readonly name: string;
  readonly email: string;
}

interface IUserRepository {
  findById(userId: string): Promise<User | null>;
  save(user: User): Promise<void>;
}
```

#### 2. Use Case Layer

**Purpose**: Application-specific business rules

**Responsibilities**:
- Orchestrate domain entities
- Implement business workflows
- Define use case interfaces
- Handle business logic errors

**Rules**:
- Depends only on Domain layer
- No framework dependencies
- No I/O operations (delegates to repositories)

**Example**:
```python
# Python
class CreateUserUseCase:
    def __init__(self, user_repository: IUserRepository):
        self._user_repository = user_repository
    
    def execute(self, name: str, email: str) -> User:
        user = User(id=generate_id(), name=name, email=email)
        self._user_repository.save(user)
        return user
```

```typescript
// TypeScript
class CreateUserUseCase {
  constructor(private userRepository: IUserRepository) {}
  
  async execute(name: string, email: string): Promise<User> {
    const user: User = { id: generateId(), name, email };
    await this.userRepository.save(user);
    return user;
  }
}
```

#### 3. Adapter Layer

**Purpose**: Interface adapters (controllers, presenters)

**Responsibilities**:
- Convert data between use cases and external interfaces
- Implement controllers (HTTP, CLI, etc.)
- Implement presenters (format output)
- Handle input validation

**Rules**:
- Depends on Domain and Use Case layers
- No direct database or external API calls
- Framework-specific code allowed

**Example**:
```python
# Python (FastAPI)
from fastapi import APIRouter, HTTPException

router = APIRouter()

@router.post("/users")
async def create_user(request: CreateUserRequest):
    try:
        user = create_user_use_case.execute(request.name, request.email)
        return UserResponse.from_domain(user)
    except DomainError as e:
        raise HTTPException(status_code=400, detail=str(e))
```

```typescript
// TypeScript (Express)
router.post('/users', async (req, res) => {
  try {
    const user = await createUserUseCase.execute(req.body.name, req.body.email);
    res.json(UserResponse.fromDomain(user));
  } catch (error) {
    if (error instanceof DomainError) {
      res.status(400).json({ error: error.message });
    }
  }
});
```

#### 4. Infrastructure Layer

**Purpose**: External interfaces (database, APIs, frameworks)

**Responsibilities**:
- Implement repository interfaces
- Database access
- External API calls
- File system operations
- Framework configuration

**Rules**:
- Depends on Domain, Use Case, and Adapter layers
- Implements interfaces defined in Domain layer
- Contains all I/O operations

**Example**:
```python
# Python
class UserRepositoryImpl(IUserRepository):
    def __init__(self, db: Database):
        self._db = db
    
    def find_by_id(self, user_id: str) -> User | None:
        row = self._db.query("SELECT * FROM users WHERE id = ?", user_id)
        return User(**row) if row else None
    
    def save(self, user: User) -> None:
        self._db.execute(
            "INSERT INTO users (id, name, email) VALUES (?, ?, ?)",
            user.id, user.name, user.email
        )
```

## Modular Monolith

This project uses a Modular Monolith architecture:

- Single deployable unit
- Clear module boundaries
- Modules communicate via defined interfaces
- Enables future microservices migration if needed

### Module Structure

```
src/
├── users/
│   ├── domain/
│   ├── usecase/
│   ├── adapter/
│   └── infrastructure/
├── orders/
│   ├── domain/
│   ├── usecase/
│   ├── adapter/
│   └── infrastructure/
└── shared/
    └── domain/
```

## Key Architectural Decisions

See [Architecture Decision Records](./ADR) for detailed decisions.

## Diagrams

### System Context Diagram

```
[Add C4 Context diagram here]
```

### Container Diagram

```
[Add C4 Container diagram here]
```

### Component Diagram

```
[Add C4 Component diagram here]
```

## References

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Engineering Handbook - Architecture Principles](https://github.com/sera-inc/engineering-handbook/blob/main/docs/05-architecture/architecture-principles.md)
