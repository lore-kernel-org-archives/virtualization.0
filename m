From: Will Deacon <will@kernel.org>
Subject: [PATCH v3 09/19] locking/barriers: Remove definitions for
 [smp_]read_barrier_depends()
Date: Fri, 10 Jul 2020 17:51:53 +0100
Message-ID: <20200710165203.31284-10-will@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200710165203.31284-1-will@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joelaf@google.com>, Mark Rutland <mark.rutland@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alan Stern <stern@rowland.harvard.edu>, Sami Tolvanen <samitolvanen@google.com>, Matt Turner <mattst88@gmail.com>, kernel-team@android.com, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>, Nick Desaulniers <ndesaulniers@google.com>, linux-alpha@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

There are no remaining users of [smp_]read_barrier_depends(), so
remove it from the generic implementation of 'barrier.h'.

Acked-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/asm-generic/barrier.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 8116744bb82c..fec97dc34de7 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -46,10 +46,6 @@
 #define dma_wmb()	wmb()
 #endif
 
-#ifndef read_barrier_depends
-#define read_barrier_depends()		do { } while (0)
-#endif
-
 #ifndef __smp_mb
 #define __smp_mb()	mb()
 #endif
@@ -62,10 +58,6 @@
 #define __smp_wmb()	wmb()
 #endif
 
-#ifndef __smp_read_barrier_depends
-#define __smp_read_barrier_depends()	read_barrier_depends()
-#endif
-
 #ifdef CONFIG_SMP
 
 #ifndef smp_mb
@@ -80,10 +72,6 @@
 #define smp_wmb()	__smp_wmb()
 #endif
 
-#ifndef smp_read_barrier_depends
-#define smp_read_barrier_depends()	__smp_read_barrier_depends()
-#endif
-
 #else	/* !CONFIG_SMP */
 
 #ifndef smp_mb
@@ -98,10 +86,6 @@
 #define smp_wmb()	barrier()
 #endif
 
-#ifndef smp_read_barrier_depends
-#define smp_read_barrier_depends()	do { } while (0)
-#endif
-
 #endif	/* CONFIG_SMP */
 
 #ifndef __smp_store_mb
@@ -196,7 +180,6 @@ do {									\
 #define virt_mb() __smp_mb()
 #define virt_rmb() __smp_rmb()
 #define virt_wmb() __smp_wmb()
-#define virt_read_barrier_depends() __smp_read_barrier_depends()
 #define virt_store_mb(var, value) __smp_store_mb(var, value)
 #define virt_mb__before_atomic() __smp_mb__before_atomic()
 #define virt_mb__after_atomic()	__smp_mb__after_atomic()
-- 
2.27.0.383.g050319c2ae-goog
