From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: Re: A clocksource driver for HyperV
Date: Wed, 07 Apr 2010 12:20:29 -0600
Message-ID: <4BBC788D0200003000082A39@sinclair.provo.novell.com>
References: <4BBC67980200003000082A15@sinclair.provo.novell.com>
	<4BBC788D0200003000082A39@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartAE8454FD.2__="
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
To: jeremy@goop.org
Cc: devel@driverdev.osuosl.org, Virtualization@lists.osdl.org, haiyangz@microsoft.com, gregkh@suse.de
List-Id: virtualization@lists.linuxfoundation.org

--=__PartAE8454FD.2__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



>>> On 4/5/2010 at  5:36 PM, in message <  4BBA57FB.2000406@goop.org  >, =
Jeremy
Fitzhardinge <  jeremy@goop.org  > wrote:=20
> On 04/05/2010 01:30 PM, Ky Srinivasan wrote:
>> +static cycle_t read_hv_clock(struct clocksource *arg)
>> +{
>> +	cycle_t current_tick;
>> +	/*
>> +	 * Read the partition counter to get the current tick count. This =
count
>> +	 * is set to 0 when the partition is created and is incremented in
>> +	 * 100 nanosecond units.
>> +	 */
>> +	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, current_tick);
>> +	return current_tick;
>> +}
>> +
>> +static struct clocksource clocksource_hyperv =3D {
>> +	.name           =3D "hyperv_clocksource",
>>   =20
>=20
> Seems like a redundantly long name; any use of this string is going =
to=20
> be in a context where it is obviously a clocksource.  How about just=20
> "hyperv"


>=20
>> +	.rating         =3D 400, /* use this when running on Hyperv*/
>> +	.read           =3D read_hv_clock,
>> +	.mask           =3D CLOCKSOURCE_MASK(64),
>> +	.shift          =3D HV_CLOCK_SHIFT,
>> +};
>> +
>> +static struct dmi_system_id __initconst
>> +hv_timesource_dmi_table[] __maybe_unused  =3D {
>> +	{
>> +		.ident =3D "Hyper-V",
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),=

>> +			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
>> +			DMI_MATCH(DMI_BOARD_NAME, "Virtual Machine"),
>> +		},
>> +	},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(dmi, hv_timesource_dmi_table);
>>   =20
>=20
> So you use the DMI signatures to determine whether the module is =
needed,=20
> but cpuid to work out if the feature is present?
>=20
>> +
>> +static struct pci_device_id __initconst
>> +hv_timesource_pci_table[] __maybe_unused =3D {
>> +	{ PCI_DEVICE(0x1414, 0x5353) }, /* VGA compatible controller */
>> +	{ 0 }
>> +};
>> +MODULE_DEVICE_TABLE(pci, hv_timesource_pci_table);
>>   =20
>=20
> And/or PCI?
>=20
> Seems a bit... ad-hoc?  Is this the official way to determine the=20
> presence of Hyper-V?

