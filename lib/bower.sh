install_bower_dependencies() {
  npm install bower
}

run_bower_task() {
  local build_dir=${1:-}

  $build_dir/node_modules/bower/bin/bower install


}
