From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH 1/3] KVM paravirt_ops infrastructure
Date: Wed, 30 May 2007 09:52:23 -0500
Message-ID: <465D8FA7.9050600@us.ibm.com>
References: <465D8F03.7000201@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020604020802020609020602"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465D8F03.7000201@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: virtualization <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------020604020802020609020602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Regards,

Anthony Liguori

--------------020604020802020609020602
Content-Type: text/x-patch;
 name="kvm-paravirt-guest.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kvm-paravirt-guest.diff"

Subject: [PATCH] Add KVM paravirt_ops implementation
From: Anthony Liguori <aliguori@us.ibm.com>

This patch adds the basic infrastructure for paravirtualizing a KVM guest.
Discovery of running under KVM is done by sharing a page of memory between
the guest and host (initially through an MSR write).

This is based on a patch written by Ingo Molnar.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

Index: kvm/arch/i386/Kconfig
===================================================================
--- kvm.orig/arch/i386/Kconfig	2007-05-30 08:42:31.000000000 -0500
+++ kvm/arch/i386/Kconfig	2007-05-30 08:42:38.000000000 -0500
@@ -231,6 +231,13 @@
 	  at the moment), by linking the kernel to a GPL-ed ROM module
 	  provided by the hypervisor.
 
+config KVM_GUEST
+	bool "KVM paravirt-ops support"
+	depends on PARAVIRT
+	help
+	  This option enables various optimizations for running under the KVM
+          hypervisor.
+
 config ACPI_SRAT
 	bool
 	default y
Index: kvm/arch/i386/kernel/Makefile
===================================================================
--- kvm.orig/arch/i386/kernel/Makefile	2007-05-30 08:42:26.000000000 -0500
+++ kvm/arch/i386/kernel/Makefile	2007-05-30 08:42:38.000000000 -0500
@@ -41,6 +41,7 @@
 obj-$(CONFIG_K8_NB)		+= k8.o
 
 obj-$(CONFIG_VMI)		+= vmi.o vmiclock.o
+obj-$(CONFIG_KVM_GUEST)		+= kvm.o
 obj-$(CONFIG_PARAVIRT)		+= paravirt.o
 obj-y				+= pcspeaker.o
 
Index: kvm/arch/i386/kernel/kvm.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ kvm/arch/i386/kernel/kvm.c	2007-05-30 09:29:37.000000000 -0500
@@ -0,0 +1,100 @@
+/*
+ * KVM paravirt_ops implementation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright (C) 2007, Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
+ * Copyright IBM Corporation, 2007
+ *   Authors: Anthony Liguori <aliguori@us.ibm.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/kvm_para.h>
+#include <linux/cpu.h>
+
+static DEFINE_PER_CPU(struct kvm_vcpu_para_state, para_state);
+extern unsigned char hypercall_addr[4];
+
+static void kvm_guest_setup(void)
+{
+	paravirt_ops.name = "KVM";
+	paravirt_ops.paravirt_enabled = 1;
+}
+
+/*
+ * This is the vm-syscall address - to be patched by the host to
+ * VMCALL (Intel) or VMMCALL (AMD), depending on the CPU model:
+ */
+asm (
+	".globl hypercall_addr\n"
+	".align 4\n"
+	"hypercall_addr:\n"
+	"movl $-38, %eax\n"
+	"ret\n"
+);
+
+static int kvm_guest_register_para(int cpu)
+{
+	struct kvm_vcpu_para_state *para_state = &per_cpu(para_state, cpu);
+
+	printk(KERN_DEBUG "kvm guest on VCPU#%d: trying to register para_state %p\n",
+	       cpu, para_state);
+
+	/*
+	 * Try to write to a magic MSR (which is invalid on any real CPU),
+	 * and thus signal to KVM that we wish to entering paravirtualized
+	 * mode:
+	 */
+	para_state->guest_version = KVM_PARA_API_VERSION;
+	para_state->host_version = -1;
+	para_state->size = sizeof(*para_state);
+	para_state->ret = 0;
+	para_state->hypercall_gpa = __pa(hypercall_addr);
+
+	if (wrmsr_safe(MSR_KVM_API_MAGIC, __pa(para_state), 0)) {
+		printk(KERN_INFO "KVM guest: WRMSR probe failed.\n");
+		return -ENOENT;
+	}
+
+	printk(KERN_DEBUG "kvm guest: host returned %d\n", para_state->ret);
+	printk(KERN_DEBUG "kvm guest: host version: %d\n", para_state->host_version);
+	printk(KERN_DEBUG "kvm guest: syscall entry: %02x %02x %02x %02x\n",
+	       hypercall_addr[0], hypercall_addr[1],
+	       hypercall_addr[2], hypercall_addr[3]);
+
+	if (para_state->ret) {
+		printk(KERN_ERR "kvm guest: host refused registration.\n");
+		return para_state->ret;
+	}
+
+	return 0;
+}
+
+static int __init kvm_guest_init(void)
+{
+	int rc;
+
+	rc = kvm_guest_register_para(smp_processor_id());
+	if (rc) {
+		printk(KERN_INFO "paravirt KVM unavailable\n");
+		goto out;
+	}
+
+	kvm_guest_setup();
+ out:
+	return 0;
+}
+core_initcall(kvm_guest_init);

--------------020604020802020609020602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------020604020802020609020602--
