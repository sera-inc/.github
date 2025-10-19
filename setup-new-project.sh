#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SETUP_DIR="$SCRIPT_DIR/setup"

echo "🚀 Welcome to Sera Inc. Project Initialization System"
echo "======================================================"
echo ""

show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Initialize a new project with all Sera Inc. engineering standards.

OPTIONS:
    -h, --help              Show this help message
    -d, --dir DIR           Project directory (default: current directory)
    -t, --type TYPE         Project type: python, typescript (required)
    -n, --name NAME         Project name (required)
    -o, --owner OWNER       GitHub owner/organization (required)
    -r, --repo REPO         GitHub repository name (required)
    -g, --token TOKEN       GitHub personal access token (required)
    --skip-structure        Skip project structure creation
    --skip-env              Skip development environment setup
    --skip-hooks            Skip Git hooks setup
    --skip-workflows        Skip CI/CD workflows setup
    --skip-labels           Skip GitHub labels setup
    --skip-wiki             Skip GitHub Wiki setup
    --skip-projects         Skip GitHub Projects setup

EXAMPLES:
    $0

    $0 -d ./my-project -t python -n my-project -o sera-inc -r my-project -g ghp_xxxxx

    $0 -t python -n my-project -o sera-inc -r my-project -g ghp_xxxxx --skip-projects

EOF
}

PROJECT_DIR="."
PROJECT_TYPE=""
PROJECT_NAME=""
GITHUB_OWNER=""
GITHUB_REPO=""
GITHUB_TOKEN=""
SKIP_STRUCTURE=false
SKIP_ENV=false
SKIP_HOOKS=false
SKIP_WORKFLOWS=false
SKIP_LABELS=false
SKIP_WIKI=false
SKIP_PROJECTS=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            exit 0
            ;;
        -d|--dir)
            PROJECT_DIR="$2"
            shift 2
            ;;
        -t|--type)
            PROJECT_TYPE="$2"
            shift 2
            ;;
        -n|--name)
            PROJECT_NAME="$2"
            shift 2
            ;;
        -o|--owner)
            GITHUB_OWNER="$2"
            shift 2
            ;;
        -r|--repo)
            GITHUB_REPO="$2"
            shift 2
            ;;
        -g|--token)
            GITHUB_TOKEN="$2"
            shift 2
            ;;
        --skip-structure)
            SKIP_STRUCTURE=true
            shift
            ;;
        --skip-env)
            SKIP_ENV=true
            shift
            ;;
        --skip-hooks)
            SKIP_HOOKS=true
            shift
            ;;
        --skip-workflows)
            SKIP_WORKFLOWS=true
            shift
            ;;
        --skip-labels)
            SKIP_LABELS=true
            shift
            ;;
        --skip-wiki)
            SKIP_WIKI=true
            shift
            ;;
        --skip-projects)
            SKIP_PROJECTS=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

if [ -z "$PROJECT_TYPE" ] || [ -z "$PROJECT_NAME" ] || [ -z "$GITHUB_OWNER" ] || [ -z "$GITHUB_REPO" ] || [ -z "$GITHUB_TOKEN" ]; then
    echo "📝 Interactive Setup Mode"
    echo ""
    
    if [ -z "$PROJECT_TYPE" ]; then
        echo "Select project type:"
        echo "  1) Python"
        echo "  2) TypeScript"
        read -p "Enter choice (1 or 2): " choice
        case $choice in
            1) PROJECT_TYPE="python" ;;
            2) PROJECT_TYPE="typescript" ;;
            *) echo "Invalid choice"; exit 1 ;;
        esac
    fi
    
    if [ -z "$PROJECT_NAME" ]; then
        read -p "Enter project name: " PROJECT_NAME
    fi
    
    if [ -z "$GITHUB_OWNER" ]; then
        read -p "Enter GitHub owner/organization (e.g., sera-inc): " GITHUB_OWNER
    fi
    
    if [ -z "$GITHUB_REPO" ]; then
        read -p "Enter GitHub repository name (default: $PROJECT_NAME): " GITHUB_REPO
        GITHUB_REPO="${GITHUB_REPO:-$PROJECT_NAME}"
    fi
    
    if [ -z "$GITHUB_TOKEN" ]; then
        read -sp "Enter GitHub personal access token: " GITHUB_TOKEN
        echo ""
    fi
fi

echo ""
echo "📋 Configuration Summary"
echo "========================"
echo "Project Directory: $PROJECT_DIR"
echo "Project Type: $PROJECT_TYPE"
echo "Project Name: $PROJECT_NAME"
echo "GitHub Owner: $GITHUB_OWNER"
echo "GitHub Repository: $GITHUB_REPO"
echo ""

