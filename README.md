# Sera Inc. 組織全体の設定

このリポジトリには、すべてのSera Inc.プロジェクトで使用する組織全体のテンプレート、ワークフロー、自動化が含まれています。

## 🚀 クイックスタート

### 新規プロジェクトの場合

**📖 まず読む**: [新規プロジェクト作成手順.md](./新規プロジェクト作成手順.md) - GitHubでのリポジトリ作成から完全セットアップまでの詳細手順

Sera Inc.の全標準規格を使用して新規プロジェクトを初期化:

```bash
curl -fsSL https://raw.githubusercontent.com/sera-inc/.github/main/setup-new-project.sh | bash
```

またはローカルでクローンして実行:

```bash
git clone https://github.com/sera-inc/.github.git
cd .github
./setup-new-project.sh
```

詳細な手順については以下を参照してください：
- **[新規プロジェクト作成手順.md](./新規プロジェクト作成手順.md)** - 推奨：ステップバイステップガイド
- [SETUP_GUIDE.md](./SETUP_GUIDE.md) - 包括的なセットアップガイド

### 既存プロジェクトの場合

個別のセットアップスクリプトを適用:

```bash
# プロジェクト構造
./setup/setup-project-structure.sh . python my-project

# 開発環境
./setup/setup-dev-environment.sh . python my-project

# Gitフック
./setup/setup-git-hooks.sh . python

# CI/CDワークフロー
./setup/setup-ci-workflows.sh . python

# GitHubラベル
./setup/setup-labels.sh sera-inc my-repo ghp_xxxxx

# GitHub Wiki
./setup/setup-wiki.sh my-repo

# GitHubプロジェクト
./setup/setup-projects.sh sera-inc my-repo ghp_xxxxx "My Project"
```

## 📁 リポジトリ構造

```
.github/
├── setup-new-project.sh         # マスター初期化スクリプト
├── setup/                        # 個別セットアップスクリプト
│   ├── setup-labels.sh          # GitHubラベル
│   ├── setup-wiki.sh            # GitHub Wiki
│   ├── setup-projects.sh        # GitHubプロジェクト
│   ├── setup-ci-workflows.sh    # CI/CDワークフロー
│   ├── setup-git-hooks.sh       # Gitフック
│   ├── setup-project-structure.sh  # プロジェクト構造
│   └── setup-dev-environment.sh    # 開発環境
├── templates/                    # プロジェクトテンプレート
│   ├── python/                  # Pythonプロジェクトテンプレート
│   ├── typescript/              # TypeScriptプロジェクトテンプレート
│   └── common/                  # 共通テンプレート
├── wiki-templates/               # Wikiページテンプレート
├── workflows-templates/          # CI/CDワークフローテンプレート
├── ISSUE_TEMPLATE/              # Issueテンプレート
├── workflows/                    # 組織ワークフロー
├── pull_request_template.md     # PRテンプレート
├── SETUP_GUIDE.md               # 詳細セットアップガイド
├── SETUP_INSTRUCTIONS.md        # クイックセットアップ手順
└── github-projects-setup.md     # GitHubプロジェクトガイド
```

## 🎯 提供される機能

### 1. プロジェクト初期化システム

以下を含む新規プロジェクトの自動セットアップ:

- **クリーンアーキテクチャ**: 4層構造（Domain、Use Case、Adapter、Infrastructure）
- **開発環境**: すべてのツールの設定ファイル
- **Gitフック**: プリコミット品質チェック
- **CI/CDワークフロー**: 自動テスト、セキュリティスキャン、デプロイメント
- **GitHub統合**: ラベル、Wiki、プロジェクト

### 2. Issueテンプレート

以下の標準化されたテンプレート:

- UI/UXデザインリクエスト
- 機能要件
- バグレポート
- 変更リクエスト
- セキュリティ問題

### 3. 自動化ワークフロー

- **週次レポート**: 自動進捗レポート
- **ミーティング統合**: AI駆動のミーティング議事録
- **自動ラベリング**: 自動PRラベル付け
- **依存関係レビュー**: セキュリティ脆弱性スキャン
- **AI要約**: 自動Issue要約

### 4. セットアップスクリプト

以下の個別スクリプト:

