From: Will Deacon <will@kernel.org>
Subject: [PATCH v3 02/19] compiler.h: Split {READ,WRITE}_ONCE definitions out into rwonce.h
Date: Fri, 10 Jul 2020 17:51:46 +0100
Message-ID: <20200710165203.31284-3-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
Sender: linux-alpha-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Joel Fernandes <joelaf@google.com>, Sami Tolvanen <samitolvanen@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, Matt Turner <mattst88@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Richard Henderson <rth@twiddle.net>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org, virtualizati
List-Id: virtualization@lists.linuxfoundation.org

In preparation for allowing architectures to define their own
implementation of the READ_ONCE() macro, move the generic
{READ,WRITE}_ONCE() definitions out of the unwieldy 'linux/compiler.h'
file and into a new 'rwonce.h' header under 'asm-generic'.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/Kbuild    |  1 +
 include/asm-generic/barrier.h |  2 +-
 include/asm-generic/rwonce.h  | 91 +++++++++++++++++++++++++++++++++++
 include/linux/compiler.h      | 83 +-------------------------------
 4 files changed, 95 insertions(+), 82 deletions(-)
 create mode 100644 include/asm-generic/rwonce.h

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 44ec80e70518..74b0612601dd 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -45,6 +45,7 @@ mandatory-y += pci.h
 mandatory-y += percpu.h
 mandatory-y += pgalloc.h
 mandatory-y += preempt.h
+mandatory-y += rwonce.h
 mandatory-y += sections.h
 mandatory-y += serial.h
 mandatory-y += shmparam.h
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 2eacaf7d62f6..8116744bb82c 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -13,7 +13,7 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/compiler.h>
+#include <asm/rwonce.h>
 
 #ifndef nop
 #define nop()	asm volatile ("nop")
diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
new file mode 100644
index 000000000000..92cc2f223cb3
--- /dev/null
+++ b/include/asm-generic/rwonce.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Prevent the compiler from merging or refetching reads or writes. The
+ * compiler is also forbidden from reordering successive instances of
+ * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
+ * particular ordering. One way to make the compiler aware of ordering is to
+ * put the two invocations of READ_ONCE or WRITE_ONCE in different C
+ * statements.
+ *
+ * These two macros will also work on aggregate data types like structs or
+ * unions.
+ *
+ * Their two major use cases are: (1) Mediating communication between
+ * process-level code and irq/NMI handlers, all running on the same CPU,
+ * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
+ * mutilate accesses that either do not require ordering or that interact
+ * with an explicit memory barrier or atomic instruction that provides the
+ * required ordering.
+ */
+#ifndef __ASM_GENERIC_RWONCE_H
+#define __ASM_GENERIC_RWONCE_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/compiler_types.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+
+#include <asm/barrier.h>
+
+/*
+ * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
+ * atomicity or dependency ordering guarantees. Note that this may result
+ * in tears!
+ */
+#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
+
+#define __READ_ONCE_SCALAR(x)						\
+({									\
+	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
+	smp_read_barrier_depends();					\
+	(typeof(x))__x;							\
+})
+
+#define READ_ONCE(x)							\
+({									\
+	compiletime_assert_rwonce_type(x);				\
+	__READ_ONCE_SCALAR(x);						\
+})
+
+#define __WRITE_ONCE(x, val)						\
+do {									\
+	*(volatile typeof(x) *)&(x) = (val);				\
+} while (0)
+
+#define WRITE_ONCE(x, val)						\
+do {									\
+	compiletime_assert_rwonce_type(x);				\
+	__WRITE_ONCE(x, val);						\
+} while (0)
+
+static __no_sanitize_or_inline
+unsigned long __read_once_word_nocheck(const void *addr)
+{
+	return __READ_ONCE(*(unsigned long *)addr);
+}
+
+/*
+ * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need to load a
+ * word from memory atomically but without telling KASAN/KCSAN. This is
+ * usually used by unwinding code when walking the stack of a running process.
+ */
+#define READ_ONCE_NOCHECK(x)						\
+({									\
+	unsigned long __x;						\
+	compiletime_assert(sizeof(x) == sizeof(__x),			\
+		"Unsupported access size for READ_ONCE_NOCHECK().");	\
+	__x = __read_once_word_nocheck(&(x));				\
+	smp_read_barrier_depends();					\
+	(typeof(x))__x;							\
+})
+
+static __no_kasan_or_inline
+unsigned long read_word_at_a_time(const void *addr)
+{
+	kasan_check_read(addr, 1);
+	return *(unsigned long *)addr;
+}
+
+#endif /* __ASSEMBLY__ */
+#endif	/* __ASM_GENERIC_RWONCE_H */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 204e76856435..718b4357af32 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -230,28 +230,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
 #endif
 
