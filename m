From: Carsten Otte <cotte@de.ibm.com>
Subject: [RFC/PATCH 10/15 v2] kvm-s390: intercepts for diagnose instructions
Date: Sat, 22 Mar 2008 18:02:54 +0100
Message-ID: <1206205374.7177.92.camel__18888.7922945016$1206215023$gmane$org@cotte.boeblingen.de.ibm.com>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
	<1206203560.7177.45.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206203560.7177.45.camel@cotte.boeblingen.de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, kvm-devel@lists.sourceforge.net, Avi Kivity <avi@qumranet.com>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, arnd@arndb.de, hollisb@us.ibm.com, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, borntraeger@de.ibm.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang,
	Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Carsten Otte <cotte@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch introduces interpretation of some diagnose instruction intercepts.
Diagnose is our classic architected way of doing a hypercall. This patch
features the following diagnose codes:
- vm storage size, that tells the guest about its memory layout
- time slice end, which is used by the guest to indicate that it waits
  for a lock and thus cannot use up its time slice in a useful way
- ipl functions, which a guest can use to reset and reboot itself

In order to implement ipl functions, we also introduce an exit reason that
causes userspace to perform various resets on the virtual machine. All resets
are described in the principles of operation book, except KVM_S390_RESET_IPL
which causes a reboot of the machine.

Acked-by: Martin Schwidefsky <martin.schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
 arch/s390/kvm/Makefile      |    2 -
 arch/s390/kvm/diag.c        |   67 ++++++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/intercept.c   |    1 
 arch/s390/kvm/kvm-s390.c    |    1 
 arch/s390/kvm/kvm-s390.h    |    2 +
 include/asm-s390/kvm_host.h |    5 ++-
 include/linux/kvm.h         |    8 +++++
 7 files changed, 84 insertions(+), 2 deletions(-)

