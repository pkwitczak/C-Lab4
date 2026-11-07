#!/usr/bin/env bash

set -u
set -o pipefail

PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TASK="${1:-zad01}"

export LC_ALL=C

case "$TASK" in
    zad01|zad02|zad03|zad04|zad05|zad06)
        ;;
    *)
        printf 'Nieznane zadanie: %s\n' "$TASK" >&2
        exit 1
        ;;
esac

APP="$PROJECT_DIR/build/$TASK"
TEST_DIR="$PROJECT_DIR/tests/$TASK"

[[ -x "$APP" ]] || {
    printf 'Brak pliku: %s\n' "$APP" >&2
    exit 1
}

[[ -f "$TEST_DIR/input.txt" && -f "$TEST_DIR/expected.txt" ]] || {
    printf 'Brak plikow testowych dla: %s\n' "$TASK" >&2
    exit 1
}

passed=0
failed=0

printf '[SCENARIO] %s\n' "$TASK"

"$APP" \
    < "$TEST_DIR/input.txt" \
    > "$TEST_DIR/actual.txt" \
    2> "$TEST_DIR/stderr.txt"

status=$?

if diff -u "$TEST_DIR/expected.txt" "$TEST_DIR/actual.txt"; then
    if (( status < 128 )); then
        printf '[PASS]\n'
        passed=$((passed + 1))
    else
        printf '[FAIL] Program terminated: %d\n' "$status"
        failed=$((failed + 1))
    fi
else
    printf '[FAIL] exit code: %d\n' "$status"
    failed=$((failed + 1))
fi

if [[ -s "$TEST_DIR/stderr.txt" ]]; then
    printf '[STDERR]\n'
    cat "$TEST_DIR/stderr.txt"
fi

printf '==========\n'

total=$((passed + failed))

printf '\n[SCENARIOS PASS] %d/%d\n' "$passed" "$total"
printf '[SCENARIOS FAIL] %d/%d\n' "$failed" "$total"

(( total > 0 && failed == 0 ))