The presence of HyperV and our ability to use the partition-wide counter =
obviously is checked via probing the cpuid leaves. The DMI/PCI signatures =
are used in auto-loading these modules.
>=20
>> +
>> +
>> +static int __init hv_detect_hyperv(void)
>>   =20
>=20
> This looks generally useful.  Should it be hidden away in the=20
> clocksource driver, or in some common hyper-v code?  Do other hyper-v=20
> drivers have versions of this?
Good point. Right now, I can think of  multiple drivers replicating this =
code. We could include hyperV detection code in cpu/hypervisor.c . I will =
spin up a patch for doing that shortly.=20
>=20
>> +{
>> +	u32 eax, ebx, ecx, edx;
>> +	static char hyp_signature[20];
>>   =20
> 20?  static?
>=20
>> +
>> +	cpuid(1,&eax,&ebx,&ecx,&edx);
>> +	if (!(ecx&  HV_HYPERVISOR_PRESENT_BIT)) {
>> +		printk(KERN_WARNING
>> +			"Not on a Hypervisor\n");
>>   =20
> This just looks like noise, especially since it doesn't identify what =
is=20
> generating the message.  And if you compile this code in as =3Dy=20
> (non-modular) then it will complain every boot.
>=20
>> +		return 1;
>> +	}
>> +	cpuid(HV_CPUID_SIGNATURE,&eax,&ebx,&ecx,&edx);
>> +	*(u32 *)(hyp_signature + 0) =3D ebx;
>> +	*(u32 *)(hyp_signature + 4) =3D ecx;
>> +	*(u32 *)(hyp_signature + 8) =3D edx;
>> +	hyp_signature[12] =3D 0;
>> +
>> +	if ((eax<  HV_CPUID_MIN) || (strcmp("Microsoft Hv", hyp_signature))=
) {
>>   =20
>=20
> memcmp, surely?
>=20
>> +		printk(KERN_WARNING
>> +			"Not on HyperV; signature %s, eax %x\n",
>> +			hyp_signature, eax);
>> +		return 1;
>> +	}
>> +	/*
>> +	 * Extract the features, recommendations etc.
>> +	 */
>> +	cpuid(HV_CPUID_FEATURES,&eax,&ebx,&ecx,&edx);
>> +	if (!(eax&  0x10)) {
>> +		printk(KERN_WARNING "HyperV Time Ref Counter not available!=
\n");
>> +		return 1;
>> +	}
>> +
>> +	cpuid(HV_CPUID_RECOMMENDATIONS,&eax,&ebx,&ecx,&edx);
>> +	printk(KERN_INFO "HyperV recommendations: %x\n", eax);
>> +	printk(KERN_INFO "HyperV spin count: %x\n", ebx);
>> +	return 0;
>> +}
>> +
>> +
>> +static int __init init_hv_clocksource(void)
>> +{
>> +	if (hv_detect_hyperv())
>> +		return -ENODEV;


>> +	/*
>> +	 * The time ref counter in HyperV is in 100ns units.
>> +	 * The definition of mult is:
>> +	 * mult/2^shift =3D ns/cyc =3D 100
>> +	 * mult =3D (100<<  shift)
>> +	 */
>> +	clocksource_hyperv.mult =3D (100<<  HV_CLOCK_SHIFT);
>>   =20
>=20
> Why not initialize this in the structure?  It's just 100<<22 isn't it?
>=20
>> +	printk(KERN_INFO "Registering HyperV clock source\n");
>> +	return clocksource_register(&clocksource_hyperv);
>> +}
>> +
>> +module_init(init_hv_clocksource);
>> +MODULE_DESCRIPTION("HyperV based clocksource");
>> +MODULE_AUTHOR("K. Y. Srinivasan<  ksrinivasan@novell.com  >");
>> +MODULE_LICENSE("GPL");
>> Index: linux/drivers/staging/hv/Makefile
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux.orig/drivers/staging/hv/Makefile	2010-04-05 13:02:06.0000000=
00 -0600
>> +++ linux/drivers/staging/hv/Makefile	2010-04-05 13:02:13.0000000=
00 -0600
>> @@ -1,4 +1,4 @@
>> -obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o
>> +obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o hv_timesource.o
>>   obj-$(CONFIG_HYPERV_STORAGE)	+=3D hv_storvsc.o
>>   obj-$(CONFIG_HYPERV_BLOCK)	+=3D hv_blkvsc.o
>>   obj-$(CONFIG_HYPERV_NET)	+=3D hv_netvsc.o
>>   =20

Jeremy, thank you for your comments. I am attaching the next version of =
this patch that addresses the comments I have gotten thus far. =20

Regards,

K. Y=20


--=__PartAE8454FD.2__=
Content-Type: text/plain; name="hyperv_clocksource.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hyperv_clocksource.patch"

From: K. Y. Srinivasan <ksrinivasan@novell.com>=0ASubject:  A clocksource =
for Linux guests hosted on HyperV.=0AReferences: None=0APatch-mainline: =
=0A=0AThis patch is a clocksource implementation suitable for guests =
hosted on HyperV.=0ATime keeping in Linux guests hosted on HyperV is =
unstable. This clocksource =0Adriver fixes the problem. =0A=0ASigned-off-by=
: K. Y. Srinivasan <ksrinivasan@novell.com>=0A=0AIndex: linux/drivers/stagi=
ng/hv/hv_timesource.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0A--- /dev/null	1970-01-01 00:00:00.000000000 +0000=0A+++ =
linux/drivers/staging/hv/hv_timesource.c	2010-04-07 12:17:29.0000000=
00 -0600=0A@@ -0,0 +1,147 @@=0A+/*=0A+ * A clocksource for Linux running =
on HyperV.=0A+ *=0A+ *=0A+ * Copyright (C) 2010, Novell, Inc.=0A+ * Author =
: K. Y. Srinivasan <ksrinivasan@novell.com>=0A+ *=0A+ * This program is =
free software; you can redistribute it and/or modify=0A+ * it under the =
terms of the GNU General Public License as published by=0A+ * the Free =
Software Foundation; either version 2 of the License, or=0A+ * (at your =
option) any later version.=0A+ *=0A+ * This program is distributed in the =
hope that it will be useful, but=0A+ * WITHOUT ANY WARRANTY; without even =
the implied warranty of=0A+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR =
PURPOSE, GOOD TITLE or=0A+ * NON INFRINGEMENT.  See the GNU General Public =
License for more=0A+ * details.=0A+ *=0A+ * You should have received a =
copy of the GNU General Public License=0A+ * along with this program; if =
not, write to the Free Software=0A+ * Foundation, Inc., 51 Franklin St, =
Fifth Floor, Boston, MA 02110-1301 USA.=0A+ *=0A+ */=0A+=0A+#include =
<linux/version.h>=0A+#include <linux/clocksource.h>=0A+#include <linux/init=
.h>=0A+#include <linux/module.h>=0A+#include <linux/pci.h>=0A+#include =
<linux/dmi.h>=0A+=0A+#define HV_CLOCK_SHIFT	22=0A+/*=0A+ * HyperV =
defined synthetic CPUID leaves:=0A+ */=0A+#define HV_CPUID_SIGNATURE	=
0x40000000=0A+#define HV_CPUID_MIN		0x40000005=0A+#define =
HV_HYPERVISOR_PRESENT_BIT	0x80000000=0A+#define HV_CPUID_FEATURES	=
0x40000003=0A+#define HV_CPUID_RECOMMENDATIONS	0x40000004=0A+=0A+/*=0A+ * =
HyperV defined synthetic MSRs=0A+ */=0A+=0A+#define HV_X64_MSR_TIME_REF_COU=
NT	0x40000020=0A+=0A+=0A+static cycle_t read_hv_clock(struct =
clocksource *arg)=0A+{=0A+	cycle_t current_tick;=0A+	/*=0A+	 * =
Read the partition counter to get the current tick count. This count=0A+	=
 * is set to 0 when the partition is created and is incremented in=0A+	 * =
100 nanosecond units.=0A+	 */=0A+	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, =
current_tick);=0A+	return current_tick;=0A+}=0A+=0A+static struct =
clocksource hyperv_cs =3D {=0A+	.name           =3D "hyperv_clocksource",=
=0A+	.rating         =3D 400, /* use this when running on Hyperv*/=0A+	=
.read           =3D read_hv_clock,=0A+	.mask           =3D CLOCKSOURCE_MAS=
K(64),=0A+	/*=0A+	 * The time ref counter in HyperV is in 100ns =
units.=0A+	 * The definition of mult is:=0A+	 * mult/2^shift =
=3D ns/cyc =3D 100=0A+	 * mult =3D (100 << shift)=0A+	 */=0A+	.mult      =
     =3D (100 << HV_CLOCK_SHIFT),=0A+	.shift          =3D HV_CLOCK_SHIFT,=
=0A+};=0A+=0A+static const struct dmi_system_id __initconst=0A+hv_timesourc=
e_dmi_table[] __maybe_unused  =3D {=0A+	{=0A+		.ident =3D =
"Hyper-V",=0A+		.matches =3D {=0A+			DMI_MATCH(D=
MI_SYS_VENDOR, "Microsoft Corporation"),=0A+			DMI_MATCH(D=
MI_PRODUCT_NAME, "Virtual Machine"),=0A+			DMI_MATCH(D=
MI_BOARD_NAME, "Virtual Machine"),=0A+		},=0A+	},=0A+	{ =
},=0A+};=0A+MODULE_DEVICE_TABLE(dmi, hv_timesource_dmi_table);=0A+=0A+stati=
c const struct pci_device_id __initconst=0A+hv_timesource_pci_table[] =
__maybe_unused =3D {=0A+	{ PCI_DEVICE(0x1414, 0x5353) }, /* VGA =
compatible controller */=0A+	{ 0 }=0A+};=0A+MODULE_DEVICE_TABLE(pci, =
hv_timesource_pci_table);=0A+=0A+=0A+static int __init hv_detect_hyperv(voi=
d)=0A+{=0A+	u32 eax, ebx, ecx, edx;=0A+	char hyp_signature[20];=0A+=
=0A+	cpuid(1, &eax, &ebx, &ecx, &edx);=0A+=0A+	if (!(ecx & =
HV_HYPERVISOR_PRESENT_BIT))=0A+		return 1;=0A+=0A+	cpuid(HV_CP=
UID_SIGNATURE, &eax, &ebx, &ecx, &edx);=0A+	*(u32 *)(hyp_signature + =
0) =3D ebx;=0A+	*(u32 *)(hyp_signature + 4) =3D ecx;=0A+	*(u32 =
*)(hyp_signature + 8) =3D edx;=0A+=0A+	if ((eax < HV_CPUID_MIN) ||=0A+	   =
 (memcmp("Microsoft Hv", hyp_signature, 12))) {=0A+		printk(KERN=
_WARNING=0A+			"Not on HyperV; signature %s, eax =
%x\n",=0A+			hyp_signature, eax);=0A+		=
return 1;=0A+	}=0A+	/*=0A+	 * Extract the features, recommendations =
etc.=0A+	 */=0A+	cpuid(HV_CPUID_FEATURES, &eax, &ebx, &ecx, =
&edx);=0A+	if (!(eax & 0x10)) {=0A+		printk(KERN_WARNING=
 "HyperV Time Ref Counter not available!\n");=0A+		return =
1;=0A+	}=0A+=0A+	cpuid(HV_CPUID_RECOMMENDATIONS, &eax, &ebx, &ecx, =
&edx);=0A+	printk(KERN_INFO "HyperV recommendations: %x\n", eax);=0A+	=
printk(KERN_INFO "HyperV spin count: %x\n", ebx);=0A+	return 0;=0A+}=0A+=
=0A+=0A+static int __init init_hv_clocksource(void)=0A+{=0A+	if =
(hv_detect_hyperv())=0A+		return -ENODEV;=0A+	printk(KERN=
_INFO "Registering HyperV clock source\n");=0A+	return clocksource_register=
(&hyperv_cs);=0A+}=0A+=0A+module_init(init_hv_clocksource);=0A+MODULE_DESCR=
IPTION("HyperV based clocksource");=0A+MODULE_AUTHOR("K. Y. Srinivasan =
<ksrinivasan@novell.com>");=0A+MODULE_LICENSE("GPL");=0AIndex: linux/driver=
s/staging/hv/Makefile=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0A--- linux.orig/drivers/staging/hv/Makefile	2010-04-07 12:17:25.0000000=
00 -0600=0A+++ linux/drivers/staging/hv/Makefile	2010-04-07 =
12:17:29.000000000 -0600=0A@@ -1,4 +1,4 @@=0A-obj-$(CONFIG_HYPERV)		=
+=3D hv_vmbus.o=0A+obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o hv_timesour=
ce.o=0A obj-$(CONFIG_HYPERV_STORAGE)	+=3D hv_storvsc.o=0A obj-$(CONFIG_H=
YPERV_BLOCK)	+=3D hv_blkvsc.o=0A obj-$(CONFIG_HYPERV_NET)	+=3D =
hv_netvsc.o=0A
--=__PartAE8454FD.2__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--=__PartAE8454FD.2__=--
