#!/usr/bin/env bash
# Morse code beeper — works with either PC speaker (beep) or headphones (SoX)
# Usage: `````````./morse2beep.sh "your text" [buzzer|headphones]`````````

# Settings
FREQ=800
DOT_DURATION=0.1  # seconds
DASH_DURATION=$(echo "$DOT_DURATION * 3" | bc)
GAP_DURATION=$(echo "$DOT_DURATION * 2" | bc)
WORD_GAP=$(echo "$DOT_DURATION * 7" | bc)

# Mode: buzzer (default) or headphones
MODE=${2:-buzzer}

# Morse map
declare -A MORSE=(
  [A]=".-"   [B]="-..." [C]="-.-." [D]="-.."  [E]="."
  [F]="..-." [G]="--."  [H]="...." [I]=".."   [J]=".---"
  [K]="-.-"  [L]=".-.." [M]="--"   [N]="-."   [O]="---"
  [P]=".--." [Q]="--.-" [R]=".-."  [S]="..."  [T]="-"
  [U]="..-"  [V]="...-" [W]=".--"  [X]="-..-" [Y]="-.--" [Z]="--.."
  [0]="-----" [1]=".----" [2]="..---" [3]="...--" [4]="....-"
  [5]="....." [6]="-...." [7]="--..." [8]="---.." [9]="----."
)

if [[ -z "$1" ]]; then
  echo "Usage: $0 'TEXT' [buzzer|headphones]"
  exit 1
fi

TEXT=$(echo "$1" | tr '[:lower:]' '[:upper:]')

# Function to play tones depending on mode
play_tone() {
  local duration="$1"
  if [[ "$MODE" == "headphones" ]]; then
    play -q -n synth "$duration" sine "$FREQ" >/dev/null 2>&1
  else
    beep -f "$FREQ" -l "$(echo "$duration * 1000" | bc)"
  fi
}

# Main loop
for (( i=0; i<${#TEXT}; i++ )); do
  char="${TEXT:$i:1}"
  if [[ "$char" == " " ]]; then
    sleep "$WORD_GAP"
    continue
  fi

  code="${MORSE[$char]}"
  [[ -z "$code" ]] && continue

  for (( j=0; j<${#code}; j++ )); do
    symbol="${code:$j:1}"
    if [[ "$symbol" == "." ]]; then
      play_tone "$DOT_DURATION"
    else
      play_tone "$DASH_DURATION"
    fi
    sleep "$GAP_DURATION"
  done
  sleep "$GAP_DURATION"
done
