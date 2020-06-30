From: Will Deacon <will@kernel.org>
Subject: [PATCH 01/18] tools: bpf: Use local copy of headers including uapi/linux/filter.h
Date: Tue, 30 Jun 2020 18:37:17 +0100
Message-ID: <20200630173734.14057-2-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.orgv
List-Id: virtualization@lists.linuxfoundation.org

Pulling header files directly out of the kernel sources for inclusion in
userspace programs is highly error prone, not least because it bypasses
the kbuild infrastructure entirely and so may end up referencing other
header files that have not been generated.

Subsequent patches will cause compiler.h to pull in the ungenerated
asm/rwonce.h file via filter.h, breaking the build for tools/bpf:

  | $ make -C tools/bpf
  | make: Entering directory '/linux/tools/bpf'
  |   CC       bpf_jit_disasm.o
  |   LINK     bpf_jit_disasm
  |   CC       bpf_dbg.o
  | In file included from /linux/include/uapi/linux/filter.h:9,
  |                  from /linux/tools/bpf/bpf_dbg.c:41:
  | /linux/include/linux/compiler.h:247:10: fatal error: asm/rwonce.h: No such file or directory
  |  #include <asm/rwonce.h>
  |           ^~~~~~~~~~~~~~
  | compilation terminated.
  | make: *** [Makefile:61: bpf_dbg.o] Error 1
  | make: Leaving directory '/linux/tools/bpf'

Take a copy of the installed version of linux/filter.h  (i.e. the one
created by the 'headers_install' target) into tools/include/uapi/linux/
and adjust the BPF tool Makefile to reference the local include
directories instead of those in the main source tree.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Reported-by: Xiao Yang <ice_yangxiao@163.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 tools/bpf/Makefile                |  3 +-
 tools/include/uapi/linux/filter.h | 90 +++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/uapi/linux/filter.h

diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
index 6df1850f8353..8a69258fd8aa 100644
--- a/tools/bpf/Makefile
+++ b/tools/bpf/Makefile
@@ -9,7 +9,8 @@ MAKE = make
 INSTALL ?= install
 
 CFLAGS += -Wall -O2
-CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/include/uapi -I$(srctree)/include
+CFLAGS += -D__EXPORTED_HEADERS__ -I$(srctree)/tools/include/uapi \
+	  -I$(srctree)/tools/include
 
 # This will work when bpf is built in tools env. where srctree
 # isn't set and when invoked from selftests build, where srctree
diff --git a/tools/include/uapi/linux/filter.h b/tools/include/uapi/linux/filter.h
new file mode 100644
index 000000000000..eaef459e7bd4
--- /dev/null
+++ b/tools/include/uapi/linux/filter.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Linux Socket Filter Data Structures
+ */
+
+#ifndef __LINUX_FILTER_H__
+#define __LINUX_FILTER_H__
+
+
+#include <linux/types.h>
+#include <linux/bpf_common.h>
+
+/*
+ * Current version of the filter code architecture.
+ */
+#define BPF_MAJOR_VERSION 1
+#define BPF_MINOR_VERSION 1
+
+/*
+ *	Try and keep these values and structures similar to BSD, especially
+ *	the BPF code definitions which need to match so you can share filters
+ */
+ 
+struct sock_filter {	/* Filter block */
+	__u16	code;   /* Actual filter code */
+	__u8	jt;	/* Jump true */
+	__u8	jf;	/* Jump false */
+	__u32	k;      /* Generic multiuse field */
+};
+
+struct sock_fprog {	/* Required for SO_ATTACH_FILTER. */
+	unsigned short		len;	/* Number of filter blocks */
+	struct sock_filter *filter;
+};
+
+/* ret - BPF_K and BPF_X also apply */
+#define BPF_RVAL(code)  ((code) & 0x18)
+#define         BPF_A           0x10
+
+/* misc */
+#define BPF_MISCOP(code) ((code) & 0xf8)
+#define         BPF_TAX         0x00
+#define         BPF_TXA         0x80
+
+/*
+ * Macros for filter block array initializers.
+ */
+#ifndef BPF_STMT
+#define BPF_STMT(code, k) { (unsigned short)(code), 0, 0, k }
+#endif
+#ifndef BPF_JUMP
+#define BPF_JUMP(code, k, jt, jf) { (unsigned short)(code), jt, jf, k }
+#endif
+
+/*
+ * Number of scratch memory words for: BPF_ST and BPF_STX
+ */
+#define BPF_MEMWORDS 16
+
+/* RATIONALE. Negative offsets are invalid in BPF.
+   We use them to reference ancillary data.
+   Unlike introduction new instructions, it does not break
+   existing compilers/optimizers.
+ */
+#define SKF_AD_OFF    (-0x1000)
+#define SKF_AD_PROTOCOL 0
+#define SKF_AD_PKTTYPE 	4
+#define SKF_AD_IFINDEX 	8
+#define SKF_AD_NLATTR	12
+#define SKF_AD_NLATTR_NEST	16
+#define SKF_AD_MARK 	20
+#define SKF_AD_QUEUE	24
+#define SKF_AD_HATYPE	28
+#define SKF_AD_RXHASH	32
+#define SKF_AD_CPU	36
+#define SKF_AD_ALU_XOR_X	40
+#define SKF_AD_VLAN_TAG	44
+#define SKF_AD_VLAN_TAG_PRESENT 48
+#define SKF_AD_PAY_OFFSET	52
+#define SKF_AD_RANDOM	56
+#define SKF_AD_VLAN_TPID	60
+#define SKF_AD_MAX	64
+
+#define SKF_NET_OFF	(-0x100000)
+#define SKF_LL_OFF	(-0x200000)
+
+#define BPF_NET_OFF	SKF_NET_OFF
+#define BPF_LL_OFF	SKF_LL_OFF
+
+#endif /* __LINUX_FILTER_H__ */
-- 
2.27.0.212.ge8ba1cc988-goog
