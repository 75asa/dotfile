# dotfiles
75asa's dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Get started

#### 1. Install chezmoi

```
brew install chezmoi
```

#### 2. Clone dotfiles

```
chezmoi init https://github.com/kawamataryo/dotfiles.git
```

#### 3. Login to 1password cli

```
# On bash
eval $(op my.1password.com メールアドレス)
# On fish with fish-replay
replay 'eval $(op my.1password.com メールアドレス)'
```

#### 4. Apply dotfiles

```
chezmoi apply
```

## FYI

- [chezmoi で dotfiles を手軽に柔軟にセキュアに管理する](https://zenn.dev/ryo_kawamata/articles/introduce-chezmoi)
- [1Password Cliの使い方](https://mazgi.github.io/posts/2019.07/how-to-use-1password-cli/)
