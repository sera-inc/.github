# GitHub組織設定手順書

## 概要
この手順書は、sera-inc/.github リポジトリのセットアップと使用方法を記載しています。

このリポジトリは、sera-inc 組織全体で使用される GitHub テンプレート、ワークフロー、セットアップスクリプトを提供します。より詳細なプロジェクト管理のガイドラインについては、[sera-inc/engineering-handbook](https://github.com/sera-inc/engineering-handbook) の [GitHub プロジェクト管理ドキュメント](https://github.com/sera-inc/engineering-handbook/tree/main/docs/07-github-project-management) を参照してください。

## 前提条件
- GitHub Personal Access Token (classic) が必要
- リポジトリへの管理者権限が必要

## セットアップ手順

### 1. リポジトリのクローン
```bash
git clone https://github.com/sera-inc/.github.git
```

### 2. 環境変数の設定
```bash
export GITHUB_TOKEN="your_github_token_here"
```

**⚠️ 重要**: 実際のトークンは安全に管理してください。上記の例のトークンは無効化済みです。

### 3. GitHub Labels セットアップ

#### スクリプトに実行権限を付与
```bash
chmod +x setup-labels.sh
```

#### ラベルの設定実行
```bash
./setup-labels.sh sera-inc project-name $GITHUB_TOKEN
```

### 4. GitHub Wiki セットアップ

#### スクリプトに実行権限を付与
```bash
chmod +x setup-github-wiki.sh
```

#### Wiki の設定実行
```bash
./setup-github-wiki.sh .github
```

## 利用可能なファイル

### テンプレート
- `pull_request_template.md` - プルリクエストテンプレート
- `ISSUE_TEMPLATE/` - 各種 Issue テンプレート
- `README_template.md` - README テンプレート

### セットアップスクリプト
- `setup-labels.sh` - GitHub ラベル自動設定スクリプト
- `setup-github-wiki.sh` - GitHub Wiki セットアップスクリプト

### ワークフロー
- `workflows/weekly-report.yml` - 週次レポート自動生成
- `workflows/meeting-integration.yml` - ミーティング連携

### ドキュメント
- `github-projects-setup.md` - GitHub Projects 設定ガイド

## 使用方法

### 新しいプロジェクトでの利用
1. このリポジトリが組織の `.github` リポジトリとして設定されていれば、組織内のすべてのリポジトリで自動的にテンプレートが利用可能になります
2. 個別のプロジェクトでセットアップスクリプトを実行してください

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
