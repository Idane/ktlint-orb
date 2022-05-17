if cat /etc/issue | grep "Alpine" >/dev/null 2>&1; then
    if [ "$ID" = 0 ]; then export SUDO=""; else export SUDO="sudo"; fi
else
    if [[ $EUID == 0 ]]; then export SUDO=""; else export SUDO="sudo"; fi
fi

if command -v ktlint >/dev/null 2>&1; then
    echo "ktlint is already installed"
    exit 0
fi

cd /tmp || { echo "Failed to switch to /tmp directory"; exit 1; }

# Download ktlint
curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.45.2/ktlint

# Verify PGP signature
curl -sS https://keybase.io/ktlint/pgp_keys.asc | gpg --import
curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.45.2/ktlint.asc
gpg --verify ktlint.asc
chmod a+x ktlint && $SUDO mv ktlint ${KTLINT_BINARY_DIR}