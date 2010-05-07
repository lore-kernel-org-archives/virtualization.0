From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: Patch to auto-load MSFT PV NIC driver
Date: Fri, 07 May 2010 17:52:17 -0600
Message-ID: <4BE453510200003000084906@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartC1EB63A1.0__="
Return-path: <devel-bounces@linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

--=__PartC1EB63A1.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I am attaching a patch to auto-load hv_netvsc.

Regards,

K. Y




--=__PartC1EB63A1.0__=
Content-Type: text/plain; name="hv_netvsc_autoload.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hv_netvsc_autoload.patch"

From: K. Y. Srinivasan <ksrinivasan@novell.com>=0ASubject: Auto-load the =
hyperV PV net driver. =0AReferences: None=0APatch-mainline:=0A=0ASigned-off=
-by: K. Y. Srinivasan <ksrinivasan@novell.com>=0A=0AIndex: linux/drivers/st=
aging/hv/netvsc_drv.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0A--- linux.orig/drivers/staging/hv/netvsc_drv.c	2010-05-07 =
15:29:32.000000000 -0600=0A+++ linux/drivers/staging/hv/netvsc_drv.c	=
2010-05-07 15:30:00.000000000 -0600=0A@@ -29,6 +29,8 @@=0A #include =
<linux/etherdevice.h>=0A #include <linux/skbuff.h>=0A #include <linux/in.h>=
=0A+#include <linux/dmi.h>=0A+#include <linux/pci.h>=0A #include <net/arp.h=
>=0A #include <net/route.h>=0A #include <net/sock.h>=0A@@ -592,6 +594,20 =
@@ static int netvsc_drv_init(int (*drv_ini=0A 	return ret;=0A }=0A =
=0A+static const struct dmi_system_id __initconst=0A+hv_netvsc_dmi_table[] =
__maybe_unused  =3D {=0A+	{=0A+		.ident =3D "Hyper-V",=0A+	=
	.matches =3D {=0A+			DMI_MATCH(DMI_SYS_VENDOR, =
"Microsoft Corporation"),=0A+			DMI_MATCH(DMI_PRODUCT_NAME,=
 "Virtual Machine"),=0A+			DMI_MATCH(DMI_BOARD_NAME, =
"Virtual Machine"),=0A+		},=0A+	},=0A+	{ },=0A+};=0A+MODULE_DEVICE=
_TABLE(dmi, hv_netvsc_dmi_table);=0A+=0A static int __init netvsc_init(void=
)=0A {=0A 	int ret;=0A@@ -599,6 +615,9 @@ static int __init netvsc_ini=
t(void)=0A 	DPRINT_ENTER(NETVSC_DRV);=0A 	DPRINT_INFO(NETVSC_DRV, =
"Netvsc initializing....");=0A =0A+	if (!dmi_check_system(hv_netvsc_dmi=
_table))=0A+		return -ENODEV;=0A+=0A 	ret =3D netvsc_drv_init(Net=
VscInitialize);=0A =0A 	DPRINT_EXIT(NETVSC_DRV);=0A@@ -613,6 +632,13 @@ =
static void __exit netvsc_exit(void)=0A 	DPRINT_EXIT(NETVSC_DRV);=0A=
 }=0A =0A+static const struct pci_device_id __initconst=0A+hv_netvsc_pci_ta=
ble[] __maybe_unused =3D {=0A+	{ PCI_DEVICE(0x1414, 0x5353) }, /* VGA =
compatible controller */=0A+	{ 0 }=0A+};=0A+MODULE_DEVICE_TABLE(pci, =
hv_netvsc_pci_table);=0A+=0A module_param(netvsc_ringbuffer_size, int, =
S_IRUGO);=0A =0A module_init(netvsc_init);=0A
--=__PartC1EB63A1.0__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/devel

--=__PartC1EB63A1.0__=--
