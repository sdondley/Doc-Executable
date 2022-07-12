set -e

cat << 'HERE' > $cache_root_dir/file.raku
##
(1, 2, 3).shift;
##
HERE

echo "file: "

cat $cache_root_dir/file.raku

echo ">>>"
docexec $cache_root_dir/file.raku 2>&1
echo "<<<"
