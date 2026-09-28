# dotfiles
75asa's dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Get started

#### 1. Install chezmoi and 1Password CLI

```
brew install chezmoi 1password-cli
```

#### 2. Clone dotfiles

```
chezmoi init https://github.com/75asa/dotfile.git
```

#### 3. Sign in to 1Password CLI

`~/.ssh/id_rsa` is fetched from 1Password. If the 1Password app integration is enabled, this step is not needed.

```
# On bash / zsh
eval $(op signin)
# On fish
op signin | source
```

#### 4. Apply dotfiles

```
chezmoi diff
chezmoi apply
```

## Update

After editing a managed file in place, pull the change back into the source:

```
chezmoi re-add
```

## FYI

- [chezmoi で dotfiles を手軽に柔軟にセキュアに管理する](https://zenn.dev/ryo_kawamata/articles/introduce-chezmoi)
- [1Password CLI: Get started](https://developer.1password.com/docs/cli/get-started/)
