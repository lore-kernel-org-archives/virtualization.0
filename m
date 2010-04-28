From: "Ky Srinivasan" <ksrinivasan@novell.com>
Subject: [virtualization-mngt] HyperV detection patch
Date: Wed, 28 Apr 2010 14:56:54 -0600
Message-ID: <4BD85C9F.E57C.0030.0@novell.com>
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

This is a resend of a patch I had posted a couple of weeks ago. As suggested by Jeremy, I am enclosing a patch that integrates HyperV detection with the current hypervisor detection mechanism in the kernel. A patch for implementing a HyperV clock source based on this patch will be sent out shortly.


From: K. Y. Srinivasan <ksrinivasan@novell.com>
Subject:  HyperV Detection code.
References: None
Patch-mainline:

This patch integrates HyperV detection within the framework currently used by
VmWare. With this patch, we can avoid having to replicate the HyperV detection
code in each of the HyperV specific Linux drivers - MSFT Linux Integration 
Components. 

Signed-off-by: K. Y. Srinivasan <ksrinivasan@novell.com>

Index: linux-2.6.34-rc4/arch/x86/include/asm/processor.h
===================================================================
--- linux-2.6.34-rc4.orig/arch/x86/include/asm/processor.h	2010-04-12 19:41:35.000000000 -0600
+++ linux-2.6.34-rc4/arch/x86/include/asm/processor.h	2010-04-15 10:00:18.000000000 -0600
@@ -114,6 +114,8 @@ struct cpuinfo_x86 {
 	u16			cpu_index;
 #endif
 	unsigned int		x86_hyper_vendor;
+	/* The layout of this field is hypervisor specific */
+	unsigned int		x86_hyper_features;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
 
 #define X86_VENDOR_INTEL	0
@@ -129,6 +131,7 @@ struct cpuinfo_x86 {
 
 #define X86_HYPER_VENDOR_NONE  0
 #define X86_HYPER_VENDOR_VMWARE 1
+#define X86_HYPER_VENDOR_MSFT 2
 
 /*
  * capabilities of CPUs
Index: linux-2.6.34-rc4/arch/x86/kernel/cpu/Makefile
===================================================================
--- linux-2.6.34-rc4.orig/arch/x86/kernel/cpu/Makefile	2010-04-12 19:41:35.000000000 -0600
+++ linux-2.6.34-rc4/arch/x86/kernel/cpu/Makefile	2010-04-15 10:00:18.000000000 -0600
@@ -14,7 +14,7 @@ CFLAGS_common.o		:= $(nostackp)
 
 obj-y			:= intel_cacheinfo.o addon_cpuid_features.o
 obj-y			+= proc.o capflags.o powerflags.o common.o
-obj-y			+= vmware.o hypervisor.o sched.o
+obj-y			+= vmware.o hypervisor.o sched.o hyperv.o
 
 obj-$(CONFIG_X86_32)	+= bugs.o cmpxchg.o
 obj-$(CONFIG_X86_64)	+= bugs_64.o
Index: linux-2.6.34-rc4/arch/x86/kernel/cpu/hyperv.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.34-rc4/arch/x86/kernel/cpu/hyperv.c	2010-04-15 10:00:18.000000000 -0600
@@ -0,0 +1,66 @@
+/*
+ * HyperV  Detection code.
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
+#include <linux/types.h>
+#include <asm/processor.h>
+#include <asm/hyperv.h>
+
+
+int hyperv_platform(void)
+{
+	u32 eax, ebx, ecx, edx;
+	char hyp_signature[13];
+
+	cpuid(1, &eax, &ebx, &ecx, &edx);
+	if (!(ecx & HYPERV_HYPERVISOR_PRESENT_BIT))
+		return 0;
+
+	cpuid(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS, &eax, &ebx, &ecx, &edx);
+	*(u32 *)(hyp_signature + 0) = ebx;
+	*(u32 *)(hyp_signature + 4) = ecx;
+	*(u32 *)(hyp_signature + 8) = edx;
+
+	if ((eax < HYPERV_CPUID_MIN) || (memcmp("Microsoft Hv", hyp_signature, 12)))
+		return 0;
+	return 1;
+}
+
+void __cpuinit hyperv_set_feature_bits(struct cpuinfo_x86 *c)
+{
+	u32 eax, ebx, ecx, edx;
+
+	c->x86_hyper_features = 0;
+	/*
+	 * Extract the features, recommendations etc.
+	 * The first 9 bits will be used to track hypervisor features.
+	 * The next 6 bits will be used to track the hypervisor
+	 * recommendations.
+	 */
+	cpuid(HYPERV_CPUID_FEATURES, &eax, &ebx, &ecx, &edx);
+	c->x86_hyper_features |= (eax & 0x1ff);
+
+	cpuid(HYPERV_CPUID_ENLIGHTMENT_INFO, &eax, &ebx, &ecx, &edx);
+	c->x86_hyper_features |= ((eax & 0x3f) << 9);
+	printk(KERN_INFO "Detected HyperV with features: %x\n",
+		c->x86_hyper_features);
+}
Index: linux-2.6.34-rc4/arch/x86/kernel/cpu/hypervisor.c
===================================================================
--- linux-2.6.34-rc4.orig/arch/x86/kernel/cpu/hypervisor.c	2010-04-12 19:41:35.000000000 -0600
+++ linux-2.6.34-rc4/arch/x86/kernel/cpu/hypervisor.c	2010-04-15 10:00:18.000000000 -0600
@@ -23,6 +23,7 @@
 
 #include <asm/processor.h>
 #include <asm/vmware.h>
+#include <asm/hyperv.h>
 #include <asm/hypervisor.h>
 
 static inline void __cpuinit
@@ -30,6 +31,8 @@ detect_hypervisor_vendor(struct cpuinfo_
 {
 	if (vmware_platform())
 		c->x86_hyper_vendor = X86_HYPER_VENDOR_VMWARE;
+	else if (hyperv_platform())
+		c->x86_hyper_vendor = X86_HYPER_VENDOR_MSFT;
 	else
 		c->x86_hyper_vendor = X86_HYPER_VENDOR_NONE;
 }
@@ -37,10 +40,11 @@ detect_hypervisor_vendor(struct cpuinfo_
 static inline void __cpuinit
 hypervisor_set_feature_bits(struct cpuinfo_x86 *c)
 {
-	if (boot_cpu_data.x86_hyper_vendor == X86_HYPER_VENDOR_VMWARE) {
+	if (boot_cpu_data.x86_hyper_vendor == X86_HYPER_VENDOR_VMWARE)
 		vmware_set_feature_bits(c);
-		return;
-	}
+	else if (boot_cpu_data.x86_hyper_vendor == X86_HYPER_VENDOR_MSFT)
+		hyperv_set_feature_bits(c);
+	return;
 }
 
 void __cpuinit init_hypervisor(struct cpuinfo_x86 *c)
Index: linux-2.6.34-rc4/arch/x86/include/asm/hyperv.h
===================================================================
--- linux-2.6.34-rc4.orig/arch/x86/include/asm/hyperv.h	2010-04-12 19:41:35.000000000 -0600
+++ linux-2.6.34-rc4/arch/x86/include/asm/hyperv.h	2010-04-15 13:06:58.000000000 -0600
@@ -2,6 +2,8 @@
 #define _ASM_X86_KVM_HYPERV_H
 
 #include <linux/types.h>
+#include <linux/init.h>
+#include <asm/processor.h>
 
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
@@ -14,6 +16,9 @@
 #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
 #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
 
+#define HYPERV_HYPERVISOR_PRESENT_BIT		0x80000000
+#define HYPERV_CPUID_MIN			0x40000005
+
 /*
  * Feature identification. EAX indicates which features are available
  * to the partition based upon the current partition privileges.
@@ -129,6 +134,9 @@
 /* MSR used to provide vcpu index */
 #define HV_X64_MSR_VP_INDEX			0x40000002
 
+/* MSR used to read the per-partition time reference counter */
+#define HV_X64_MSR_TIME_REF_COUNT       0x40000020
+
 /* Define the virtual APIC registers */
 #define HV_X64_MSR_EOI				0x40000070
 #define HV_X64_MSR_ICR				0x40000071
@@ -183,4 +191,6 @@
 #define HV_STATUS_INVALID_HYPERCALL_INPUT	3
 #define HV_STATUS_INVALID_ALIGNMENT		4
 
+int hyperv_platform(void);
+void __cpuinit hyperv_set_feature_bits(struct cpuinfo_x86 *c);
 #endif

_______________________________________________
Virtualization-Mngt mailing list
Virtualization-Mngt@lists.novell.com
https://lists.innerweb.novell.com/mailman/listinfo/virtualization-mngt
Search Archives: https://lists.innerweb.novell.com/search
