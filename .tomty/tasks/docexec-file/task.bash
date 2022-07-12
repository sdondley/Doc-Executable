set -e

cat << 'HERE' > $cache_root_dir/file.raku
##
say 1, 2;
say (1, 2);
##
HERE

echo "file: "

cat $cache_root_dir/file.raku

echo ">>>"
docexec $cache_root_dir/file.raku 2>&1
echo "<<<"