-/*
- * Prevent the compiler from merging or refetching reads or writes. The
- * compiler is also forbidden from reordering successive instances of
- * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
- * particular ordering. One way to make the compiler aware of ordering is to
- * put the two invocations of READ_ONCE or WRITE_ONCE in different C
- * statements.
- *
- * These two macros will also work on aggregate data types like structs or
- * unions.
- *
- * Their two major use cases are: (1) Mediating communication between
- * process-level code and irq/NMI handlers, all running on the same CPU,
- * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
- * mutilate accesses that either do not require ordering or that interact
- * with an explicit memory barrier or atomic instruction that provides the
- * required ordering.
- */
-#include <asm/barrier.h>
-#include <linux/kasan-checks.h>
-#include <linux/kcsan-checks.h>
-
 /**
  * data_race - mark an expression as containing intentional data races
  *
@@ -272,65 +250,6 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	__v;								\
 })
 
-/*
- * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
- * atomicity or dependency ordering guarantees. Note that this may result
- * in tears!
- */
-#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
-
-#define __READ_ONCE_SCALAR(x)						\
-({									\
-	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
-	smp_read_barrier_depends();					\
-	(typeof(x))__x;							\
-})
-
-#define READ_ONCE(x)							\
-({									\
-	compiletime_assert_rwonce_type(x);				\
-	__READ_ONCE_SCALAR(x);						\
-})
-
-#define __WRITE_ONCE(x, val)						\
-do {									\
-	*(volatile typeof(x) *)&(x) = (val);				\
-} while (0)
-
-#define WRITE_ONCE(x, val)						\
-do {									\
-	compiletime_assert_rwonce_type(x);				\
-	__WRITE_ONCE(x, val);						\
-} while (0)
-
-static __no_sanitize_or_inline
-unsigned long __read_once_word_nocheck(const void *addr)
-{
-	return __READ_ONCE(*(unsigned long *)addr);
-}
-
-/*
- * Use READ_ONCE_NOCHECK() instead of READ_ONCE() if you need to load a
- * word from memory atomically but without telling KASAN/KCSAN. This is
- * usually used by unwinding code when walking the stack of a running process.
- */
-#define READ_ONCE_NOCHECK(x)						\
-({									\
-	unsigned long __x;						\
-	compiletime_assert(sizeof(x) == sizeof(__x),			\
-		"Unsupported access size for READ_ONCE_NOCHECK().");	\
-	__x = __read_once_word_nocheck(&(x));				\
-	smp_read_barrier_depends();					\
-	(typeof(x))__x;							\
-})
-
-static __no_kasan_or_inline
-unsigned long read_word_at_a_time(const void *addr)
-{
-	kasan_check_read(addr, 1);
-	return *(unsigned long *)addr;
-}
-
 #endif /* __KERNEL__ */
 
 /*
@@ -414,4 +333,6 @@ static inline void *offset_to_ptr(const int *off)
  */
 #define prevent_tail_call_optimization()	mb()
 
+#include <asm/rwonce.h>
+
 #endif /* __LINUX_COMPILER_H */
-- 
2.27.0.383.g050319c2ae-goog
