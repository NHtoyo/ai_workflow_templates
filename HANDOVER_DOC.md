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

---

## 📈 動的開発進捗ログ (AI自動更新セクション)

AIエージェントが本プロジェクトで行った最新の実装状況や設計変更のログです。作業完了時にAIが自動追記します。

### 2026-05-29 (環境構築・テンプレート改善)
* **実施内容**:
  * Windows PCにおけるAI共同開発環境の初期セットアップを完了。
  * `C:\Users\0722h\.gemini\config\AGENTS.md` にグローバルルールを定義し、`.gemini/rule.md` を廃止して本ファイル（`HANDOVER_DOC.md`）へ進捗・引き継ぎ記録を一元化するポリシーに移行。
  * Codex CLI に Brave Search、Tavily、GitHub 検索のMCPサーバーを登録し、不要となった `brave-search` を削除（Tavilyに一本化）。
  * 動作確認用のテストフォルダ `C:\Users\islab\ai_env_test_project\` を作成し、`setup-ai-env.ps1` の自動展開と、CodexによるTavily経由の天気予報調査（`docs/research/weather_report.md` 生成）のテストを実行。正常に完遂を確認。
* **作成・更新したプログラム・設定ファイル**:
  * [setup-ai-env.ps1](file:///C:/Users/islab/ai_workflow_templates/setup-ai-env.ps1) : テンプレートの自動展開とGit初期化を行うスクリプト（検証済み）。
  * [codex_collaboration.md](file:///C:/Users/islab/ai_workflow_templates/docs/agent_rules/codex_collaboration.md) : Windows環境における非対話型エラーの回避策（実行ポリシー、TUIフリーズ、サンドボックス制限、文字化け対策リダイレクトHOWTO）およびAI絶対厳守ルールを追記。
  * [search_research_workflow.md](file:///C:/Users/islab/ai_workflow_templates/docs/agent_rules/search_research_workflow.md) : TavilyとBrave Searchの特徴と、無料枠における制限（クレジットカード登録の有無など）の解説を追記。
  * [HANDOVER_DOC.md](file:///C:/Users/islab/ai_workflow_templates/HANDOVER_DOC.md) : 引継ぎ・進捗管理の `HANDOVER_DOC.md` 一本化ポリシーを追加、不要な `.gemini/` 除外を解除。
* **リモートコミットID**: `2aa06df` (および今回の進捗追記分)

---

## 🔍 技術的な調査・解析メモ

### Codex CLI実行時のフリーズ問題と解決策 (Windows/PowerShell制限)

* **エラーの原因**:
  * PowerShell経由でバックグラウンド実行した際、Windowsのセキュリティ（ExecutionPolicy）によってプロファイルの読み込みがブロックされました。
  * さらに、非対話実行（`-a never`）を行っていたため、Codex内部でユーザーに入力やツールの承認を求める処理が発生した際、標準入力（stdin）の応答待ち状態で完全にフリーズ（ハングアップ）してしまっていたことが原因でした。
* **対応・解決策**:
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

---

## 📈 動的開発進捗ログ (AI自動更新セクション)

AIエージェントが本プロジェクトで行った最新の実装状況や設計変更のログです。作業完了時にAIが自動追記します。

### 2026-05-29 (環境構築・テンプレート改善)
* **実施内容**:
  * Windows PCにおけるAI共同開発環境の初期セットアップを完了。
  * `C:\Users\0722h\.gemini\config\AGENTS.md` にグローバルルールを定義し、`.gemini/rule.md` を廃止して本ファイル（`HANDOVER_DOC.md`）へ進捗・引き継ぎ記録を一元化するポリシーに移行。
  * Codex CLI に Brave Search、Tavily、GitHub 検索のMCPサーバーを登録し、不要となった `brave-search` を削除（Tavilyに一本化）。
  * 動作確認用のテストフォルダ `C:\Users\islab\ai_env_test_project\` を作成し、`setup-ai-env.ps1` の自動展開と、CodexによるTavily経由の天気予報調査（`docs/research/weather_report.md` 生成）のテストを実行。正常に完遂を確認。
* **作成・更新したプログラム・設定ファイル**:
  * [setup-ai-env.ps1](file:///C:/Users/islab/ai_workflow_templates/setup-ai-env.ps1) : テンプレートの自動展開とGit初期化を行うスクリプト（検証済み）。
  * [codex_collaboration.md](file:///C:/Users/islab/ai_workflow_templates/docs/agent_rules/codex_collaboration.md) : Windows環境における非対話型エラーの回避策（実行ポリシー、TUIフリーズ、サンドボックス制限、文字化け対策リダイレクトHOWTO）およびAI絶対厳守ルールを追記。
  * [search_research_workflow.md](file:///C:/Users/islab/ai_workflow_templates/docs/agent_rules/search_research_workflow.md) : TavilyとBrave Searchの特徴と、無料枠における制限（クレジットカード登録の有無など）の解説を追記。
  * [HANDOVER_DOC.md](file:///C:/Users/islab/ai_workflow_templates/HANDOVER_DOC.md) : 引継ぎ・進捗管理の `HANDOVER_DOC.md` 一本化ポリシーを追加、不要な `.gemini/` 除外を解除。
* **リモートコミットID**: `2aa06df` (および今回の進捗追記分)

---

## 🔍 技術的な調査・解析メモ

### Codex CLI実行時のフリーズ問題と解決策 (Windows/PowerShell制限)

* **エラーの原因**:
  * PowerShell経由でバックグラウンド実行した際、Windowsのセキュリティ（ExecutionPolicy）によってプロファイルの読み込みがブロックされました。
  * さらに、非対話実行（`-a never`）を行っていたため、Codex内部でユーザーに入力やツールの承認を求める処理が発生した際、標準入力（stdin）の応答待ち状態で完全にフリーズ（ハングアップ）してしまっていたことが原因でした。
* **対応・解決策**:
  * PowerShell環境固有の制限を回避するため、Codexを呼び出す際のシェルをコマンドプロンプト（`cmd.exe /c`）に切り替えました。
  * 同時に、標準入力を強制的に遮断するコマンド（`< NUL`）を付与することで、「入力待ちによるフリーズ」を根本から防ぎ、非インタラクティブなバックグラウンドタスクとして安定稼働させる手法を確立しました。

### 2026-06-22 (グローバルルールのアーキテクチャ統合)
* **実施内容**:
  * グローバルルールの配置場所を非公式パス（`.gemini/GEMINI.md`）から、Antigravity標準の公式パス（`.gemini/config/AGENTS.md`）に統合。これにより仕様書と現実のズレ（二重管理による混乱）を解消。
  * テンプレートリポジトリ内の旧 `GEMINI.md` を `AGENTS.md` にリネーム。
  * `setup-ai-env.ps1` を修正し、他のPCでクローン・セットアップを実行した際に、自動的にホストPCの `~/.gemini/config/AGENTS.md` へルールがデプロイされる処理を追加実装。

### 2026-06-23 (ドキュメント更新ルールの復元)
* **実施内容**:
  * 旧ファイルから移行漏れとなっていた「自発的ドキュメント更新の義務 (Proactive Documentation Policy)」を `AGENTS.md` に復元し、テンプレートおよびホスト側に適用。
  * ユーザーからの追加指摘により、さらに移行漏れが判明した「実行効率化・ユーザーUX保護ポリシー (Execution Efficiency Policy)」および「Proactive Documentation Policy の完全版」を `AGENTS.md` に完全復元。
  * 本ポリシーに従い、作業内容を即座に [HANDOVER_DOC.md](file:///C:/Users/0722h/ai_workflow_templates/HANDOVER_DOC.md) へ記録。
  * 本ファイルの参照パス内の `0722h` などの他環境ユーザー名を、このPC環境 (`islab`) に適合するよう一部修正。

### 2026-06-23 (グローバルルールの完全統合とマージ反映)
* **実施内容**:
  * 旧 `GEMINI.md` にのみ記載されていた詳細ルール（詳細な作業承認リスト、秘密情報の取り扱い、作業前確認リスト、検索MCPの具体的な使い分け、報告フォーマット）を、最新の `antigravity_global_rules/AGENTS.md` に漏れなく統合・マージ。
  * グローバル展開スクリプトのパス指定を本PCの構成（`islab`）に修正。
  * `setup-ai-env.ps1` を実行し、マージ・修正済みの新グローバルルールを `~/.gemini/config/AGENTS.md` に配備。古い `GEMINI.md` はクリーンアップせず残存。
  * 以上の変更をリポジトリへコミットし、Gitへプッシュ。
* **作成・更新したプログラム・設定ファイル**:
  * [antigravity_global_rules/AGENTS.md](file:///C:/Users/islab/ai_workflow_templates/antigravity_global_rules/AGENTS.md) : 旧GEMINI.mdの重要ルールをマージした完全版グローバルルール。
  * [HANDOVER_DOC.md](file:///C:/Users/islab/ai_workflow_templates/HANDOVER_DOC.md) : 今回のグローバルルール統合の作業ログを追記。

### 2026-06-23 (グローバルルールのリファクタリング・スリム化)
* **実施内容**:
  * `antigravity_global_rules/AGENTS.md` が統合によって冗長化していたため、禁止事項や制約の意味を一切欠落させずに、重複箇所（環境セットアップ指示、ドキュメント更新ルールの分散など）を整理・統合してスリム化を実施。
  * スリム化された新グローバルルールを `setup-ai-env.ps1` 経由で再配備し、本ファイルおよびリポジトリを更新してプッシュ完了。
