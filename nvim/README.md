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

このリポジトリは `flake` を使うので、Nix では `nix-command` と `flakes` を有効にしてください。

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix
printf 'experimental-features = nix-command flakes\n' >> ~/.config/nix/nix.conf
```

その後、このリポジトリを clone してから `home-manager` を実行します。

```bash
git clone <このリポジトリのURL> ~/dotfiles
cd ~/dotfiles
home-manager switch -b backup --flake .
```

`flake.nix` は現状 `x86_64-linux` を対象にしています。WSL2 や Intel/AMD の Linux 端末向けです。

## 設定変更を端末へ反映する方法

1. 設定ファイルを編集する
2. 反映する

```bash
cd ~/dotfiles
home-manager switch -b backup --flake .
```

3. 端末側で再読み込みする

- **bash**: `source ~/.bashrc`
- **zsh**: `source ~/.zshrc`
- **tmux**: `tmux source-file ~/.tmux.conf`
- **nvim**: 終了して起動し直す

`home.packages` を変えた場合は、`switch` 後に新しいシェルを開くと PATH も反映されやすいです。

## このリポジトリの構成

- `flake.nix`: Home Manager の入口
- `nix/modules/home/default.nix`: Home Manager の共通設定
- `nix/modules/home/dotfiles.nix`: dotfiles のリンク設定
- `nix/modules/home/packages.nix`: インストールするパッケージ
- `bash/`, `zsh/`, `tmux/`, `nvim/`: 各設定本体
