#!/bin/bash

# sera-inc GitHub Wiki 自動セットアップスクリプト
# 使用方法: ./setup-wiki.sh [repository-name]

set -e

# 設定
REPO_NAME=${1:-"project-repo"}
WIKI_REPO="${REPO_NAME}.wiki"
GITHUB_TOKEN=${GITHUB_TOKEN:-""}

if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ GITHUB_TOKEN環境変数を設定してください"
    exit 1
fi

echo "📚 sera-inc GitHub Wiki セットアップ開始"
echo "リポジトリ: $REPO_NAME"

# Wikiリポジトリをクローン（存在しない場合は作成）
if [ -d "$WIKI_REPO" ]; then
    echo "📁 既存のWikiディレクトリを更新中..."
    cd "$WIKI_REPO"
    git pull origin master || git pull origin main
else
    echo "📥 Wikiリポジトリをクローン中..."
    git clone "https://github.com/sera-inc/${WIKI_REPO}.git"
    cd "$WIKI_REPO"
fi

# Homeページ作成
cat > Home.md << 'EOF'
# 🏠 プロジェクトWiki ホーム

株式会社世良のプロジェクト管理Wikiへようこそ！

## 📋 クイックナビゲーション

| セクション | 説明 | リンク |
|------------|------|--------|
| 📖 プロジェクト概要 | プロジェクトの基本情報 | [[Project Overview]] |
| 🎯 要件定義 | 機能要件・非機能要件 | [[Requirements]] |
| 🏗️ アーキテクチャ | システム構成・技術仕様 | [[Architecture]] |
| 👥 チーム情報 | メンバー・役割・連絡先 | [[Team Info]] |
| 📅 プロジェクト計画 | スケジュール・マイルストーン | [[Project Plan]] |
| 🔧 開発ガイド | 開発環境・コーディング規約 | [[Development Guide]] |
| 🚀 デプロイ手順 | 本番環境への展開手順 | [[Deployment Guide]] |
| 📊 会議議事録 | 定例会議・重要な決定事項 | [[Meeting Notes]] |
| 🐛 トラブルシューティング | よくある問題と解決策 | [[Troubleshooting]] |
| 📚 参考資料 | 関連ドキュメント・外部リソース | [[References]] |

## 🔄 最近の更新

- **$(date '+%Y-%m-%d')**: Wikiセットアップ完了
- このWikiは自動的に更新されます

## ⚡ クイックアクション

### 🆕 新規ページ作成
1. 上記のリンクをクリック
2. 「Create this page」をクリック
3. テンプレートを使用して内容を編集

### 📝 編集方法
- GitHub Wikiエディタを使用
- Markdownフォーマットをサポート
- 画像・図表の埋め込み可能

### 🔍 検索
- Wiki内の全ページを対象とした全文検索が利用可能
- ページ名による部分検索も対応

---

## 🎨 Wikiの使い方

### Markdownサポート機能
- ✅ 表、リスト、見出し
- ✅ コードブロック、シンタックスハイライト
- ✅ 画像、リンク
- ✅ 数式表記（LaTeX）
- ✅ 図表（Mermaid）

### 協働編集
- 全チームメンバーが編集可能
- 変更履歴の自動保存
- コミット単位でのバージョン管理

---

**📞 サポート**: 質問や提案は [Issues](../issues) または Slack #dev-support チャンネルまで

*最終更新: $(date '+%Y-%m-%d %H:%M:%S JST')*
EOF

# Project Overview ページ
cat > Project-Overview.md << 'EOF'
# 📖 プロジェクト概要

## 🎯 プロジェクトの目的

### ビジネス目標
- [ ] 主要なビジネス課題の解決
- [ ] ユーザー体験の向上
- [ ] 業務効率化の実現
- [ ] 売上・利益の向上

### 技術目標
- [ ] システムの安定性向上
- [ ] パフォーマンスの最適化
- [ ] セキュリティの強化
- [ ] 保守性の向上

