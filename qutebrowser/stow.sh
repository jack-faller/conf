#! /bin/sh

echo "$QUTE_URL" >> "$QUTE_CONFIG_DIR/stowed"
echo "tab-close $1" >> "$QUTE_FIFO"
