From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: Re: A clocksource driver for HyperV
Date: Thu, 15 Apr 2010 14:04:53 -0600
Message-ID: <4BC71D050200003000083226@sinclair.provo.novell.com>
References: <4BBC67980200003000082A15@sinclair.provo.novell.com>
	<4BBC789A0200003000082A41@sinclair.provo.novell.com>
	<4BBC789A0200003000082A41@sinclair.provo.novell.com>
	<4BBCDF93.9010305@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartE0CA6175.1__="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4BBCDF93.9010305@goop.org>
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
Cc: haiyangz@microsoft.com, gregkh@suse.de
List-Id: virtualization@lists.linuxfoundation.org

--=__PartE0CA6175.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jeremy,

As suggested by you, I am enclosing a patch that integrates HyperV =
detection with the  current hypervisor detection mechanism in the kernel. =
Also attached is a HyperV clocksource patch that uses this new functionalit=
y.

Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>








--=__PartE0CA6175.1__=
Content-Type: text/plain; name="hyperv_detection.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hyperv_detection.patch"

From: K. Y. Srinivasan <ksrinivasan@novell.com>=0ASubject:  HyperV =
Detection code.=0AReferences: None=0APatch-mainline:=0A=0AThis patch =
integrates HyperV detection within the framework currently used by=0AVmWare=
. With this patch, we can avoid having to replicate the HyperV detection=0A=
code in each of the HyperV specific Linux drivers - MSFT Linux Integration =
=0AComponents. =0A=0ASigned-off-by: K. Y. Srinivasan <ksrinivasan@novell.co=
m>=0A=0AIndex: linux-2.6.34-rc4/arch/x86/include/asm/processor.h=0A=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A--- linux-2.6.34-rc4.orig/a=
rch/x86/include/asm/processor.h	2010-04-12 19:41:35.000000000 -0600=0A+++ =
linux-2.6.34-rc4/arch/x86/include/asm/processor.h	2010-04-15 =
10:00:18.000000000 -0600=0A@@ -114,6 +114,8 @@ struct cpuinfo_x86 {=0A 	=
u16			cpu_index;=0A #endif=0A 	unsigned int		=
x86_hyper_vendor;=0A+	/* The layout of this field is hypervisor specific =
*/=0A+	unsigned int		x86_hyper_features;=0A } __attribute__((__a=
ligned__(SMP_CACHE_BYTES)));=0A =0A #define X86_VENDOR_INTEL	0=0A@@ =
-129,6 +131,7 @@ struct cpuinfo_x86 {=0A =0A #define X86_HYPER_VENDOR_NONE =
 0=0A #define X86_HYPER_VENDOR_VMWARE 1=0A+#define X86_HYPER_VENDOR_MSFT =
2=0A =0A /*=0A  * capabilities of CPUs=0AIndex: linux-2.6.34-rc4/arch/x86/k=
ernel/cpu/Makefile=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
--- linux-2.6.34-rc4.orig/arch/x86/kernel/cpu/Makefile	2010-04-12 =
19:41:35.000000000 -0600=0A+++ linux-2.6.34-rc4/arch/x86/kernel/cpu/Makefil=
e	2010-04-15 10:00:18.000000000 -0600=0A@@ -14,7 +14,7 @@ CFLAGS_comm=
on.o		:=3D $(nostackp)=0A =0A obj-y			:=3D =
intel_cacheinfo.o addon_cpuid_features.o=0A obj-y			=
+=3D proc.o capflags.o powerflags.o common.o=0A-obj-y			=
+=3D vmware.o hypervisor.o sched.o=0A+obj-y			+=3D =
vmware.o hypervisor.o sched.o hyperv.o=0A =0A obj-$(CONFIG_X86_32)	=
+=3D bugs.o cmpxchg.o=0A obj-$(CONFIG_X86_64)	+=3D bugs_64.o=0AIndex: =
linux-2.6.34-rc4/arch/x86/kernel/cpu/hyperv.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=0A--- /dev/null	1970-01-01 00:00:00.0000000=
00 +0000=0A+++ linux-2.6.34-rc4/arch/x86/kernel/cpu/hyperv.c	2010-04-15 =
10:00:18.000000000 -0600=0A@@ -0,0 +1,66 @@=0A+/*=0A+ * HyperV  Detection =
code.=0A+ *=0A+ * Copyright (C) 2010, Novell, Inc.=0A+ * Author : K. Y. =
Srinivasan <ksrinivasan@novell.com>=0A+ *=0A+ * This program is free =
software; you can redistribute it and/or modify=0A+ * it under the terms =
of the GNU General Public License as published by=0A+ * the Free Software =
Foundation; either version 2 of the License, or=0A+ * (at your option) any =
later version.=0A+ *=0A+ * This program is distributed in the hope that it =
will be useful, but=0A+ * WITHOUT ANY WARRANTY; without even the implied =
warranty of=0A+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, =
GOOD TITLE or=0A+ * NON INFRINGEMENT.  See the GNU General Public License =
for more=0A+ * details.=0A+ *=0A+ * You should have received a copy of the =
GNU General Public License=0A+ * along with this program; if not, write to =
the Free Software=0A+ * Foundation, Inc., 51 Franklin St, Fifth Floor, =
Boston, MA 02110-1301 USA.=0A+ *=0A+ */=0A+=0A+#include <linux/types.h>=0A+=
#include <asm/processor.h>=0A+#include <asm/hyperv.h>=0A+=0A+=0A+int =
hyperv_platform(void)=0A+{=0A+	u32 eax, ebx, ecx, edx;=0A+	char =
hyp_signature[13];=0A+=0A+	cpuid(1, &eax, &ebx, &ecx, &edx);=0A+	if =
(!(ecx & HYPERV_HYPERVISOR_PRESENT_BIT))=0A+		return 0;=0A+=0A+	=
cpuid(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS, &eax, &ebx, &ecx, &edx);=0A+	=
*(u32 *)(hyp_signature + 0) =3D ebx;=0A+	*(u32 *)(hyp_signature + =
4) =3D ecx;=0A+	*(u32 *)(hyp_signature + 8) =3D edx;=0A+=0A+	if ((eax < =
HYPERV_CPUID_MIN) || (memcmp("Microsoft Hv", hyp_signature, 12)))=0A+		=
return 0;=0A+	return 1;=0A+}=0A+=0A+void __cpuinit hyperv_set_feature_bit=
s(struct cpuinfo_x86 *c)=0A+{=0A+	u32 eax, ebx, ecx, edx;=0A+=0A+	=
c->x86_hyper_features =3D 0;=0A+	/*=0A+	 * Extract the features, =
recommendations etc.=0A+	 * The first 9 bits will be used to track =
hypervisor features.=0A+	 * The next 6 bits will be used to track =
the hypervisor=0A+	 * recommendations.=0A+	 */=0A+	cpuid(HYPERV_CPUID_=
FEATURES, &eax, &ebx, &ecx, &edx);=0A+	c->x86_hyper_features |=3D (eax & =
0x1ff);=0A+=0A+	cpuid(HYPERV_CPUID_ENLIGHTMENT_INFO, &eax, &ebx, &ecx, =
&edx);=0A+	c->x86_hyper_features |=3D ((eax & 0x3f) << 9);=0A+	=
printk(KERN_INFO "Detected HyperV with features: %x\n",=0A+		=
c->x86_hyper_features);=0A+}=0AIndex: linux-2.6.34-rc4/arch/x86/kernel/cpu/=
hypervisor.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A--- =
linux-2.6.34-rc4.orig/arch/x86/kernel/cpu/hypervisor.c	2010-04-12 =
19:41:35.000000000 -0600=0A+++ linux-2.6.34-rc4/arch/x86/kernel/cpu/hypervi=
sor.c	2010-04-15 10:00:18.000000000 -0600=0A@@ -23,6 +23,7 @@=0A =0A =
#include <asm/processor.h>=0A #include <asm/vmware.h>=0A+#include =
<asm/hyperv.h>=0A #include <asm/hypervisor.h>=0A =0A static inline void =
__cpuinit=0A@@ -30,6 +31,8 @@ detect_hypervisor_vendor(struct cpuinfo_=0A =
{=0A 	if (vmware_platform())=0A 		c->x86_hyper_vendor =3D =
X86_HYPER_VENDOR_VMWARE;=0A+	else if (hyperv_platform())=0A+		=
c->x86_hyper_vendor =3D X86_HYPER_VENDOR_MSFT;=0A 	else=0A 		=
c->x86_hyper_vendor =3D X86_HYPER_VENDOR_NONE;=0A }=0A@@ -37,10 +40,11 @@ =
detect_hypervisor_vendor(struct cpuinfo_=0A static inline void __cpuinit=0A=
 hypervisor_set_feature_bits(struct cpuinfo_x86 *c)=0A {=0A-	if =
(boot_cpu_data.x86_hyper_vendor =3D=3D X86_HYPER_VENDOR_VMWARE) {=0A+	if =
(boot_cpu_data.x86_hyper_vendor =3D=3D X86_HYPER_VENDOR_VMWARE)=0A 		=
vmware_set_feature_bits(c);=0A-		return;=0A-	}=0A+	else if =
(boot_cpu_data.x86_hyper_vendor =3D=3D X86_HYPER_VENDOR_MSFT)=0A+		=
hyperv_set_feature_bits(c);=0A+	return;=0A }=0A =0A void __cpuinit =
init_hypervisor(struct cpuinfo_x86 *c)=0AIndex: linux-2.6.34-rc4/arch/x86/i=
nclude/asm/hyperv.h=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0A--- linux-2.6.34-rc4.orig/arch/x86/include/asm/hyperv.h	2010-04-12 =
19:41:35.000000000 -0600=0A+++ linux-2.6.34-rc4/arch/x86/include/asm/hyperv=
.h	2010-04-15 13:06:58.000000000 -0600=0A@@ -2,6 +2,8 @@=0A #define =
_ASM_X86_KVM_HYPERV_H=0A =0A #include <linux/types.h>=0A+#include =
<linux/init.h>=0A+#include <asm/processor.h>=0A =0A /*=0A  * The below =
CPUID leaves are present if VersionAndFeatures.HypervisorPresent=0A@@ =
-14,6 +16,9 @@=0A #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004=
=0A #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005=0A =
=0A+#define HYPERV_HYPERVISOR_PRESENT_BIT		0x80000000=0A+#defi=
ne HYPERV_CPUID_MIN			0x40000005=0A+=0A /*=0A  * Feature =
identification. EAX indicates which features are available=0A  * to the =
partition based upon the current partition privileges.=0A@@ -129,6 +134,9 =
@@=0A /* MSR used to provide vcpu index */=0A #define HV_X64_MSR_VP_INDEX	=
		0x40000002=0A =0A+/* MSR used to read the per-partition =
time reference counter */=0A+#define HV_X64_MSR_TIME_REF_COUNT       =
0x40000020=0A+=0A /* Define the virtual APIC registers */=0A #define =
HV_X64_MSR_EOI				0x40000070=0A #define HV_X64_MSR_IC=
R				0x40000071=0A@@ -183,4 +191,6 @@=0A =
#define HV_STATUS_INVALID_HYPERCALL_INPUT	3=0A #define HV_STATUS_INVA=
LID_ALIGNMENT		4=0A =0A+int hyperv_platform(void);=0A+void =
__cpuinit hyperv_set_feature_bits(struct cpuinfo_x86 *c);=0A #endif=0A
--=__PartE0CA6175.1__=
Content-Type: text/plain; name="hyperv_clocksource.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="hyperv_clocksource.patch"

From: K. Y. Srinivasan <ksrinivasan@novell.com>=0ASubject:  A clocksource =
for Linux guests hosted on HyperV.=0AReferences: None=0APatch-mainline: =
=0A=0AThis patch is a clocksource implementation suitable for guests =
hosted on HyperV.=0ATime keeping in Linux guests hosted on HyperV is =
unstable. This clocksource =0Adriver fixes the problem. =0A=0ASigned-off-by=
: K. Y. Srinivasan <ksrinivasan@novell.com>=0A=0AIndex: linux-2.6.34-rc4/dr=
ivers/staging/hv/hv_timesource.c=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=0A--- /dev/null	1970-01-01 00:00:00.000000000 +0000=0A+++ =
linux-2.6.34-rc4/drivers/staging/hv/hv_timesource.c	2010-04-15 =
13:45:46.000000000 -0600=0A@@ -0,0 +1,97 @@=0A+/*=0A+ * A clocksource for =
Linux running on HyperV.=0A+ *=0A+ *=0A+ * Copyright (C) 2010, Novell, =
Inc.=0A+ * Author : K. Y. Srinivasan <ksrinivasan@novell.com>=0A+ *=0A+ * =
This program is free software; you can redistribute it and/or modify=0A+ * =
it under the terms of the GNU General Public License as published by=0A+ * =
the Free Software Foundation; either version 2 of the License, or=0A+ * =
(at your option) any later version.=0A+ *=0A+ * This program is distributed=
 in the hope that it will be useful, but=0A+ * WITHOUT ANY WARRANTY; =
without even the implied warranty of=0A+ * MERCHANTABILITY OR FITNESS FOR =
A PARTICULAR PURPOSE, GOOD TITLE or=0A+ * NON INFRINGEMENT.  See the GNU =
General Public License for more=0A+ * details.=0A+ *=0A+ * You should have =
received a copy of the GNU General Public License=0A+ * along with this =
program; if not, write to the Free Software=0A+ * Foundation, Inc., 51 =
Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.=0A+ *=0A+ */=0A+=0A+#i=
nclude <linux/version.h>=0A+#include <linux/clocksource.h>=0A+#include =
<linux/init.h>=0A+#include <linux/module.h>=0A+#include <linux/pci.h>=0A+#i=
nclude <linux/dmi.h>=0A+#include <asm/hyperv.h>=0A+=0A+#define HV_CLOCK_SHI=
FT	22=0A+=0A+static cycle_t read_hv_clock(struct clocksource =
*arg)=0A+{=0A+	cycle_t current_tick;=0A+	/*=0A+	 * Read the =
partition counter to get the current tick count. This count=0A+	 * is set =
to 0 when the partition is created and is incremented in=0A+	 * 100 =
nanosecond units.=0A+	 */=0A+	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, =
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
hv_timesource_pci_table);=0A+=0A+=0A+static int __init init_hv_clocksource(=
void)=0A+{=0A+	if ((boot_cpu_data.x86_hyper_vendor !=3D X86_HYPER_VENDOR_M=
SFT) ||=0A+		!(boot_cpu_data.x86_hyper_features &=0A+		=
HV_X64_MSR_TIME_REF_COUNT_AVAILABLE))=0A+		return -ENODEV;=0A+=
	printk(KERN_INFO "Registering HyperV clock source\n");=0A+	=
return clocksource_register(&hyperv_cs);=0A+}=0A+=0A+module_init(init_hv_cl=
ocksource);=0A+MODULE_DESCRIPTION("HyperV based clocksource");=0A+MODULE_AU=
THOR("K. Y. Srinivasan <ksrinivasan@novell.com>");=0A+MODULE_LICENSE("GPL")=
;=0AIndex: linux-2.6.34-rc4/drivers/staging/hv/Makefile=0A=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A--- linux-2.6.34-rc4.orig/drivers/st=
aging/hv/Makefile	2010-04-12 19:41:35.000000000 -0600=0A+++ =
linux-2.6.34-rc4/drivers/staging/hv/Makefile	2010-04-15 13:09:07.0000000=
00 -0600=0A@@ -1,4 +1,4 @@=0A-obj-$(CONFIG_HYPERV)		+=3D =
hv_vmbus.o=0A+obj-$(CONFIG_HYPERV)		+=3D hv_vmbus.o hv_timesour=
ce.o=0A obj-$(CONFIG_HYPERV_STORAGE)	+=3D hv_storvsc.o=0A obj-$(CONFIG_H=
YPERV_BLOCK)	+=3D hv_blkvsc.o=0A obj-$(CONFIG_HYPERV_NET)	+=3D =
hv_netvsc.o=0A
--=__PartE0CA6175.1__=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--=__PartE0CA6175.1__=--
