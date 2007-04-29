From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 09/32] xen: xen configuration
Date: Sun, 29 Apr 2007 10:28:44 -0700
Message-ID: <20070429172912.297678000@goop.org>
References: <20070429172835.284784000@goop.org>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=xen-config.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Put config options for Xen after the core pieces are in place.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>

---
 arch/i386/Kconfig     |    2 ++
 arch/i386/xen/Kconfig |   12 ++++++++++++
 2 files changed, 14 insertions(+)

===================================================================
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -217,6 +217,8 @@ config PARAVIRT
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
@@ -0,0 +1,12 @@
+#
+# This Kconfig describes xen options
+#
+
+config XEN
+	bool "Enable support for Xen hypervisor"
+	depends on PARAVIRT && !PREEMPT && !SMP
+	default y
+	help
+	  This is the Linux Xen port.  Enabling this will allow the
+	  kernel to boot in a paravirtualized environment under the
+	  Xen hypervisor.

-- 
