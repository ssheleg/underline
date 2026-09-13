#!/usr/bin/env bash
# SCOPE: checks the required Underline documentation, README navigation,
# register allocators and the closed vocabulary of open-question statuses.
# It does not validate prose meaning, cryptographic correctness or code.

set -u

fail=0

required_files="
README.md
docs/PRODUCT.md
docs/ARCHITECTURE.md
docs/ux/scenarios.md
docs/DECISIONS.md
docs/OPEN_QUESTIONS.md
docs/DOCMAP.md
"

for file in $required_files; do
  if [ ! -f "$file" ]; then
    echo "ERR: missing required document: $file"
    fail=1
  fi
done

if [ "$fail" -ne 0 ]; then
  echo "FAIL: documentation gate"
  exit 1
fi

for target in docs/PRODUCT.md docs/ARCHITECTURE.md docs/ux/scenarios.md \
  docs/DECISIONS.md docs/OPEN_QUESTIONS.md docs/DOCMAP.md; do
  if ! grep -Fq "($target)" README.md; then
    echo "ERR: README does not link to $target"
    fail=1
  fi
done

defined_decisions=$(grep -E '^### DEC-[0-9]{4} — ' docs/DECISIONS.md | wc -l | tr -d ' ')
next_decision=$(grep -Eo 'Next free ID:\*\* `DEC-[0-9]{4}`' docs/DECISIONS.md | grep -Eo '[0-9]{4}' | sed 's/^0*//')
[ -n "$next_decision" ] || next_decision=0
expected_decision=$((defined_decisions + 1))
if [ -z "$next_decision" ] || [ "$next_decision" -ne "$expected_decision" ]; then
  echo "ERR: decision allocator expected DEC-$(printf '%04d' "$expected_decision")"
  fail=1
fi

defined_questions=$(grep -E '^\| OQ-[0-9]{4} \|' docs/OPEN_QUESTIONS.md | wc -l | tr -d ' ')
next_question=$(grep -Eo 'Next free ID:\*\* `OQ-[0-9]{4}`' docs/OPEN_QUESTIONS.md | grep -Eo '[0-9]{4}' | sed 's/^0*//')
[ -n "$next_question" ] || next_question=0
expected_question=$((defined_questions + 1))
if [ -z "$next_question" ] || [ "$next_question" -ne "$expected_question" ]; then
  echo "ERR: question allocator expected OQ-$(printf '%04d' "$expected_question")"
  fail=1
fi

invalid_status=$(awk -F'|' '/^\| OQ-[0-9]{4} / {
  status=$6
  gsub(/^[ \t]+|[ \t]+$/, "", status)
  if (status != "Open" && status !~ /^Resolved→DEC-[0-9]{4}$/ && status !~ /^Dropped \(.+\)$/) print NR ":" status
}' docs/OPEN_QUESTIONS.md)
if [ -n "$invalid_status" ]; then
  echo "ERR: invalid open-question status: $invalid_status"
  fail=1
fi

if [ "$fail" -ne 0 ]; then
  echo "FAIL: documentation gate"
  exit 1
fi

echo "PASS: documentation gate (7 documents, $defined_decisions decisions, $defined_questions open questions)"