## 📊 プロジェクト基本情報

| 項目 | 内容 |
|------|------|
| **プロジェクト名** | [プロジェクト名を入力] |
| **開始日** | [開始日を入力] |
| **予定終了日** | [終了予定日を入力] |
| **ステータス** | 🟢 計画中 / 🔵 開発中 / 🟡 テスト中 / ✅ 完了 |
| **優先度** | 🔴 高 / 🟡 中 / 🟢 低 |
| **予算** | [予算を入力] |

## 👥 ステークホルダー

### プロジェクトオーナー
- **名前**: [名前]
- **役職**: [役職]
- **連絡先**: [メール/Slack]
- **責任範囲**: プロジェクト全体の意思決定

### プロダクトマネージャー
- **名前**: [名前]
- **役職**: [役職]
- **連絡先**: [メール/Slack]
- **責任範囲**: 要件定義・進捗管理

### 技術リード
- **名前**: [名前]
- **役職**: [役職]
- **連絡先**: [メール/Slack]
- **責任範囲**: アーキテクチャ・技術仕様

## 🎯 成功指標（KPI）

### ビジネス指標
- [ ] **指標1**: [具体的な数値目標]
- [ ] **指標2**: [具体的な数値目標]
- [ ] **指標3**: [具体的な数値目標]

### 技術指標
- [ ] **パフォーマンス**: [レスポンス時間等]
- [ ] **可用性**: [稼働率等]
- [ ] **セキュリティ**: [脆弱性件数等]

## 🚀 主要な成果物

- [ ] **要件定義書**: 機能・非機能要件の詳細
- [ ] **設計書**: システム・データベース設計
- [ ] **ソースコード**: 開発したアプリケーション
- [ ] **テスト仕様書**: テストケース・結果
- [ ] **運用手順書**: 運用・保守のガイド
- [ ] **ユーザーマニュアル**: エンドユーザー向け説明書

## ⚠️ リスクと課題

### 高リスク項目
- 🔴 **[リスク1]**: [説明・対策]
- 🔴 **[リスク2]**: [説明・対策]

### 中リスク項目
- 🟡 **[リスク1]**: [説明・対策]
- 🟡 **[リスク2]**: [説明・対策]

## 📅 主要マイルストーン

```mermaid
gantt
    title プロジェクト主要マイルストーン
    dateFormat  YYYY-MM-DD
    section Phase 1
    要件定義完了    :milestone, req-done, 2024-01-15, 0d
    section Phase 2  
    設計完了        :milestone, design-done, 2024-02-15, 0d
    section Phase 3
    開発完了        :milestone, dev-done, 2024-04-15, 0d
    section Phase 4
    リリース        :milestone, release, 2024-05-01, 0d
```

---

*最終更新: $(date '+%Y-%m-%d %H:%M:%S JST')*
EOF

# Requirements ページ
cat > Requirements.md << 'EOF'
# 🎯 要件定義

## 📋 機能要件

### 🌟 主要機能

#### 機能1: [機能名]
- **概要**: [機能の概要説明]
- **目的**: [なぜこの機能が必要か]
- **優先度**: 🔴 高 / 🟡 中 / 🟢 低
- **工数見積**: [人日]
- **担当者**: [担当者名]

**詳細仕様**:
- [ ] **要件1.1**: [詳細な要件]
- [ ] **要件1.2**: [詳細な要件]
- [ ] **要件1.3**: [詳細な要件]

**受入条件**:
- [ ] [テスト可能な条件1]
- [ ] [テスト可能な条件2]
- [ ] [テスト可能な条件3]

#### 機能2: [機能名]
- **概要**: [機能の概要説明]
- **目的**: [なぜこの機能が必要か]
- **優先度**: 🔴 高 / 🟡 中 / 🟢 低
- **工数見積**: [人日]
- **担当者**: [担当者名]

### 🔧 システム機能

