# Antigravity + Codex + GitHub + 論文調査 運用テンプレート

このテンプレートは、Antigravityをメイン開発環境、Codex CLIを調査・レビュー・GitHub整理係として使うための初期セットです。

## 使い方 (自動セットアップ)

他のプロジェクトにこの環境（設定ファイル、フォルダ構造、ルール、テンプレートなど）を一括して展開するには、以下の手順を実行します。

1. **PowerShell** を起動し、環境を適用したいプロジェクトのルートディレクトリに移動します。
   ```powershell
   cd C:\path\to\your\target_project
   ```
2. 本テンプレートリポジトリ内の `setup-ai-env.ps1` を実行します。
   ```powershell
   powershell -ExecutionPolicy Bypass -File C:\Users\0722h\ai_workflow_templates\setup-ai-env.ps1
   ```
   * ※実行すると自動で `AGENTS.md` や `docs/` 等のコピー、`git init` の確認、`.gitignore` への除外パターン追記が行われます。

---

## 使い方 (手動セットアップ)

PowerShellスクリプトを使用せず、手動でセットアップする場合は以下を行います。

1. `antigravity_global_rules/GEMINI.md` の内容を Antigravity の Global Rules に貼り付ける。
2. `project/AGENTS.md` を自分のプロジェクト直下に置く。
3. `project/.agent/rules/00_project_ai_workflow.md` を自分のプロジェクトの `.agent/rules/` に置く。
4. `project/docs/agent_rules/` と `project/docs/templates/` を自分のプロジェクトにコピーする。
5. `project/.gitignore_snippet.txt` の内容を自分の `.gitignore` に追加する。
6. プロジェクト直下に `external_repos/` ディレクトリを作成する。

---

## 基本思想

- Antigravity: 実装、UI確認、ブラウザ確認、全体の司令塔。
- Codex CLI: 調査、エラー原因分析、差分レビュー、GitHub整理、論文・外部コード調査。
- GitHub: セーブ地点、履歴、バックアップ、Pull Request確認場所。
- docs/research/: 検索・論文・外部コードの調査メモ置き場。
- external_repos/: 参考用にcloneした外部リポジトリ置き場。自分のGitには含めない。

## 注意

このテンプレートは「AIが必ず自動で指定ファイルを読む」ことを保証するものではありません。Global Rules や AGENTS.md に「必要時はこのパスを読む」と明記し、プロンプトでも必要に応じて読み込みを指示してください。
