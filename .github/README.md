# dotfiles managed by yadm

[yadm](https://yadm.io/) で管理している dotfiles。

## 管理ツール

| ツール | 用途 |
|---|---|
| [yadm](https://yadm.io/) | dotfiles 管理 |
| [WezTerm](https://wezfurlong.org/wezterm/) | ターミナルエミュレータ |
| [Neovim](https://neovim.io/) + [LazyVim](https://www.lazyvim.org/) | エディタ |
| [AeroSpace](https://github.com/nikitabobko/AeroSpace) | タイリングウィンドウマネージャ（macOS） |
| [fzf](https://github.com/junegunn/fzf) | ファジーファインダー |
| [Zinit](https://github.com/zdharma-continuum/zinit) + Powerlevel10k | zsh プラグイン管理 |

---

## セットアップ

### macOS

```sh
# yadm をインストール
brew install yadm

# dotfiles をクローン（ホームディレクトリに展開される）
yadm clone https://github.com/r-waki/dotfiles.git

# 追加ツールをインストール
brew install fzf fd ripgrep bat eza
brew install --cask wezterm aerospace
```

### Linux

```sh
# yadm をインストール
sudo apt install yadm        # Ubuntu/Debian
# or
brew install yadm            # Homebrew on Linux

# dotfiles をクローン
yadm clone https://github.com/r-waki/dotfiles.git

# 追加ツールをインストール
sudo apt install fzf fd-find ripgrep bat eza
# または Homebrew で統一する場合
brew install fzf fd ripgrep bat eza
```

> **Note:** Linux では `fd` → `fdfind`、`bat` → `batcat` になる場合があるが、`.zshrc` で自動判定済み。

### Windows

Windows では [Scoop](https://scoop.sh/) でツールを管理し、[Git for Windows](https://gitforwindows.org/) 経由で yadm を使う。

```powershell
# Scoop をインストール（PowerShell で実行）
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

# Git と yadm をインストール
scoop install git yadm

# dotfiles をクローン（Git Bash または PowerShell で実行）
yadm clone https://github.com/r-waki/dotfiles.git

# 追加ツールをインストール
scoop install fzf fd ripgrep bat eza wezterm neovim
```

> **Note:** Windows では AeroSpace は使用不可。タイリング WM が必要な場合は [GlazeWM](https://github.com/glzr-io/glazewm) などを検討。

> **Note:** PowerShell プロファイルは `$PROFILE`（`~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`）に配置する。

---

## WezTerm ショートカット

Leader キー = `Ctrl+Space`

### フォントサイズ

| キー | 動作 |
|---|---|
| `Cmd+=` / `Ctrl+Shift+=` | フォントサイズ大きく |
| `Cmd+-` / `Ctrl+Shift+-` | フォントサイズ小さく |
| `Cmd+0` / `Ctrl+Shift+0` | フォントサイズリセット |

### スクロール

| キー | 動作 |
|---|---|
| `Ctrl+Shift+U` | 半ページ上 |
| `Ctrl+Shift+D` | 半ページ下 |
| `Ctrl+Shift+B` | 1ページ上 |
| `Ctrl+Shift+F` | 1ページ下 |
| `Shift+PageUp` | 1ページ上 |
| `Shift+PageDown` | 1ページ下 |

### Copy Mode（TUI アプリ内スクロールなどに）

| キー | 動作 |
|---|---|
| `Leader + v` | Copy Mode 開始 |
| `Ctrl+U` / `Ctrl+D` | 半ページ上/下 |
| `Ctrl+B` / `Ctrl+F` | 1ページ上/下 |
| `k` / `j` | 1行上/下 |
| `g` / `G` | 最上部/最下部 |
| `q` / `Esc` | Copy Mode 終了 |

> **Note:** TUI アプリ（nvim, lazygit 等）内ではターミナルのスクロールバックは使えない。Copy Mode で代替。

### ペイン操作

| キー | 動作 |
|---|---|
| `Leader + v` | 縦分割 |
| `Leader + s` | 横分割 |
| `Leader + h/j/k/l` | ペイン移動 |
| `Leader + H/J/K/L` | ペインサイズ変更 |

### タブ操作

| キー | 動作 |
|---|---|
| `Ctrl+Shift+T` | 新しいタブ |
| `Ctrl+Shift+W` | タブを閉じる |
| `Ctrl+Tab` | 次のタブ |
| `Ctrl+Shift+Tab` | 前のタブ |
| `Cmd+1〜9` | タブ番号で移動 |

---

## fzf ショートカット

### キーバインド

| キー | 動作 |
|---|---|
| `Ctrl+R` | コマンド履歴検索 |
| `Ctrl+T` | ファイル検索してコマンドラインに挿入 |
| `Alt+C` | ディレクトリ検索して `cd` |
| `Ctrl+/` | プレビューウィンドウ切り替え |

### エイリアス

| コマンド | 動作 |
|---|---|
| `gfco` | git ブランチを fzf で選択してチェックアウト |

### fzf 検索構文

| 入力 | 動作 |
|---|---|
| `foo bar` | foo AND bar |
| `foo \| bar` | foo OR bar |
| `^foo` | foo で始まる |
| `foo$` | foo で終わる |
| `!foo` | foo を含まない |

---

## AeroSpace ショートカット（macOS）

| キー | 動作 |
|---|---|
| `Alt+h/j/k/l` | ウィンドウフォーカス移動 |
| `Alt+Shift+h/j/k/l` | ウィンドウ移動 |
| `Alt+1〜0` | ワークスペース切り替え |
| `Alt+Shift+1〜0` | ウィンドウをワークスペースへ移動 |
| `Alt+f` | フルスクリーン |
| `Alt+v` | 縦分割 |
| `Alt+b` | 横分割 |
| `Alt+Shift+C` | 設定リロード |