#### ユーザー管理
- [ ] ユーザー登録・認証
- [ ] ロールベースアクセス制御
- [ ] パスワード管理
- [ ] セッション管理

#### データ管理
- [ ] データの作成・読取・更新・削除
- [ ] データバリデーション
- [ ] データバックアップ
- [ ] データ復旧

#### API機能
- [ ] RESTful API提供
- [ ] API認証・認可
- [ ] レート制限
- [ ] APIドキュメント

## ⚡ 非機能要件

### 🏎️ パフォーマンス要件

| 項目 | 要件 | 測定方法 |
|------|------|----------|
| **レスポンス時間** | 平均2秒以内 | ページロード時間測定 |
| **同時接続数** | 1,000ユーザー対応 | 負荷テスト |
| **スループット** | 100req/sec以上 | パフォーマンステスト |
| **CPU使用率** | 平均70%以下 | システムモニタリング |
| **メモリ使用量** | 8GB以下 | メモリ使用量監視 |

### 🛡️ セキュリティ要件

- [ ] **認証**: 多要素認証対応
- [ ] **認可**: 最小権限の原則
- [ ] **暗号化**: 通信・保存データの暗号化
- [ ] **監査ログ**: 全ての操作ログ記録
- [ ] **脆弱性対策**: 定期的なセキュリティスキャン

### 📈 可用性要件

| 項目 | 要件 |
|------|------|
| **稼働率** | 99.5%以上 |
| **RTO (復旧時間)** | 4時間以内 |
| **RPO (復旧ポイント)** | 1時間以内 |
| **障害検知時間** | 5分以内 |

### 🔧 保守性要件

- [ ] **コード品質**: SonarQubeスコア80以上
- [ ] **テストカバレッジ**: 80%以上
- [ ] **ドキュメント**: コード・API・運用手順
- [ ] **モニタリング**: アプリケーション・インフラ監視
- [ ] **ログ管理**: 構造化ログ・集約分析

## 🌐 環境要件

### 💻 開発環境
- **OS**: macOS / Windows / Linux
- **エディタ**: VS Code / IntelliJ
- **Node.js**: v18.x以上
- **Python**: v3.11以上
- **データベース**: PostgreSQL 15

### 🚀 本番環境
- **クラウド**: AWS
- **コンピュート**: EC2 / ECS
- **データベース**: RDS (PostgreSQL)
- **CDN**: CloudFront
- **監視**: CloudWatch + DataDog

## 📱 対応ブラウザ・デバイス

### デスクトップ
- [ ] Chrome (最新版)
- [ ] Firefox (最新版)
- [ ] Safari (最新版)
- [ ] Edge (最新版)

### モバイル
- [ ] iOS Safari (iOS 15+)
- [ ] Android Chrome (Android 10+)

### レスポンシブ対応
- [ ] デスクトップ (1920px+)
- [ ] タブレット (768px-1920px)
- [ ] モバイル (320px-767px)

## 📊 要件トレーサビリティマトリクス

