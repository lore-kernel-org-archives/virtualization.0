From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 3/3] Vmi native fix
Date: Thu, 4 Jan 2007 20:35:30 -0800
Message-ID: <200701050435.l054ZUWn005547@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030334AbXAEEfn@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eli Collins <ecollins@vmware.com>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

In paravirt builds with VMI compiled in, vmi_bringup is called
unconditionally, not via a paravirt-ops table (as no other hypervisor
uses the APIC startup technique).  Make the calls to setup VMI state
conditional on the presence of the VMI ROM.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 1915e2685a3c arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Thu Jan 04 15:56:40 2007 -0800
+++ b/arch/i386/kernel/vmi.c	Thu Jan 04 15:57:38 2007 -0800
@@ -645,7 +645,8 @@ void vmi_bringup(void)
 void vmi_bringup(void)
 {
  	/* We must establish the lowmem mapping for MMU ops to work */
-	vmi_ops.set_linear_mapping(0, __PAGE_OFFSET, max_low_pfn, 0);
+	if (vmi_rom) 
+		vmi_ops.set_linear_mapping(0, __PAGE_OFFSET, max_low_pfn, 0);
 }
 
 /*
