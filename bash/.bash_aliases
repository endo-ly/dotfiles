# .bash_aliases

# ローカル環境変数（Git管理外）
[ -f ~/.bash_aliases.local ] && source ~/.bash_aliases.local

# 一般的なエイリアス
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# モダンツールの代替
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons'
    alias ll='eza -al --icons'
fi

if command -v batcat >/dev/null 2>&1; then
    alias bat='batcat'
fi

# Git エイリアス
alias gst='git status'
alias gad='git add'
alias gcm='git commit -m'
alias gpl='git pull'
alias gps='git push'
alias glo='git log --oneline --graph'

alias ccglm='ANTHROPIC_AUTH_TOKEN="${GLM_CODING_PLAN_API_KEY}" \
    ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic" \
    API_TIMEOUT_MS="3000000" \
    CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 \
    ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.7-flash" \
    ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.7" \
    ANTHROPIC_DEFAULT_OPUS_MODEL="glm-4.7" claude'
