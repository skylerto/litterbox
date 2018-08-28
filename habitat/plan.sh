pkg_name=litterbox
pkg_origin=skylerto
pkg_deps=(core/ruby core/coreutils)
pkg_build_deps=(core/make core/gcc core/git)
pkg_bin_dirs=(bin)
pkg_upstream_url=https://github.com/skylerto/litterbox

pkg_version() {
  $(pkg_path_for core/ruby)/bin/ruby -I $SRC_PATH/lib -e "require 'litterbox/version'; puts Litterbox::VERSION"
}

do_before() {
  do_default_before
  update_pkg_version
}

do_prepare() {
  GEM_HOME=$pkg_prefix
  build_line "Setting GEM_HOME=$GEM_HOME"
  GEM_PATH="$GEM_HOME"
  build_line "Setting GEM_PATH=$GEM_PATH"
  export GEM_HOME GEM_PATH
}

do_build(){
  build_line "Building gem"
  gem build "$pkg_name.gemspec"
}

do_install(){
  build_line "Installing gem"
  mkdir -p "$pkg_prefix/ruby-bin"
  gem install --bindir "$pkg_prefix/ruby-bin" "./$pkg_name-$pkg_version.gem" --no-ri --no-rdoc
  fix_interpreter "$pkg_prefix/ruby-bin/*" core/coreutils bin/env
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
  wrap_ruby_bin "litterbox"
}

wrap_ruby_bin() {
  local name="$1"
  local original="$pkg_prefix/ruby-bin/$name"
  local wrapper="$pkg_prefix/bin/$name"

  build_line "Adding wrapper $original to $wrapper"

  cat <<EOF > "$wrapper"
#!/bin/sh
set -e
if test -n "$DEBUG"; then set -x; fi
export GEM_HOME="$GEM_HOME"
export GEM_PATH="$GEM_PATH"
unset RUBYOPT GEMRC
exec $(pkg_path_for ruby)/bin/ruby $original \$@
EOF
  chmod -v 755 "$wrapper"
}
