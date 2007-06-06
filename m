From: Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: [PATCH] paravirt: helper to disable all IO space
Date: Tue, 05 Jun 2007 18:24:02 -0700
Message-ID: <46660CB2.60409@xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

In a virtual environment, device drivers such as legacy IDE will waste
quite a lot of time probing for their devices which will never appear.
This helper function allows a paravirt implementation to lay claim to
the whole iomem and ioport space, thereby disabling all device drivers
trying to claim IO resources.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>

diff -r 83c67f9402b5 arch/i386/kernel/paravirt.c
--- a/arch/i386/kernel/paravirt.c	Tue Jun 05 17:41:04 2007 -0700
+++ b/arch/i386/kernel/paravirt.c	Tue Jun 05 18:17:29 2007 -0700
@@ -227,6 +227,39 @@ static int __init print_banner(void)
 	return 0;
 }
 core_initcall(print_banner);
+
+static struct resource reserve_ioports = {
+	.start = 0,
+	.end = IO_SPACE_LIMIT,
+	.name = "paravirt-ioport",
+	.flags = IORESOURCE_IO | IORESOURCE_BUSY,
+};
+
+static struct resource reserve_iomem = {
+	.start = 0,
+	.end = -1,
+	.name = "paravirt-iomem",
+	.flags = IORESOURCE_MEM | IORESOURCE_BUSY,
+};
+
+/*
+ * Reserve the whole legacy IO space to prevent any legacy drivers
+ * from wasting time probing for their hardware.  This is a fairly
+ * brute-force approach to disabling all non-virtual drivers.
+ * 
+ * Note that this must be called very early to have any effect.
+ */
+int paravirt_disable_iospace(void)
+{
+	int ret = 0;
+
+	ret = request_resource(&ioport_resource, &reserve_ioports);
+	if (ret == 0)
+		ret = request_resource(&iomem_resource, &reserve_iomem);
+
+	return ret;
+}
+
 
 struct paravirt_ops paravirt_ops = {
 	.name = "bare hardware",
diff -r 83c67f9402b5 arch/i386/xen/setup.c
--- a/arch/i386/xen/setup.c	Tue Jun 05 17:41:04 2007 -0700
+++ b/arch/i386/xen/setup.c	Tue Jun 05 18:17:29 2007 -0700
@@ -8,12 +8,14 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
+#include <linux/ioport.h>
 
 #include <asm/elf.h>
 #include <asm/e820.h>
 #include <asm/setup.h>
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
+#include <asm/io.h>
 
 #include <xen/interface/physdev.h>
 #include <xen/features.h>
diff -r 83c67f9402b5 include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h	Tue Jun 05 17:41:04 2007 -0700
+++ b/include/asm-i386/paravirt.h	Tue Jun 05 18:17:29 2007 -0700
@@ -262,6 +262,7 @@ unsigned paravirt_patch_insns(void *site
 unsigned paravirt_patch_insns(void *site, unsigned len,
 			      const char *start, const char *end);
 
+int paravirt_disable_iospace(void);
 
 /*
  * This generates an indirect call based on the operation type number.
