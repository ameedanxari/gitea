#!/bin/bash

GIT_USER="ameedanxari"
GIT_EMAIL="ameedanxari@example.com"
REPO_DIR="."

cd "$REPO_DIR"

git config user.name "$GIT_USER"
git config user.email "$GIT_EMAIL"

START_DATE=$(date -I -d "2 years ago")
END_DATE=$(date -I -d "yesterday")

current_date=$START_DATE

while [ "$current_date" != "$END_DATE" ]; do
  if [ $((RANDOM % 4)) -eq 0 ]; then
    num_commits=$((RANDOM % 3 + 1))
    for i in $(seq 1 $num_commits); do
      echo "Commit on $current_date #$i" >> activity.log
      git add activity.log
      export GIT_AUTHOR_DATE="$current_date 12:$((RANDOM % 60)):00"
      export GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"
      git commit -m "Commit $i on $current_date"
    done
  fi
  current_date=$(date -I -d "$current_date + 1 day")
done

git push -u origin main
