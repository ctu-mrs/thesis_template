# get the path to this script
REPO_ROOT=`dirname "$0"`
REPO_ROOT=`( cd "$REPO_ROOT" && pwd )`

./.ci/build.sh
