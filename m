From: rusty@rustcorp.com.au
Subject: [patch 03/43] lguest: Normalize config options for guest support
Date: Wed, 26 Sep 2007 16:36:21 +1000
Message-ID: <20070926063645.457927224@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=lguest-Kconfig-options.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: Chris Wright <chrisw@sous-sol.org>, Zach Amsden <zamsden@vmware.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

1) Group all the "guest OS" support options together, under a PARAVIRT_GUEST
   menu.
2) Make those options select CONFIG_PARAVIRT, as suggested by Andi.
3) Make kconfig help titles consistent.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>
Cc: Zach Amsden <zamsden@vmware.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/Kconfig      |   38 ++++++++++++++++++++++++++++----------
 arch/i386/xen/Kconfig  |    5 +++--
 drivers/lguest/Kconfig |    3 +--
 3 files changed, 32 insertions(+), 14 deletions(-)

===================================================================
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -215,27 +215,45 @@ endchoice
 endchoice
 
 config PARAVIRT
-	bool "Paravirtualization support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL
+	bool
 	depends on !(X86_VISWS || X86_VOYAGER)
 	help
-	  Paravirtualization is a way of running multiple instances of
-	  Linux on the same machine, under a hypervisor.  This option
-	  changes the kernel so it can modify itself when it is run
-	  under a hypervisor, improving performance significantly.
-	  However, when run without a hypervisor the kernel is
-	  theoretically slower.  If in doubt, say N.
+	  This changes the kernel so it can modify itself when it is run
+	  under a hypervisor, potentially improving performance significantly
+	  over full virtualization.  However, when run without a hypervisor
+	  the kernel is theoretically slower and slightly larger.
+
+menuconfig PARAVIRT_GUEST
+	bool "Paravirtualized guest support"
+	help
+	  Say Y here to get to see options related to running Linux under
+	  various hypervisors.  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if PARAVIRT_GUEST
 
 source "arch/i386/xen/Kconfig"
 
 config VMI
-	bool "VMI Paravirt-ops support"
-	depends on PARAVIRT
+	bool "VMI Guest support"
+	select PARAVIRT
+	depends on !(X86_VISWS || X86_VOYAGER)
 	help
 	  VMI provides a paravirtualized interface to the VMware ESX server
 	  (it could be used by other hypervisors in theory too, but is not
 	  at the moment), by linking the kernel to a GPL-ed ROM module
 	  provided by the hypervisor.
+
+config LGUEST_GUEST
+	bool "Lguest guest support"
+	select PARAVIRT
+	depends on !X86_PAE
+	help
+	  Lguest is a tiny in-kernel hypervisor.  Selecting this will
+	  allow your kernel to boot under lguest.  This option will increase
+	  your kernel size by about 6k.  If in doubt, say N.
+endif
 
 config ACPI_SRAT
 	bool
===================================================================
--- a/arch/i386/xen/Kconfig
+++ b/arch/i386/xen/Kconfig
@@ -3,8 +3,9 @@
 #
 
 config XEN
-	bool "Enable support for Xen hypervisor"
-	depends on PARAVIRT && X86_CMPXCHG && X86_TSC && !NEED_MULTIPLE_NODES
+	bool "Xen guest support"
+	select PARAVIRT
+	depends on X86_CMPXCHG && X86_TSC && !NEED_MULTIPLE_NODES && !(X86_VISWS || X86_VOYAGER)
 	help
 	  This is the Linux Xen port.  Enabling this will allow the
 	  kernel to boot in a paravirtualized environment under the
===================================================================
--- a/drivers/lguest/Kconfig
+++ b/drivers/lguest/Kconfig
@@ -1,7 +1,6 @@ config LGUEST
 config LGUEST
 	tristate "Linux hypervisor example code"
-	depends on X86 && PARAVIRT && EXPERIMENTAL && !X86_PAE && FUTEX
-	select LGUEST_GUEST
+	depends on X86 && EXPERIMENTAL && !X86_PAE && FUTEX && !(X86_VISWS || X86_VOYAGER)
 	select HVC_DRIVER
 	---help---
 	  This is a very simple module which allows you to run

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
