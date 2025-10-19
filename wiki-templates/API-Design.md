# API Design

## Overview

This document describes the API design guidelines for PROJECT_NAME, including REST API conventions, error handling, and versioning strategy.

## REST API Conventions

### HTTP Methods

- `GET`: Retrieve resources (idempotent, safe)
- `POST`: Create new resources
- `PUT`: Replace entire resource (idempotent)
- `PATCH`: Partial update of resource (idempotent)
- `DELETE`: Remove resource (idempotent)

### URL Structure

```
/api/v1/{resource}/{id}/{sub-resource}
```

**Examples**:
- `GET /api/v1/users` - List all users
- `GET /api/v1/users/123` - Get user by ID
- `POST /api/v1/users` - Create new user
- `PUT /api/v1/users/123` - Update user
- `DELETE /api/v1/users/123` - Delete user
- `GET /api/v1/users/123/orders` - Get user's orders

### Naming Conventions

- Use **plural nouns** for resources: `/users`, `/orders`
- Use **kebab-case** for multi-word resources: `/order-items`
- Use **lowercase** only
- Avoid verbs in URLs (use HTTP methods instead)

### Query Parameters

**Filtering**:
```
GET /api/v1/users?status=active&role=admin
```

**Sorting**:
```
GET /api/v1/users?sort=created_at&order=desc
```

**Pagination**:
```
GET /api/v1/users?page=2&limit=20
```

**Field Selection**:
```
GET /api/v1/users?fields=id,name,email
```

## Request/Response Format

### Request Body (JSON)

```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "role": "admin"
}
```

### Response Body (JSON)

**Success Response**:
```json
{
  "data": {
    "id": "123",
    "name": "John Doe",
    "email": "john@example.com",
    "role": "admin",
    "created_at": "2024-01-01T00:00:00Z"
  }
}
```

**List Response**:
```json
{
  "data": [
    { "id": "123", "name": "John Doe" },
    { "id": "456", "name": "Jane Smith" }
  ],
  "meta": {
    "total": 100,
    "page": 1,
    "limit": 20,
    "total_pages": 5
  }
}
```

## HTTP Status Codes

### Success Codes

- `200 OK`: Successful GET, PUT, PATCH, DELETE
- `201 Created`: Successful POST (resource created)
- `204 No Content`: Successful DELETE (no response body)

### Client Error Codes

- `400 Bad Request`: Invalid request format or validation error
- `401 Unauthorized`: Authentication required
- `403 Forbidden`: Authenticated but not authorized
- `404 Not Found`: Resource not found
- `409 Conflict`: Resource conflict (e.g., duplicate)
- `422 Unprocessable Entity`: Validation error

### Server Error Codes

- `500 Internal Server Error`: Unexpected server error
- `503 Service Unavailable`: Service temporarily unavailable

## Error Response Format

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      },
      {
        "field": "password",
        "message": "Password must be at least 8 characters"
      }
    ]
  }
}
```

### Error Codes

- `VALIDATION_ERROR`: Input validation failed
- `AUTHENTICATION_ERROR`: Authentication failed
- `AUTHORIZATION_ERROR`: Not authorized
- `NOT_FOUND`: Resource not found
- `CONFLICT`: Resource conflict
- `INTERNAL_ERROR`: Internal server error

## Authentication

### JWT Bearer Token

```http
Authorization: Bearer <token>
```

**Token Structure**:
```json
{
  "sub": "user_id",
  "exp": 1234567890,
  "iat": 1234567890,
  "role": "admin"
}
```

## Versioning

### URL Versioning

```
/api/v1/users
/api/v2/users
```

**Rules**:
- Major version in URL path
- Breaking changes require new version
- Support at least 2 versions simultaneously
- Deprecation notice 6 months before removal

## Rate Limiting

**Headers**:
```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1234567890
```

**Response when limit exceeded**:
```http
HTTP/1.1 429 Too Many Requests
Retry-After: 3600
```

## CORS

**Allowed Origins**: Configure in environment variables

**Allowed Methods**: GET, POST, PUT, PATCH, DELETE, OPTIONS

**Allowed Headers**: Content-Type, Authorization

## API Documentation

Use OpenAPI (Swagger) specification:

```yaml
openapi: 3.0.0
info:
  title: PROJECT_NAME API
  version: 1.0.0
paths:
  /api/v1/users:
    get:
      summary: List users
      responses:
        '200':
          description: Successful response
```

## Best Practices

1. **Idempotency**: GET, PUT, PATCH, DELETE should be idempotent
2. **Consistency**: Use consistent naming and structure
3. **Validation**: Validate all inputs
4. **Security**: Always use HTTPS in production
5. **Documentation**: Keep API docs up to date
6. **Versioning**: Plan for API evolution
7. **Testing**: Write integration tests for all endpoints
8. **Monitoring**: Log all API requests and errors

## Examples

### Python (FastAPI)

```python
from fastapi import APIRouter, HTTPException, status
from pydantic import BaseModel

router = APIRouter(prefix="/api/v1")

class UserCreate(BaseModel):
    name: str
    email: str

class UserResponse(BaseModel):
    id: str
    name: str
    email: str
    created_at: str

@router.post("/users", status_code=status.HTTP_201_CREATED)
async def create_user(user: UserCreate) -> UserResponse:
    try:
        result = await create_user_use_case.execute(user.name, user.email)
        return UserResponse.from_domain(result)
    except ValidationError as e:
        raise HTTPException(status_code=400, detail=str(e))
```

### TypeScript (Express)

```typescript
import { Router } from 'express';

const router = Router();

router.post('/api/v1/users', async (req, res) => {
  try {
    const user = await createUserUseCase.execute(req.body.name, req.body.email);
    res.status(201).json({ data: UserResponse.fromDomain(user) });
  } catch (error) {
    if (error instanceof ValidationError) {
      res.status(400).json({
        error: {
          code: 'VALIDATION_ERROR',
          message: error.message,
        },
      });
    }
  }
});
```

## References

- [REST API Design Best Practices](https://restfulapi.net/)
- [HTTP Status Codes](https://httpstatuses.com/)
- [OpenAPI Specification](https://swagger.io/specification/)
