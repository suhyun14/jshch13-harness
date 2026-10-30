#!/usr/bin/env bash
# 사용법: bash <키트폴더>/scripts/init.sh [과제폴더]   (과제폴더 기본값: 현재 폴더)
# 키트의 AGENTS.md와 문서 양식을 과제 폴더에 복사한다. 기존 파일은 덮어쓰지 않는다.
# 과제에 AGENTS.md가 이미 있으면 그 뒤에 키트 규칙을 덧붙인다.
set -e
KIT="$(cd "$(dirname "$0")/.." && pwd)"
TARGET="${1:-.}"
cd "$TARGET"

if [ ! -f AGENTS.md ]; then
  cp "$KIT/AGENTS.md" AGENTS.md
  echo "[+] AGENTS.md"
elif grep -q "작업 규칙" AGENTS.md; then
  echo "[=] AGENTS.md에 키트 규칙이 이미 있음, 건너뜀"
else
  # 과제에 원래 AGENTS.md가 있으면 지우지 않고 뒤에 키트 규칙을 덧붙인다 (과제 규칙 우선)
  { echo ""; echo "---"; echo "<!-- 아래는 응시자 작업 하네스. 위의 과제 규칙과 충돌하면 과제 규칙이 우선한다. -->"; cat "$KIT/AGENTS.md"; } >> AGENTS.md
  echo "[+] 기존 AGENTS.md 뒤에 키트 규칙 추가 (과제 규칙 우선)"
fi

mkdir -p docs
for f in AGREEMENT DECISIONS VERIFICATION HANDOFF; do
  if [ ! -f "docs/$f.md" ]; then
    cp "$KIT/templates/$f.md" "docs/$f.md"
    echo "[+] docs/$f.md"
  else
    echo "[=] docs/$f.md 이미 있음, 건너뜀"
  fi
done

if [ ! -d .git ]; then
  git init -q && echo "[+] git init"
fi
# 키트 폴더가 과제 폴더 안에 있으면 제출물 커밋에 섞이지 않게 로컬에서만 제외한다
KIT_REL="$(realpath --relative-to="$(pwd)" "$KIT" 2>/dev/null || echo "")"
case "$KIT_REL" in
  ""|..*|/*) ;;
  *) grep -qxF "$KIT_REL/" .git/info/exclude 2>/dev/null || echo "$KIT_REL/" >> .git/info/exclude ;;
esac

git config user.name >/dev/null || git config user.name "candidate"
git config user.email >/dev/null || git config user.email "candidate@example.com"
git add AGENTS.md docs
git diff --cached --quiet && echo "[=] 커밋할 변경 없음" || git commit -qm "[S1] 작업 하네스(AGENTS.md, docs 양식) 적용" && echo "[+] 첫 커밋 완료"

echo ""
echo "완료. 이제 'codex'를 실행하고 $KIT/prompts/PROMPTS.md 의 [시작] 프롬프트를 붙여 넣으세요."
