# dotfiles

このリポジトリは、`nix` と `home-manager` でユーザー環境を宣言的に管理するための設定集です。  
`bash` / `zsh` / `tmux` / `nvim` の設定と、よく使うツール類をひとまとめにしています。

## 設計思想

- **設定はすべてコードで管理する**
  - 手で書き換えるより、リポジトリを更新して再適用する。
- **Home Manager をユーザー環境の単一ソースにする**
  - シェル設定、dotfiles、パッケージを `nix/modules/home` に集約する。
- **再現性を重視する**
  - `flake.nix` で `nixpkgs` と `home-manager` の組み合わせを固定する。
- **必要なものだけを入れる**
  - `home.packages` に入れたものだけを端末から使えるようにする。

## 新規端末での Nix / Home Manager 導入

このリポジトリは `flake` を使うので、Nix では `nix-command` と home-manager switch -b backup --flake .`flakes` を有効にしてください。

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix
printf 'experimental-features = nix-command flakes\n' >> ~/.config/nix/nix.conf
```

インストール直後は、新しいシェルを開くか次を実行して Nix を PATH に通します。

```bash
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
```

その後、このリポジトリを clone します。初回は `home-manager` コマンドがまだ存在しないため、`nix run` 経由で適用します。

```bash
git clone <このリポジトリのURL> ~/dotfiles
cd ~/dotfiles
nix run home-manager/master -- switch -b backup --flake .#r-waki@x86_64-linux
```

適用後は `home-manager` コマンドが使えるようになります。

設定名は `r-waki@<system>` 形式です。`flake.nix` は `x86_64-linux`(WSL2 や Intel/AMD の Linux)と `aarch64-darwin`(Apple Silicon の macOS)を対象にしています。macOS では `.#r-waki@aarch64-darwin` を指定してください。

## 設定変更を端末へ反映する方法

1. 設定ファイルを編集する
2. 反映する

```bash
cd ~/dotfiles
home-manager switch -b backup --flake .#r-waki@x86_64-linux
```

3. 端末側で再読み込みする

- **bash**: `source ~/.bashrc`
- **zsh**: `source ~/.zshrc`
- **tmux**: `tmux source-file ~/.tmux.conf`
- **nvim**: 終了して起動し直す

`home.packages` を変えた場合は、`switch` 後に新しいシェルを開くと PATH も反映されやすいです。

## AIエージェント用スキルの導入

