From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 1/3] Vmi compile fix
Date: Thu, 4 Jan 2007 20:35:30 -0800
Message-ID: <200701050435.l054ZUHx005535@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030315AbXAEEfp@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eli Collins <ecollins@vmware.com>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

The variable no_timer_check does not exist in UP builds; don't try to
set it in the vmi init code.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 21d7686ee318 arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Thu Jan 04 15:23:30 2007 -0800
+++ b/arch/i386/kernel/vmi.c	Thu Jan 04 15:55:39 2007 -0800
@@ -913,7 +913,9 @@ void __init vmi_init(void)
 
 	local_irq_save(flags);
 	activate_vmi();
+#ifdef CONFIG_SMP
 	no_timer_check = 1;
+#endif
 	local_irq_restore(flags & X86_EFLAGS_IF);
 }
 
