# Morse2Beep

A tiny Bash script that converts any text message into **Morse code beeps** —
either through your **PC speaker** (buzzer) or your **headphones**

---

## Features

- Converts text (A–Z, 0–9) into audible Morse code.
- Works on **Linux (Arch, Ubuntu, Debian, etc.)**
- Supports two modes:
  - `buzzer` → plays via internal PC speaker (`beep` command)
  - `headphones` → plays via system audio (`sox` / `play` command)
- Customizable frequency and speed.

---

## Installation

### Clone or download
```bash
git clone https://github.com/yourusername/morse2beep.git
cd morse2beep
```

### Install dependencies
For Arch Linux:
```bash
sudo pacman -S sox beep bc
```

For Debian/Ubuntu:
```bash
sudo apt install sox beep bc
```

---

## Usage

```bash
bash morse2beep.sh "SOS" buzzer
bash morse2beep.sh "HELLO WORLD" headphones
```

If you skip the second argument, it defaults to the buzzer mode:
```bash
bash morse2beep.sh "HELLO"
```

---

## Notes

- On many modern laptops (like Lenovo Legion series), the internal **PC buzzer** doesn’t exist or is disabled.
  In that case, use the `headphones` mode instead — it’ll play through your speakers or headset.
- You can tweak the frequency or speed inside the script:
  ```bash
  FREQ=800        # tone frequency in Hz
  DOT_DURATION=0.1 # seconds per dot
  ```

---

## Example

```bash
bash morse2beep.sh "CQ CQ CQ DE THANOS" headphones
```

Outputs the Morse sequence for “CQ CQ CQ DE THANOS” as beeps in your headphones.

---

## License
MIT License — free to use, modify, and share.

---

### Author
**Thanos Mourtzoukos**
https://github.com/athamour1
