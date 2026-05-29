# Codex CLI 連携ルール

## Codexの位置づけ

Codex CLIは、Antigravityの代替ではなく補助係として使う。

## Codex CLIとChatGPT Plusの関係

このプロジェクトでは、OpenAIのCodex CLIをAntigravityの補助エージェントとして使う。

ChatGPT Plusに加入している場合、CodexはPlusプランに含まれる。
Codexはブラウザ版ChatGPTに手動でプロンプトを貼るだけの使い方ではなく、Codex CLI、Codex IDE拡張、Codex WebなどのCodexクライアントから利用できる。

Codex CLIを使う場合は、CLI側でChatGPTアカウントにサインインする。
認証時にブラウザが開く場合があるが、通常運用ではAntigravityのターミナルからCodex CLIを呼び出す。

Codex CLIには、以下の作業を任せる。

- git diff の要約
- commitメッセージ案の作成
- コードレビュー
- エラー原因調査
- テスト失敗ログの分析
- 論文調査
- 外部GitHubコード調査
- 実装計画作成

注意：
Codexの利用枠は無制限ではない。
利用上限はChatGPTプラン、使用モデル、タスクの大きさ、ローカル実行かクラウド実行かによって変わる。
軽い調査・レビューは多く回せるが、大規模コードベース調査や長時間セッションは消費が大きい。
APIキーでCodexを使う場合は、ChatGPT Plus枠ではなくAPI課金になる可能性があるため、原則としてChatGPTサインインを優先する。

## 基本姿勢

最初からCodexに大規模修正をさせない。まずは「読む」「調べる」「要約する」「原因候補を出す」作業を任せる。

## 推奨プロンプト：差分レビュー

```text
現在のgit diffを読んで、変更内容を初心者にも分かるように要約してください。
ファイルは変更しないでください。
最後にcommitメッセージ案を3つ出してください。
```

## 推奨プロンプト：エラー調査

```text
エラー原因を調査してください。
まずファイルは変更しないでください。
エラーログと関連しそうなファイルだけを見て、原因候補を最大3つ出してください。
各候補について根拠、確認方法、修正方針を示してください。
最後にAntigravity側への次の指示文を作ってください。
```

## 推奨プロンプト：論文・外部コード調査

```text
この調査依頼書を読んで、実装に必要な論文・公式GitHub・README・requirements・license・issueを調査してください。
結果は docs/research/ にMarkdownで保存してください。
完成コードではなく、実装仕様書と最小実装案を作ってください。
```

## Codexに修正させる場合

- AntigravityとCodexを同時に同じファイルへ走らせない。
- 変更前に `git status` を確認する。
- 変更後に `git diff --stat` と変更理由を出す。
- 可能なら構文確認、テスト、起動確認を行う。

## Windows環境における非対話型呼び出しのエラー回避方法（HOWTO）

Antigravityなどの外部エージェント（非対話型プログラム）から、Windows環境上のPowerShell経由でCodex CLIを呼び出す際、以下の2つの制限によりエラーが発生する場合があります。

### 1. PowerShellのセキュリティ制限（ExecutionPolicy）
- **現象**: `running scripts is disabled on this system.（このシステムではスクリプトの実行が無効になっています）` というエラーが発生し、インストールされた `codex.ps1` が実行できない。
- **回避策**:
  - PowerShellではなく、スクリプト実行制限を受けない `cmd.exe` を通して起動する（`codex` コマンドの代わりに、コマンドプロンプト用の `codex.cmd` を呼び出す）。
  - または、実行時に `-ExecutionPolicy Bypass` オプションを明示的に指定して実行する。

### 2. 対話画面（TUI）の要求制限
- **現象**: `Error: stdin is not a terminal` というエラーが発生する。これはCodex CLIが通常起動時に対話型のUI画面を表示しようとしますが、非対話環境から呼び出されたために安全のために停止する制限です。
- **回避策**:
  - **execモードを使用する**: 対話画面を開かず、一回限りの命令として実行する `codex exec` もしくは `codex.cmd exec` モードを使用する。
  - **標準入力を閉じる**: コマンドの末尾に `< NUL` （Windowsのコマンドプロンプト）または標準入力のリダイレクトを行い、入力待ちでフリーズしないように制御する。
  - **承認ポリシーを設定する**: 承認待ちで止まらないように、非対話実行時は `--ask-for-approval never` オプションを付与する。