read -p "Proceed with initialization? (y/n): " confirm
if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Initialization cancelled."
    exit 0
fi

echo ""
echo "🎯 Starting Project Initialization..."
echo ""

mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

STEP=1
TOTAL_STEPS=7

if [ "$SKIP_STRUCTURE" = false ]; then
    echo "[$STEP/$TOTAL_STEPS] 🏗️  Creating project structure..."
    "$SETUP_DIR/setup-project-structure.sh" . "$PROJECT_TYPE" "$PROJECT_NAME"
    echo ""
    ((STEP++))
fi

if [ "$SKIP_ENV" = false ]; then
    echo "[$STEP/$TOTAL_STEPS] ⚙️  Setting up development environment..."
    "$SETUP_DIR/setup-dev-environment.sh" . "$PROJECT_TYPE" "$PROJECT_NAME"
    echo ""
    ((STEP++))
fi

if [ "$SKIP_HOOKS" = false ]; then
    echo "[$STEP/$TOTAL_STEPS] 🪝 Setting up Git hooks..."
    "$SETUP_DIR/setup-git-hooks.sh" . "$PROJECT_TYPE"
    echo ""
    ((STEP++))
fi

if [ "$SKIP_WORKFLOWS" = false ]; then
    echo "[$STEP/$TOTAL_STEPS] 🔄 Setting up CI/CD workflows..."
    "$SETUP_DIR/setup-ci-workflows.sh" . "$PROJECT_TYPE"
    echo ""
    ((STEP++))
fi

if [ "$SKIP_LABELS" = false ]; then
    echo "[$STEP/$TOTAL_STEPS] 🏷️  Setting up GitHub labels..."
    "$SETUP_DIR/setup-labels.sh" "$GITHUB_OWNER" "$GITHUB_REPO" "$GITHUB_TOKEN"
    echo ""
    ((STEP++))
fi

if [ "$SKIP_WIKI" = false ]; then
    echo "[$STEP/$TOTAL_STEPS] 📚 Setting up GitHub Wiki..."
    "$SETUP_DIR/setup-wiki.sh" "$GITHUB_REPO"
    echo ""
    ((STEP++))
fi

if [ "$SKIP_PROJECTS" = false ]; then
    echo "[$STEP/$TOTAL_STEPS] 📊 Setting up GitHub Projects..."
    "$SETUP_DIR/setup-projects.sh" "$GITHUB_OWNER" "$GITHUB_REPO" "$GITHUB_TOKEN" "$PROJECT_NAME Project"
    echo ""
    ((STEP++))
fi

echo ""
echo "✅ Project Initialization Complete!"
echo "===================================="
echo ""
echo "📁 Project Location: $(pwd)"
echo "📦 Project Type: $PROJECT_TYPE"
echo "🔗 GitHub Repository: https://github.com/$GITHUB_OWNER/$GITHUB_REPO"
echo ""
echo "🚀 Next Steps:"
echo ""
echo "1. Initialize Git repository (if not already done):"
echo "   git init"
echo "   git add ."
echo "   git commit -m 'chore: initial project setup'"
echo ""
echo "2. Add remote and push:"
echo "   git remote add origin git@github.com:$GITHUB_OWNER/$GITHUB_REPO.git"
echo "   git branch -M main"
echo "   git push -u origin main"
echo ""
echo "3. Start developing:"
case "$PROJECT_TYPE" in
    python)
        echo "   uv run pytest          # Run tests"
        echo "   uv run ruff check .    # Run linter"
        echo "   uv run pyright         # Run type checker"
        ;;
    typescript)
        echo "   pnpm test              # Run tests"
        echo "   pnpm lint              # Run linter"
        echo "   pnpm typecheck         # Run type checker"
        ;;
esac
echo ""
echo "4. Review and customize:"
echo "   - README.md (project documentation)"
echo "   - CONTRIBUTING.md (contribution guidelines)"
echo "   - SECURITY.md (security policy)"
echo "   - .github/workflows/*.yml (CI/CD workflows)"
echo ""
echo "📚 Documentation:"
echo "   - Engineering Handbook: https://github.com/sera-inc/engineering-handbook"
echo "   - Project Wiki: https://github.com/$GITHUB_OWNER/$GITHUB_REPO/wiki"
echo "   - GitHub Projects: https://github.com/orgs/$GITHUB_OWNER/projects"
echo ""
echo "💡 Tips:"
echo "   - All Git hooks are configured and will run automatically"
echo "   - CI/CD workflows will run on push and pull requests"
echo "   - Follow the engineering handbook for coding standards"
echo ""
echo "🎉 Happy coding!"
