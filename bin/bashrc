# source file via `. ~/.bashrc` to get a local::lib environment
if [ -z "$SHLVL" ] || [ $SHLVL -eq 1 ]; then
    cpanm --skip-satisfied --local-lib=~/perl5 local::lib
    eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
fi
