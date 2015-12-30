From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 12/34] mips: reuse asm-generic/barrier.h
Date: Wed, 30 Dec 2015 15:25:05 +0200
Message-ID: <1451473761-30019-13-git-send-email-mst__1905.42474524609$1451481998$gmane$org@redhat.com>
References: <1451473761-30019-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1451473761-30019-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Davidlohr Bueso <dbueso@suse.de>, Ralf Baechle <ralf@linux-mips.org>, virtualization@lists.linux-foundation.org, Andrey Konovalov <andreyknvl@google.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On mips dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
the asm-generic variants exactly. Drop the local definitions and pull in
asm-generic/barrier.h instead.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/mips/include/asm/barrier.h | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index 752e0b8..3eac4b9 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -10,9 +10,6 @@
 
 #include <asm/addrspace.h>
 
-#define read_barrier_depends()		do { } while(0)
-#define smp_read_barrier_depends()	do { } while(0)
-
 #ifdef CONFIG_CPU_HAS_SYNC
 #define __sync()				\
 	__asm__ __volatile__(			\
@@ -87,8 +84,6 @@
 
 #define wmb()		fast_wmb()
 #define rmb()		fast_rmb()
-#define dma_wmb()	fast_wmb()
-#define dma_rmb()	fast_rmb()
 
 #if defined(CONFIG_WEAK_ORDERING) && defined(CONFIG_SMP)
 # ifdef CONFIG_CPU_CAVIUM_OCTEON
@@ -112,9 +107,6 @@
 #define __WEAK_LLSC_MB		"		\n"
 #endif
 
-#define smp_store_mb(var, value) \
-	do { WRITE_ONCE(var, value); smp_mb(); } while (0)
-
 #define smp_llsc_mb()	__asm__ __volatile__(__WEAK_LLSC_MB : : :"memory")
 
 #ifdef CONFIG_CPU_CAVIUM_OCTEON
@@ -129,22 +121,9 @@
 #define nudge_writes() mb()
 #endif
 
-#define smp_store_release(p, v)						\
-do {									\
-	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
-	WRITE_ONCE(*p, v);						\
-} while (0)
-
-#define smp_load_acquire(p)						\
-({									\
-	typeof(*p) ___p1 = READ_ONCE(*p);				\
-	compiletime_assert_atomic_type(*p);				\
-	smp_mb();							\
-	___p1;								\
-})
-
 #define smp_mb__before_atomic()	smp_mb__before_llsc()
 #define smp_mb__after_atomic()	smp_llsc_mb()
 
+#include <asm-generic/barrier.h>
+
 #endif /* __ASM_BARRIER_H */
-- 
MST
