From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 12/50] ia64/pv_ops: introduce ia64_set_rr0_to_rr4() to make
	kernel paravirtualization friendly.
Date: Thu,  6 Mar 2008 03:18:27 +0900
Message-ID: <12047411461336-git-send-email-yamahata__13097.0974606045$1204754849$gmane$org@valinux.co.jp>
References: <12047411453864-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12047411453864-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, virtualization@lists.linux-foundation.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

ia64/Xen will replace setting rr[0-4] with single hypercall later.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/intrinsics.h  |   10 ++++++++++
 include/asm-ia64/mmu_context.h |    6 +-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/asm-ia64/intrinsics.h b/include/asm-ia64/intrinsics.h
index f1135b5..c206755 100644
--- a/include/asm-ia64/intrinsics.h
+++ b/include/asm-ia64/intrinsics.h
@@ -18,6 +18,15 @@
 # include <asm/gcc_intrin.h>
 #endif
 
+#define ia64_set_rr0_to_rr4(val0, val1, val2, val3, val4)	\
+do {								\
+	ia64_set_rr(0x0000000000000000UL, (val0));		\
+	ia64_set_rr(0x2000000000000000UL, (val1));		\
+	ia64_set_rr(0x4000000000000000UL, (val2));		\
+	ia64_set_rr(0x6000000000000000UL, (val3));		\
+	ia64_set_rr(0x8000000000000000UL, (val4));		\
+} while (0)
+
 /*
  * Force an unresolved reference if someone tries to use
  * ia64_fetch_and_add() with a bad value.
@@ -183,4 +192,5 @@ extern long ia64_cmpxchg_called_with_bad_pointer (void);
 #endif /* !CONFIG_IA64_DEBUG_CMPXCHG */
 
 #endif
+#include <asm/privop.h>
 #endif /* _ASM_IA64_INTRINSICS_H */
diff --git a/include/asm-ia64/mmu_context.h b/include/asm-ia64/mmu_context.h
index cef2400..040bc87 100644
--- a/include/asm-ia64/mmu_context.h
+++ b/include/asm-ia64/mmu_context.h
@@ -152,11 +152,7 @@ reload_context (nv_mm_context_t context)
 #  endif
 #endif
 
-	ia64_set_rr(0x0000000000000000UL, rr0);
-	ia64_set_rr(0x2000000000000000UL, rr1);
-	ia64_set_rr(0x4000000000000000UL, rr2);
-	ia64_set_rr(0x6000000000000000UL, rr3);
-	ia64_set_rr(0x8000000000000000UL, rr4);
+	ia64_set_rr0_to_rr4(rr0, rr1, rr2, rr3, rr4);
 	ia64_srlz_i();			/* srlz.i implies srlz.d */
 }
 
-- 
1.5.3
