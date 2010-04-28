From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: A Clock source for HyperV
Date: Wed, 28 Apr 2010 14:45:08 -0600
Message-ID: <4BD859DD.E57C.0030.1@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Greg KH <gregkh@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

This is a resend of a patch I posted couple of weeks ago. This patch implements a clocksource for HyperV. This patch depends on the HyperV detection patch I had posted earler.


From: K. Y. Srinivasan <ksrinivasan@novell.com>
Subject:  A clocksource for Linux guests hosted on HyperV.
References: None
Patch-mainline: 

This patch is a clocksource implementation suitable for guests hosted on HyperV.
Time keeping in Linux guests hosted on HyperV is unstable. This clocksource 
driver fixes the problem. 

Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>

Index: linux-2.6.34-rc4/drivers/staging/hv/hv_timesource.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.34-rc4/drivers/staging/hv/hv_timesource.c	2010-04-15 13:45:46.000000000 -0600
@@ -0,0 +1,97 @@
+/*
+ * A clocksource for Linux running on HyperV.
+ *
+ *
+ * Copyright (C) 2010, Novell, Inc.
+ * Author : K. Y. Srinivasan <ksrinivasan@novell.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
+ *
+ */
+
+#include <linux/version.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/dmi.h>
+#include <asm/hyperv.h>
+
+#define HV_CLOCK_SHIFT	22
+
+static cycle_t read_hv_clock(struct clocksource *arg)
+{
+	cycle_t current_tick;
+	/*
+	 * Read the partition counter to get the current tick count. This count
+	 * is set to 0 when the partition is created and is incremented in
+	 * 100 nanosecond units.
+	 */
+	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
+	return current_tick;
+}
+
+static struct clocksource hyperv_cs = {
+	.name           = "hyperv_clocksource",
+	.rating         = 400, /* use this when running on Hyperv*/
+	.read           = read_hv_clock,
+	.mask           = CLOCKSOURCE_MASK(64),
+	/*
+	 * The time ref counter in HyperV is in 100ns units.
+	 * The definition of mult is:
+	 * mult/2^shift = ns/cyc = 100
+	 * mult = (100 << shift)
+	 */
+	.mult           = (100 << HV_CLOCK_SHIFT),
+	.shift          = HV_CLOCK_SHIFT,
+};
+
+static const struct dmi_system_id __initconst
+hv_timesource_dmi_table[] __maybe_unused  = {
+	{
+		.ident = "Hyper-V",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
+			DMI_MATCH(DMI_BOARD_NAME, "Virtual Machine"),
+		},
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(dmi, hv_timesource_dmi_table);
+
+static const struct pci_device_id __initconst
+hv_timesource_pci_table[] __maybe_unused = {
+	{ PCI_DEVICE(0x1414, 0x5353) }, /* VGA compatible controller */
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, hv_timesource_pci_table);
+
+
+static int __init init_hv_clocksource(void)
+{
+	if ((boot_cpu_data.x86_hyper_vendor != X86_HYPER_VENDOR_MSFT) ||
+		!(boot_cpu_data.x86_hyper_features &
+		HV_X64_MSR_TIME_REF_COUNT_AVAILABLE))
+		return -ENODEV;
+	printk(KERN_INFO "Registering HyperV clock source\n");
+	return clocksource_register(&hyperv_cs);
+}
+
+module_init(init_hv_clocksource);
+MODULE_DESCRIPTION("HyperV based clocksource");
+MODULE_AUTHOR("K. Y. Srinivasan <ksrinivasan@novell.com>");
+MODULE_LICENSE("GPL");
Index: linux-2.6.34-rc4/drivers/staging/hv/Makefile
===================================================================
--- linux-2.6.34-rc4.orig/drivers/staging/hv/Makefile	2010-04-12 19:41:35.000000000 -0600
+++ linux-2.6.34-rc4/drivers/staging/hv/Makefile	2010-04-15 13:09:07.000000000 -0600
@@ -1,4 +1,4 @@
-obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
+obj-$(CONFIG_HYPERV)		+= hv_vmbus.o hv_timesource.o
 obj-$(CONFIG_HYPERV_STORAGE)	+= hv_storvsc.o
 obj-$(CONFIG_HYPERV_BLOCK)	+= hv_blkvsc.o
 obj-$(CONFIG_HYPERV_NET)	+= hv_netvsc.o
