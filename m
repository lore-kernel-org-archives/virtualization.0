From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 7/25][V3] interrupt related native paravirt functions.
Date: Wed, 15 Aug 2007 09:49:27 -0300
Message-ID: <1187182253740-git-send-email-gcosta@redhat.com>
References: <11871821854176-git-send-email-gcosta@redhat.com>
	<1187182197314-git-send-email-gcosta@redhat.com>
	<11871822062386-git-send-email-gcosta@redhat.com>
	<11871822163867-git-send-email-gcosta@redhat.com>
	<11871822244170-git-send-email-gcosta@redhat.com>
	<11871822342754-git-send-email-gcosta@redhat.com>
	<11871822421713-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11871822421713-git-send-email-gcosta@redhat.com>
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
Cc: lguest@ozlabs.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

The interrupt initialization routine becomes native_init_IRQ and will
be overriden later in case paravirt is on.

[  updates from v1
   * After a talk with Jeremy Fitzhardinge, it turned out that making the
   interrupt vector global was not a good idea. So it is removed in this
   patch
]
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/x86_64/kernel/i8259.c |    5 ++++-
 include/asm-x86_64/irq.h   |    2 ++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/i8259.c b/arch/x86_64/kernel/i8259.c
index 948cae6..048e3cb 100644
--- a/arch/x86_64/kernel/i8259.c
+++ b/arch/x86_64/kernel/i8259.c
@@ -484,7 +484,10 @@ static int __init init_timer_sysfs(void)
 
 device_initcall(init_timer_sysfs);
 
-void __init init_IRQ(void)
+/* Overridden in paravirt.c */
+void init_IRQ(void) __attribute__((weak, alias("native_init_IRQ")));
+
+void __init native_init_IRQ(void)
 {
 	int i;
 
diff --git a/include/asm-x86_64/irq.h b/include/asm-x86_64/irq.h
index 5006c6e..be55299 100644
--- a/include/asm-x86_64/irq.h
+++ b/include/asm-x86_64/irq.h
@@ -46,6 +46,8 @@ static __inline__ int irq_canonicalize(int irq)
 extern void fixup_irqs(cpumask_t map);
 #endif
 
+void native_init_IRQ(void);
+
 #define __ARCH_HAS_DO_SOFTIRQ 1
 
 #endif /* _ASM_IRQ_H */
-- 
1.4.4.2
