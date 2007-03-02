From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 9/9] Vmi smp fixes.patch
Date: Thu, 1 Mar 2007 18:55:58 -0800
Message-ID: <200703020255.l222twSE009700@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422731AbXCBC4L@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>, Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Critical fixes for SMP.

Fix a couple functions which needed to be __devinit and fix a bogus
parameter to AP startup that just so happened to work because the
low virtual mapping of memory was still established.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r baf2e278a482 arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Thu Mar 01 18:08:53 2007 -0800
+++ b/arch/i386/kernel/vmi.c	Thu Mar 01 18:10:18 2007 -0800
@@ -525,13 +525,14 @@ void vmi_pmd_clear(pmd_t *pmd)
 #endif
 
 #ifdef CONFIG_SMP
-struct vmi_ap_state ap;
 extern void setup_pda(void);
 
-static void __init /* XXX cpu hotplug */
+static void __devinit
 vmi_startup_ipi_hook(int phys_apicid, unsigned long start_eip,
 		     unsigned long start_esp)
 {
+	struct vmi_ap_state ap;
+
 	/* Default everything to zero.  This is fine for most GPRs. */
 	memset(&ap, 0, sizeof(struct vmi_ap_state));
 
@@ -570,7 +571,7 @@ vmi_startup_ipi_hook(int phys_apicid, un
 	/* Protected mode, paging, AM, WP, NE, MP. */
 	ap.cr0 = 0x80050023;
 	ap.cr4 = mmu_cr4_features;
-	vmi_ops.set_initial_ap_state(__pa(&ap), phys_apicid);
+	vmi_ops.set_initial_ap_state((u32)&ap, phys_apicid);
 }
 #endif
 
diff -r baf2e278a482 arch/i386/kernel/vmitime.c
--- a/arch/i386/kernel/vmitime.c	Thu Mar 01 18:08:53 2007 -0800
+++ b/arch/i386/kernel/vmitime.c	Thu Mar 01 18:08:53 2007 -0800
@@ -243,7 +243,7 @@ void __init vmi_timer_setup_boot_alarm(v
 
 /* Initialize the time accounting variables for an AP on an SMP system.
  * Also, set the local alarm for the AP. */
-void __init vmi_timer_setup_secondary_alarm(void)
+void __devinit vmi_timer_setup_secondary_alarm(void)
 {
 	int cpu = smp_processor_id();
 
