#!/bin/bash
#
# Source: https://github.com/rjuju/postgres-manage
#
# Create environment variables and aliases to easily manage PostgreSQL
# built from the postgresql git repository.

# FIXME clarify all this

export MAINGITDIR="/var/lib/git"
export PGMANAGE="${MAINGITDIR}/postgres-manage/postgres.pl"
export PGTOOLS="${MAINGITDIR}/postgres-manage/"
export PGSRC="${MAINGITDIR}/postgresql/"
# FIXME requires a proper install directory
export postgres_manage="${HOME}/tools/postgres-manage/postgres-manage.conf"

function pg {
    if [[ "$1" == "git" ]]; then
        export PGPORT=5432
        export pgclusterid="-"
        export pgversion="git"
        export PGDATA="/tmp/pgbuild/data"
        export LD_LIBRARY_PATH="/tmp/pgbuild/lib"
        if [[ $PATH != *"pgbuild"* ]]; then
            export PATH="/tmp/pgbuild/bin:$PATH"
        fi
    else
        # Silence shellcheck about "[SC1090] Can't follow non-constant source".
        # shellcheck source=/dev/null
        source <("$PGMANAGE" -version "$1" -mode env)
        export PGLOG="{PGDATA}/log"
    fi
}

alias pgstart='$PGMANAGE -mode start'
alias pgstartall='$PGMANAGE -mode startall'
alias pgstop='$PGMANAGE -mode stop'
alias pgstopall='$PGMANAGE -mode stopall'
alias pgrestart='pgstop;pgstart'
alias pgrestartall='pgstopall;pgstartall'
alias pgbuild='$PGMANAGE -mode build'
alias pgbuildpostgis='$PGMANAGE -mode build_postgis'
alias pgclean='$PGMANAGE -mode clean'
alias pgls='$PGMANAGE -mode list'
alias pglsavail='$PGMANAGE -mode list_avail'
alias pglslatest='$PGMANAGE -mode list_latest'
alias pgrebuild='$PGMANAGE -mode rebuild_latest'
alias pggitupdate='$PGMANAGE -mode git_update'
alias pgdoxy='$PGMANAGE -mode doxy'
alias pgslave='$PGMANAGE -mode slave'
alias pgsync='git -C $PGTOOLS pull && git -C $PGSRC pull'
alias pgtail='tail -f $PGDATA/log'
alias pgconf='vi $PGDATA/postgresql.conf'
alias pghba='vi $PGDATA/pg_hba.conf'
alias pgpid='pgrep -f "postgres: \w+ \w+ .*((\d+)|\[local\])" | head -1'
alias pgdb='gdb -p $(pgpid)'
#alias pgtop=FIXME
alias agc='ag -G c$'
alias pgconfigure="./configure --with-extra-version=\"-O0@\$(git show HEAD --abbrev-commit --stat|head -n1|cut -d' ' -f2)\" --prefix /tmp/pgbuild --enable-thread-safety --enable-coverage --with-openssl --with-libxml --enable-nls --with-ossp-uuid --enable-cassert --enable-debug --enable-depend --disable-dtrace --enable-tap-tests CFLAGS=\"-gdwarf -g3 -fno-omit-frame-pointer -fno-common\""
alias pgconfigure_perf="./configure --with-extra-version=\"-O2@\$(git show HEAD --abbrev-commit --stat|head -n1|cut -d' ' -f2)\" --prefix /tmp/pgbuild --enable-thread-safety --disable-coverage --with-openssl --with-libxml --enable-nls --with-ossp-uuid --disable-cassert --enable-debug --enable-depend --disable-dtrace --enable-tap-tests CFLAGS=\"-gdwarf -g3 -fno-omit-frame-pointer -fno-common -O2\""
alias pgconfigure32="./configure --with-extra-version=\"-32b@\$(git show HEAD --abbrev-commit --stat|head -n1|cut -d' ' -f2)\" --prefix /tmp/pgbuild --enable-thread-safety --enable-nls --enable-cassert --enable-debug --enable-depend --enable-coverage --disable-dtrace -without-readline --without-zlib --without-openssl --enable-tap-tests CFLAGS=\"-gdwarf -g3 -fno-omit-frame-pointer -m32\""
alias pgctags='ctags -R --exclude ".git" .'
alias pgctags_dualdir='ctags -R --exclude ".git" . ${MAINGITDIR}/postgresql'

# Example for specifying arguments.
#export PGSUPARGS='-c fsync=off -c shared_buffers=1GB'
export PGHOST=/tmp



