From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 10/41] metag: reuse asm-generic/barrier.h
Date: Sun, 10 Jan 2016 16:17:54 +0200
Message-ID: <1452426622-4471-11-git-send-email-mst__13100.5095704042$1452435518$gmane$org@redhat.com>
References: <1452426622-4471-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1452426622-4471-1-git-send-email-mst@redhat.com>
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, linux-xtensa@linux-xtensa.org, James Hogan <james.hogan@imgtec.com>, user-mode-linux-devel@lists.sourceforge.net, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, adi-buildroot-devel@lists.sourceforge.net, Thomas Gleixner <tglx@linutronix.de>, linux-metag@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Andrew Cooper <andrew.cooper3@citrix.com>, Joe Perches <joe@perches.com>, linuxppc-dev@list
List-Id: virtualization@lists.linuxfoundation.org

On metag dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
the asm-generic variants exactly. Drop the local definitions and pull in
asm-generic/barrier.h instead.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/metag/include/asm/barrier.h | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/arch/metag/include/asm/barrier.h b/arch/metag/include/asm/barrier.h
index 172b7e5..b5b778b 100644
--- a/arch/metag/include/asm/barrier.h
+++ b/arch/metag/include/asm/barrier.h
@@ -44,9 +44,6 @@ static inline void wr_fence(void)
 #define rmb()		barrier()
 #define wmb()		mb()
 
-#define dma_rmb()	rmb()
-#define dma_wmb()	wmb()
-
 #ifndef CONFIG_SMP
 #define fence()		do { } while (0)
 #define smp_mb()        barrier()
@@ -81,27 +78,9 @@ static inline void fence(void)
 #endif
 #endif
 
-#define read_barrier_depends()		do { } while (0)
-#define smp_read_barrier_depends()	do { } while (0)
-
-#define smp_store_mb(var, value) do { WRITE_ONCE(var, value); smp_mb(); } while (0)
-
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
 #define smp_mb__before_atomic()	barrier()
 #define smp_mb__after_atomic()	barrier()
 
+#include <asm-generic/barrier.h>
+
 #endif /* _ASM_METAG_BARRIER_H */
-- 
MST
