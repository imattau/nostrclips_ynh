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
		# --ignore-scripts: onnxruntime-node (a transitive dep of
		# @huggingface/transformers, pulled in only for a Node-native binding
		# this browser bundle never loads - the in-browser build uses
		# onnxruntime-web instead) runs a postinstall script that downloads a
		# prebuilt binary from GitHub releases, which can time out and is
		# needless work either way. Skipping lifecycle scripts also skips the
		# package's own postinstall (scripts/copy-ffmpeg-core.sh), so run that
		# one explicitly.
		ynh_exec_as_app npm ci --ignore-scripts
		ynh_exec_as_app bash scripts/copy-ffmpeg-core.sh
		ynh_exec_as_app npm run build
	popd

	ynh_safe_rm "$install_dir/www"
	mv "$install_dir/source/dist" "$install_dir/www"

	# node_modules is only needed to produce the build; dropping it keeps the
	# app's on-disk footprint close to the size of the static build itself.
	ynh_safe_rm "$install_dir/source/node_modules"
}
