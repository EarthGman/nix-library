#!/usr/bin/env bash
if [ ! -f ./overlays/images.nix ]; then
	echo "you must be in the root of the repository to run this command"
	exit 1
fi

images=$(lynx -dump -listonly https://cache.earthgman.net/images | grep https | grep -e .jpg -e .png -e .webp -e .gif | awk '{print $2}')

asset_path=./overlays/images.nix
echo "{" >$asset_path
for i in $images; do
	hash=$(curl -s $i | sha256sum | cut -f 1 -d " ")
	asset_name=$(echo $i | cut -f 5 -d '/')
	asset_no_ext=$(echo $asset_name | cut -f 1 -d '.')
	printf "%s = builtins.fetchurl { \n  url = \"%s\";\n  sha256 = \"%s\";\n};\n\n" $asset_no_ext $i $hash >>$asset_path
	echo "fetched $asset_name with hash: $hash"
done
echo "}" >>$asset_path
nixfmt $asset_path
