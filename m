From: yamahata@valinux.co.jp
Subject: [PATCH 02/28] ia64/xen: introduce ia64_get_psr_i() to make kernel
	paravirtualization friendly.
Date: Thu, 21 Feb 2008 18:17:33 +0900
Message-ID: <20080221091859.389695000__14861.4926766188$1203633701$gmane$org@ls.local.valinux.co.jp>
References: <20080221091731.641745000@ls.local.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20080221223141.GC17530%yamahata@valinux.co.jp>
Resent-To: linux-ia64@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        kvm-ia64-devel@lists.sourceforge.net
Content-Disposition: inline;
	filename=0002-ia64-xen-introduce-ia64_get_psr_i-to-make-kernel.patch
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
Cc: xen-ia64-devel@lists.xensource.com, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

__local_irq_save() and local_save_flags() are used to mask interruptions.
They read all psr bits that requres whole bit emulation.
On the other hand, reading only psr.i, the single bit, can be virtualized
cheaply.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/intrinsics.h |    2 ++
 include/asm-ia64/system.h     |    4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/asm-ia64/intrinsics.h b/include/asm-ia64/intrinsics.h
index c206755..5800ad0 100644
--- a/include/asm-ia64/intrinsics.h
+++ b/include/asm-ia64/intrinsics.h
@@ -18,6 +18,8 @@
 # include <asm/gcc_intrin.h>
 #endif
 
+#define ia64_get_psr_i()	(ia64_getreg(_IA64_REG_PSR) & IA64_PSR_I)
+
 #define ia64_set_rr0_to_rr4(val0, val1, val2, val3, val4)	\
 do {								\
 	ia64_set_rr(0x0000000000000000UL, (val0));		\
diff --git a/include/asm-ia64/system.h b/include/asm-ia64/system.h
index 595112b..2bca73e 100644
--- a/include/asm-ia64/system.h
+++ b/include/asm-ia64/system.h
@@ -125,7 +125,7 @@ extern struct ia64_boot_param {
 #define __local_irq_save(x)			\
 do {						\
 	ia64_stop();				\
-	(x) = ia64_getreg(_IA64_REG_PSR);	\
+	(x) = ia64_get_psr_i();			\
 	ia64_stop();				\
 	ia64_rsm(IA64_PSR_I);			\
 } while (0)
@@ -173,7 +173,7 @@ do {								\
 #endif /* !CONFIG_IA64_DEBUG_IRQ */
 
 #define local_irq_enable()	({ ia64_stop(); ia64_ssm(IA64_PSR_I); ia64_srlz_d(); })
-#define local_save_flags(flags)	({ ia64_stop(); (flags) = ia64_getreg(_IA64_REG_PSR); })
+#define local_save_flags(flags)	({ ia64_stop(); (flags) = ia64_get_psr_i(); })
 
 #define irqs_disabled()				\
 ({						\
-- 
1.5.3

-- 
yamahata
