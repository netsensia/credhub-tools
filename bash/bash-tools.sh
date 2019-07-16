function credhub_deploy_key() {
  SSHDIR=~/.ssh
  ssh-keygen -t rsa -N "" -f $SSHDIR/$1
  credhub set -n concourse/$1/GITHUB_DEPLOY_KEY --type ssh --private $SSHDIR/$1 --public $SSHDIR/$1.pub
}

function chget() {
  credhub get -n concourse/$1
}

function chset() {
  credhub set -n concourse/$1 --type value --value $2
}

function chsetkey() {
  SSHDIR=/home/chrismoreton/.ssh
  credhub set -n concourse/$1 --type ssh --private $SSHDIR/$1 --public $SSHDIR/$1.pub
}

function chsetuser() {
  credhub set -n concourse/$1 --type user --username $2 --password $3
}

function chdel() {
  credhub delete -n concourse/$1
}

function chdoubleenv() {
  credhub set -n concourse/$1/aat/env/$2 --type value --value $3
  credhub set -n concourse/$1/prod/env/$2 --type value --value $3
}

function chcopy() {
  credhub set -n concourse/$3/$2 --type value --value $(credhub get -q -n concourse/$1/$2)
}

function chcopyuser() {
  credhub set -n concourse/$3/$2 --type user --username $(credhub get -q -k username -n concourse/$1/$2) --password $(credhub get -q -k password -n concourse/$1/$2)
}

