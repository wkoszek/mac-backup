#!/bin/sh

set -e

git config --global credential.helper osxkeychain
read -p "Pass personal GitHub username  : " GITHUB_USERNAME
read -p "Pass personal GitHub token here: " GITHUB_TOKEN

# eh. not the best idea. oh well..
export GITHUB_USERNAME
export GITHUB_TOKEN

#rm -rf tools
#expect <<END
#log_user 1
#set timeout 20
#spawn git clone https://github.com/wkoszek/mac-backup.git
#expect "Username"
#send "$::env(GITHUB_USERNAME)"
#send -- "\r\r\r"
#sleep 1
#expect "Password"
#send "$::env(GITHUB_TOKEN)"
#send -- "\r\r\r"
#expect eof
#END

#rm -rf tools

curl -o repos.json -H "Authorization: token $GITHUB_TOKEN" https://api.github.com/users/wkoszek/repos
jq -r ".[].clone_url" repos.json | xargs -n 1 git clone
