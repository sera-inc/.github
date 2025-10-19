# GitHub Projects 設定手順書

## 🎯 概要
GitHub Projects (v2) を使用してプロジェクト管理を行うための詳細設定手順です。

## 📋 設定手順

### ステップ1: プロジェクト作成
1. GitHubの組織ページ（https://github.com/sera-inc）に移動
2. 上部メニューの「Projects」をクリック
3. 「New project」ボタンをクリック
4. プロジェクト設定を入力：
   ```
   Project name: [CLIENT-NAME]-[SYSTEM-NAME] Project
   例: 世良寺-参拝者管理システム Project
   ```
5. Template: 「Team backlog」を選択
6. 「Create project」をクリック

### ステップ2: カスタムフィールド設定

#### 2-1. Status フィールド（既存を編集）
```yaml
Field名: Status
Type: Single select
Options:
  - name: 📋 Backlog
    color: Gray
    description: 未着手のタスク
  - name: 🔍 Ready  
    color: Blue
    description: 着手準備完了
  - name: 🚀 In Progress
    color: Yellow
    description: 作業進行中
  - name: 👀 Review
    color: Orange  
    description: レビュー待ち
  - name: ✅ Done
    color: Green
    description: 完了済み
  - name: ❌ Blocked
    color: Red
    description: ブロック状態
```

#### 2-2. Priority フィールド
```yaml
Field名: Priority
Type: Single select
Options:
  - name: 🔴 Critical
    color: Red
    description: 緊急対応必要
  - name: 🟠 High
    color: Orange
    description: 高優先度
  - name: 🟡 Medium
    color: Yellow
    description: 中優先度
  - name: 🔵 Low
    color: Blue
    description: 低優先度
```

#### 2-3. Component フィールド
```yaml
Field名: Component
Type: Single select
Options:
  - name: 🎨 Frontend
    color: Blue
  - name: ⚙️ Backend
    color: Purple
  - name: 🗄️ Database
    color: Orange
  - name: 🏗️ Infrastructure
    color: Gray
  - name: 🎭 UI/UX
    color: Pink
  - name: 📱 API
    color: Green
```

#### 2-4. Sprint フィールド
```yaml
Field名: Sprint
Type: Single select
Options:
  - name: Sprint 1
    color: Blue
  - name: Sprint 2  
    color: Green
  - name: Sprint 3
    color: Orange
  - name: Sprint 4
    color: Purple
  # 必要に応じて追加
```

#### 2-5. Story Points フィールド
```yaml
Field名: Story Points
Type: Single select
Options:
  - name: 1
    color: Light Green
  - name: 2
    color: Green
  - name: 3
    color: Yellow
  - name: 5
    color: Orange
  - name: 8
    color: Red
  - name: 13
    color: Dark Red
  - name: 21
    color: Purple
```

#### 2-6. Must/Want フィールド
```yaml
Field名: Must/Want
Type: Single select
Options:
  - name: 🚨 Must
    color: Red
    description: 必須要件
  - name: 💫 Want
    color: Blue
    description: 希望要件
```

#### 2-7. Figma Link フィールド
```yaml
Field名: Figma Link
Type: URL
Description: 関連するFigmaデザインのURL
```

#### 2-8. Security Status フィールド
```yaml
Field名: Security Status
Type: Single select
Options:
  - name: ✅ Checked
    color: Green
    description: セキュリティチェック済み
  - name: 🔍 Checking
    color: Yellow
    description: チェック中
  - name: ❌ Not Checked
    color: Red
    description: 未チェック
  - name: N/A
    color: Gray
    description: チェック不要
```

#### 2-9. Review Status フィールド
```yaml
Field名: Review Status
Type: Single select
Options:
  - name: ✅ Approved
    color: Green
    description: 承認済み
  - name: 🔍 In Review
    color: Orange
    description: レビュー中
  - name: 📝 Changes Requested
    color: Red
    description: 修正要求
  - name: ⏳ Pending
    color: Yellow
    description: レビュー待ち
```

### ステップ3: ビュー設定

#### 3-1. メインカンバンビュー（Default Board）
```yaml
View名: 📊 Main Kanban
Type: Board
Group by: Status
Filters:
  - is:open
Sort: 
  - Priority (descending)
  - Story Points (ascending)
Fields displayed:
  - Title
  - Assignees
  - Labels
  - Priority
  - Component
  - Story Points
  - Sprint
```

#### 3-2. スプリントビュー
```yaml
View名: 🏃 Sprint Board
Type: Board
Group by: Status
Filters:
  - is:open
  - Sprint equals "Sprint 1" (現在のスプリント)
Sort:
  - Priority (descending)
Fields displayed:
  - Title
  - Assignees
  - Priority
  - Story Points
  - Component
  - Review Status
```

#### 3-3. 担当者別ビュー
```yaml
View名: 👥 Team Members
Type: Board
Group by: Assignees
Filters:
  - is:open
Sort:
  - Priority (descending)
Fields displayed:
  - Title
  - Status
  - Priority
  - Component
  - Story Points
  - Sprint
```

#### 3-4. 優先度別ビュー
```yaml
View名: 🔥 Priority View
Type: Table
Filters:
  - is:open
Sort:
  - Priority (descending)
  - Story Points (descending)
Fields displayed:
  - Title
  - Status
  - Priority
  - Component
  - Assignees
  - Story Points
  - Sprint
  - Must/Want
```

