#!/bin/bash

# GitHub Repository Labels Setup Script
# 使用方法: ./setup-labels.sh <owner> <repo> <github_token>

if [ $# -ne 3 ]; then
    echo "使用方法: $0 <owner> <repo> <github_token>"
    echo "例: $0 sera-inc sample-project ghp_xxxxxxxxxxxx"
    exit 1
fi

OWNER=$1
REPO=$2
TOKEN=$3

echo "🏷️  GitHub ラベル設定開始: $OWNER/$REPO"

# 色定義
COLOR_RED="d73a49"
COLOR_ORANGE="f66a0a"
COLOR_YELLOW="fbca04"
COLOR_GREEN="28a745"
COLOR_BLUE="0366d6"
COLOR_PURPLE="6f42c1"
COLOR_PINK="ea4aaa"
COLOR_GRAY="6a737d"
COLOR_LIGHT_BLUE="54aeff"
COLOR_LIGHT_GREEN="7fd321"
COLOR_LIGHT_ORANGE="ff851b"

# GitHub API Base URL
API_BASE="https://api.github.com/repos/$OWNER/$REPO/labels"

# ラベル作成関数
create_label() {
    local name="$1"
    local description="$2"
    local color="$3"
    
    echo "作成中: $name"
    
    response=$(curl -s -w "%{http_code}" -o response.json -X POST \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Authorization: token $TOKEN" \
        "$API_BASE" \
        -d "{\"name\":\"$name\",\"description\":\"$description\",\"color\":\"$color\"}")
    
    if [ "$response" -eq 201 ]; then
        echo "  ✅ 作成成功: $name"
    elif [ "$response" -eq 422 ]; then
        echo "  ⚠️  既存ラベル: $name"
    else
        echo "  ❌ 作成失敗: $name (HTTP: $response)"
        cat response.json
    fi
    
    rm -f response.json
}

# 既存のデフォルトラベルを削除（オプション）
delete_default_labels() {
    echo "🗑️  デフォルトラベルの削除..."
    
    default_labels=("bug" "documentation" "duplicate" "enhancement" "good first issue" "help wanted" "invalid" "question" "wontfix")
    
    for label in "${default_labels[@]}"; do
        echo "削除中: $label"
        response=$(curl -s -w "%{http_code}" -o /dev/null -X DELETE \
            -H "Accept: application/vnd.github.v3+json" \
            -H "Authorization: token $TOKEN" \
            "$API_BASE/$(echo "$label" | sed 's/ /%20/g')")
        
        if [ "$response" -eq 204 ]; then
            echo "  ✅ 削除成功: $label"
        elif [ "$response" -eq 404 ]; then
            echo "  ⚠️  ラベルなし: $label"
        else
            echo "  ❌ 削除失敗: $label (HTTP: $response)"
        fi
    done
}

echo "📋 プロジェクト管理用ラベル設定開始"
echo ""

# 優先度ラベル
echo "🔥 優先度ラベル設定"
create_label "priority-critical" "緊急対応が必要な最優先事項" "$COLOR_RED"
create_label "priority-high" "高優先度のタスク・課題" "$COLOR_ORANGE"
create_label "priority-medium" "中優先度のタスク・課題" "$COLOR_YELLOW"
create_label "priority-low" "低優先度のタスク・課題" "$COLOR_GRAY"

echo ""

# Must/Want ラベル
echo "⚡ 重要度ラベル設定"
create_label "must-have" "必須機能・要件" "$COLOR_RED"
create_label "want-have" "希望機能・要件" "$COLOR_BLUE"

echo ""

# 要件・機能種別ラベル
echo "📋 機能種別ラベル設定"
create_label "requirement" "要件定義関連" "$COLOR_BLUE"
create_label "feature" "新機能追加" "$COLOR_GREEN"
create_label "enhancement" "既存機能改善" "$COLOR_LIGHT_GREEN"
create_label "bug" "バグ・不具合修正" "$COLOR_RED"
create_label "hotfix" "緊急修正対応" "$COLOR_RED"

echo ""

# コンポーネント・技術領域ラベル
echo "🔧 技術領域ラベル設定"
create_label "frontend" "フロントエンド関連" "$COLOR_LIGHT_BLUE"
create_label "backend" "バックエンド関連" "$COLOR_PURPLE"
create_label "database" "データベース関連" "$COLOR_ORANGE"
create_label "infrastructure" "インフラ・環境関連" "$COLOR_GRAY"
create_label "ui-ux" "UI/UXデザイン関連" "$COLOR_PINK"
create_label "api" "API設計・実装" "$COLOR_BLUE"
create_label "security" "セキュリティ対応" "$COLOR_RED"

echo ""

# プロセス・ステータスラベル
echo "📊 プロセスラベル設定"
create_label "needs-review" "レビュー待ち" "$COLOR_YELLOW"
create_label "in-progress" "作業進行中" "$COLOR_LIGHT_ORANGE"
create_label "blocked" "作業ブロック中" "$COLOR_RED"
create_label "waiting-for-feedback" "フィードバック待ち" "$COLOR_YELLOW"
create_label "ready-for-testing" "テスト準備完了" "$COLOR_LIGHT_GREEN"
create_label "testing" "テスト実行中" "$COLOR_LIGHT_BLUE"
create_label "approved" "承認済み" "$COLOR_GREEN"

echo ""

# 品質・チェックラベル
echo "🔍 品質管理ラベル設定"
create_label "figma-linked" "Figmaデザインリンク済み" "$COLOR_PINK"
create_label "security-checked" "セキュリティチェック済み" "$COLOR_GREEN"
create_label "reviewed" "コードレビュー完了" "$COLOR_GREEN"
create_label "tested" "テスト完了" "$COLOR_GREEN"
create_label "documentation" "ドキュメント関連" "$COLOR_GRAY"

echo ""

# 自動化・統合ラベル
echo "🤖 自動化ラベル設定"
create_label "automated" "自動生成・処理" "$COLOR_GRAY"
create_label "weekly-report" "週次レポート" "$COLOR_BLUE"
create_label "monthly-report" "月次レポート" "$COLOR_PURPLE"
create_label "from-meeting" "会議から生成" "$COLOR_LIGHT_BLUE"
create_label "action-item" "アクションアイテム" "$COLOR_ORANGE"

echo ""

# プロジェクト管理ラベル
echo "📈 プロジェクト管理ラベル設定"
create_label "change-request" "変更要求" "$COLOR_ORANGE"
create_label "risk" "リスク事項" "$COLOR_RED"
create_label "escalation" "エスカレーション必要" "$COLOR_RED"
create_label "client-feedback" "クライアントフィードバック" "$COLOR_BLUE"
create_label "internal-task" "内部タスク" "$COLOR_GRAY"

echo ""

# 工程・フェーズラベル  
echo "🏗️ 工程ラベル設定"
create_label "requirements" "要件定義フェーズ" "$COLOR_BLUE"
create_label "design" "設計フェーズ" "$COLOR_PINK"
create_label "development" "開発フェーズ" "$COLOR_GREEN"
create_label "testing" "テストフェーズ" "$COLOR_YELLOW"
create_label "deployment" "デプロイフェーズ" "$COLOR_PURPLE"
create_label "maintenance" "保守・運用フェーズ" "$COLOR_GRAY"

echo ""

# ストーリーポイント・工数ラベル
echo "📊 工数ラベル設定"
create_label "story-1" "1ポイント (簡単)" "$COLOR_LIGHT_GREEN"
create_label "story-2" "2ポイント (小)" "$COLOR_GREEN"
create_label "story-3" "3ポイント (小-中)" "$COLOR_YELLOW"
create_label "story-5" "5ポイント (中)" "$COLOR_ORANGE"
create_label "story-8" "8ポイント (中-大)" "$COLOR_LIGHT_ORANGE"
create_label "story-13" "13ポイント (大)" "$COLOR_RED"
create_label "story-21" "21ポイント (特大)" "$COLOR_RED"

echo ""
echo "🎉 ラベル設定完了！"
echo ""
echo "📋 設定されたラベルカテゴリ:"
echo "  🔥 優先度: critical, high, medium, low"
echo "  ⚡ 重要度: must-have, want-have"
echo "  📋 機能種別: requirement, feature, enhancement, bug"  
echo "  🔧 技術領域: frontend, backend, database, infrastructure, ui-ux"
echo "  📊 プロセス: needs-review, in-progress, blocked, approved"
echo "  🔍 品質管理: figma-linked, security-checked, reviewed, tested"
echo "  🤖 自動化: automated, weekly-report, from-meeting, action-item"
echo "  📈 プロジェクト管理: change-request, risk, escalation"
echo "  🏗️ 工程: requirements, design, development, testing, deployment"
echo "  📊 工数: story-1 〜 story-21"
echo ""
echo "🔗 GitHubリポジトリのラベル一覧: https://github.com/$OWNER/$REPO/labels"
