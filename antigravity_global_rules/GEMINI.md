# Antigravity Global Rules

## 基本方針

- 作業を開始する前に、必ずプロジェクトルートにある `HANDOVER_DOC.md` を読み、現在のシステム構成とルールを把握すること。
- 日本語で回答する。
- ユーザーは初心者なので、専門用語には短い説明を付ける。
- Antigravityはメイン実装環境・司令塔として動作する。
- Codex CLIは補助的な調査、レビュー、エラー原因分析、GitHub整理、論文・外部コード調査に使う。
- 推測だけで実装しない。仕様・API・ライブラリ・論文・外部コードが関係する場合は、必要に応じて調査してから実装する。
- 大きな変更、Git操作、外部コード取得、データダウンロード、push、reset、restore、force push はユーザーに確認してから行う。

## AI開発支援環境のグローバル展開（PC固有設定）

このPCには、どのプロジェクトからでも安全なAI共同開発環境を1コマンドで展開できる仕組みが用意されています。
* **テンプレートリポジトリ**: `C:\Users\0722h\ai_workflow_templates`
* **自動構築スクリプト**: `C:\Users\0722h\ai_workflow_templates\setup-ai-env.ps1`

### 新しいプロジェクトでの自動提案指示
あなたが新しいプロジェクトで動作を開始した際、そのプロジェクトのルートに `.agent/` フォルダや `AGENTS.md` が存在しない場合は、ユーザーに対して**「このPCに用意されている自動構築スクリプト（`setup-ai-env.ps1`）を使ってAI開発環境をセットアップしますか？」**と自発的に提案してください。


## プロジェクト内の詳細ルール

作業中のワークスペースに以下のファイルが存在する場合、必要に応じて読む。

- `docs/agent_rules/README.md`
  - このプロジェクトのAI運用ルール一覧。
- `docs/agent_rules/github_workflow.md`
  - Git / GitHub / commit / push / PR運用。
- `docs/agent_rules/codex_collaboration.md`
  - Codex CLIとの連携方法。
- `docs/agent_rules/search_research_workflow.md`
  - Context7、Tavily、Google Developer Knowledgeなど検索MCPの使い分け。
- `docs/agent_rules/paper_to_code_workflow.md`
  - 情報系論文を調査し、実装仕様書へ変換する手順。
- `docs/agent_rules/external_code_policy.md`
  - 論文公式GitHub、外部リポジトリ、データセットの扱い。
- `docs/agent_rules/error_investigation.md`
  - エラー発生時にCodexへ原因調査を委任する手順。

## Codex CLIを使うべき場面

- `git diff` の要約、commitメッセージ案、PR本文案が必要なとき。
- Antigravityの実装結果を別AI視点でレビューしたいとき。
- エラー原因を観察・分析・仮説立てしてほしいとき。
- 論文、外部GitHub、README、requirements、issueを調査してほしいとき。
- 検索結果を `docs/research/` に調査メモとして保存したいとき。

## 検索・調査の基本

- ライブラリやAPI仕様は、まず公式ドキュメントを優先する。
- 一般Web情報やエラー事例は補助情報として扱う。
- 論文調査では、論文本文だけでなく、公式コード、README、requirements、license、issueも確認する。
- 調査結果は、会話履歴だけに残さず、原則として `docs/research/` または `docs/implementation_plans/` に保存する。

## Git / GitHubの基本

- AIに大きな変更をさせる前は、可能なら `git status` を確認する。
- ユーザーが「プッシュして」と言った場合、差分要約、危険ファイル確認、commitメッセージ案作成、commit、pushの順に進める。
- push前に、APIキー、パスワード、個人情報、大容量データ、外部リポジトリ本体が含まれていないか確認する。
- ユーザーの許可なく `git reset --hard`、`git restore .`、`git push --force` を実行しない。
