From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/8] lguest: the Makefile and Kconfig
Date: Tue, 10 Apr 2007 21:08:05 +1000
Message-ID: <1176203285.26372.29.camel@localhost.localdomain>
References: <1176203068.26372.21.camel@localhost.localdomain>
	<1176203130.26372.23.camel@localhost.localdomain>
	<1176203176.26372.25.camel@localhost.localdomain>
	<1176203231.26372.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1176203231.26372.27.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andi Kleen <ak@muc.de>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is the Kconfig and Makefile to allow lguest to actually be
compiled.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/Kconfig         |    2 ++
 drivers/Makefile        |    1 +
 drivers/lguest/Kconfig  |   20 ++++++++++++++++++++
 drivers/lguest/Makefile |    7 +++++++
 4 files changed, 30 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -87,4 +87,6 @@ source "drivers/kvm/Kconfig"
 source "drivers/kvm/Kconfig"
 =

 source "drivers/uio/Kconfig"
+
+source "drivers/lguest/Kconfig"
 endmenu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -86,3 +86,4 @@ obj-$(CONFIG_HID)		+=3D hid/
 obj-$(CONFIG_HID)		+=3D hid/
 obj-$(CONFIG_PPC_PS3)		+=3D ps3/
 obj-$(CONFIG_SSB)		+=3D ssb/
+obj-$(CONFIG_LGUEST_GUEST)	+=3D lguest/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/lguest/Kconfig
@@ -0,0 +1,20 @@
+config LGUEST
+	tristate "Linux hypervisor example code"
+	depends on X86 && PARAVIRT && NET && EXPERIMENTAL && !X86_PAE
+	select LGUEST_GUEST
+	select HVC_DRIVER
+	---help---
+	  This is a very simple module which allows you to run
+	  multiple instances of the same Linux kernel, using the
+	  "lguest" command found in the Documentation/lguest directory.
+	  Note that "lguest" is pronounced to rhyme with "fell quest",
+	  not "rustyvisor".  See Documentation/lguest/lguest.txt.
+
+	  If unsure, say N.  If curious, say M.  If masochistic, say Y.
+
+config LGUEST_GUEST
+	bool
+	help
+	  The guest needs code built-in, even if the host has lguest
+	  support as a module.  The drivers are tiny, so we build them
+	  in too.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ b/drivers/lguest/Makefile
@@ -0,0 +1,7 @@
+# Guest requires the paravirt_ops replacement and the bus driver.
+obj-$(CONFIG_LGUEST_GUEST) +=3D lguest.o lguest_asm.o lguest_bus.o
+
+# Host requires the other files, which can be a module.
+obj-$(CONFIG_LGUEST)	+=3D lg.o
+lg-objs :=3D core.o hypercalls.o page_tables.o interrupts_and_traps.o \
+	segments.o io.o lguest_user.o switcher.o
