From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 13/20] XEN-paravirt: Xen: Add config options and disable unsupported config options.
Date: Fri, 12 Jan 2007 17:45:52 -0800
Message-ID: <20070113014648.416236390@goop.org>
References: <20070113014539.408244126@goop.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422810AbXAMXMM@vger.kernel.org>
Content-Disposition: inline; filename=xen-config.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>, Chris Wright <chrisw@sous-sol.org>
List-Id: virtualization@lists.linuxfoundation.org

The XEN config option enables the Xen paravirt_ops interface, which is
installed when the kernel finds itself running under Xen. (By some
as-yet fully defined mechanism, implemented in a future patch.)

Xen is no longer a sub-architecture, so the X86_XEN subarch config
option has gone.

The disabled config options are:
- PREEMPT: Xen doesn't support it
- HZ: set to 100Hz for now, to cut down on VCPU context switch rate.
  This will be adapted to use tickless later.
- kexec: not yet supported

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/i386/Kconfig              |    8 +++++---
 arch/i386/Kconfig.debug        |    1 +
 arch/i386/paravirt-xen/Kconfig |   17 +++++++++++++++++
 kernel/Kconfig.hz              |    4 ++--
 kernel/Kconfig.preempt         |    1 +
 5 files changed, 26 insertions(+), 5 deletions(-)

===================================================================
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -192,6 +192,8 @@ config PARAVIRT
 	  under a hypervisor, improving performance significantly.
 	  However, when run without a hypervisor the kernel is
 	  theoretically slower.  If in doubt, say N.
+
+source "arch/i386/paravirt-xen/Kconfig"
 
 config ACPI_SRAT
 	bool
@@ -298,12 +300,12 @@ config X86_UP_IOAPIC
 
 config X86_LOCAL_APIC
 	bool
-	depends on X86_UP_APIC || ((X86_VISWS || SMP) && !X86_VOYAGER) || X86_GENERICARCH
+	depends on X86_UP_APIC || (((X86_VISWS || SMP) && !X86_VOYAGER) || X86_GENERICARCH)
 	default y
 
 config X86_IO_APIC
 	bool
-	depends on X86_UP_IOAPIC || (SMP && !(X86_VISWS || X86_VOYAGER)) || X86_GENERICARCH
+	depends on X86_UP_IOAPIC || ((SMP && !(X86_VISWS || X86_VOYAGER)) || X86_GENERICARCH)
 	default y
 
 config X86_VISWS_APIC
@@ -743,6 +745,7 @@ source kernel/Kconfig.hz
 
 config KEXEC
 	bool "kexec system call"
+	depends on !XEN
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
===================================================================
--- a/arch/i386/Kconfig.debug
+++ b/arch/i386/Kconfig.debug
@@ -79,6 +79,7 @@ config DOUBLEFAULT
 config DOUBLEFAULT
 	default y
 	bool "Enable doublefault exception handler" if EMBEDDED
+	depends on !XEN
 	help
           This option allows trapping of rare doublefault exceptions that
           would otherwise cause a system to silently reboot. Disabling this
===================================================================
--- /dev/null
+++ b/arch/i386/paravirt-xen/Kconfig
@@ -0,0 +1,10 @@
+#
+# This Kconfig describes xen options
+#
+
+config XEN
+	bool "Enable support for Xen hypervisor"
+	depends PARAVIRT
+	default y
+	help
+	  This is the Linux Xen port.
===================================================================
--- a/kernel/Kconfig.hz
+++ b/kernel/Kconfig.hz
@@ -3,7 +3,7 @@
 #
 
 choice
-	prompt "Timer frequency"
+	prompt "Timer frequency" if !XEN
 	default HZ_250
 	help
 	 Allows the configuration of the timer frequency. It is customary
@@ -49,7 +49,7 @@ endchoice
 
 config HZ
 	int
-	default 100 if HZ_100
+	default 100 if HZ_100 || XEN
 	default 250 if HZ_250
 	default 300 if HZ_300
 	default 1000 if HZ_1000
===================================================================
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -35,6 +35,7 @@ config PREEMPT_VOLUNTARY
 
 config PREEMPT
 	bool "Preemptible Kernel (Low-Latency Desktop)"
+	depends on !XEN
 	help
 	  This option reduces the latency of the kernel by making
 	  all kernel code (that is not executing in a critical section)

-- 