- GitHubラベル（10カテゴリ、53ラベル）
- GitHub Wiki（9ドキュメントページ）
- GitHubプロジェクト（9カスタムフィールド、7ビュー）
- CI/CDワークフロー（5ワークフロー）
- Gitフック（プリコミット品質チェック）
- プロジェクト構造（クリーンアーキテクチャ）
- 開発環境（設定ファイル）

## 📚 ドキュメント

- **[新規プロジェクト作成手順.md](./新規プロジェクト作成手順.md)**: 🌟 推奨：GitHubリポジトリ作成から完全セットアップまでのステップバイステップガイド
- **[SETUP_GUIDE.md](./SETUP_GUIDE.md)**: 包括的なセットアップガイド
- **[SETUP_INSTRUCTIONS.md](./SETUP_INSTRUCTIONS.md)**: クイックセットアップ手順
- **[github-projects-setup.md](./github-projects-setup.md)**: GitHubプロジェクト設定
- **[Engineering Handbook](https://github.com/sera-inc/engineering-handbook)**: 完全な開発ガイドライン

## 🔧 サポートされるプロジェクトタイプ

### Pythonプロジェクト

- パッケージマネージャー: [uv](https://github.com/astral-sh/uv)
- リンター/フォーマッター: [Ruff](https://github.com/astral-sh/ruff)
- 型チェッカー: [Pyright](https://github.com/microsoft/pyright)
- テストフレームワーク: [pytest](https://pytest.org/)
- Gitフック: [pre-commit](https://pre-commit.com/)

### TypeScriptプロジェクト

- パッケージマネージャー: [pnpm](https://pnpm.io/)
- リンター/フォーマッター: [Biome](https://biomejs.dev/)
- 型チェッカー: [TypeScript](https://www.typescriptlang.org/)
- テストフレームワーク: [Vitest](https://vitest.dev/)
- Gitフック: [Husky](https://typicode.github.io/husky/)

## 🏗️ アーキテクチャ

すべてのプロジェクトはクリーンアーキテクチャの原則に従います:

```
┌─────────────────────────────────────┐
│         Infrastructure              │  外部インターフェース
├─────────────────────────────────────┤
│            Adapter                  │  インターフェースアダプター
├─────────────────────────────────────┤
│           Use Case                  │  ビジネスロジック
├─────────────────────────────────────┤
│            Domain                   │  コアエンティティ
└─────────────────────────────────────┘
```

**依存関係ルール**: 依存関係は内側のみを向きます。

## 🧪 品質基準

### テストカバレッジ

- ユニットテスト: 80%以上のカバレッジが必要
- 統合テスト: 60%以上のカバレッジが必要
- E2Eテスト: 重要なシナリオ

### コード品質

- リントエラーゼロ
- 型チェックエラーゼロ
- すべてのテストが合格
- セキュリティスキャンが合格

### CI/CDゲート

1. **プリコミット**: フォーマット、リント、型チェック、ユニットテスト
2. **PR作成**: すべてのテスト、セキュリティスキャン
3. **マージ前**: すべてのチェックが合格必須
4. **デプロイ前**: E2Eテスト、パフォーマンステスト

## 🔒 セキュリティ

- 自動依存関係スキャン
- SAST（静的アプリケーションセキュリティテスト）
- Gitleaksによるシークレットスキャン
- セキュリティIssueテンプレート
- すべてのプロジェクトにSECURITY.md

## 🤝 コントリビューション

コントリビューションガイドラインについては[CONTRIBUTING.md](./templates/common/CONTRIBUTING.md)テンプレートを参照してください。

## 📖 追加リソース

- [Engineering Handbook](https://github.com/sera-inc/engineering-handbook)
- [クリーンアーキテクチャガイド](https://github.com/sera-inc/engineering-handbook/blob/main/docs/05-architecture/clean-architecture.md)
- [テスト戦略](https://github.com/sera-inc/engineering-handbook/blob/main/docs/03-quality-assurance/test-strategy.md)
- [Gitワークフロー](https://github.com/sera-inc/engineering-handbook/blob/main/docs/02-development-process/git-workflow.md)

## 🆘 ヘルプ

1. [SETUP_GUIDE.md](./SETUP_GUIDE.md)を確認
2. [Engineering Handbook](https://github.com/sera-inc/engineering-handbook)をレビュー
3. 既存のIssueを検索
4. チームSlackで質問
5. Issueを作成

## 📄 ライセンス

内部使用のみ - Sera Inc.
