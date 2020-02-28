From: Vivek Thampi <vithampi@vmware.com>
Subject: [PATCH RESEND] ptp: add VMware virtual PTP clock driver
Date: Fri, 28 Feb 2020 05:32:46 +0000
Message-ID: <20200228053230.GA457139@sc2-cpbu2-b0737.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
Content-Language: en-US
Content-ID: <3AA440F89217864C81B078A485FBE2A9@namprd05.prod.outlook.com>
Sender: netdev-owner@vger.kernel.org
To: Richard Cochran <richardcochran@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Pv-drivers <Pv-drivers@vmware.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>, Thomas Hellstrom <thellstrom@vmware.com>, Juergen Gross <jgross@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

Add a PTP clock driver called ptp_vmw, for guests running on VMware ESXi
hypervisor. The driver attaches to a VMware virtual device called
"precision clock" that provides a mechanism for querying host system time.
Similar to existing virtual PTP clock drivers (e.g. ptp_kvm), ptp_vmw
utilizes the kernel's PTP hardware clock API to implement a clock device
that can be used as a reference in Chrony for synchronizing guest time with
host.

The driver is only applicable to x86 guests running in VMware virtual
machines with precision clock virtual device present. It uses a VMware
specific hypercall mechanism to read time from the device.

Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Vivek Thampi <vithampi@vmware.com>
---
 Based on feedback, resending patch to include a broader audience.

 MAINTAINERS           |   7 +++
 drivers/ptp/Kconfig   |  12 +++++
 drivers/ptp/Makefile  |   1 +
 drivers/ptp/ptp_vmw.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 164 insertions(+)
 create mode 100644 drivers/ptp/ptp_vmw.c

diff --git a/MAINTAINERS b/MAINTAINERS
index fcd79fc..871bb39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17854,6 +17854,13 @@ S:	Supported
 F:	arch/x86/kernel/cpu/vmware.c
 F:	arch/x86/include/asm/vmware.h
=20
+VMWARE VIRTUAL PTP CLOCK DRIVER
+M:	Vivek Thampi <vithampi@vmware.com>
+M:	"VMware, Inc." <pv-drivers@vmware.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	drivers/ptp/ptp_vmw.c
+
 VMWARE PVRDMA DRIVER
 M:	Adit Ranadive <aditr@vmware.com>
 M:	VMware PV-Drivers <pv-drivers@vmware.com>
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 475c60d..7d7bb99 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -127,4 +127,16 @@ config PTP_1588_CLOCK_IDTCM
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_clockmatrix.
=20
+config PTP_1588_CLOCK_VMW
+	tristate "VMware virtual PTP clock"
+	depends on ACPI && HYPERVISOR_GUEST && X86
+	depends on PTP_1588_CLOCK
+	help
+	  This driver adds support for using VMware virtual precision
+	  clock device as a PTP clock. This is only useful in virtual
+	  machines running on VMware virtual infrastructure.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ptp_vmw.
+
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 8c83033..04b9acc 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_QORIQ)	+=3D ptp-qoriq.o
 ptp-qoriq-y				+=3D ptp_qoriq.o
 ptp-qoriq-$(CONFIG_DEBUG_FS)		+=3D ptp_qoriq_debugfs.o
 obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+=3D ptp_clockmatrix.o
+obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+=3D ptp_vmw.o
diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
new file mode 100644
index 0000000..5dca26e
--- /dev/null
+++ b/drivers/ptp/ptp_vmw.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Copyright (C) 2020 VMware, Inc., Palo Alto, CA., USA
+ *
+ * PTP clock driver for VMware precision clock virtual device.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/ptp_clock_kernel.h>
+#include <asm/hypervisor.h>
+#include <asm/vmware.h>
+
+#define VMWARE_MAGIC 0x564D5868
+#define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
+#define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
+
+static struct acpi_device *ptp_vmw_acpi_device;
+static struct ptp_clock *ptp_vmw_clock;
+
+
+static int ptp_vmw_pclk_read(u64 *ns)
+{
+	u32 ret, nsec_hi, nsec_lo, unused1, unused2, unused3;
+
+	asm volatile (VMWARE_HYPERCALL :
+		"=3Da"(ret), "=3Db"(nsec_hi), "=3Dc"(nsec_lo), "=3Dd"(unused1),
+		"=3DS"(unused2), "=3DD"(unused3) :
+		"a"(VMWARE_MAGIC), "b"(0),
+		"c"(VMWARE_CMD_PCLK_GETTIME), "d"(0) :
+		"memory");
+
+	if (ret =3D=3D 0)
+		*ns =3D ((u64)nsec_hi << 32) | nsec_lo;
+	return ret;
+}
+
+/*
+ * PTP clock ops.
+ */
+
+static int ptp_vmw_adjtime(struct ptp_clock_info *info, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ptp_vmw_adjfreq(struct ptp_clock_info *info, s32 delta)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ptp_vmw_gettime(struct ptp_clock_info *info, struct timespec64 =
*ts)
+{
+	u64 ns;
+
+	if (ptp_vmw_pclk_read(&ns) !=3D 0)
+		return -EIO;
+	*ts =3D ns_to_timespec64(ns);
+	return 0;
+}
+
+static int ptp_vmw_settime(struct ptp_clock_info *info,
+			  const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ptp_vmw_enable(struct ptp_clock_info *info,
+			 struct ptp_clock_request *request, int on)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct ptp_clock_info ptp_vmw_clock_info =3D {
+	.owner		=3D THIS_MODULE,
+	.name		=3D "ptp_vmw",
+	.max_adj	=3D 0,
+	.adjtime	=3D ptp_vmw_adjtime,
+	.adjfreq	=3D ptp_vmw_adjfreq,
+	.gettime64	=3D ptp_vmw_gettime,
+	.settime64	=3D ptp_vmw_settime,
+	.enable		=3D ptp_vmw_enable,
+};
+
+/*
+ * ACPI driver ops for VMware "precision clock" virtual device.
+ */
+
+static int ptp_vmw_acpi_add(struct acpi_device *device)
+{
+	ptp_vmw_clock =3D ptp_clock_register(&ptp_vmw_clock_info, NULL);
+	if (IS_ERR(ptp_vmw_clock)) {
+		pr_err("failed to register ptp clock\n");
+		return PTR_ERR(ptp_vmw_clock);
+	}
+
+	ptp_vmw_acpi_device =3D device;
+	return 0;
+}
+
+static int ptp_vmw_acpi_remove(struct acpi_device *device)
+{
+	ptp_clock_unregister(ptp_vmw_clock);
+	return 0;
+}
+
+static const struct acpi_device_id ptp_vmw_acpi_device_ids[] =3D {
+	{ "VMW0005", 0 },
+	{ "", 0 },
+};
+
+MODULE_DEVICE_TABLE(acpi, ptp_vmw_acpi_device_ids);
+
+static struct acpi_driver ptp_vmw_acpi_driver =3D {
+	.name =3D "ptp_vmw",
+	.ids =3D ptp_vmw_acpi_device_ids,
+	.ops =3D {
+		.add =3D ptp_vmw_acpi_add,
+		.remove	=3D ptp_vmw_acpi_remove
+	},
+	.owner	=3D THIS_MODULE
+};
+
+static int __init ptp_vmw_init(void)
+{
+	if (x86_hyper_type !=3D X86_HYPER_VMWARE)
+		return -1;
+	return acpi_bus_register_driver(&ptp_vmw_acpi_driver);
+}
+
+static void __exit ptp_vmw_exit(void)
+{
+	acpi_bus_unregister_driver(&ptp_vmw_acpi_driver);
+}
+
+module_init(ptp_vmw_init);
+module_exit(ptp_vmw_exit);
+
+MODULE_DESCRIPTION("VMware virtual PTP clock driver");
+MODULE_AUTHOR("VMware, Inc.");
+MODULE_LICENSE("Dual BSD/GPL");
--=20
1.8.5.6
