#!/bin/bash

set -e

PROJECT_DIR="${1:-.}"
PROJECT_TYPE="${2:-}"

if [ -z "$PROJECT_TYPE" ]; then
    echo "Usage: $0 <project_dir> <project_type>"
    echo "Project types: python, typescript, both"
    echo "Example: $0 . python"
    exit 1
fi

echo "🚀 Setting up CI/CD workflows for $PROJECT_TYPE project..."

WORKFLOWS_DIR="$PROJECT_DIR/.github/workflows"
TEMPLATE_DIR="$(dirname "$0")/../workflows-templates"

mkdir -p "$WORKFLOWS_DIR"

case "$PROJECT_TYPE" in
    python)
        echo "📦 Copying Python workflows..."
        cp "$TEMPLATE_DIR/lint-and-test-python.yml" "$WORKFLOWS_DIR/lint-and-test.yml"
        ;;
    typescript)
        echo "📦 Copying TypeScript workflows..."
        cp "$TEMPLATE_DIR/lint-and-test-typescript.yml" "$WORKFLOWS_DIR/lint-and-test.yml"
        ;;
    both)
        echo "📦 Copying both Python and TypeScript workflows..."
        cp "$TEMPLATE_DIR/lint-and-test-python.yml" "$WORKFLOWS_DIR/lint-and-test-python.yml"
        cp "$TEMPLATE_DIR/lint-and-test-typescript.yml" "$WORKFLOWS_DIR/lint-and-test-typescript.yml"
        ;;
    *)
        echo "❌ Invalid project type: $PROJECT_TYPE"
        echo "Valid types: python, typescript, both"
        exit 1
        ;;
esac

echo "📦 Copying common workflows..."
cp "$TEMPLATE_DIR/security-scan.yml" "$WORKFLOWS_DIR/security-scan.yml"
cp "$TEMPLATE_DIR/deploy-dev.yml" "$WORKFLOWS_DIR/deploy-dev.yml"
cp "$TEMPLATE_DIR/deploy-staging.yml" "$WORKFLOWS_DIR/deploy-staging.yml"
cp "$TEMPLATE_DIR/deploy-production.yml" "$WORKFLOWS_DIR/deploy-production.yml"

echo ""
echo "✅ CI/CD workflows created successfully!"
echo ""
echo "📝 Workflows created:"
echo "  - $WORKFLOWS_DIR/lint-and-test.yml (or language-specific)"
echo "  - $WORKFLOWS_DIR/security-scan.yml"
echo "  - $WORKFLOWS_DIR/deploy-dev.yml"
echo "  - $WORKFLOWS_DIR/deploy-staging.yml"
echo "  - $WORKFLOWS_DIR/deploy-production.yml"
echo ""
echo "⚙️  Next steps:"
echo ""
echo "1. Configure GitHub Secrets:"
echo "   - CODECOV_TOKEN (optional, for coverage reports)"
echo "   - AWS_ROLE_ARN (if using AWS)"
echo "   - AWS_REGION (if using AWS)"
echo "   - SLACK_WEBHOOK_URL (optional, for notifications)"
echo ""
echo "2. Configure GitHub Environments:"
echo "   - development"
echo "   - staging"
echo "   - production (with required reviewers)"
echo ""
echo "3. Customize deployment workflows:"
echo "   - Edit deploy-*.yml files with your deployment commands"
echo "   - Add environment-specific configuration"
echo ""
echo "4. Enable branch protection rules:"
echo "   - Require status checks to pass"
echo "   - Require pull request reviews"
echo "   - Require linear history"
echo ""
echo "5. Test the workflows:"
echo "   - Create a pull request to trigger lint-and-test"
echo "   - Push to develop to trigger deploy-dev"
echo ""
echo "📚 For more information, see:"
echo "   - https://docs.github.com/en/actions"
echo "   - https://github.com/sera-inc/engineering-handbook"
