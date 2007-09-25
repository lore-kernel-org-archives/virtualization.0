From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/3] Virtualization config cleanup: The real patch 1/3
Date: Tue, 25 Sep 2007 14:18:32 +1000
Message-ID: <1190693912.27805.289.camel__15060.9583048665$1190694055$gmane$org@localhost.localdomain>
References: <1190692688.27805.276.camel@localhost.localdomain>
	<1190692799.27805.279.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190692799.27805.279.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>, Adrian Bunk <bunk@stusta.de>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

OK, I screwed up and sent the old 1/3.  This was supposed to be 1/3, and
there is no 3.  I'm stupid.

Be nice to get acks from Jeremy and Zach as it's their original
penmanship.

Cheers,
Rusty.
---
Normalize config options for guest support

1) Group all the "guest OS" support options together, under a PARAVIRT_GUEST
   menu.
2) Make those options select CONFIG_PARAVIRT, as suggested by Andi.
3) Make kconfig help titles consistent.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/i386/Kconfig     |   33 ++++++++++++++++++++-------------
 arch/i386/xen/Kconfig |    1 +
 2 files changed, 21 insertions(+), 13 deletions(-)

diff -r 1c1fc74a471c arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Sep 25 14:05:39 2007 +1000
+++ b/arch/i386/Kconfig	Tue Sep 25 14:06:19 2007 +1000
@@ -215,27 +215,44 @@ endchoice
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
diff -r 1c1fc74a471c arch/i386/xen/Kconfig
--- a/arch/i386/xen/Kconfig	Tue Sep 25 14:05:39 2007 +1000
+++ b/arch/i386/xen/Kconfig	Tue Sep 25 14:06:19 2007 +1000
@@ -3,8 +3,9 @@
 #
 
 config XEN
-	bool "Enable support for Xen hypervisor"
-	depends on PARAVIRT && X86_CMPXCHG && X86_TSC && !NEED_MULTIPLE_NODES
+	bool "Xen guest support"
+	select PARAVIRT
+	depends on X86_CMPXCHG && X86_TSC && !NEED_MULTIPLE_NODES
 	help
 	  This is the Linux Xen port.  Enabling this will allow the
 	  kernel to boot in a paravirtualized environment under the
diff -r 1c1fc74a471c drivers/lguest/Kconfig
--- a/drivers/lguest/Kconfig	Tue Sep 25 14:05:39 2007 +1000
+++ b/drivers/lguest/Kconfig	Tue Sep 25 14:05:39 2007 +1000
@@ -1,23 +1,18 @@ config LGUEST
 config LGUEST
 	tristate "Linux hypervisor example code"
-	depends on X86 && PARAVIRT && EXPERIMENTAL && !X86_PAE && FUTEX
-	select LGUEST_GUEST
+	depends on X86 && EXPERIMENTAL && !X86_PAE && FUTEX
 	select HVC_DRIVER
 	---help---
-	  This is a very simple module which allows you to run
-	  multiple instances of the same Linux kernel, using the
+	  This is a very simple module called lg.ko which allows you to run
+	  multiple instances of the Linux kernel, using the
 	  "lguest" command found in the Documentation/lguest directory.
 	  Note that "lguest" is pronounced to rhyme with "fell quest",
 	  not "rustyvisor".  See Documentation/lguest/lguest.txt.
 
+	  Usually you would also turn on "Lguest guest support", to create a
+	  kernel which can also boot under lguest.
+
 	  If unsure, say N.  If curious, say M.  If masochistic, say Y.
-
-config LGUEST_GUEST
-	bool
-	help
-	  The guest needs code built-in, even if the host has lguest
-	  support as a module.  The drivers are tiny, so we build them
-	  in too.
 
 config LGUEST_NET
 	tristate
