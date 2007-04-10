From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 6/10] Vmi supports compat vdso.patch
Date: Mon, 9 Apr 2007 17:06:17 -0700
Message-ID: <200704100006.l3A06H0b020626@zach-dev.vmware.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932274AbXDJAJl@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that the VDSO can be relocated, we can support it in VMI configurations.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 158d9ffb46fe arch/i386/Kconfig
--- a/arch/i386/Kconfig	Thu Mar 29 04:17:05 2007 -0700
+++ b/arch/i386/Kconfig	Thu Mar 29 04:18:05 2007 -0700
@@ -220,7 +220,7 @@ config PARAVIRT
 
 config VMI
 	bool "VMI Paravirt-ops support"
-	depends on PARAVIRT && !COMPAT_VDSO
+	depends on PARAVIRT
 	help
 	  VMI provides a paravirtualized interface to the VMware ESX server
 	  (it could be used by other hypervisors in theory too, but is not
