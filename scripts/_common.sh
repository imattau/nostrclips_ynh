#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

# Build Nostr Clips' static frontend from the extracted source into
# $install_dir/www.
#
# Expects $install_dir to be set, and the pristine upstream source to
# already be extracted into $install_dir/source (see ynh_setup_source in
# the install/upgrade scripts).
nostrclips_build() {
	pushd "$install_dir/source"
		ynh_exec_as_app npm ci
		ynh_exec_as_app npm run build
	popd

	ynh_safe_rm "$install_dir/www"
	mv "$install_dir/source/dist" "$install_dir/www"

	# node_modules is only needed to produce the build; dropping it keeps the
	# app's on-disk footprint close to the size of the static build itself.
	ynh_safe_rm "$install_dir/source/node_modules"
}
