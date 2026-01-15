# My Dotfiles

開発環境を迅速にセットアップするためのドットファイル管理リポジトリです。
`GNU Stow` を使用して、各設定ファイルをホームディレクトリにシンボリックリンクとして配置します。

## 🚀 はじめに

このリポジトリには、Ubuntu/Debian ベースのシステム（WSL2 含む）向けの自動セットアップスクリプトが含まれています。

### 含まれるツール群

- **Shell**: Bash, tmux
- **Languages**: Python (uv), Node.js (nvm), Bun
- **Modern CLI**: ripgrep, bat, eza, zoxide, fzf, fd
- **AI Tools**: Claude Code, Codex, Gemini CLI, CodeRabbit, OpenCode
- **Others**: Git, GitHub CLI, GnuPG/Gnome-keyring (for secrets)

## 🛠 インストール方法

1. リポジトリをクローンします：

   ```bash
   git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. インストールスクリプトを実行します：

   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. シェルを再起動するか、設定を反映させます：
   ```bash
   source ~/.bashrc
   ```

## 📂 ディレクトリ構成

- `bash/`: Bash の設定 (`.bashrc`, `.bash_aliases`, `.profile`)
- `git/`: Git の設定 (`.gitconfig`, `.gitignore_global`)
- `tmux/`: tmux の設定 (`.tmux.conf`)
- `vscode/`: VS Code の設定
- `agents/`: AI エージェント用の命令・ルールファイル集
- `scripts/`: 自作のユーティリティスクリプト

## 🌲 ディレクトリ構成

```text
/root/dotfiles
├── README.md
├── install.sh
├── .bash_local (optional, ignored)
├── agents/             # AI Agent用ルール
│   └── AGENTS.md       # 環境サマリー + 共通ルール (Master)
├── bash/
│   ├── .bash_aliases
│   ├── .bashrc
│   └── .profile
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
├── scripts/
│   ├── coderabbit-token-sync.sh
│   ├── start-gnome-keyring.sh
│   └── unlock-gnome-keyring.sh
├── tmux/
│   └── .tmux.conf
└── vscode/
    └── .config/
        └── Code/
            └── User/
                └── settings.json
```

## 🔧 手動でのリンク適用 (GNU Stow)

特定のディレクトリのみを適用したい場合は、`stow` コマンドを使用します：

```bash
# 例: gitの設定のみを適用
stow git
```

## 🤖 AI エージェント用グローバルルール

`agents/AGENTS.md` は、様々な AI エージェント（Claude, Gemini, Codex 等）が共通して参照するルールファイルです。
`install.sh` を実行すると、以下の場所にシンボリックリンクが作成されます：

- `~/.claude/CLAUDE.md`
- `~/.gemini/GEMINI.md`
- `~/.codex/AGENTS.md`

## 🤖 CodeRabbit (Headless) の永続ログイン

GUI なし環境では `login` キーリングが作れないことがあり、`session` コレクションが使われます。
その場合は再起動でトークンが消えるため、**トークンをファイルに保存して自動投入**する構成にしています。

### 仕組み

- トークン保存先: `~/.config/coderabbit/token` (パーミッション 600)
- ログイン後に `coderabbit-token-sync` がトークンを保存
- 起動時に `.profile` から `coderabbit-token-sync` がトークンを keyring に投入

### 初回ログインの流れ

```bash
eval "$(~/.local/bin/start-gnome-keyring)"
coderabbit auth login
~/.local/bin/coderabbit-token-sync
```

### 注意

この方式はトークンを平文で保持します。root-only で運用する前提です。