| 要件ID | 要件名 | 優先度 | 設計書 | テストケース | ステータス |
|--------|--------|--------|--------|--------------|------------|
| REQ-001 | [要件名] | 高 | [[設計書#section1]] | [[テスト仕様書#test1]] | ✅ 完了 |
| REQ-002 | [要件名] | 中 | [[設計書#section2]] | [[テスト仕様書#test2]] | 🔄 進行中 |
| REQ-003 | [要件名] | 低 | - | - | ⏳ 未着手 |

---

*最終更新: $(date '+%Y-%m-%d %H:%M:%S JST')*
EOF

# Team Info ページ
cat > Team-Info.md << 'EOF'
# 👥 チーム情報

## 🌟 プロジェクトチーム

### プロジェクトマネージャー
- **名前**: [PM名]
- **Slack**: @pm-name
- **Email**: pm@sera-inc.co.jp
- **GitHub**: [@pm-github]
- **責任範囲**: 
  - プロジェクト全体の進行管理
  - ステークホルダーとの調整
  - リスク管理・課題解決

### テクニカルリード
- **名前**: [TL名]
- **Slack**: @tl-name
- **Email**: tl@sera-inc.co.jp
- **GitHub**: [@tl-github]
- **責任範囲**:
  - 技術仕様の策定
  - アーキテクチャ設計
  - コードレビュー・技術指導

### フロントエンド開発
- **名前**: [FE名]
- **Slack**: @fe-name
- **Email**: fe@sera-inc.co.jp
- **GitHub**: [@fe-github]
- **担当技術**: React, TypeScript, CSS
- **責任範囲**: UI/UX実装、フロントエンド最適化

### バックエンド開発
- **名前**: [BE名]
- **Slack**: @be-name
- **Email**: be@sera-inc.co.jp
- **GitHub**: [@be-github]
- **担当技術**: Python, FastAPI, PostgreSQL
- **責任範囲**: API開発、データベース設計、サーバー構築

### QAエンジニア
- **名前**: [QA名]
- **Slack**: @qa-name
- **Email**: qa@sera-inc.co.jp
- **GitHub**: [@qa-github]
- **責任範囲**: テスト設計・実行、品質保証、自動化

## 📞 連絡先・緊急時対応

### 業務時間内 (平日 9:00-18:00)
1. **Slack**: #project-team チャンネル
2. **Email**: 個別連絡
3. **Zoom**: 定例会議・臨時会議

### 緊急時 (業務時間外・休日)
1. **PM携帯**: [電話番号]
2. **TL携帯**: [電話番号]
3. **緊急Slack**: #emergency-support

## 📅 会議スケジュール

### 定例会議

#### 週次進捗会議
- **頻度**: 毎週月曜日 10:00-11:00
- **参加者**: 全チームメンバー
- **議題**: 
  - 前週の振り返り
  - 今週の計画
  - 課題・リスクの共有
- **Zoom**: [会議リンク]

#### デイリースタンドアップ
- **頻度**: 平日毎日 9:30-9:45
- **参加者**: 開発メンバー
- **議題**:
  - 昨日の成果
  - 今日の予定
  - ブロッカー・課題
- **Slack**: #daily-standup チャンネル

#### 月次レビュー会議
- **頻度**: 月末最終金曜日 15:00-16:00
- **参加者**: ステークホルダー含む
- **議題**:
  - 月次成果報告
  - KPI進捗確認
  - 次月計画
- **Zoom**: [会議リンク]

### 技術会議

#### アーキテクチャレビュー
- **頻度**: 隔週水曜日 14:00-15:00
- **参加者**: テクニカルリード、シニア開発者
- **議題**: 技術選定、設計レビュー

#### コードレビュー会議
- **頻度**: 週次金曜日 16:00-17:00
- **参加者**: 開発チーム全員
- **議題**: コード品質、ベストプラクティス共有

## 🛠️ 開発体制・ワークフロー

### Git ワークフロー
```mermaid
gitGraph
    commit id: "main"
    branch develop
    checkout develop
    commit id: "feature準備"
    branch feature/new-function
    checkout feature/new-function
    commit id: "機能開発"
    commit id: "テスト"
    checkout develop
    merge feature/new-function
    commit id: "統合テスト"
    checkout main
    merge develop
    commit id: "リリース"
```

### 作業手順
1. **Issue作成**: GitHub Issuesで作業を管理
2. **ブランチ作成**: `feature/issue-number-description`
3. **開発・テスト**: ローカル環境での実装
4. **Pull Request**: コードレビュー依頼
5. **レビュー**: チームメンバーによる確認
6. **マージ**: developブランチに統合
7. **リリース**: mainブランチへのマージ・デプロイ

### ツール・プラットフォーム

| カテゴリ | ツール | 用途 |
|----------|--------|------|
| **コミュニケーション** | Slack | 日常的な連絡・相談 |
| **ビデオ会議** | Zoom / Google Meet | 会議・ペアプログラミング |
| **プロジェクト管理** | GitHub Projects | タスク・進捗管理 |
| **ドキュメント** | GitHub Wiki | 仕様書・手順書 |
| **コードリポジトリ** | GitHub | ソースコード・バージョン管理 |
| **CI/CD** | GitHub Actions | 自動テスト・デプロイ |
| **監視** | DataDog | アプリケーション・インフラ監視 |
| **ログ管理** | CloudWatch | システムログ・エラー追跡 |

## 📚 オンボーディング（新メンバー向け）

### 初日
- [ ] Slackチャンネルへの招待
- [ ] GitHubリポジトリアクセス権限付与
- [ ] 開発環境セットアップ
- [ ] チームメンバー紹介

### 1週目
- [ ] プロジェクト概要説明
- [ ] 技術スタック・アーキテクチャ理解
- [ ] 開発ワークフロー体験
- [ ] 初回コードレビュー

### 1ヶ月目
- [ ] メインタスクの割り当て
- [ ] 独立した機能開発
- [ ] チーム内での技術共有

### 参考資料
- [[Development Guide]] - 開発環境・コーディング規約
- [[Architecture]] - システム構成・技術仕様
- [[Project Plan]] - プロジェクト全体計画

---

*最終更新: $(date '+%Y-%m-%d %H:%M:%S JST')*
EOF

# Development Guide ページ
cat > Development-Guide.md << 'EOF'
# 🔧 開発ガイド

## 🏗️ 開発環境セットアップ

### 前提条件

**必須ツール**:
- Git (v2.30+)
- Node.js (v18.x LTS)
- Python (v3.11+)
- Docker & Docker Compose
- VS Code または IntelliJ IDEA

**推奨ツール**:
- Volta (Node.jsバージョン管理)
- pyenv (Pythonバージョン管理)
- Postman (API テスト)
- TablePlus (データベース管理)

### 🚀 クイックスタート

```bash
# 1. リポジトリのクローン
git clone https://github.com/sera-inc/[repository-name].git
cd [repository-name]

# 2. 環境変数ファイルの作成
cp .env.example .env

# 3. 依存関係のインストール
npm install
pip install -r requirements.txt

# 4. データベースのセットアップ
docker-compose up -d postgres
npm run db:migrate

# 5. 開発サーバーの起動
npm run dev
```

### 🐳 Docker環境

```bash
# 全サービスの起動
docker-compose up -d

# 特定サービスのみ
docker-compose up -d postgres redis

# ログ確認
docker-compose logs -f app

# 環境のクリーンアップ
docker-compose down -v
```

## 📝 コーディング規約

### JavaScript/TypeScript

**eslint + prettier設定**: 自動フォーマット有効

```typescript
// ✅ 良い例
interface User {
  id: number;
  name: string;
  email: string;
  createdAt: Date;
}

const getUserById = async (id: number): Promise<User | null> => {
  try {
    const user = await userRepository.findById(id);
    return user;
  } catch (error) {
    logger.error('ユーザー取得エラー', { id, error });
    return null;
  }
};

// ❌ 悪い例
var user = function(id) {
  return db.query("SELECT * FROM users WHERE id = " + id)
}
```

**命名規則**:
- **変数・関数**: camelCase (`getUserList`)
- **定数**: UPPER_SNAKE_CASE (`MAX_RETRY_COUNT`)
- **クラス・インターフェース**: PascalCase (`UserService`)
- **ファイル名**: kebab-case (`user-service.ts`)

### Python

**Black + isort + flake8設定**: 自動フォーマット有効

```python
# ✅ 良い例
from typing import Optional
import logging

logger = logging.getLogger(__name__)

class UserService:
    def __init__(self, repository: UserRepository) -> None:
        self.repository = repository
    
    async def get_user_by_id(self, user_id: int) -> Optional[User]:
        """IDによるユーザー取得"""
        try:
            return await self.repository.find_by_id(user_id)
        except Exception as e:
            logger.error("ユーザー取得エラー", extra={"user_id": user_id, "error": str(e)})
            return None

# ❌ 悪い例  
def getUser(id):
    return db.execute(f"SELECT * FROM users WHERE id = {id}").fetchone()
```

**命名規則**:
- **変数・関数**: snake_case (`get_user_list`)
- **定数**: UPPER_SNAKE_CASE (`MAX_RETRY_COUNT`)
- **クラス**: PascalCase (`UserService`)
- **ファイル名**: snake_case (`user_service.py`)

### SQL

```sql
-- ✅ 良い例
SELECT 
    u.id,
    u.name,
    u.email,
    p.title AS project_title
FROM users u
    LEFT JOIN project_members pm ON u.id = pm.user_id
    LEFT JOIN projects p ON pm.project_id = p.id
WHERE 
    u.status = 'active'
    AND u.created_at >= '2024-01-01'
ORDER BY u.created_at DESC
LIMIT 100;

-- ❌ 悪い例
select * from users where status='active' order by id
```

## 🌟 Git ワークフロー

### ブランチ戦略

```mermaid
gitGraph
    commit id: "main"
    branch develop
    checkout develop
    commit id: "develop初期化"
    
    branch feature/user-auth
    checkout feature/user-auth
    commit id: "ログイン機能"
    commit id: "テスト追加"
    
    checkout develop
    merge feature/user-auth
    commit id: "統合テスト"
    
    branch hotfix/security-fix
    checkout main
    checkout hotfix/security-fix
    commit id: "セキュリティ修正"
    
    checkout main
    merge hotfix/security-fix
    checkout develop
    merge hotfix/security-fix
    
    checkout main
    merge develop
    commit id: "v1.0.0リリース"
```

### ブランチ命名規則

```bash
# 機能開発
feature/issue-123-user-authentication
feature/add-payment-system

# バグ修正
bugfix/issue-456-login-error
bugfix/fix-memory-leak

# 緊急修正
hotfix/security-vulnerability
hotfix/critical-production-bug

# リリース準備
release/v1.2.0
release/2024-01-sprint
```

### コミットメッセージ

**Conventional Commits** 形式を使用:

```bash
# ✅ 良い例
feat: ユーザー認証機能を追加

- JWTベースの認証システム実装
- ログイン・ログアウト機能
- パスワードハッシュ化対応

fix: ログイン時のメモリリーク修正

closes #123

docs: API仕様書を更新

test: ユーザー認証のテストケース追加

refactor: 認証ミドルウェアを分離

# ❌ 悪い例
update
fix bug
add feature
```

**プレフィックス**:
- `feat:` - 新機能
- `fix:` - バグ修正
- `docs:` - ドキュメント
- `test:` - テスト関連
- `refactor:` - リファクタリング
- `style:` - フォーマット修正
- `chore:` - 設定・ツール関連

### Pull Request

**PRテンプレート**:
```markdown
## 📋 変更概要
[変更内容の簡潔な説明]

## 🎯 関連Issue
Closes #[issue番号]

## ✅ 変更内容
- [ ] [変更内容1]
- [ ] [変更内容2]
- [ ] [変更内容3]

## 🧪 テスト
- [ ] ユニットテスト追加・更新
- [ ] 統合テスト実行
- [ ] 手動テスト実行

## 📸 スクリーンショット
[必要に応じて画像を添付]

## ⚠️ 注意事項
[レビュワーが知っておくべき重要な情報]

## 🔗 参考資料
[関連するドキュメント・資料のリンク]
```

**レビュー観点**:
- [ ] 機能が要件を満たしているか
- [ ] コーディング規約に準拠しているか
- [ ] テストが適切に書かれているか
- [ ] セキュリティ上の問題はないか
- [ ] パフォーマンスへの影響はないか
- [ ] ドキュメントは更新されているか

## 🧪 テスト戦略

### テストピラミッド

```
        /\
       /  \
      / E2E \     ← 少数（ブラウザ自動化）
     /______\
    /        \
   /統合テスト \   ← 中程度（API・DB）
  /____________\
 /              \
/  ユニットテスト  \  ← 多数（関数・クラス）
/________________\
```

### JavaScript/TypeScript

```typescript
// Jest + Testing Library
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import { UserProfile } from './UserProfile';

describe('UserProfile', () => {
  it('ユーザー名が正しく表示される', () => {
    const user = { id: 1, name: '佐藤太郎', email: 'sato@example.com' };
    
    render(<UserProfile user={user} />);
    
    expect(screen.getByText('佐藤太郎')).toBeInTheDocument();
    expect(screen.getByText('sato@example.com')).toBeInTheDocument();
  });

  it('編集ボタンクリックで編集モードになる', async () => {
    const user = { id: 1, name: '佐藤太郎', email: 'sato@example.com' };
    
    render(<UserProfile user={user} />);
    
    fireEvent.click(screen.getByRole('button', { name: '編集' }));
    
    await waitFor(() => {
      expect(screen.getByDisplayValue('佐藤太郎')).toBeInTheDocument();
    });
  });
});
```

### Python

```python
# pytest + FastAPI TestClient
import pytest
from fastapi.testclient import TestClient
from app.main import app
from app.models import User

client = TestClient(app)

@pytest.fixture
def sample_user():
    return {
        "name": "佐藤太郎",
        "email": "sato@example.com",
        "password": "secure_password123"
    }

def test_create_user_success(sample_user):
    """ユーザー作成成功ケース"""
    response = client.post("/api/users", json=sample_user)
    
    assert response.status_code == 201
    data = response.json()
    assert data["name"] == sample_user["name"]
    assert data["email"] == sample_user["email"]
    assert "password" not in data  # パスワードが含まれていないことを確認

def test_create_user_duplicate_email(sample_user):
    """重複メールアドレスでのユーザー作成"""
    # 最初のユーザーを作成
    client.post("/api/users", json=sample_user)
    
    # 同じメールアドレスで再作成
    response = client.post("/api/users", json=sample_user)
    
    assert response.status_code == 400
    assert "already exists" in response.json()["detail"]

@pytest.mark.asyncio
async def test_user_service_get_by_email():
    """ユーザーサービスの単体テスト"""
    service = UserService(repository=MockUserRepository())
    
    user = await service.get_user_by_email("sato@example.com")
    
    assert user is not None
    assert user.email == "sato@example.com"
```

### 実行コマンド

```bash
# JavaScript/TypeScript
npm test                    # 全テスト実行
npm run test:watch         # ファイル変更監視
npm run test:coverage      # カバレッジ計測

# Python
pytest                     # 全テスト実行
pytest -v                  # 詳細出力
pytest --cov=app          # カバレッジ計測
pytest -k "test_user"     # 特定テストのみ

# E2E テスト
npm run test:e2e          # Playwright実行
npm run test:e2e:ui       # UIモードで実行
```

## 🔍 デバッグ・ログ管理

### ログレベル

```typescript
// TypeScript
import logger from './logger';

logger.error('致命的なエラー', { userId: 123, error: e.message });
logger.warn('警告: APIレスポンス時間が長い', { duration: 5000 });
logger.info('ユーザーログイン', { userId: 123, ip: req.ip });
logger.debug('デバッグ情報', { query: sqlQuery, params });
```

```python
# Python
import logging
import structlog

logger = structlog.get_logger()

logger.error("致命的なエラー", user_id=123, error=str(e))
logger.warning("API応答時間警告", duration_ms=5000)
logger.info("ユーザーログイン", user_id=123, ip=request.client.host)
logger.debug("SQLクエリ", query=query, params=params)
```

### VS Code デバッグ設定

```json
// .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Node.js Debug",
      "type": "node",
      "request": "launch",
      "program": "${workspaceFolder}/src/index.ts",
      "env": {
        "NODE_ENV": "development"
      },
      "runtimeArgs": ["-r", "ts-node/register"],
      "sourceMaps": true
    },
    {
      "name": "Python Debug",
      "type": "python",
      "request": "launch",
      "program": "${workspaceFolder}/main.py",
      "env": {
        "PYTHONPATH": "${workspaceFolder}"
      },
      "console": "integratedTerminal"
    }
  ]
}
```

## 🚀 パフォーマンス・セキュリティ

### パフォーマンス最適化

**フロントエンド**:
```typescript
// ✅ 良い例 - React最適化
import { memo, useMemo, useCallback } from 'react';

const UserList = memo(({ users, onUserClick }) => {
  const sortedUsers = useMemo(() => 
    users.sort((a, b) => a.name.localeCompare(b.name)), 
    [users]
  );

  const handleClick = useCallback((user) => {
    onUserClick(user.id);
  }, [onUserClick]);

  return (
    <>
      {sortedUsers.map(user => (
        <UserCard key={user.id} user={user} onClick={handleClick} />
      ))}
    </>
  );
});
```

**バックエンド**:
```python
# ✅ 良い例 - データベース最適化
async def get_users_with_projects(limit: int = 100):
    """N+1クエリ問題を回避した効率的なデータ取得"""
    query = (
        select(User, Project)
        .join(ProjectMember, User.id == ProjectMember.user_id)
        .join(Project, ProjectMember.project_id == Project.id)
        .options(selectinload(User.projects))
        .limit(limit)
    )
    
    result = await db.execute(query)
    return result.unique().scalars().all()
```

### セキュリティチェックリスト

- [ ] **入力検証**: 全ての入力データをバリデーション
- [ ] **SQLインジェクション対策**: パラメータ化クエリ使用
- [ ] **XSS対策**: 出力エスケープ・CSP設定
- [ ] **CSRF対策**: CSRFトークン実装
- [ ] **認証・認可**: JWT・RBAC実装
- [ ] **HTTPS強制**: 全通信の暗号化
- [ ] **センシティブデータ**: パスワード・APIキーの暗号化
- [ ] **ログ**: セキュリティイベントの記録
- [ ] **依存関係**: 脆弱性スキャン・定期更新

---

*最終更新: $(date '+%Y-%m-%d %H:%M:%S JST')*
EOF

echo "📚 Wikiページを作成中..."

# 基本ページをGitにコミット
git add .
git commit -m "feat: プロジェクト管理用Wikiセットアップ完了

- Home: ナビゲーション・基本情報
- Project Overview: プロジェクト概要・KPI
- Requirements: 機能・非機能要件
- Team Info: チーム情報・連絡先・会議
- Development Guide: 開発環境・コーディング規約・テスト

sera-inc標準のプロジェクト管理テンプレート適用"

git push origin master 2>/dev/null || git push origin main

echo "✅ sera-inc GitHub Wiki セットアップ完了！"
echo ""
echo "📋 作成されたページ:"
echo "  🏠 Home - プロジェクトWikiのメインページ"
echo "  📖 Project Overview - プロジェクトの基本情報・KPI"
echo "  🎯 Requirements - 機能・非機能要件"
echo "  👥 Team Info - チーム情報・連絡先・会議スケジュール"
echo "  🔧 Development Guide - 開発環境・コーディング規約"
echo ""
echo "🌐 Wikiアクセス: https://github.com/sera-inc/${REPO_NAME}/wiki"
echo ""
echo "🎯 次のステップ:"
echo "  1. 各ページの[項目]を実際の情報に更新"
echo "  2. チームメンバーに編集権限付与"
echo "  3. プロジェクト固有の情報を追加"

cd ..