Index: linux-host/arch/s390/kvm/Makefile
===================================================================
--- linux-host.orig/arch/s390/kvm/Makefile
+++ linux-host/arch/s390/kvm/Makefile
@@ -10,5 +10,5 @@ common-objs = $(addprefix ../../../virt/
 
 EXTRA_CFLAGS += -Ivirt/kvm -Iarch/s390/kvm
 
-kvm-objs := $(common-objs) kvm-s390.o sie64a.o intercept.o interrupt.o priv.o sigp.o
+kvm-objs := $(common-objs) kvm-s390.o sie64a.o intercept.o interrupt.o priv.o sigp.o diag.o
 obj-$(CONFIG_KVM) += kvm.o
Index: linux-host/arch/s390/kvm/diag.c
===================================================================
--- /dev/null
+++ linux-host/arch/s390/kvm/diag.c
@@ -0,0 +1,67 @@
+/*
+ * diag.c - handling diagnose instructions
+ *
+ * Copyright IBM Corp. 2008
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ *
+ *    Author(s): Carsten Otte <cotte@de.ibm.com>
+ *               Christian Borntraeger <borntraeger@de.ibm.com>
+ */
+
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include "kvm-s390.h"
+
+static int __diag_time_slice_end(struct kvm_vcpu *vcpu)
+{
+	VCPU_EVENT(vcpu, 5, "%s", "diag time slice end");
+	vcpu->stat.diagnose_44++;
+	vcpu_put(vcpu);
+	schedule();
+	vcpu_load(vcpu);
+	return 0;
+}
+
+static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
+{
+	unsigned int reg = vcpu->arch.sie_block->ipa & 0xf;
+	unsigned long subcode = vcpu->arch.guest_gprs[reg] & 0xffff;
+
+	VCPU_EVENT(vcpu, 5, "diag ipl functions, subcode %lx", subcode);
+	switch (subcode) {
+	case 3:
+		vcpu->run->s390_reset_flags = KVM_S390_RESET_CLEAR;
+		break;
+	case 4:
+		vcpu->run->s390_reset_flags = 0;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	atomic_clear_mask(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
+	vcpu->run->s390_reset_flags |= KVM_S390_RESET_SUBSYSTEM;
+	vcpu->run->s390_reset_flags |= KVM_S390_RESET_IPL;
+	vcpu->run->s390_reset_flags |= KVM_S390_RESET_CPU_INIT;
+	vcpu->run->exit_reason = KVM_EXIT_S390_RESET;
+	VCPU_EVENT(vcpu, 3, "requesting userspace resets %lx",
+	  vcpu->run->s390_reset_flags);
+	return -EREMOTE;
+}
+
+int kvm_s390_handle_diag(struct kvm_vcpu *vcpu)
+{
+	int code = (vcpu->arch.sie_block->ipb & 0xfff0000) >> 16;
+
+	switch (code) {
+	case 0x44:
+		return __diag_time_slice_end(vcpu);
+	case 0x308:
+		return __diag_ipl_functions(vcpu);
+	default:
+		return -ENOTSUPP;
+	}
+}
Index: linux-host/arch/s390/kvm/intercept.c
===================================================================
--- linux-host.orig/arch/s390/kvm/intercept.c
+++ linux-host/arch/s390/kvm/intercept.c
@@ -100,6 +100,7 @@ static int handle_lctl(struct kvm_vcpu *
 }
 
 static intercept_handler_t instruction_handlers[256] = {
+	[0x83] = kvm_s390_handle_diag,
 	[0xae] = kvm_s390_handle_sigp,
 	[0xb2] = kvm_s390_handle_priv,
 	[0xb7] = handle_lctl,
Index: linux-host/arch/s390/kvm/kvm-s390.c
===================================================================
--- linux-host.orig/arch/s390/kvm/kvm-s390.c
+++ linux-host/arch/s390/kvm/kvm-s390.c
@@ -63,6 +63,7 @@ struct kvm_stats_debugfs_item debugfs_en
 	{ "instruction_sigp_set_arch", VCPU_STAT(instruction_sigp_arch) },
 	{ "instruction_sigp_set_prefix", VCPU_STAT(instruction_sigp_prefix) },
 	{ "instruction_sigp_restart", VCPU_STAT(instruction_sigp_restart) },
+	{ "diagnose_44", VCPU_STAT(diagnose_44) },
 	{ NULL }
 };
 
Index: linux-host/arch/s390/kvm/kvm-s390.h
===================================================================
--- linux-host.orig/arch/s390/kvm/kvm-s390.h
+++ linux-host/arch/s390/kvm/kvm-s390.h
@@ -57,4 +57,6 @@ int kvm_s390_handle_sigp(struct kvm_vcpu
 /* implemented in kvm-s390.c */
 int __kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu,
 				 unsigned long addr);
+/* implemented in diag.c */
+int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
 #endif
Index: linux-host/include/asm-s390/kvm_host.h
===================================================================
--- linux-host.orig/include/asm-s390/kvm_host.h
+++ linux-host/include/asm-s390/kvm_host.h
@@ -94,7 +94,9 @@ struct sie_block {
 	psw_t	gpsw;			/* 0x0090 */
 	__u64	gg14;			/* 0x00a0 */
 	__u64	gg15;			/* 0x00a8 */
-	__u8	reservedb0[80];		/* 0x00b0 */
+	__u8	reservedb0[30];		/* 0x00b0 */
+	__u16   iprcc;			/* 0x00ce */
+	__u8	reservedd0[48];		/* 0x00d0 */
 	__u64	gcr[16];		/* 0x0100 */
 	__u64	gbea;			/* 0x0180 */
 	__u8	reserved188[120];	/* 0x0188 */
@@ -134,6 +136,7 @@ struct kvm_vcpu_stat {
 	u32 instruction_sigp_arch;
 	u32 instruction_sigp_prefix;
 	u32 instruction_sigp_restart;
+	u32 diagnose_44;
 };
 
 struct io_info {
Index: linux-host/include/linux/kvm.h
===================================================================
--- linux-host.orig/include/linux/kvm.h
+++ linux-host/include/linux/kvm.h
@@ -75,6 +75,7 @@ struct kvm_irqchip {
 #define KVM_EXIT_SET_TPR          11
 #define KVM_EXIT_TPR_ACCESS       12
 #define KVM_EXIT_S390_SIEIC       13
+#define KVM_EXIT_S390_RESET       14
 
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
@@ -147,6 +148,13 @@ struct kvm_run {
 			__u16 ipa;
 			__u32 ipb;
 		} s390_sieic;
+		/* KVM_EXIT_S390_RESET */
+#define KVM_S390_RESET_POR       1
+#define KVM_S390_RESET_CLEAR     2
+#define KVM_S390_RESET_SUBSYSTEM 4
+#define KVM_S390_RESET_CPU_INIT  8
+#define KVM_S390_RESET_IPL       16
+		__u64 s390_reset_flags;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
