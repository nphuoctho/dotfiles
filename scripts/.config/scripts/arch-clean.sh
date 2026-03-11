#!/usr/bin/env bash
set -euo pipefail

MODE=${1:-safe}

LOG_DIR="$HOME/logs"
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
LOG_FILE="$LOG_DIR/arch-clean_$TIMESTAMP.log"

mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

require_sudo() {
  if ! sudo -v; then
    log "ERROR: sudo permission required"
    exit 1
  fi
}

log "=== Arch Clean Started (mode: $MODE) ==="
require_sudo

# =====================
# SAFE MODE
# =====================
if [[ "$MODE" == "safe" ]]; then
  log "Cleaning pacman cache (safe)"
  sudo pacman -Sc --noconfirm || true

  log "Removing leftover pacman download temp files"
  sudo find /var/cache/pacman/pkg -type f -name "download-*" -delete || true

  log "Removing orphan packages"
  orphans=$(pacman -Qtdq || true)
  if [[ -n "$orphans" ]]; then
    sudo pacman -Rns $orphans --noconfirm
  else
    log "No orphan packages found"
  fi

  log "Cleaning systemd journal (keep 7 days)"
  sudo journalctl --vacuum-time=7d

  log "Cleaning user cache (~/.cache)"
  rm -rf ~/.cache/*

  log "Cleaning /tmp"
  sudo rm -rf /tmp/*

# =====================
# DEV MODE
# =====================
elif [[ "$MODE" == "dev" ]]; then
  log "Cleaning Python __pycache__"
  find ~ -type d -name "__pycache__" -prune -exec rm -rf {} +

  log "Cleaning pip cache"
  rm -rf ~/.cache/pip

  log "Cleaning Node cache"
  rm -rf ~/.npm ~/.cache/node-gyp

  log "Cleaning Cargo cache"
  rm -rf ~/.cargo/registry ~/.cargo/git

# =====================
# AGGRESSIVE MODE
# =====================
elif [[ "$MODE" == "aggressive" ]]; then
  log "Aggressive cleanup started"

  sudo pacman -Scc --noconfirm || true
  sudo find /var/cache/pacman/pkg -type f -name "download-*" -delete || true

  sudo journalctl --vacuum-time=3d
  rm -rf ~/.cache/*
  sudo rm -rf /tmp/*

  log "Removing all node_modules"
  find ~ -type d -name "node_modules" -prune -exec rm -rf {} +

  log "Docker cleanup (if running)"
  if systemctl is-active --quiet docker; then
    docker system prune -a -f
  else
    log "Docker not running"
  fi

else
  echo "Usage: $0 {safe|dev|aggressive}"
  exit 1
fi

log "Disk usage after clean:"
df -h / | tee -a "$LOG_FILE"

log "=== Arch Clean Finished ==="

