# Test Plan

## Overview

This document describes the testing strategy for PROJECT_NAME, including test types, coverage requirements, and testing procedures.

> **Test Case Management**: For detailed test case documentation and execution tracking, use one of the following templates:
> - **Local**: [test-case-template.xlsx](./test-case-template.xlsx)
> - **Online**: [Google Sheets version](https://docs.google.com/spreadsheets/d/1PquS0YWC_r1TyrKVpJ_l2-TEIVzk-lJw/edit?gid=1858056975#gid=1858056975)
> 
> These templates include structured fields for test item ID, functional requirement ID, test procedures, expected results, and more.

## Test Pyramid

```
        /\
       /E2E\        Critical scenarios only
      /------\
     /  Inte  \     60%+ coverage
    /----------\
   /    Unit    \   80%+ coverage
  /--------------\
```

## Test Types

### 1. Unit Tests

**Purpose**: Test individual functions, classes, and modules in isolation

**Coverage Target**: 80%+

**Execution Time**: < 5 minutes

**Tools**:
- Python: `pytest`
- TypeScript: `vitest`

**Characteristics**:
- Fast execution
- No external dependencies
- Use mocks/stubs for dependencies
- Follow AAA pattern (Arrange-Act-Assert)

**Example (Python)**:
```python
def test_create_user():
    # Arrange
    repository = MockUserRepository()
    use_case = CreateUserUseCase(repository)
    
    # Act
    user = use_case.execute("John Doe", "john@example.com")
    
    # Assert
    assert user.name == "John Doe"
    assert user.email == "john@example.com"
    assert repository.save_called
```

**Example (TypeScript)**:
```typescript
describe('CreateUserUseCase', () => {
  it('should create user successfully', async () => {
    // Arrange
    const repository = new MockUserRepository();
    const useCase = new CreateUserUseCase(repository);
    
    // Act
    const user = await useCase.execute('John Doe', 'john@example.com');
    
    // Assert
    expect(user.name).toBe('John Doe');
    expect(user.email).toBe('john@example.com');
    expect(repository.saveCalled).toBe(true);
  });
});
```

### 2. Integration Tests

**Purpose**: Test interaction between multiple components

**Coverage Target**: 60%+

**Execution Time**: < 15 minutes

**Tools**:
- Python: `pytest` + `Testcontainers`
- TypeScript: `vitest` + `Testcontainers`

**Characteristics**:
- Test real database interactions
- Test external API integrations
- Use real dependencies when possible
- Use Testcontainers for databases

**Example (Python)**:
```python
@pytest.fixture
def db_container():
    with PostgresContainer("postgres:15") as postgres:
        yield postgres

def test_user_repository_integration(db_container):
    # Arrange
    db = Database(db_container.get_connection_url())
    repository = UserRepositoryImpl(db)
    user = User(id="123", name="John", email="john@example.com")
    
    # Act
    repository.save(user)
    found_user = repository.find_by_id("123")
    
    # Assert
    assert found_user is not None
    assert found_user.name == "John"
```

### 3. End-to-End (E2E) Tests

**Purpose**: Test complete user workflows

**Coverage Target**: Critical scenarios only

**Execution Time**: < 30 minutes

**Tools**:
- Python: `pytest` + `httpx`
- TypeScript: `Playwright`

**Characteristics**:
- Test from user perspective
- Test critical business flows
- Use real or staging environment
- Include UI testing for web apps

**Example (TypeScript + Playwright)**:
```typescript
test('user registration flow', async ({ page }) => {
  // Navigate to registration page
  await page.goto('/register');
  
  // Fill registration form
  await page.fill('[name="name"]', 'John Doe');
  await page.fill('[name="email"]', 'john@example.com');
  await page.fill('[name="password"]', 'password123');
  
  // Submit form
  await page.click('button[type="submit"]');
  
  // Verify success
  await expect(page.locator('.success-message')).toBeVisible();
});
```

### 4. Security Tests

**Purpose**: Identify security vulnerabilities

**Tools**:
- SAST: `bandit` (Python), `eslint-plugin-security` (TypeScript)
- DAST: `OWASP ZAP`
- Dependency scanning: `Dependabot`, `Snyk`

**Test Cases**:
- SQL injection
- XSS (Cross-Site Scripting)
- CSRF (Cross-Site Request Forgery)
- Authentication bypass
- Authorization bypass
- Sensitive data exposure

### 5. Performance Tests

**Purpose**: Verify system performance under load

**Tools**:
- `Locust` (Python)
- `k6` (JavaScript)

**Test Types**:
- **Load Test**: Normal expected load
- **Stress Test**: Beyond normal capacity
- **Spike Test**: Sudden traffic increase
- **Soak Test**: Extended duration

**Metrics**:
- Response time (p50, p95, p99)
- Throughput (requests/second)
- Error rate
- Resource utilization (CPU, memory)

## Test Case Documentation

### Test Case Template (Excel)

For structured test case management, use one of the following templates:
- **Local**: [test-case-template.xlsx](./test-case-template.xlsx)
- **Online**: [Google Sheets version](https://docs.google.com/spreadsheets/d/1PquS0YWC_r1TyrKVpJ_l2-TEIVzk-lJw/edit?gid=1858056975#gid=1858056975)

These templates include:

**Required Fields**:
- **Test Item ID**: Unique identifier (e.g., TC-001, TC-002)
- **Functional Requirement ID**: Links to requirement documentation (e.g., FR-001)
- **Major Category**: High-level functional area (e.g., Login Function, Data Management)
- **Minor Category**: Specific test category (e.g., Normal Login, Error Login)
- **Test Item Name**: Clear description of what is being tested
- **Test Perspective**: Normal case, error case, boundary value, performance, etc.
- **Preconditions**: System state and data requirements before test
- **Test Procedure**: Numbered steps to execute the test
- **Input Data**: Specific test data to use
- **Expected Result (Acceptance Criteria)**: Clear, measurable success criteria
- **Actual Result**: Recorded during test execution
- **Judgment**: Pass / Fail / Pending / Not Executed
- **Priority**: High / Medium / Low
- **Test Executor**: Name of person executing the test
- **Test Execution Date**: Date in YYYY/MM/DD format
- **Notes**: Additional information, constraints, bug IDs

**Acceptance Criteria Guidelines**:
1. **Measurable**: Use specific outcomes (e.g., "Dashboard screen is displayed" not "Works correctly")
2. **Clear**: Avoid ambiguity - anyone should interpret the same way
3. **Complete**: Include all expected results without omissions
4. **Verifiable**: Only include what can be actually tested

## Test Organization

### Directory Structure

```
tests/
├── unit/
│   ├── domain/
│   ├── usecase/
│   └── adapter/
├── integration/
│   ├── repository/
│   └── api/
└── e2e/
    ├── user_flows/
    └── critical_scenarios/
```

## Test Execution

### Local Development

```bash
# Python
uv run pytest tests/unit -v          # Unit tests only
uv run pytest tests/integration -v   # Integration tests
uv run pytest tests/e2e -v          # E2E tests
uv run pytest --cov                  # All tests with coverage

# TypeScript
pnpm test:unit                       # Unit tests only
pnpm test:integration                # Integration tests
pnpm test:e2e                        # E2E tests
pnpm test:coverage                   # All tests with coverage
```

### CI/CD Pipeline

1. **Pre-commit**: Unit tests (fast feedback)
2. **PR Creation**: Unit + Integration tests
3. **Pre-merge**: All tests including E2E
4. **Pre-deployment**: E2E + Performance tests

## Coverage Requirements

### Minimum Coverage

- **Unit Tests**: 80%
- **Integration Tests**: 60%
- **E2E Tests**: Critical user scenarios

### Coverage Exclusions

- Generated code
- Configuration files
- Test files themselves
- Third-party code

## Test Data Management

### Test Data Strategy

1. **Unit Tests**: Use in-memory data, mocks
2. **Integration Tests**: Use Testcontainers with seed data
3. **E2E Tests**: Use dedicated test database with fixtures

### Test Data Cleanup

- Clean up after each test
- Use transactions and rollback
- Use database migrations for schema

## Mocking Strategy

### When to Mock

- External APIs
- Slow operations
- Non-deterministic behavior
- Third-party services

### When NOT to Mock

- Domain logic
- Database operations (use Testcontainers)
- Simple functions

### Mock Examples

**Python**:
```python
from unittest.mock import Mock, patch

def test_with_mock():
    mock_repository = Mock(spec=IUserRepository)
    mock_repository.find_by_id.return_value = User(id="123", name="John")
    
    use_case = GetUserUseCase(mock_repository)
    user = use_case.execute("123")
    
    assert user.name == "John"
    mock_repository.find_by_id.assert_called_once_with("123")
```

**TypeScript**:
```typescript
import { vi } from 'vitest';

test('with mock', () => {
  const mockRepository = {
    findById: vi.fn().mockResolvedValue({ id: '123', name: 'John' }),
  };
  
  const useCase = new GetUserUseCase(mockRepository);
  const user = await useCase.execute('123');
  
  expect(user.name).toBe('John');
  expect(mockRepository.findById).toHaveBeenCalledWith('123');
});
```

## Test Quality Guidelines

### Good Test Characteristics

1. **Fast**: Unit tests should run in milliseconds
2. **Isolated**: Tests don't depend on each other
3. **Repeatable**: Same result every time
4. **Self-validating**: Pass or fail, no manual verification
5. **Timely**: Written before or with production code

### Test Naming

```python
# Python
def test_create_user_with_valid_data_should_succeed():
    pass

def test_create_user_with_invalid_email_should_raise_error():
    pass
```

```typescript
// TypeScript
describe('CreateUserUseCase', () => {
  it('should create user with valid data', () => {});
  it('should throw error with invalid email', () => {});
});
```

## Continuous Testing

### Pre-commit Hooks

- Run unit tests
- Run linter
- Run type checker

### CI/CD Integration

- Automated test execution on PR
- Coverage reports
- Test result notifications
- Block merge if tests fail

## Test Metrics

### Track These Metrics

- Test coverage percentage
- Test execution time
- Test failure rate
- Flaky test count
- Time to fix failing tests

### Coverage Reports

Generate and review coverage reports:

```bash
# Python
uv run pytest --cov --cov-report=html
open htmlcov/index.html

# TypeScript
pnpm test:coverage
open coverage/index.html
```

## References

- [Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)
- [Engineering Handbook - Test Strategy](https://github.com/sera-inc/engineering-handbook/blob/main/docs/03-quality-assurance/test-strategy.md)
- [pytest Documentation](https://docs.pytest.org/)
- [Vitest Documentation](https://vitest.dev/)
- [Playwright Documentation](https://playwright.dev/)
