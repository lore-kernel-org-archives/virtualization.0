From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 03/33] xen: paravirt: increase IRQ limit
Date: Tue, 22 May 2007 15:09:44 +0100
Message-ID: <20070522141251.075067202@goop.org>
References: <20070522140941.802382212@goop.org>
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline; filename=paravirt-increase-irq-limit.patch
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>
Cc: Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

When running with CONFIG_PARAVIRT, we may want lots of IRQs even if
there's no IO APIC.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com> 
---
 include/asm-i386/mach-default/irq_vectors_limits.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

===================================================================
--- a/include/asm-i386/mach-default/irq_vectors_limits.h
+++ b/include/asm-i386/mach-default/irq_vectors_limits.h
@@ -1,7 +1,7 @@
 #ifndef _ASM_IRQ_VECTORS_LIMITS_H
 #define _ASM_IRQ_VECTORS_LIMITS_H
 
-#ifdef CONFIG_X86_IO_APIC
+#if defined(CONFIG_X86_IO_APIC) || defined(CONFIG_PARAVIRT)
 #define NR_IRQS 224
 # if (224 >= 32 * NR_CPUS)
 # define NR_IRQ_VECTORS NR_IRQS

-- 