#### 3-5. コンポーネント別ビュー
```yaml
View名: 🔧 Component View
Type: Board
Group by: Component
Filters:
  - is:open
Sort:
  - Priority (descending)
Fields displayed:
  - Title
  - Status
  - Priority
  - Assignees
  - Story Points
  - Review Status
```

#### 3-6. レビューステータス別ビュー
```yaml
View名: 👀 Review Pipeline
Type: Board
Group by: Review Status
Filters:
  - is:open
  - Status not equal "Backlog"
Sort:
  - Priority (descending)
Fields displayed:
  - Title
  - Status
  - Priority
  - Component
  - Assignees
  - Figma Link
  - Security Status
```

#### 3-7. 完了済みタスクビュー
```yaml
View名: ✅ Completed Tasks
Type: Table
Filters:
  - is:closed
  - closed date within last 30 days
Sort:
  - Closed date (descending)
Fields displayed:
  - Title
  - Status
  - Priority
  - Component
  - Assignees
  - Story Points
  - Sprint
```

### ステップ4: 自動化設定

#### 4-1. Issue自動追加
```yaml
項目: リポジトリのIssueを自動でプロジェクトに追加
設定: 
  - Trigger: Issue created
  - Action: Add to project
  - Default values:
    - Status: Backlog
    - Priority: Medium
```

#### 4-2. Pull Request自動追加
```yaml
項目: Pull Requestを自動でプロジェクトに追加
設定:
  - Trigger: Pull request created
  - Action: Add to project
  - Default values:
    - Status: Review
    - Priority: Medium
```

#### 4-3. ステータス自動更新
```yaml
項目: PRマージ時に自動でDoneに移動
設定:
  - Trigger: Pull request merged
  - Action: Set Status to "Done"
```

### ステップ5: 権限設定

#### 5-1. チームメンバー招待
1. プロジェクト右上の「⚙️」→「Settings」
2. 「Manage access」セクション
3. 「Add people」で以下を招待：

```yaml
Project Manager:
  - Role: Admin
  - Permissions: 全権限

Lead Developer:
  - Role: Write
  - Permissions: 編集・コメント・ステータス変更

Developers:
  - Role: Write  
  - Permissions: 編集・コメント・ステータス変更

Designer:
  - Role: Write
  - Permissions: 編集・コメント・Figmaリンク更新

QA Engineer:
  - Role: Write
  - Permissions: 編集・レビューステータス更新

Client:
  - Role: Read
  - Permissions: 閲覧・コメントのみ
```

## 🚀 運用フロー

### 新規タスク作成時
1. GitHub Issueを作成（Issue Templateを使用）
2. 自動でProjectに追加される
3. PMが以下を設定：
   - Priority
   - Component  
   - Sprint
   - Story Points
   - Must/Want

### 開発開始時
1. 開発者がタスクをアサイン
2. StatusをIn Progressに変更
3. Figmaデザインがある場合はURLを設定

### レビュー時
1. StatusをReviewに変更
2. Review StatusをIn Reviewに変更
3. セキュリティチェック実施
4. Security StatusをCheckedに変更

### 完了時
1. Pull RequestをMerge
2. 自動でStatusがDoneに変更
3. Review StatusをApprovedに変更

## 📊 レポート活用

### 週次レポート
- Priority Viewで高優先度タスクの進捗確認
- Sprint Boardで当週の完了予定確認
- Team Membersで個人の作業負荷確認

### 月次レポート  
- Completed Tasksで月間完了実績確認
- Component Viewでモジュール別進捗確認
- 自動化されたGitHub Actionsレポートと連携

## 🔧 カスタマイズポイント

### プロジェクト固有の設定
- 業界・システム特有のComponentを追加
- 客先特有のワークフローに合わせたStatusを調整
- 開発チームのスキルに応じたStory Points調整

### 外部ツール連携
- Figma Plugin との連携設定
- Slack通知設定
- GitHub Actions自動レポート連携

これらの設定により、包括的なプロジェクト管理が可能になります。

## 📚 関連ドキュメント

このガイドは GitHub Projects の技術的な設定手順を説明していますが、より詳細なプロジェクト管理のガイドラインについては、以下のドキュメントを参照してください：

### Engineering Handbook
- [sera-inc/engineering-handbook](https://github.com/sera-inc/engineering-handbook) - 開発組織全体のプロセスとガイドライン
- [GitHub プロジェクト管理ドキュメント](https://github.com/sera-inc/engineering-handbook/tree/main/docs/07-github-project-management) - プロジェクト管理の包括的なガイド

### 具体的なトピック
- [Issue 管理](https://github.com/sera-inc/engineering-handbook/blob/main/docs/07-github-project-management/03-issue-management.md) - ラベル体系、Issue テンプレート、ワークフローの詳細
- [Projects 設定](https://github.com/sera-inc/engineering-handbook/blob/main/docs/07-github-project-management/02-projects-setup.md) - カスタムフィールド、ビュー、自動化の運用ガイド
- [Pull Request プロセス](https://github.com/sera-inc/engineering-handbook/blob/main/docs/07-github-project-management/05-pull-request-process.md) - PR テンプレート、レビュープロセス、マージ戦略
- [自動化ワークフロー](https://github.com/sera-inc/engineering-handbook/blob/main/docs/07-github-project-management/README.md#07-自動化ワークフロー) - GitHub Actions による自動化の詳細
