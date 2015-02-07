# https://gist.github.com/azu/d526e212ca764b3dd029

# ghq get + ghq look(cd repo)
# Usage: gcd git://example.com/repo.git
function gcd {
  if [ ! -n "$1" ]; then
    echo "Usage: gcd git://example.com/repo.git"
    return;
  fi
  declare url=$1;
  declare reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
  ghq get "${url}"
  ghq look "${reponame}"
}
 
# 現在のディレクトリのプロジェクトをghqでgetし直して移動する
function ghq-get-own() {
  gcd "$(git config --get remote.origin.url)"
}