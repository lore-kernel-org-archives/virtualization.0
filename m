From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH PV_OPS X86_64 15/17] paravirt_op - kconfig
Date: Thu, 08 Mar 2007 01:02:35 -0500
Message-ID: <1173333755.25848.16.camel@localhost.localdomain>
References: <20070308054422.820010000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Glauber de Oliveira Costa <gcosta@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (xx-paravirt-kconfig.patch)
Add the config options for paravirt_ops and x86_64

Signed-off-by: Steven Rostedt srostedt@redhat.com
Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>


Index: clean-start/arch/x86_64/Kconfig.debug
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/Kconfig.debug
+++ clean-start/arch/x86_64/Kconfig.debug
@@ -55,6 +55,17 @@ config DEBUG_STACK_USAGE
 =

 	  This option will slow down process creation somewhat.
 =

+config DEBUG_PARAVIRT
+       bool "Enable some paravirtualization debugging"
+       default y
+       depends on PARAVIRT && DEBUG_KERNEL
+       help
+         Currently deliberately clobbers regs which are allowed to be
+         clobbered in inlined paravirt hooks, even in native mode.
+         If turning this off solves a problem, then DISABLE_INTERRUPTS() or
+         ENABLE_INTERRUPTS() is lying about what registers can be clobbere=
d.
+
+
 #config X86_REMOTE_DEBUG
 #       bool "kgdb debugging stub"
 =

Index: clean-start/arch/x86_64/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- clean-start.orig/arch/x86_64/Kconfig
+++ clean-start/arch/x86_64/Kconfig
@@ -349,6 +349,18 @@ config NODES_SHIFT
 =

 # Dummy CONFIG option to select ACPI_NUMA from drivers/acpi/Kconfig.
 =

+config PARAVIRT
+       bool "Paravirtualization support (EXPERIMENTAL)"
+       depends on EXPERIMENTAL
+       help
+         Paravirtualization is a way of running multiple instances of
+         Linux on the same machine, under a hypervisor.  This option
+         changes the kernel so it can modify itself when it is run
+         under a hypervisor, improving performance significantly.
+         However, when run without a hypervisor the kernel is
+         theoretically slower.  If in doubt, say N.
+
+
 config X86_64_ACPI_NUMA
        bool "ACPI NUMA detection"
        depends on NUMA

--
