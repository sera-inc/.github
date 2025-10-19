#!/bin/bash

set -e

PROJECT_DIR="${1:-.}"
PROJECT_TYPE="${2:-}"

if [ -z "$PROJECT_TYPE" ]; then
    echo "Usage: $0 <project_dir> <project_type>"
    echo "Project types: python, typescript"
    echo "Example: $0 . python"
    exit 1
fi

echo "🪝 Setting up Git hooks for $PROJECT_TYPE project..."

cd "$PROJECT_DIR"

case "$PROJECT_TYPE" in
    python)
        echo "📦 Setting up Python pre-commit hooks..."
        
        if [ ! -f ".pre-commit-config.yaml" ]; then
            cat > .pre-commit-config.yaml << 'EOF'
repos:
  - repo: local
    hooks:
      - id: ruff-format
        name: ruff format
        entry: uv run ruff format
        language: system
        types: [python]
        pass_filenames: false
      
      - id: ruff-check
        name: ruff check
        entry: uv run ruff check --fix
        language: system
        types: [python]
        pass_filenames: false
      
      - id: pyright
        name: pyright
        entry: uv run pyright
        language: system
        types: [python]
        pass_filenames: false
      
      - id: pytest-unit
        name: pytest unit tests
        entry: uv run pytest tests/unit -q
        language: system
        types: [python]
        pass_filenames: false
        stages: [commit]
EOF
            echo "✅ Created .pre-commit-config.yaml"
        else
            echo "⚠️  .pre-commit-config.yaml already exists, skipping..."
        fi
        
        if command -v uv &> /dev/null; then
            echo "📦 Installing pre-commit..."
            uv run pre-commit install
            echo "✅ Pre-commit hooks installed"
        else
            echo "⚠️  uv not found. Please install uv and run: uv run pre-commit install"
        fi
        ;;
    
    typescript)
        echo "📦 Setting up TypeScript Husky hooks..."
        
        if command -v pnpm &> /dev/null; then
            if [ ! -d ".husky" ]; then
                echo "📦 Installing Husky..."
                pnpm add -D husky lint-staged
                pnpm exec husky install
                
                mkdir -p .husky
                
                cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

pnpm exec lint-staged
EOF
                chmod +x .husky/pre-commit
                
                echo "✅ Created .husky/pre-commit"
            else
                echo "⚠️  .husky directory already exists, skipping..."
            fi
            
            if [ -f "package.json" ]; then
                if ! grep -q "lint-staged" package.json; then
                    echo "📝 Adding lint-staged configuration to package.json..."
                    echo "⚠️  Please add the following to your package.json manually:"
                    cat << 'EOF'

"lint-staged": {
  "*.{ts,tsx}": [
    "biome format --write",
    "biome lint --write",
    "tsc --noEmit"
  ]
}
EOF
                fi
            fi
            
            echo "✅ Husky hooks installed"
        else
            echo "⚠️  pnpm not found. Please install pnpm and run this script again"
        fi
        ;;
    
    *)
        echo "❌ Invalid project type: $PROJECT_TYPE"
        echo "Valid types: python, typescript"
        exit 1
        ;;
esac

echo ""
echo "✅ Git hooks setup complete!"
echo ""
echo "📝 Hooks configured:"
case "$PROJECT_TYPE" in
    python)
        echo "  - ruff format (code formatting)"
        echo "  - ruff check (linting)"
        echo "  - pyright (type checking)"
        echo "  - pytest unit tests"
        ;;
    typescript)
        echo "  - biome format (code formatting)"
        echo "  - biome lint (linting)"
        echo "  - tsc --noEmit (type checking)"
        ;;
esac
echo ""
echo "🧪 Test the hooks:"
case "$PROJECT_TYPE" in
    python)
        echo "  git add ."
        echo "  git commit -m 'test: verify pre-commit hooks'"
        ;;
    typescript)
        echo "  git add ."
        echo "  git commit -m 'test: verify husky hooks'"
        ;;
esac
echo ""
echo "💡 To skip hooks (not recommended):"
echo "  git commit --no-verify"
