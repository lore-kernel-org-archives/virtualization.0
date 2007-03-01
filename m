From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 18/26] Xen-paravirt_ops: Add XEN config options
Date: Thu, 01 Mar 2007 15:25:01 -0800
Message-ID: <20070301232528.462923016@goop.org>
References: <20070301232443.195603797@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1161295AbXCBACF@vger.kernel.org>
Content-Disposition: inline; filename=xen-config.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Chris Wright <chrisw@sous-sol.org>, Zachary Amsden <zach@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

The XEN config option enables the Xen paravirt_ops interface, which is
installed when the kernel finds itself running under Xen.

Xen is no longer a sub-architecture, so the X86_XEN subarch config
option has gone.

Xen is currently incompatible with:
- PREEMPT
- HZ: set to 100Hz for now, to cut down on VCPU context switch rate.
  This will be adapted to use tickless later.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/Kconfig     |    2 ++
 arch/i386/xen/Kconfig |   10 ++++++++++
 2 files changed, 12 insertions(+)

===================================================================
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -216,6 +216,8 @@ config PARAVIRT
 	  under a hypervisor, improving performance significantly.
 	  However, when run without a hypervisor the kernel is
 	  theoretically slower.  If in doubt, say N.
+
+source "arch/i386/xen/Kconfig"
 
 config VMI
 	bool "VMI Paravirt-ops support"
===================================================================
--- /dev/null
+++ b/arch/i386/xen/Kconfig
@@ -0,0 +1,10 @@
+#
+# This Kconfig describes xen options
+#
+
+config XEN
+	bool "Enable support for Xen hypervisor"
+	depends on PARAVIRT && HZ_100 && !PREEMPT && !NO_HZ
+	default y
+	help
+	  This is the Linux Xen port.

-- 
