From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 11/34] metag: reuse asm-generic/barrier.h
Date: Wed, 30 Dec 2015 15:25:00 +0200
Message-ID: <1451473761-30019-12-git-send-email-mst__48712.8356159248$1451481988$gmane$org@redhat.com>
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
Cc: linux-arch@vger.kernel.org, James Hogan <james.hogan@imgtec.com>, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Andrey Konovalov <andreyknvl@google.com>, virtualization@lists.linux-foundation.org, linux-metag@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On metag dma_rmb, dma_wmb, smp_store_mb, read_barrier_depends,
smp_read_barrier_depends, smp_store_release and smp_load_acquire  match
the asm-generic variants exactly. Drop the local definitions and pull in
asm-generic/barrier.h instead.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

This is straightforward, but unfortunately untested: I don't have a metag compiler.
I would appreciate an ack from someone with a metag compiler.

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
