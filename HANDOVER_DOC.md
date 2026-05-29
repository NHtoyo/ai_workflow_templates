# HANDOVER_DOC.md (プロジェクト引継ぎ書)

このファイルは、本プロジェクト（`ai_workflow_templates`）の構成および、ここで定義された「AI開発支援環境」を他のプロジェクトへ適用する方法を説明する引継ぎドキュメントです。

---

## 🛠️ プロジェクト概要と役割

このリポジトリは、**初心者でも安全かつ効率的にAIと共同開発を進めるための「AI開発支援環境のテンプレート原本」**です。

メイン開発AIである **Antigravity** と、調査・レビュー用の補助AI **Codex CLI**、および **Git/GitHub**、各種**検索MCP**を組み合わせた開発フローを定義しています。

---

## 📁 フォルダ構成とファイルの説明

プロジェクト直下の主要なファイルとフォルダの構成は以下の通りです。

```text
ai_workflow_templates/
├── README.md             <- 他プロジェクトへの導入手順書
├── HANDOVER_DOC.md       <- 本書（プロジェクト構成・ルールの記録）
├── AGENTS.md             <- エージェント共通の基本連携ルール
├── setup-ai-env.ps1      <- 【自動構築スクリプト】他プロジェクトで環境を作るためのツール
├── project/              <- 【テンプレート原本】他プロジェクトにコピーされるフォルダ原本
│   ├── AGENTS.md
│   ├── .agent/
│   │   └── rules/
│   │       └── 00_project_ai_workflow.md  <- Antigravityの自動読込用ルール
│   └── docs/
│       ├── agent_rules/   <- 詳細な各種運用ルール
│       │   ├── README.md
│       │   ├── codex_collaboration.md     <- Codex CLI連携
│       │   ├── github_workflow.md         <- Git/GitHub運用
│       │   ├── search_research_workflow.md <- 検索MCP運用
│       │   ├── paper_to_code_workflow.md  <- 論文実装手順
│       │   ├── external_code_policy.md    <- 外部コードポリシー
│       │   └── error_investigation.md     <- エラー調査手順
│       └── templates/     <- 開発で使う各種Markdownテンプレート
│           ├── research_request_template.md             <- 調査依頼書
│           ├── paper_implementation_research_memo_template.md <- 論文実装メモ
│           ├── implementation_plan_template.md          <- 実装計画書
│           ├── external_repo_record_template.md         <- 外部リポジトリ記録
│           ├── error_investigation_report_template.md   <- エラー調査報告
│           └── pr_summary_template.md                   <- 差分要約
├── docs/                 <- 本リポジトリ自身の運用フォルダ (上記の project/docs/ と同等)
├── .agent/               <- 本リポジトリ自身のルールフォルダ (上記の project/.agent/ と同等)
├── external_repos/       <- 外部リポジトリを一時的に置いておくフォルダ（Git管理対象外）
└── .gitignore            <- Git管理から除外する設定（external_repos/ や 秘密情報など）
```

---

## 🚀 他のプロジェクトへの環境展開方法 (グローバル再利用)

新しいプロジェクトや、他の開発リポジトリにこの「AI共同開発環境」を適用したい場合は、以下の手順を実行します。

1. **コピー先プロジェクトのフォルダを開く**
   PowerShell で、環境を適用したいプロジェクトのルートフォルダに移動します。
   ```powershell
   cd C:\Users\0722h\my_new_project
   ```

2. **セットアップスクリプトの実行**
   本リポジトリ内にある `setup-ai-env.ps1` を指定して、PowerShell上で実行します。
   ```powershell
   powershell -ExecutionPolicy Bypass -File C:\Users\0722h\ai_workflow_templates\setup-ai-env.ps1
   ```

3. **実行されること**
   - テンプレート原本（`project/` 配下）の `AGENTS.md`、`docs/`、`.agent/` が自動でコピーされます。
   - `external_repos/`（外部コード用フォルダ）が作成されます。
   - コピー先プロジェクトで Git が初期化されていない場合、自動的に `git init` が実行されます。
   - `.gitignore` に、外部コードや秘密情報（`external_repos/`, `.env` など）をGitに含めないためのルールが自動追記されます。

---

## ⚖️ 基本的なAI共同開発ルール

### 1. 相談と承認（セーフティネット）
* 大きな変更（ファイルの移動、Gitの初期化、外部コードの導入など）を行う前には、**必ず事前に日本語でユーザーに目的・影響・対象ファイルを説明し、明確な許可を得る**。
* エラーが発生した場合、AIが裏で勝手にコマンドを動かして「もみ消し」や「自己修復」を図ることは禁止。即座に作業を止め、状況を日本語で正確にユーザーに報告する。

### 2. 役割分担
* **Antigravity (Gemini)**:
  - メインの開発・実装、UI設計、動作確認、プロジェクト全体の意思決定と司令塔。
* **Codex CLI**:
  - `git diff` の要約、commitメッセージ案、PR本文案の作成。
  - エラー発生時の「原因推定」や「確認コマンドの提案」。
  - 論文や外部コードの要約とコード比較。
* **Git**:
  - AIが開発中にコードを壊してしまった場合のセーブ地点として使用。
  - 作業前後の `git status` 確認と、変更完了時の丁寧な日本語説明付きcommit。

---

## 🔄 今後の運用とメンテナンス

* テンプレートの「詳細ルール」や「テンプレート」を修正する場合は、必ず **`project/` ディレクトリ配下にある原本ファイル**を編集してください。
* 原本を編集した後は、必要に応じて `setup-ai-env.ps1` を実行することで、本テンプレートリポジトリ自身のルート環境も最新の状態にアップデートできます。

---

## 🔄 プロジェクト引継ぎ・進捗管理の一本化 (HANDOVER_DOC.md)

本プロジェクトでは、動的な開発進捗・プログラム一覧の記録と、静的な概要説明を **`HANDOVER_DOC.md`（本ファイル）一本に一元化** して運用します。

* **.gemini/rule.md の完全廃止**
  - 重複を防ぐため、`.gemini/rule.md` は使用せず完全に廃止されました。
* **本ファイルへの動的記録の統合**
  - AIエージェントは、作業中にプログラムの追加・変更を行った場合や、設計の決定を行った場合、その機能解説や作成されたプログラムのパス・説明、および現在の開発状況を、すべて本ファイルの該当セクション（進捗状況など）に直接自動で追記・更新してください。
  - 本ファイルはGitで管理され、人間とAIが常に同じファイルを見て正確な進捗とドキュメントを同期します。
