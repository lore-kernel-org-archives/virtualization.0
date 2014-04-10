From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] tools: Unify export.h
Date: Thu, 10 Apr 2014 19:38:05 +0200
Message-ID: <20140410173805.GA28613@pd.tnic>
References: <1393153753-2369-1-git-send-email-bp@alien8.de>
	<87eh2s55tg.fsf@rustcorp.com.au> <20140225070020.GA19504@pd.tnic>
	<87eh2r4c2d.fsf@rustcorp.com.au>
	<20140225140511.GD5982@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140225140511.GD5982@ghostprotocols.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Sasha Levin <sasha.levin@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Rebased onto current acme/perf/core:

--
From: Borislav Petkov <bp@suse.de>
Date: Sun, 23 Feb 2014 12:04:53 +0100
Subject: [PATCH] tools: Unify export.h

So tools/ has been growing three, at a different stage of their
development export.h headers and so we should unite into one. Add
tools/include/ to the include path of virtio and liblockdep to pick the
shared header now.

Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 tools/{virtio => include}/linux/export.h  | 5 +++++
 tools/lib/lockdep/Makefile                | 2 +-
 tools/lib/lockdep/uinclude/linux/export.h | 7 -------
 tools/perf/Makefile.perf                  | 2 +-
 tools/perf/util/include/linux/export.h    | 6 ------
 tools/virtio/Makefile                     | 2 +-
 6 files changed, 8 insertions(+), 16 deletions(-)
 rename tools/{virtio => include}/linux/export.h (70%)
 delete mode 100644 tools/lib/lockdep/uinclude/linux/export.h
 delete mode 100644 tools/perf/util/include/linux/export.h

diff --git a/tools/virtio/linux/export.h b/tools/include/linux/export.h
similarity index 70%
rename from tools/virtio/linux/export.h
rename to tools/include/linux/export.h
index 7311d326894a..d07e586b9ba0 100644
--- a/tools/virtio/linux/export.h
+++ b/tools/include/linux/export.h
@@ -1,5 +1,10 @@
+#ifndef _TOOLS_LINUX_EXPORT_H_
+#define _TOOLS_LINUX_EXPORT_H_
+
 #define EXPORT_SYMBOL(sym)
 #define EXPORT_SYMBOL_GPL(sym)
 #define EXPORT_SYMBOL_GPL_FUTURE(sym)
 #define EXPORT_UNUSED_SYMBOL(sym)
 #define EXPORT_UNUSED_SYMBOL_GPL(sym)
+
+#endif
diff --git a/tools/lib/lockdep/Makefile b/tools/lib/lockdep/Makefile
index 07b0b7542511..41d4a99ce46e 100644
--- a/tools/lib/lockdep/Makefile
+++ b/tools/lib/lockdep/Makefile
@@ -112,7 +112,7 @@ export Q VERBOSE
 
 LIBLOCKDEP_VERSION = $(LL_VERSION).$(LL_PATCHLEVEL).$(LL_EXTRAVERSION)
 
-INCLUDES = -I. -I/usr/local/include -I./uinclude -I./include $(CONFIG_INCLUDES)
+INCLUDES = -I. -I/usr/local/include -I./uinclude -I./include -I../../include $(CONFIG_INCLUDES)
 
 # Set compile option CFLAGS if not set elsewhere
 CFLAGS ?= -g -DCONFIG_LOCKDEP -DCONFIG_STACKTRACE -DCONFIG_PROVE_LOCKING -DBITS_PER_LONG=__WORDSIZE -DLIBLOCKDEP_VERSION='"$(LIBLOCKDEP_VERSION)"' -rdynamic -O0 -g
diff --git a/tools/lib/lockdep/uinclude/linux/export.h b/tools/lib/lockdep/uinclude/linux/export.h
deleted file mode 100644
index 6bdf3492c535..000000000000
--- a/tools/lib/lockdep/uinclude/linux/export.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef _LIBLOCKDEP_LINUX_EXPORT_H_
-#define _LIBLOCKDEP_LINUX_EXPORT_H_
-
-#define EXPORT_SYMBOL(sym)
-#define EXPORT_SYMBOL_GPL(sym)
-
-#endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 667e85a1f949..791ad6d1994e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -222,7 +222,7 @@ LIB_H += util/include/linux/const.h
 LIB_H += util/include/linux/ctype.h
 LIB_H += util/include/linux/kernel.h
 LIB_H += util/include/linux/list.h
-LIB_H += util/include/linux/export.h
+LIB_H += ../include/linux/export.h
 LIB_H += util/include/linux/poison.h
 LIB_H += util/include/linux/rbtree.h
 LIB_H += util/include/linux/rbtree_augmented.h
diff --git a/tools/perf/util/include/linux/export.h b/tools/perf/util/include/linux/export.h
deleted file mode 100644
index b43e2dc21e04..000000000000
--- a/tools/perf/util/include/linux/export.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef PERF_LINUX_MODULE_H
-#define PERF_LINUX_MODULE_H
-
-#define EXPORT_SYMBOL(name)
-
-#endif
diff --git a/tools/virtio/Makefile b/tools/virtio/Makefile
index 3187c62d9814..9325f4693821 100644
--- a/tools/virtio/Makefile
+++ b/tools/virtio/Makefile
@@ -3,7 +3,7 @@ test: virtio_test vringh_test
 virtio_test: virtio_ring.o virtio_test.o
 vringh_test: vringh_test.o vringh.o virtio_ring.o
 
-CFLAGS += -g -O2 -Wall -I. -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE
+CFLAGS += -g -O2 -Wall -I. -I../include/ -I ../../usr/include/ -Wno-pointer-sign -fno-strict-overflow -fno-strict-aliasing -fno-common -MMD -U_FORTIFY_SOURCE
 vpath %.c ../../drivers/virtio ../../drivers/vhost
 mod:
 	${MAKE} -C `pwd`/../.. M=`pwd`/vhost_test
-- 
1.9.0

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
