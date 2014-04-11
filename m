From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] tools: Unify export.h
Date: Fri, 11 Apr 2014 13:59:30 +0200
Message-ID: <20140411115930.GC1107__23691.9336174198$1397247211$gmane$org@krava.brq.redhat.com>
References: <1393153753-2369-1-git-send-email-bp@alien8.de>
	<87eh2s55tg.fsf@rustcorp.com.au> <20140225070020.GA19504@pd.tnic>
	<87eh2r4c2d.fsf@rustcorp.com.au>
	<20140225140511.GD5982@ghostprotocols.net>
	<20140410173805.GA28613@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140410173805.GA28613@pd.tnic>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Borislav Petkov <bp@alien8.de>
Cc: virtio-dev@lists.oasis-open.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Sasha Levin <sasha.levin@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Apr 10, 2014 at 07:38:05PM +0200, Borislav Petkov wrote:
> Rebased onto current acme/perf/core:
> 
> --
> From: Borislav Petkov <bp@suse.de>
> Date: Sun, 23 Feb 2014 12:04:53 +0100
> Subject: [PATCH] tools: Unify export.h
> 
> So tools/ has been growing three, at a different stage of their
> development export.h headers and so we should unite into one. Add
> tools/include/ to the include path of virtio and liblockdep to pick the
> shared header now.

hum, this breaks tarpkg test.. note that I needed attached
patch to make the test output verbose

jirka


[jolsa@krava perf]$ make -f tests/make tarpkg
- tarpkg: ./tests/perf-targz-src-pkg .
make: *** [tarpkg] Error 2
[jolsa@krava perf]$ cat tarpkg 
./tests/perf-targz-src-pkg .
+ PERF=.
+ cd ./../..
+ make perf-targz-src-pkg
  TAR
++ ls -rt perf-3.14.0-rc6.tar.gz
+ TARBALL=perf-3.14.0-rc6.tar.gz
++ mktemp -d
+ TMP_DEST=/tmp/tmp.27M0WzGGue
+ tar xf perf-3.14.0-rc6.tar.gz -C /tmp/tmp.27M0WzGGue
+ rm -f perf-3.14.0-rc6.tar.gz
+ cd -
+ make -C /tmp/tmp.27M0WzGGue/perf-3.14.0-rc6/tools/perf
  BUILD:   Doing 'make -j4' parallel build
config/Makefile:289: No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR

Auto-detecting system features:
...                         dwarf: [ on  ]
...                         glibc: [ on  ]
...                          gtk2: [ on  ]
...                      libaudit: [ on  ]
...                        libbfd: [ on  ]
...                        libelf: [ on  ]
...                       libnuma: [ on  ]
...                       libperl: [ on  ]
...                     libpython: [ on  ]
...                      libslang: [ on  ]
...                     libunwind: [ on  ]
...            libdw-dwarf-unwind: [ OFF ]
...     DWARF post unwind library: libunwind

  GEN      common-cmds.h
make[2]: *** No rule to make target `../include/linux/export.h', needed by `builtin-annotate.o'.  Stop.
make[2]: *** Waiting for unfinished jobs....
  FLAGS:   * new build flags or prefix
  PERF_VERSION = 3.14.rc6.g3b66a2
make[1]: *** [all] Error 2
+ RC=2
+ rm -rf /tmp/tmp.27M0WzGGue
+ exit 2



---
diff --git a/tools/perf/tests/perf-targz-src-pkg b/tools/perf/tests/perf-targz-src-pkg
index 238aa39..f20d29e 100755
--- a/tools/perf/tests/perf-targz-src-pkg
+++ b/tools/perf/tests/perf-targz-src-pkg
@@ -7,15 +7,17 @@
 # like when we made some files that were in tools/perf/ available to other tools/
 # codebases by moving it to tools/include/, etc.
 
+set -x
+
 PERF=$1
 cd ${PERF}/../..
-make perf-targz-src-pkg > /dev/null
+make perf-targz-src-pkg
 TARBALL=$(ls -rt perf-*.tar.gz)
 TMP_DEST=$(mktemp -d)
 tar xf ${TARBALL} -C $TMP_DEST
 rm -f ${TARBALL}
 cd - > /dev/null
-make -C $TMP_DEST/perf*/tools/perf > /dev/null 2>&1
+make -C $TMP_DEST/perf*/tools/perf
 RC=$?
 rm -rf ${TMP_DEST}
 exit $RC
