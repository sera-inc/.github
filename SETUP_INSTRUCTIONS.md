# GitHub組織設定手順書

## 概要
この手順書は、sera-inc/.github リポジトリのセットアップと使用方法を記載しています。

このリポジトリは、sera-inc 組織全体で使用される GitHub テンプレート、ワークフロー、セットアップスクリプトを提供します。より詳細なプロジェクト管理のガイドラインについては、[sera-inc/engineering-handbook](https://github.com/sera-inc/engineering-handbook) の [GitHub プロジェクト管理ドキュメント](https://github.com/sera-inc/engineering-handbook/tree/main/docs/07-github-project-management) を参照してください。

## 🚀 クイックスタート

### 新規プロジェクトの初期化（推奨）

```bash
# リポジトリをクローン
git clone https://github.com/sera-inc/.github.git
cd .github

# マスター初期化スクリプトを実行
./setup-new-project.sh
```

対話形式で以下を入力：
- プロジェクトタイプ（Python または TypeScript）
- プロジェクト名
- GitHub オーナー/組織
- GitHub リポジトリ名
- GitHub Personal Access Token

詳細は [SETUP_GUIDE.md](./SETUP_GUIDE.md) を参照してください。

## 前提条件
- GitHub Personal Access Token (classic) が必要
  - スコープ: `repo`, `project`, `admin:org`
- リポジトリへの管理者権限が必要
- Python プロジェクト: [uv](https://github.com/astral-sh/uv) をインストール
- TypeScript プロジェクト: [Node.js 20+](https://nodejs.org/) と [pnpm](https://pnpm.io/) をインストール

## 個別セットアップ手順

### 1. プロジェクト構造の作成

```bash
./setup/setup-project-structure.sh . python my-project
```

Clean Architecture に基づいた4層構造を作成します。

### 2. 開発環境のセットアップ

```bash
./setup/setup-dev-environment.sh . python my-project
```

設定ファイルをコピーし、依存関係をインストールします。

### 3. Git フックのセットアップ

```bash
./setup/setup-git-hooks.sh . python
```

pre-commit フックを設定します（コード品質チェック）。

### 4. CI/CD ワークフローのセットアップ

```bash
./setup/setup-ci-workflows.sh . python
```

GitHub Actions ワークフローをコピーします。

### 5. GitHub ラベルのセットアップ

```bash
./setup/setup-labels.sh sera-inc project-name $GITHUB_TOKEN
```

53個のラベルを10カテゴリで作成します。

### 6. GitHub Wiki のセットアップ

```bash
./setup/setup-wiki.sh project-name
```

9ページのドキュメント構造を作成します。

### 7. GitHub Projects のセットアップ

```bash
./setup/setup-projects.sh sera-inc project-name $GITHUB_TOKEN "My Project"
```

GitHub Projects の設定手順を表示します（手動設定が必要）。

## 利用可能なファイル

### マスタースクリプト
- `setup-new-project.sh` - 統合初期化スクリプト（推奨）

### セットアップスクリプト（setup/）
- `setup-labels.sh` - GitHub ラベル自動設定
- `setup-wiki.sh` - GitHub Wiki セットアップ
- `setup-projects.sh` - GitHub Projects 設定ガイド
- `setup-ci-workflows.sh` - CI/CD ワークフロー配置
- `setup-git-hooks.sh` - Git フック設定
- `setup-project-structure.sh` - プロジェクト構造作成
- `setup-dev-environment.sh` - 開発環境セットアップ

### テンプレート（templates/）
- `python/` - Python プロジェクトテンプレート
  - pyproject.toml, pyrightconfig.json, .pre-commit-config.yaml
- `typescript/` - TypeScript プロジェクトテンプレート
  - package.json, tsconfig.json, biome.json, vitest.config.ts
- `common/` - 共通テンプレート
  - SECURITY.md, CONTRIBUTING.md

### Wiki テンプレート（wiki-templates/）
- Architecture.md - アーキテクチャドキュメント
- API-Design.md - API 設計ガイド
- Test-Plan.md - テスト計画
- ADR-Template.md - Architecture Decision Record テンプレート

### ワークフローテンプレート（workflows-templates/）
- lint-and-test-python.yml - Python リント＆テスト
- lint-and-test-typescript.yml - TypeScript リント＆テスト
- security-scan.yml - セキュリティスキャン
- deploy-dev.yml - 開発環境デプロイ
- deploy-staging.yml - ステージング環境デプロイ
- deploy-production.yml - 本番環境デプロイ

### Issue テンプレート（ISSUE_TEMPLATE/）
- ui-design-request.yml - UI/UX デザインリクエスト
- feature-requirement.yml - 機能要件
- bug-report.yml - バグレポート
- change-request.yml - 変更リクエスト
- security-issue.yml - セキュリティ問題

### その他
- `pull_request_template.md` - プルリクエストテンプレート
- `README_template.md` - README テンプレート
- `github-projects-setup.md` - GitHub Projects 設定ガイド
- `SETUP_GUIDE.md` - 詳細セットアップガイド

## 使用方法

### 新しいプロジェクトでの利用
1. `./setup-new-project.sh` を実行（推奨）
2. または個別のセットアップスクリプトを実行

### 既存プロジェクトへの適用
1. 必要なセットアップスクリプトを個別に実行
2. 既存の設定ファイルとマージ

### カスタマイズ
- テンプレートファイルは組織のニーズに応じて編集可能です
- ワークフローは各プロジェクトの要件に合わせて調整してください

## トラブルシューティング

### よくある問題
1. **権限エラー**: GitHub Token に十分な権限があることを確認
2. **スクリプト実行エラー**: `chmod +x` で実行権限を付与
3. **API レート制限**: しばらく時間をおいてから再実行

## セキュリティ注意事項
- GitHub Token は絶対に公開リポジトリにコミットしない
- 環境変数やシークレット管理システムを使用する
- 定期的にトークンをローテーションする

## 更新履歴
- 2024-09-25: 初版作成
- セットアップスクリプトとテンプレート追加
- ワークフロー統合

## 関連ドキュメント
- [sera-inc/engineering-handbook](https://github.com/sera-inc/engineering-handbook) - 開発組織全体のプロセスとガイドライン
- [GitHub プロジェクト管理ドキュメント](https://github.com/sera-inc/engineering-handbook/tree/main/docs/07-github-project-management) - 詳細なプロジェクト管理手順
  - [Issue 管理](https://github.com/sera-inc/engineering-handbook/blob/main/docs/07-github-project-management/03-issue-management.md) - ラベル体系と Issue テンプレートの詳細
  - [Projects 設定](https://github.com/sera-inc/engineering-handbook/blob/main/docs/07-github-project-management/02-projects-setup.md) - カスタムフィールドとビューの詳細
  - [Pull Request プロセス](https://github.com/sera-inc/engineering-handbook/blob/main/docs/07-github-project-management/05-pull-request-process.md) - PR テンプレートとレビュープロセス

## 連絡先
質問や問題がある場合は、sera-inc 開発チームまでお問い合わせください。
