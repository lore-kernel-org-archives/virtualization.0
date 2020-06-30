From: Will Deacon <will@kernel.org>
Subject: [PATCH 04/18] alpha: Override READ_ONCE() with barriered implementation
Date: Tue, 30 Jun 2020 18:37:20 +0100
Message-ID: <20200630173734.14057-5-will@kernel.org>
References: <20200630173734.14057-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200630173734.14057-1-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.orgv
List-Id: virtualization@lists.linuxfoundation.org

Rather then relying on the core code to use smp_read_barrier_depends()
as part of the READ_ONCE() definition, instead override __READ_ONCE()
in the Alpha code so that it is treated the same way as
smp_load_acquire().

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/alpha/include/asm/barrier.h | 61 ++++----------------------------
 arch/alpha/include/asm/rwonce.h  | 19 ++++++++++
 2 files changed, 26 insertions(+), 54 deletions(-)
 create mode 100644 arch/alpha/include/asm/rwonce.h

diff --git a/arch/alpha/include/asm/barrier.h b/arch/alpha/include/asm/barrier.h
index 92ec486a4f9e..2ecd068d91d1 100644
--- a/arch/alpha/include/asm/barrier.h
+++ b/arch/alpha/include/asm/barrier.h
@@ -2,64 +2,17 @@
 #ifndef __BARRIER_H
 #define __BARRIER_H
 
-#include <asm/compiler.h>
-
 #define mb()	__asm__ __volatile__("mb": : :"memory")
 #define rmb()	__asm__ __volatile__("mb": : :"memory")
 #define wmb()	__asm__ __volatile__("wmb": : :"memory")
 
-/**
- * read_barrier_depends - Flush all pending reads that subsequents reads
- * depend on.
- *
- * No data-dependent reads from memory-like regions are ever reordered
- * over this barrier.  All reads preceding this primitive are guaranteed
- * to access memory (but not necessarily other CPUs' caches) before any
- * reads following this primitive that depend on the data return by
- * any of the preceding reads.  This primitive is much lighter weight than
- * rmb() on most CPUs, and is never heavier weight than is
- * rmb().
- *
- * These ordering constraints are respected by both the local CPU
- * and the compiler.
- *
- * Ordering is not guaranteed by anything other than these primitives,
- * not even by data dependencies.  See the documentation for
- * memory_barrier() for examples and URLs to more information.
- *
- * For example, the following code would force ordering (the initial
- * value of "a" is zero, "b" is one, and "p" is "&a"):
- *
- * <programlisting>
- *	CPU 0				CPU 1
- *
- *	b = 2;
- *	memory_barrier();
- *	p = &b;				q = p;
- *					read_barrier_depends();
- *					d = *q;
- * </programlisting>
- *
- * because the read of "*q" depends on the read of "p" and these
- * two reads are separated by a read_barrier_depends().  However,
- * the following code, with the same initial values for "a" and "b":
- *
- * <programlisting>
- *	CPU 0				CPU 1
- *
- *	a = 2;
- *	memory_barrier();
- *	b = 3;				y = b;
- *					read_barrier_depends();
- *					x = a;
- * </programlisting>
- *
- * does not enforce ordering, since there is no data dependency between
- * the read of "a" and the read of "b".  Therefore, on some CPUs, such
- * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
- * in cases like this where there are no data dependencies.
- */
-#define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
+#define __smp_load_acquire(p)						\
+({									\
+	__unqual_scalar_typeof(*p) ___p1 =				\
+		(*(volatile typeof(___p1) *)(p));			\
+	compiletime_assert_atomic_type(*p);				\
+	___p1;								\
+})
 
 #ifdef CONFIG_SMP
 #define __ASM_SMP_MB	"\tmb\n"
diff --git a/arch/alpha/include/asm/rwonce.h b/arch/alpha/include/asm/rwonce.h
new file mode 100644
index 000000000000..83a92e49a615
--- /dev/null
+++ b/arch/alpha/include/asm/rwonce.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Google LLC.
+ */
+#ifndef __ASM_RWONCE_H
+#define __ASM_RWONCE_H
+
+#include <asm/barrier.h>
+
+/*
+ * Alpha is apparently daft enough to reorder address-dependent loads
+ * on some CPU implementations. Knock some common sense into it with
+ * a memory barrier in READ_ONCE().
+ */
+#define __READ_ONCE(x)	__smp_load_acquire(&(x))
+
+#include <asm-generic/rwonce.h>
+
+#endif /* __ASM_RWONCE_H */
-- 
2.27.0.212.ge8ba1cc988-goog
