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

## このリポジトリの構成

- `flake.nix`: Home Manager の入口
- `nix/modules/home/default.nix`: Home Manager の共通設定
- `nix/modules/home/dotfiles.nix`: dotfiles のリンク設定
- `nix/modules/home/packages.nix`: インストールするパッケージ
- `bash/`, `zsh/`, `tmux/`, `nvim/`: 各設定本体
- `.agents/skills/`: Skills CLIで導入できるAIエージェント用スキル