このリポジトリの `.agents/skills/` にあるスキルは、[Skills CLI](https://skills.sh/docs/cli) から各エージェントのユーザー環境へ導入できます。Node.js 22.20 以降を用意し、次を実行してください。

```bash
npx skills add r-waki/dotfiles --all -g
```

`--all` はリポジトリ内の全スキルを全対応エージェントに追加し、`-g` はプロジェクト単位ではなくユーザー単位で導入します。GitHub CopilotとClaude Codeだけに導入する場合は、対象エージェントを指定します。

```bash
npx skills add r-waki/dotfiles --skill '*' -g -a github-copilot -a claude-code
```

導入状況は次のコマンドで確認できます。

```bash
npx skills list -g
```

この操作は `.agents/` 全体をコピーするのではなく、CLIが検出したスキルを各エージェントから使えるように登録します。導入先やリンク方式を選びたい場合は `--all` を外して実行し、CLIの案内に従ってください。導入したスキルを更新するには `npx skills update -g` を実行します。

### 管理しているスキル

このリポジトリでは、次のスキルを `.agents/skills/` で管理しています。各スキル名から `SKILL.md` を開くと、詳しい使い方を確認できます。

#### Matt Pocockのスキル

以下は [`mattpocock/skills`](https://github.com/mattpocock/skills) から導入したスキルです。

| スキル | 内容 |
| --- | --- |
| [ask-matt](.agents/skills/ask-matt/SKILL.md) | 目的に合うスキルや作業フローを案内する |
| [chief-of-staff](.agents/skills/chief-of-staff/SKILL.md) | 長期的な目標に向けて複数の作業を調整する |
| [claude-handoff](.agents/skills/claude-handoff/SKILL.md) | 現在の会話を新しいバックグラウンドエージェントに引き継ぐ |
| [code-review](.agents/skills/code-review/SKILL.md) | コーディング規約と仕様の両面から変更をレビューする |
| [codebase-design](.agents/skills/codebase-design/SKILL.md) | モジュールの境界やインターフェースを設計する |
| [diagnosing-bugs](.agents/skills/diagnosing-bugs/SKILL.md) | 難しい不具合や性能低下の原因を調べる |
| [domain-modeling](.agents/skills/domain-modeling/SKILL.md) | 用語集やADRを通じてプロジェクトのドメインモデルを整える |
| [git-guardrails-claude-code](.agents/skills/git-guardrails-claude-code/SKILL.md) | Claude Codeで危険なGit操作を防ぐフックを設定する |
| [grill-me](.agents/skills/grill-me/SKILL.md) | 計画や設計を質問形式で掘り下げる |
| [grill-with-docs](.agents/skills/grill-with-docs/SKILL.md) | 計画や設計を質問で整理し、用語集やADRにも記録する |
| [grilling](.agents/skills/grilling/SKILL.md) | 計画やアイデアを厳しく問い直して検証する |
| [handoff](.agents/skills/handoff/SKILL.md) | 別のエージェントが作業を続けられる引き継ぎ文書を作る |
| [implement](.agents/skills/implement/SKILL.md) | 仕様やチケットに沿って実装する |
| [implement-spec](.agents/skills/implement-spec/SKILL.md) | `to-spec` や `to-tickets` の成果をコードに実装する |
| [improve-codebase-architecture](.agents/skills/improve-codebase-architecture/SKILL.md) | コードベースの設計改善候補を調べ、選んだ案を掘り下げる |
| [loop-me](.agents/skills/loop-me/SKILL.md) | 作りたいワークフローの仕様を質問で整理する |
| [migrate-to-shoehorn](.agents/skills/migrate-to-shoehorn/SKILL.md) | テストの型アサーションをshoehornに置き換える |
| [pr](.agents/skills/pr/SKILL.md) | プルリクエストの説明文を書く |
| [prototype](.agents/skills/prototype/SKILL.md) | 設計上の疑問を確かめる使い捨ての試作品を作る |
| [research](.agents/skills/research/SKILL.md) | 信頼できる一次情報を調べ、結果を文書にまとめる |
| [retro](.agents/skills/retro/SKILL.md) | コーディングセッションを振り返る |
| [scaffold-exercises](.agents/skills/scaffold-exercises/SKILL.md) | 演習問題・解答・解説のディレクトリ構成を作る |
| [setup-matt-pocock-skills](.agents/skills/setup-matt-pocock-skills/SKILL.md) | エンジニアリング用スキルの課題管理や文書構成を設定する |
| [setup-pre-commit](.agents/skills/setup-pre-commit/SKILL.md) | lint、型チェック、テストを実行するpre-commitフックを設定する |
| [setup-ts-deep-modules](.agents/skills/setup-ts-deep-modules/SKILL.md) | TypeScriptプロジェクトでdeep moduleの境界を設定する |
| [tdd](.agents/skills/tdd/SKILL.md) | テストを先に書く手順で機能を実装する |
| [teach](.agents/skills/teach/SKILL.md) | このワークスペースに関する技術や概念を説明する |
| [to-questionnaire](.agents/skills/to-questionnaire/SKILL.md) | 未確定の判断事項を回答用の質問票にする |
| [to-spec](.agents/skills/to-spec/SKILL.md) | 会話の内容を仕様にまとめ、課題管理先に登録する |
| [to-tickets](.agents/skills/to-tickets/SKILL.md) | 計画や仕様を依存関係つきのチケットに分ける |
| [triage](.agents/skills/triage/SKILL.md) | 課題や外部PRを分類・検証し、作業用の概要を作る |
| [wait-what](.agents/skills/wait-what/SKILL.md) | 伝わらなかった説明を別の形で伝え直す |
| [wayfinder](.agents/skills/wayfinder/SKILL.md) | 大規模な作業を追跡可能な計画に分解する |
| [wizard](.agents/skills/wizard/SKILL.md) | 人が手作業で行う設定や移行を案内するBashウィザードを作る |
| [writing-beats](.agents/skills/writing-beats/SKILL.md) | 素材を、用語の説明を含む記事の展開に組み立てる |
| [writing-for-agents](.agents/skills/writing-for-agents/SKILL.md) | エージェント向けの指示やスキル文書を書く |
| [writing-fragments](.agents/skills/writing-fragments/SKILL.md) | 素材から構成を決める前の断片を集める |
| [writing-shape](.agents/skills/writing-shape/SKILL.md) | 素材を段落単位で記事にまとめる |

#### その他のスキル

以下はMatt Pocock以外の配布元から導入したスキルです。

| スキル | 配布元 | 内容 |
| --- | --- | --- |
| [adversarial-review](.agents/skills/adversarial-review/SKILL.md) | [poteto/noodle](https://github.com/poteto/noodle) | 別の視点から計画や変更を批判的に検証する |
| [git-commit](.agents/skills/git-commit/SKILL.md) | [github/awesome-copilot](https://github.com/github/awesome-copilot) | 変更を確認し、Conventional Commits形式でコミットする |
| [natural-japanese](.agents/skills/natural-japanese/SKILL.md) | [coji/natural-japanese](https://github.com/coji/natural-japanese) | 日本語の文書を執筆・推敲し、表現を診断する |
| [web-design-guidelines](.agents/skills/web-design-guidelines/SKILL.md) | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | UIをアクセシビリティやWebインターフェースの指針に照らして確認する |

## このリポジトリの構成

- `flake.nix`: Home Manager の入口
- `nix/modules/home/default.nix`: Home Manager の共通設定
- `nix/modules/home/dotfiles.nix`: dotfiles のリンク設定
- `nix/modules/home/packages.nix`: インストールするパッケージ
- `bash/`, `zsh/`, `tmux/`, `nvim/`: 各設定本体
- `.agents/skills/`: Skills CLIで導入できるAIエージェント用スキル
