install_grunt_dependencies() {
  npm install grunt-cli
  npm install grunt
}

run_grunt_task() {
  local build_dir=${1:-}

  if [ -f $build_dir/grunt.js ] || [ -f $build_dir/Gruntfile.js ] || [ -f $build_dir/Gruntfile.coffee ]; then
    status "Found Gruntfile, running grunt"

    # Error if grunt is not found
    if [ ! -f $build_dir/node_modules/.bin/grunt ]; then
      echo "grunt binary not found. Make sure you add grunt-cli to your package.json!"
      exit 1
    else
      
      # Function that invokes grunt with params
      function grunt () {
        $build_dir/node_modules/.bin/grunt $1
        rc=$?
        
        if [ $rc != 0 ]; then
          exit 1
        fi   
        return $rc
      }
      
      if [ -n "$GRUNT_COMMAND" ]; then
        echo "Executing grunt command: $GRUNT_COMMAND"
        eval $GRUNT_COMMAND | indent
        rc=$?
      else
        echo "Executing grunt command: grunt heroku"
        $build_dir/node_modules/.bin/grunt heroku | indent
        rc=$?
      fi
      

      if [ $rc != 0 ]; then
        exit $rc
      fi     
      
    fi

  else
    status "No Gruntfile (grunt.js, Gruntfile.js, Gruntfile.coffee) found"
  fi
}
