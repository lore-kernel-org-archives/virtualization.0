From: Pawel Moll <pawel.moll@arm.com>
Subject: [PATCH v2] virtio-mmio: Devices parameter parsing
Date: Thu, 17 Nov 2011 12:42:12 +0000
Message-ID: <1321533732-22983-1-git-send-email-pawel.moll@arm.com>
References: <1321467222.3137.417.camel@hornet.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1321467222.3137.417.camel@hornet.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch adds an option to instantiate guest virtio-mmio devices
basing on a kernel command line (or module) parameter, for example:

	virtio_mmio.devices=3D0x100@0x100b0000:48,1K@0x1001e000:74

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/virtio/Kconfig       |   31 +++++++
 drivers/virtio/virtio_mmio.c |  181 ++++++++++++++++++++++++++++++++++++++=
+++-
 2 files changed, 211 insertions(+), 1 deletions(-)

Hi Rusty,

This version adds the "first_id" parameter I mentioned yesterday,
but still using single charp parameter instead of the _cb version.
And unless you are really (_really_) against it, I'd rather see
this variant.

Cheers!

Pawe=C5=82

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 816ed08..00f2c82 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -46,4 +46,35 @@ config VIRTIO_BALLOON
 =

  	 If unsure, say N.
 =

+config VIRTIO_MMIO_CMDLINE_DEVICES
+	bool "Memory mapped virtio devices parameter parsing"
+	depends on VIRTIO_MMIO
+	---help---
+	 Allow virtio-mmio devices instantiation via the kernel command line
+	 or module parameter. Be aware that using incorrect parameters (base
+	 address in particular) can crash your system - you have been warned.
+
+	 The format for the parameter is as follows:
+
+		[virtio_mmio.]devices=3D<device>[<delim><device>]
+
+	 where:
+		<device>   :=3D <size>@<baseaddr>:<irq>
+		<delim>    :=3D ',' or ';'
+		<size>     :=3D size (can use standard suffixes like K or M)
+		<baseaddr> :=3D physical base address
+		<irq>      :=3D interrupt number (as passed to request_irq())
+
+	 Example kernel command line parameter:
+
+		virtio_mmio.devices=3D0x100@0x100b0000:48,1K@0x1001e000:74
+
+	 This will register platform devices virtio_mmio.<id>, where <id>
+	 values are consecutive integer numbers starting from 0 by default.
+	 The first id value can be changed with "first_id" parameter:
+
+	 	[virtio_mmio.]first_id=3D<id>
+
+	 If unsure, say 'N'.
+
 endmenu
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index acc5e43..05b39c1 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -6,6 +6,55 @@
  * This module allows virtio devices to be used over a virtual, memory map=
ped
  * platform device.
  *
+ * The guest device(s) may be instantiated in one of three equivalent ways:
+ *
+ * 1. Static platform device in board's code, eg.:
+ *
+ *	static struct platform_device v2m_virtio_device =3D {
+ *		.name =3D "virtio-mmio",
+ *		.id =3D -1,
+ *		.num_resources =3D 2,
+ *		.resource =3D (struct resource []) {
+ *			{
+ *				.start =3D 0x1001e000,
+ *				.end =3D 0x1001e0ff,
+ *				.flags =3D IORESOURCE_MEM,
+ *			}, {
+ *				.start =3D 42 + 32,
+ *				.end =3D 42 + 32,
+ *				.flags =3D IORESOURCE_IRQ,
+ *			},
+ *		}
+ *	};
+ *
+ * 2. Device Tree node, eg.:
+ *
+ *		virtio_block@1e000 {
+ *			compatible =3D "virtio,mmio";
+ *			reg =3D <0x1e000 0x100>;
+ *			interrupts =3D <42>;
+ *		}
+ *
+ * 3. Kernel module (or command line) parameter:
+ *
+ *		[virtio_mmio.]devices=3D<device>[<delim><device>]
+ *    where:
+ *		<device>   :=3D <size>@<baseaddr>:<irq>
+ *		<delim>    :=3D ',' or ';'
+ *		<size>     :=3D size (can use standard suffixes like K or M)
+ *		<baseaddr> :=3D physical base address
+ *		<irq>      :=3D interrupt number (as passed to request_irq())
+ *    eg.:
+ *		virtio_mmio.devices=3D0x100@0x100b0000:48,1K@0x1001e000:74
+ *
+ *    This will register platform devices virtio_mmio.<id>, where <id>
+ *    values are consecutive integer numbers starting from 0 by default.
+ *    The first id value can be changed with "first_id" parameter:
+ *
+ *		[virtio_mmio.]first_id=3D<id>
+ *
+ *
+ *
  * Registers layout (all 32-bit wide):
  *
  * offset d. name             description
