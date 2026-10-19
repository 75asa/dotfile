# dotfiles

75asa's Mac setup, managed by [mise bootstrap](https://mise.jdx.dev/bootstrap.html):
packages (Homebrew formulae / casks), runtimes, dotfiles and macOS defaults in one config.

## New Mac

```sh
# 1. Homebrew と mise
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#    インストーラーが最後に案内する「~/.zprofile に brew shellenv を追記」はしない
#    （home/zprofile が入れる。追記すると dotfiles が既存ファイルとぶつかって止まる）
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install mise

# 2. このマシンのモジュールを選ぶ（work / personal）
mkdir -p ~/.config/mise
echo 'env = ["work"]' > ~/.config/mise/miserc.local.toml

# 3. このリポジトリを ~/.config/mise に clone し、計画を確認してから適用
#    （`mise bootstrap --adopt 75asa/dotfile` でも同じ状態になるが、--dry-run は clone 前だと clone コマンドしか表示しない）
git clone https://github.com/75asa/dotfile.git ~/.config/mise
mise bootstrap --dry-run
mise bootstrap
```

After that, `git pull` in `~/.config/mise` and run `mise bootstrap` to apply changes (only the diff is applied).

## Layout

| File | Purpose |
|---|---|
| `config.toml` | Shared: CLI, apps, runtimes (`[tools]`), dotfiles, macOS defaults |
| `config.work.toml` | Work Mac only (apps that Company Portal does not install) |
| `config.personal.toml` | Personal Mac only |
| `home/` | Dotfile sources, symlinked into `~` |
| `miserc.local.toml` | Per machine module selection (not committed) |

## Not in this repo (per machine)

- `~/.gitconfig.local`, `~/.ssh/config.local`: internal hosts (e.g. a company GitLab) — kept out because this repo is public.
- SSH keys: stored in 1Password and served by its SSH agent. Export the public keys from 1Password to
  `~/.ssh/id_ed25519.pub` and `~/.ssh/id_ed25519_personal.pub` (used only to pick the key per host).

## Legacy: chezmoi

The `dot_*` / `private_*` files are the old [chezmoi](https://www.chezmoi.io/) source; they are ignored by mise
and will be removed once the mise setup is confirmed on the new Mac.
