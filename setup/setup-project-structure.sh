#!/bin/bash

set -e

PROJECT_DIR="${1:-.}"
PROJECT_TYPE="${2:-}"
PROJECT_NAME="${3:-}"

if [ -z "$PROJECT_TYPE" ] || [ -z "$PROJECT_NAME" ]; then
    echo "Usage: $0 <project_dir> <project_type> <project_name>"
    echo "Project types: python, typescript"
    echo "Example: $0 . python my-project"
    exit 1
fi

echo "🏗️  Creating project structure for $PROJECT_TYPE project: $PROJECT_NAME..."

cd "$PROJECT_DIR"

case "$PROJECT_TYPE" in
    python)
        echo "📦 Creating Python project structure (Clean Architecture)..."
        
        mkdir -p src/"$PROJECT_NAME"/{domain,usecase,adapter,infrastructure}
        mkdir -p tests/{unit,integration,e2e}
        mkdir -p tests/unit/{domain,usecase,adapter,infrastructure}
        mkdir -p tests/integration/{repository,api}
        mkdir -p docs
        
        touch src/"$PROJECT_NAME"/__init__.py
        touch src/"$PROJECT_NAME"/domain/__init__.py
        touch src/"$PROJECT_NAME"/usecase/__init__.py
        touch src/"$PROJECT_NAME"/adapter/__init__.py
        touch src/"$PROJECT_NAME"/infrastructure/__init__.py
        
        touch tests/__init__.py
        touch tests/unit/__init__.py
        touch tests/integration/__init__.py
        touch tests/e2e/__init__.py
        
        cat > src/"$PROJECT_NAME"/domain/__init__.py << 'EOF'
"""
Domain Layer

This layer contains:
- Business entities
- Repository interfaces (using Protocol)
- Domain exceptions
- Value objects

Rules:
- No dependencies on other layers
- No I/O operations
- No framework dependencies
- Pure business logic only
"""
EOF
        
        cat > src/"$PROJECT_NAME"/usecase/__init__.py << 'EOF'
"""
Use Case Layer

This layer contains:
- Application-specific business rules
- Use case implementations
- Business workflow orchestration

Rules:
- Depends only on Domain layer
- No framework dependencies
- No I/O operations (delegates to repositories)
"""
EOF
        
        cat > src/"$PROJECT_NAME"/adapter/__init__.py << 'EOF'
"""
Adapter Layer

This layer contains:
- Controllers (HTTP, CLI, etc.)
- Presenters (format output)
- Input validation
- Data conversion

Rules:
- Depends on Domain and Use Case layers
- No direct database or external API calls
- Framework-specific code allowed
"""
EOF
        
        cat > src/"$PROJECT_NAME"/infrastructure/__init__.py << 'EOF'
"""
Infrastructure Layer

This layer contains:
- Repository implementations
- Database access
- External API calls
- File system operations
- Framework configuration

Rules:
- Depends on all other layers
- Implements interfaces defined in Domain layer
- Contains all I/O operations
"""
EOF
        
        echo "✅ Python project structure created"
        ;;
    
    typescript)
        echo "📦 Creating TypeScript project structure (Clean Architecture)..."
        
        mkdir -p src/{domain,usecase,adapter,infrastructure}
        mkdir -p tests/{unit,integration,e2e}
        mkdir -p tests/unit/{domain,usecase,adapter,infrastructure}
        mkdir -p tests/integration/{repository,api}
        mkdir -p docs
        
        cat > src/domain/index.ts << 'EOF'
/**
 * Domain Layer
 *
 * This layer contains:
 * - Business entities
 * - Repository interfaces
 * - Domain exceptions
 * - Value objects
 *
 * Rules:
 * - No dependencies on other layers
 * - No I/O operations
 * - No framework dependencies
 * - Pure business logic only
 */

export {};
EOF
        
        cat > src/usecase/index.ts << 'EOF'
/**
 * Use Case Layer
 *
 * This layer contains:
 * - Application-specific business rules
 * - Use case implementations
 * - Business workflow orchestration
 *
 * Rules:
 * - Depends only on Domain layer
 * - No framework dependencies
 * - No I/O operations (delegates to repositories)
 */

export {};
EOF
        
        cat > src/adapter/index.ts << 'EOF'
/**
 * Adapter Layer
 *
 * This layer contains:
 * - Controllers (HTTP, CLI, etc.)
 * - Presenters (format output)
 * - Input validation
 * - Data conversion
 *
 * Rules:
 * - Depends on Domain and Use Case layers
 * - No direct database or external API calls
 * - Framework-specific code allowed
 */

export {};
EOF
        
        cat > src/infrastructure/index.ts << 'EOF'
/**
 * Infrastructure Layer
 *
 * This layer contains:
 * - Repository implementations
 * - Database access
 * - External API calls
 * - File system operations
 * - Framework configuration
 *
 * Rules:
 * - Depends on all other layers
 * - Implements interfaces defined in Domain layer
 * - Contains all I/O operations
 */

export {};
EOF
        
        cat > src/index.ts << 'EOF'
/**
 * Main entry point
 */

export * from './domain';
export * from './usecase';
export * from './adapter';
export * from './infrastructure';
EOF
        
        echo "✅ TypeScript project structure created"
        ;;
    
    *)
        echo "❌ Invalid project type: $PROJECT_TYPE"
        echo "Valid types: python, typescript"
        exit 1
        ;;
esac

echo ""
echo "✅ Project structure created successfully!"
echo ""
echo "📁 Directory structure:"
tree -L 3 -I '__pycache__|*.pyc|node_modules' . || ls -R
echo ""
echo "📚 Layer descriptions:"
echo ""
echo "1. Domain Layer (src/$PROJECT_NAME/domain or src/domain)"
echo "   - Core business entities and rules"
echo "   - Repository interfaces"
echo "   - No external dependencies"
echo ""
echo "2. Use Case Layer (src/$PROJECT_NAME/usecase or src/usecase)"
echo "   - Application-specific business logic"
echo "   - Orchestrates domain entities"
echo "   - Depends only on Domain layer"
echo ""
echo "3. Adapter Layer (src/$PROJECT_NAME/adapter or src/adapter)"
echo "   - Controllers and presenters"
echo "   - Input/output conversion"
echo "   - Depends on Domain and Use Case layers"
echo ""
echo "4. Infrastructure Layer (src/$PROJECT_NAME/infrastructure or src/infrastructure)"
echo "   - Database implementations"
echo "   - External API integrations"
echo "   - All I/O operations"
echo ""
echo "📝 Next steps:"
echo "  1. Start implementing domain entities"
echo "  2. Define repository interfaces in domain layer"
echo "  3. Implement use cases"
echo "  4. Create adapters (controllers)"
echo "  5. Implement infrastructure (repositories)"
echo ""
echo "📚 For more information, see:"
echo "   - https://github.com/sera-inc/engineering-handbook/blob/main/docs/05-architecture/clean-architecture.md"
