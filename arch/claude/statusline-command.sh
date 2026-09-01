#!/bin/bash

input=$(cat)

model_name=$(echo "$input" | jq -r '.model.display_name // .model.id' | sed -E 's/ \(([0-9]+M) context\)$/ (\1)/')
effort_level=$(echo "$input" | jq -r '.effort.level // empty')

# The harness does not surface "ultracode" in the effort payload — it reports the
# underlying level ("xhigh"). The only signal that ultracode is active is the
# /effort selection recorded in this session's transcript, stored as a user turn
# whose content is the literal local-command-stdout string. We grep to cheaply
# narrow to candidate lines, then parse them as JSONL and keep only genuine
# command-output turns (type=="user" with a *string* content) — this excludes
# tool calls / results / prose that merely mention the phrase. The most recent
# such selection wins; if it was ultracode, override the displayed level.
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')
if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
    last_effort=$(grep -F '<local-command-stdout>Set effort level to' "$transcript_path" 2>/dev/null \
        | jq -rc 'select(.type=="user" and (.message.content|type=="string") and (.message.content|startswith("<local-command-stdout>Set effort level to"))) | .message.content' 2>/dev/null \
        | grep -o 'Set effort level to [a-zA-Z]*' | tail -1 | awk '{print $NF}')
    if [ "$last_effort" = "ultracode" ]; then
        effort_level="ultracode"
    fi
fi
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_window_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
total_cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
five_hour=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_hour_resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
seven_day=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_day_resets_at=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

cost_str=$(printf "\$%.2f" "${total_cost:-0}")

color_model() {
    local name="$1"
    local reset="\033[0m"
    case "${name,,}" in
        *sonnet*) printf "\033[36m%s${reset}" "$name" ;;   # cyan
        *opus*)   printf "\033[35m%s${reset}" "$name" ;;   # magenta/purple
        *haiku*)  printf "\033[33;2m%s${reset}" "$name" ;; # yellow/dim
        *)        printf "%s" "$name" ;;
    esac
}

color_effort() {
    local level="$1"
    local reset="\033[0m"
    case "$level" in
        low)    printf "\033[33m○ low${reset}" ;;
        medium) printf "\033[32m◐ medium${reset}" ;;
        high)   printf "\033[34m● high${reset}" ;;
        xhigh)  printf "\033[35m◉ xhigh${reset}" ;;
        max)       printf "\033[31m◈ max${reset}" ;;
        ultracode) printf "\033[1;38;2;106;13;173m✦ ultracode${reset}" ;;
        *)         printf "%s" "$level" ;;
    esac
}

# ~100k tokens used is the practical quality-degradation marker regardless of
# window size, so warn on absolute tokens (replaces the old 1M-only 30% rule).
warn_str=""
tok_str=""
if [ -n "$used_pct" ] && [ "$context_window_size" -gt 0 ] 2>/dev/null; then
    used_tokens=$(awk -v p="$used_pct" -v s="$context_window_size" 'BEGIN{printf "%.0f", p*s/100}')
    tok_str=$(awk -v t="$used_tokens" 'BEGIN{printf " · %.0fk", t/1000}')
    if [ "$used_tokens" -ge 100000 ]; then
        warn_str=" \033[1;31m⚠ 100k+\033[0m"
    fi
fi

if [ -n "$used_pct" ]; then
    used_int=$(printf "%.0f" "$used_pct")
    bar_length=20
    filled=$(( used_int * bar_length / 100 ))
    empty=$(( bar_length - filled ))

    if [ "$used_int" -ge 90 ]; then
        color="\033[31m"
    elif [ "$used_int" -ge 70 ]; then
        color="\033[33m"
    else
        color="\033[32m"
    fi

    bar="${color}"
    for ((i=0; i<filled; i++)); do bar="${bar}█"; done
    bar="${bar}\033[0m"
    for ((i=0; i<empty; i++)); do bar="${bar}░"; done

    if [ -n "$effort_level" ]; then
        effort_colored=$(color_effort "$effort_level")
        printf "%b %b [%b %3.0f%%%s]%b %s" "$(color_model "$model_name")" "$effort_colored" "$bar" "$used_pct" "$tok_str" "$warn_str" "$cost_str"
    else
        printf "%b [%b %3.0f%%%s]%b %s" "$(color_model "$model_name")" "$bar" "$used_pct" "$tok_str" "$warn_str" "$cost_str"
    fi
else
    if [ -n "$effort_level" ]; then
        effort_colored=$(color_effort "$effort_level")
        printf "%b %b%b%s" "$(color_model "$model_name")" "$effort_colored" "$warn_str" "$cost_str"
    else
        printf "%b%b %s" "$(color_model "$model_name")" "$warn_str" "$cost_str"
    fi
fi

make_blue_bar() {
    local pct="$1"
    local label="$2"
    local bar_length=8
    local pct_int
    pct_int=$(printf "%.0f" "$pct")
    local filled=$(( pct_int * bar_length / 100 ))
    local empty=$(( bar_length - filled ))
    local color="\033[34m"
    if [ "$pct_int" -ge 85 ]; then
        color="\033[31m"
    fi
    local reset="\033[0m"
    local bar="${color}"
    for ((i=0; i<filled; i++)); do bar="${bar}█"; done
    bar="${bar}${reset}"
    for ((i=0; i<empty; i++)); do bar="${bar}░"; done
    printf "%s [%b%3.0f%%]" "$label" "$bar" "$pct"
}

if [ -n "$five_hour" ]; then
    five_bar=$(make_blue_bar "$five_hour" "5h")
    reset_str=""
    if [ -n "$five_hour_resets_at" ]; then
        reset_str=$(date -d "@${five_hour_resets_at}" +"%H:%M" 2>/dev/null)
        if [ -n "$reset_str" ]; then
            reset_str=" ⏱  ${reset_str}"
        fi
    fi
    printf " | %b%s" "$five_bar" "$reset_str"
fi

if [ -n "$seven_day" ]; then
    seven_bar=$(make_blue_bar "$seven_day" "7d")
    reset_str=""
    if [ -n "$seven_day_resets_at" ]; then
        reset_str=$(date -d "@${seven_day_resets_at}" +"%a %H:%M" 2>/dev/null)
        if [ -n "$reset_str" ]; then
            reset_str=" ⏱  ${reset_str}"
        fi
    fi
    printf " | %b%s" "$seven_bar" "$reset_str"
fi
