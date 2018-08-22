pkg_name=litterbox
pkg_origin=skylerto
pkg_deps=(core/ruby core/git)
pkg_build_deps=(core/make core/gcc core/bundler)
pkg_bin_dirs=(bin)
pkg_upstream_url=https://github.com/skylerto/litterbox

pkg_version() {
  $(pkg_path_for core/ruby)/bin/ruby -I $SRC_PATH/lib -e "require 'litterbox/version'; puts Litterbox::VERSION"
}

do_before() {
  do_default_before
  update_pkg_version
}

do_build(){
  return 0
}

do_install(){
  GEM_HOME=$pkg_prefix
  build_line "Setting GEM_HOME=$GEM_HOME"
  GEM_PATH="$GEM_HOME"
  build_line "Setting GEM_PATH=$GEM_PATH"
  export GEM_HOME GEM_PATH
  build_line "Installing gem"
  bundle install --deployment --path=$pkg_prefix --binstubs=$pkg_prefix/bin --shebang=$(pkg_path_for core/ruby)/bin/ruby
}