@@ -42,6 +91,8 @@
  * See the COPYING file in the top-level directory.
  */
 =

+#define pr_fmt(fmt) "virtio-mmio: " fmt
+
 #include <linux/highmem.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -443,6 +494,130 @@ static int __devexit virtio_mmio_remove(struct platfo=
rm_device *pdev)
 =

 =

 =

+/* Devices list parameter */
+
+#if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)
+
+static char *virtio_mmio_cmdline_devices;
+module_param_named(devices, virtio_mmio_cmdline_devices, charp, 0);
+
+static int virtio_mmio_cmdline_id;
+module_param_named(first_id, virtio_mmio_cmdline_id, int, 0);
+
+static struct device virtio_mmio_cmdline_parent =3D {
+	.init_name =3D "virtio-mmio-cmdline",
+};
+
+static int virtio_mmio_register_cmdline_devices(void)
+{
+	int err;
+	char *device;
+	char *token =3D NULL;
+
+	err =3D device_register(&virtio_mmio_cmdline_parent);
+	if (err) {
+		pr_err("Failed to register %s!\n",
+				virtio_mmio_cmdline_parent.init_name);
+		return err;
+	}
+
+	/* Split colon-or-semicolon-separated devices */
+	while ((device =3D strsep(&virtio_mmio_cmdline_devices, ",;")) !=3D NULL)=
 {
+		struct resource resources[] =3D {
+			{
+				.flags =3D IORESOURCE_IRQ,
+			}, {
+				.flags =3D IORESOURCE_MEM,
+			}
+		};
+		char *size, *base;
+		unsigned long long val;
+
+		if (!*device)
+			continue;
+
+		kfree(token);
+		token =3D kstrdup(device, GFP_KERNEL);
+
+		/* Split memory and IRQ resources */
+		base =3D strsep(&token, ":");
+		if (base =3D=3D token || !token || !*token) {
+			pr_err("No IRQ in '%s'!\n", device);
+			continue;
+		}
+
+		/* Get IRQ */
+		if (kstrtoull(token, 0, &val) !=3D 0) {
+			pr_err("Wrong IRQ in '%s'!\n", device);
+			continue;
+		}
+		resources[0].start =3D val;
+		resources[0].end =3D val;
+
+		/* Split base address and size */
+		size =3D strsep(&base, "@");
+		if (size =3D=3D base || !base || !*base) {
+			pr_err("No base in '%s'!\n", device);
+			continue;
+		}
+
+		/* Get base address */
+		if (kstrtoull(base, 0, &val) !=3D 0) {
+			pr_err("Wrong base in '%s'!\n", device);
+			continue;
+		}
+		resources[1].start =3D val;
+		resources[1].end =3D val;
+
+		/* Get size */
+		resources[1].end +=3D memparse(size, &token) - 1;
+		if (size =3D=3D token || *token) {
+			pr_err("Wrong size in '%s'!\n", device);
+			continue;
+		}
+
+		pr_info("Registering device %d at 0x%x-0x%x, IRQ %u.\n",
+				virtio_mmio_cmdline_id, resources[1].start,
+				resources[1].end, resources[0].start);
+
+		platform_device_register_resndata(&virtio_mmio_cmdline_parent,
+				"virtio-mmio", virtio_mmio_cmdline_id++,
+				resources, ARRAY_SIZE(resources), NULL, 0);
+	}
+
+	kfree(token);
+
+	return 0;
+}
+
+static int virtio_mmio_unregister_cmdline_device(struct device *dev,
+		void *data)
+{
+	platform_device_unregister(to_platform_device(dev));
+
+	return 0;
+}
+
+static void virtio_mmio_unregister_cmdline_devices(void)
+{
+	device_for_each_child(&virtio_mmio_cmdline_parent, NULL,
+			virtio_mmio_unregister_cmdline_device);
+	device_unregister(&virtio_mmio_cmdline_parent);
+}
+
+#else
+
+static int virtio_mmio_register_cmdline_devices(void)
+{
+	return 0;
+}
+
+static void virtio_mmio_unregister_cmdline_devices(void)
+{
+}
+
+#endif
+
 /* Platform driver */
 =

 static struct of_device_id virtio_mmio_match[] =3D {
@@ -463,11 +638,15 @@ static struct platform_driver virtio_mmio_driver =3D {
 =

 static int __init virtio_mmio_init(void)
 {
-	return platform_driver_register(&virtio_mmio_driver);
+	int err =3D virtio_mmio_register_cmdline_devices();
+
+	return err ? err : platform_driver_register(&virtio_mmio_driver);
 }
 =

 static void __exit virtio_mmio_exit(void)
 {
+	virtio_mmio_unregister_cmdline_devices();
+
 	platform_driver_unregister(&virtio_mmio_driver);
 }
 =

-- =

1.6.3.3
