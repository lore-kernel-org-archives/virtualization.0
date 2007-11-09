From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 12/24] provide native irq initialization function
Date: Fri,  9 Nov 2007 16:42:53 -0200
Message-ID: <1194633852469-git-send-email-gcosta__48282.3894512423$1194643911$gmane$org@redhat.com>
References: <11946337851964-git-send-email-gcosta@redhat.com>
	<11946337933104-git-send-email-gcosta@redhat.com>
	<11946337991750-git-send-email-gcosta@redhat.com>
	<11946338053158-git-send-email-gcosta@redhat.com>
	<11946338103068-git-send-email-gcosta@redhat.com>
	<1194633815833-git-send-email-gcosta@redhat.com>
	<11946338212915-git-send-email-gcosta@redhat.com>
	<11946338263902-git-send-email-gcosta@redhat.com>
	<1194633831882-git-send-email-gcosta@redhat.com>
	<11946338361369-git-send-email-gcosta@redhat.com>
	<11946338413283-git-send-email-gcosta@redhat.com>
	<11946338473652-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11946338473652-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

The interrupt initialization routine becomes native_init_IRQ and will
be overriden later in case paravirt is on. The interrupt array is made visible
for guests such lguest, that will need to have their own initialization
mechanism (though using most of the same irq lines) later on.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/x86/kernel/i8259_64.c |    7 +++++--
 include/asm-x86/irq_64.h   |    3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/i8259_64.c b/arch/x86/kernel/i8259_64.c
index 3041e59..53955f4 100644
--- a/arch/x86/kernel/i8259_64.c
+++ b/arch/x86/kernel/i8259_64.c
@@ -77,7 +77,7 @@ BUILD_16_IRQS(0xc) BUILD_16_IRQS(0xd) BUILD_16_IRQS(0xe) BUILD_16_IRQS(0xf)
 	IRQ(x,c), IRQ(x,d), IRQ(x,e), IRQ(x,f)
 
 /* for the irq vectors */
-static void (*interrupt[NR_VECTORS - FIRST_EXTERNAL_VECTOR])(void) = {
+void (*interrupt[NR_VECTORS - FIRST_EXTERNAL_VECTOR])(void) = {
 					  IRQLIST_16(0x2), IRQLIST_16(0x3),
 	IRQLIST_16(0x4), IRQLIST_16(0x5), IRQLIST_16(0x6), IRQLIST_16(0x7),
 	IRQLIST_16(0x8), IRQLIST_16(0x9), IRQLIST_16(0xa), IRQLIST_16(0xb),
@@ -456,7 +456,10 @@ void __init init_ISA_irqs (void)
 	}
 }
 
-void __init init_IRQ(void)
+/* Overridden in paravirt.c */
+void init_IRQ(void) __attribute__((weak, alias("native_init_IRQ")));
+
+void __init native_init_IRQ(void)
 {
 	int i;
 
diff --git a/include/asm-x86/irq_64.h b/include/asm-x86/irq_64.h
index 5006c6e..4f02446 100644
--- a/include/asm-x86/irq_64.h
+++ b/include/asm-x86/irq_64.h
@@ -46,6 +46,9 @@ static __inline__ int irq_canonicalize(int irq)
 extern void fixup_irqs(cpumask_t map);
 #endif
 
+#include <linux/init.h>
+void native_init_IRQ(void);
+
 #define __ARCH_HAS_DO_SOFTIRQ 1
 
 #endif /* _ASM_IRQ_H */
-- 
1.4.4.2
