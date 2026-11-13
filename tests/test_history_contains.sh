source ../lib/score.sh

export HMSL_LAB="lab000"

mkdir -p "$HOME/.hmsl/history"

cat > "$HOME/.hmsl/history/lab000.history" << EOF
date
ls
ls -la
EOF


