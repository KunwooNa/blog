#!/bin/sh
# 명령어 실패 시 스크립트 중지
set -e

printf "\033[0;32mGitHub에 업데이트를 배포하는 중...\033[0m\n"

# 프로젝트 빌드
hugo -t hugo-texify2

# public 폴더로 이동
cd public

# 변경 사항을 Git에 추가
git add .

# 변경 사항 커밋
msg="사이트 재빌드 $(date)"
if [ -n "$*" ]; then
    msg="$*"
fi
git commit -m "$msg" || echo "변경 사항이 없습니다."

# 원격 저장소에 푸시 (여기서 'master'를 원격 브랜치 이름으로 대체)
git push origin master || echo "푸시 실패."

# 루트 디렉토리로 돌아감
cd ..

# 메인 저장소 업데이트
git add .
msg="사이트 재빌드 $(date)"
if [ $# -eq 1 ]; then
    msg="$1"
fi
git commit -m "$msg" || echo "변경 사항이 없습니다."
git push origin master || echo "푸시 실패."
