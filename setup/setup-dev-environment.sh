#!/bin/bash

set -e

PROJECT_DIR="${1:-.}"
PROJECT_TYPE="${2:-}"
PROJECT_NAME="${3:-my-project}"

if [ -z "$PROJECT_TYPE" ]; then
    echo "Usage: $0 <project_dir> <project_type> [project_name]"
    echo "Project types: python, typescript"
    echo "Example: $0 . python my-project"
    exit 1
fi

echo "⚙️  Setting up development environment for $PROJECT_TYPE project..."

cd "$PROJECT_DIR"
TEMPLATE_DIR="$(dirname "$0")/../templates"

case "$PROJECT_TYPE" in
    python)
        echo "📦 Copying Python configuration files..."
        
        if [ -f "$TEMPLATE_DIR/python/pyproject.toml" ]; then
            cp "$TEMPLATE_DIR/python/pyproject.toml" pyproject.toml
            sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" pyproject.toml
            sed -i "s/PROJECT_DESCRIPTION/A Python project/g" pyproject.toml
            echo "✅ Created pyproject.toml"
        fi
        
        if [ -f "$TEMPLATE_DIR/python/pyrightconfig.json" ]; then
            cp "$TEMPLATE_DIR/python/pyrightconfig.json" pyrightconfig.json
            echo "✅ Created pyrightconfig.json"
        fi
        
        if [ -f "$TEMPLATE_DIR/python/.gitignore" ]; then
            cp "$TEMPLATE_DIR/python/.gitignore" .gitignore
            echo "✅ Created .gitignore"
        fi
        
        if [ -f "$TEMPLATE_DIR/python/README.md" ]; then
            cp "$TEMPLATE_DIR/python/README.md" README.md
            sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" README.md
            sed -i "s/PROJECT_DESCRIPTION/A Python project/g" README.md
            echo "✅ Created README.md"
        fi
        
        if [ -f "$TEMPLATE_DIR/common/SECURITY.md" ]; then
            cp "$TEMPLATE_DIR/common/SECURITY.md" SECURITY.md
            sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" SECURITY.md
            sed -i "s/\[SECURITY_EMAIL\]/security@example.com/g" SECURITY.md
            echo "✅ Created SECURITY.md"
        fi
        
        if [ -f "$TEMPLATE_DIR/common/CONTRIBUTING.md" ]; then
            cp "$TEMPLATE_DIR/common/CONTRIBUTING.md" CONTRIBUTING.md
            sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" CONTRIBUTING.md
            echo "✅ Created CONTRIBUTING.md"
        fi
        
        if command -v uv &> /dev/null; then
            echo "📦 Initializing Python environment with uv..."
            uv sync
            echo "✅ Dependencies installed"
        else
            echo "⚠️  uv not found. Please install uv: https://github.com/astral-sh/uv"
        fi
        ;;
    
    typescript)
        echo "📦 Copying TypeScript configuration files..."
        
        if [ -f "$TEMPLATE_DIR/typescript/package.json" ]; then
            cp "$TEMPLATE_DIR/typescript/package.json" package.json
            sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" package.json
            sed -i "s/PROJECT_DESCRIPTION/A TypeScript project/g" package.json
            echo "✅ Created package.json"
        fi
        
        if [ -f "$TEMPLATE_DIR/typescript/tsconfig.json" ]; then
            cp "$TEMPLATE_DIR/typescript/tsconfig.json" tsconfig.json
            echo "✅ Created tsconfig.json"
        fi
        
        if [ -f "$TEMPLATE_DIR/typescript/biome.json" ]; then
            cp "$TEMPLATE_DIR/typescript/biome.json" biome.json
            echo "✅ Created biome.json"
        fi
        
        if [ -f "$TEMPLATE_DIR/typescript/vitest.config.ts" ]; then
            cp "$TEMPLATE_DIR/typescript/vitest.config.ts" vitest.config.ts
            echo "✅ Created vitest.config.ts"
        fi
        
        if [ -f "$TEMPLATE_DIR/typescript/.gitignore" ]; then
            cp "$TEMPLATE_DIR/typescript/.gitignore" .gitignore
            echo "✅ Created .gitignore"
        fi
        
        if [ -f "$TEMPLATE_DIR/typescript/README.md" ]; then
            cp "$TEMPLATE_DIR/typescript/README.md" README.md
            sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" README.md
            sed -i "s/PROJECT_DESCRIPTION/A TypeScript project/g" README.md
            echo "✅ Created README.md"
        fi
        
        if [ -f "$TEMPLATE_DIR/common/SECURITY.md" ]; then
            cp "$TEMPLATE_DIR/common/SECURITY.md" SECURITY.md
            sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" SECURITY.md
            sed -i "s/\[SECURITY_EMAIL\]/security@example.com/g" SECURITY.md
            echo "✅ Created SECURITY.md"
        fi
        
        if [ -f "$TEMPLATE_DIR/common/CONTRIBUTING.md" ]; then
            cp "$TEMPLATE_DIR/common/CONTRIBUTING.md" CONTRIBUTING.md
            sed -i "s/PROJECT_NAME/$PROJECT_NAME/g" CONTRIBUTING.md
            echo "✅ Created CONTRIBUTING.md"
        fi
        
        if command -v pnpm &> /dev/null; then
            echo "📦 Installing dependencies with pnpm..."
            pnpm install
            echo "✅ Dependencies installed"
        else
            echo "⚠️  pnpm not found. Please install pnpm: npm install -g pnpm"
        fi
        ;;
    
    *)
        echo "❌ Invalid project type: $PROJECT_TYPE"
        echo "Valid types: python, typescript"
        exit 1
        ;;
esac

echo ""
echo "✅ Development environment setup complete!"
echo ""
echo "📝 Files created:"
case "$PROJECT_TYPE" in
    python)
        echo "  - pyproject.toml (Python project configuration)"
        echo "  - pyrightconfig.json (Type checker configuration)"
        echo "  - .gitignore (Git ignore rules)"
        echo "  - README.md (Project documentation)"
        echo "  - SECURITY.md (Security policy)"
        echo "  - CONTRIBUTING.md (Contribution guidelines)"
        ;;
    typescript)
        echo "  - package.json (Node.js project configuration)"
        echo "  - tsconfig.json (TypeScript configuration)"
        echo "  - biome.json (Linter and formatter configuration)"
        echo "  - vitest.config.ts (Test configuration)"
        echo "  - .gitignore (Git ignore rules)"
        echo "  - README.md (Project documentation)"
        echo "  - SECURITY.md (Security policy)"
        echo "  - CONTRIBUTING.md (Contribution guidelines)"
        ;;
esac
echo ""
echo "🚀 Next steps:"
case "$PROJECT_TYPE" in
    python)
        echo "  1. Review and customize pyproject.toml"
        echo "  2. Add your dependencies: uv add <package>"
        echo "  3. Run tests: uv run pytest"
        echo "  4. Run linter: uv run ruff check ."
        echo "  5. Run formatter: uv run ruff format ."
        echo "  6. Run type checker: uv run pyright"
        ;;
    typescript)
        echo "  1. Review and customize package.json"
        echo "  2. Add your dependencies: pnpm add <package>"
        echo "  3. Run tests: pnpm test"
        echo "  4. Run linter: pnpm lint"
        echo "  5. Run formatter: pnpm format"
        echo "  6. Run type checker: pnpm typecheck"
        ;;
esac
echo ""
echo "📚 For more information, see:"
echo "   - README.md (in this directory)"
echo "   - CONTRIBUTING.md (contribution guidelines)"
echo "   - https://github.com/sera-inc/engineering-handbook"
