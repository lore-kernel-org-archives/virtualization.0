From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 03/15] ia64/pv_ops: preparation: introduce ia64_get_psr_i() to
	make kernel paravirtualization friendly.
Date: Wed, 30 Apr 2008 21:29:16 +0900
Message-ID: <12095585681310-git-send-email-yamahata__49859.7346399494$1209561702$gmane$org@valinux.co.jp>
References: <12095585682308-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12095585682308-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

__local_irq_save() and local_save_flags() are used to mask interruptions.
They read all psr bits that requres whole bit emulation.
On the other hand, reading only psr.i, the single bit, can be virtualized
cheaply.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 include/asm-ia64/intrinsics.h |    2 ++
 include/asm-ia64/system.h     |   10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/asm-ia64/intrinsics.h b/include/asm-ia64/intrinsics.h
index 9b83f8f..a3b9689 100644
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
index 26e250b..ed38c43 100644
--- a/include/asm-ia64/system.h
+++ b/include/asm-ia64/system.h
@@ -122,10 +122,16 @@ extern struct ia64_boot_param {
  *   write a floating-point register right before reading the PSR
  *   and that writes to PSR.mfl
  */
+#ifdef CONFIG_PARAVIRT
+#define __local_save_flags()	ia64_get_psr_i()
+#else
+#define __local_save_flags()	ia64_getreg(_IA64_REG_PSR)
+#endif
+
 #define __local_irq_save(x)			\
 do {						\
 	ia64_stop();				\
-	(x) = ia64_getreg(_IA64_REG_PSR);	\
+	(x) = __local_save_flags();		\
 	ia64_stop();				\
 	ia64_rsm(IA64_PSR_I);			\
 } while (0)
@@ -173,7 +179,7 @@ do {								\
 #endif /* !CONFIG_IA64_DEBUG_IRQ */
 
 #define local_irq_enable()	({ ia64_stop(); ia64_ssm(IA64_PSR_I); ia64_srlz_d(); })
-#define local_save_flags(flags)	({ ia64_stop(); (flags) = ia64_getreg(_IA64_REG_PSR); })
+#define local_save_flags(flags)	({ ia64_stop(); (flags) = __local_save_flags(); })
 
 #define irqs_disabled()				\
 ({						\
-- 
1.5.3
