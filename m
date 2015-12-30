From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 10/34] arm64: reuse asm-generic/barrier.h
Date: Wed, 30 Dec 2015 15:24:56 +0200
Message-ID: <1451473761-30019-11-git-send-email-mst__7944.56336084313$1451481975$gmane$org@redhat.com>
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
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Peter Zijlstra <peterz@infradead.org>, Andrew Cooper <andrew.cooper3@citrix.com>, Will Deacon <will.deacon@arm.com>, Andrey Konovalov <andreyknvl@google.com>, virtualization@lists.linux-foundation.org, Andre Przywara <andre.przywara@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On arm64 nop, read_barrier_depends, smp_read_barrier_depends
smp_store_mb(), smp_mb__before_atomic and smp_mb__after_atomic match the
asm-generic variants exactly. Drop the local definitions and pull in
asm-generic/barrier.h instead.

This is in preparation to refactoring this code area.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/arm64/include/asm/barrier.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 9622eb4..91a43f4 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -91,14 +91,7 @@ do {									\
 	__u.__val;							\
 })
 
-#define read_barrier_depends()		do { } while(0)
-#define smp_read_barrier_depends()	do { } while(0)
-
-#define smp_store_mb(var, value)	do { WRITE_ONCE(var, value); smp_mb(); } while (0)
-#define nop()		asm volatile("nop");
-
-#define smp_mb__before_atomic()	smp_mb()
-#define smp_mb__after_atomic()	smp_mb()
+#include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
 
-- 
MST
