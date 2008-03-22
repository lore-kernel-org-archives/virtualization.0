From: Carsten Otte <cotte@de.ibm.com>
Subject: [RFC/PATCH 06/15 v2] kvm-s390: sie intercept handling
Date: Sat, 22 Mar 2008 18:02:46 +0100
Message-ID: <1206205366.7177.88.camel__11160.3083940738$1206206573$gmane$org@cotte.boeblingen.de.ibm.com>
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

This path introduces handling of sie intercepts in three flavors: Intercepts
are either handled completely in-kernel by kvm_handle_sie_intercept(),
or passed to userspace with corresponding data in struct kvm_run in case
kvm_handle_sie_intercept() returns -ENOTSUPP.
In case of partial execution in kernel with the need of userspace support,
kvm_handle_sie_intercept() may choose to set up struct kvm_run and return
-EREMOTE.

The trivial intercept reasons are handled in this patch:
handle_noop() just does nothing for intercepts that don't require our support
  at all
handle_stop() is called when a cpu enters stopped state, and it drops out to
  userland after updating our vcpu state
handle_validity() faults in the cpu lowcore if needed, or passes the request
  to userland

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Carsten Otte <cotte@de.ibm.com>
---
 arch/s390/kvm/Makefile      |    2 -
 arch/s390/kvm/intercept.c   |   83 ++++++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.c    |   46 +++++++++++++++++++++++-
 arch/s390/kvm/kvm-s390.h    |    6 +++
 include/asm-s390/kvm_host.h |    4 ++
 include/linux/kvm.h         |    9 ++++
 6 files changed, 148 insertions(+), 2 deletions(-)

Index: linux-host/arch/s390/kvm/Makefile
===================================================================
--- linux-host.orig/arch/s390/kvm/Makefile
+++ linux-host/arch/s390/kvm/Makefile
@@ -10,5 +10,5 @@ common-objs = $(addprefix ../../../virt/
 
 EXTRA_CFLAGS += -Ivirt/kvm -Iarch/s390/kvm
 
-kvm-objs := $(common-objs) kvm-s390.o sie64a.o
+kvm-objs := $(common-objs) kvm-s390.o sie64a.o intercept.o
 obj-$(CONFIG_KVM) += kvm.o
Index: linux-host/arch/s390/kvm/intercept.c
===================================================================
--- /dev/null
+++ linux-host/arch/s390/kvm/intercept.c
@@ -0,0 +1,83 @@
+/*
+ * intercept.c - in-kernel handling for sie intercepts
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
+#include <linux/kvm_host.h>
+#include <linux/errno.h>
+#include <linux/pagemap.h>
+
+#include <asm/kvm_host.h>
+
+#include "kvm-s390.h"
+
+static int handle_noop(struct kvm_vcpu *vcpu)
+{
+	switch (vcpu->arch.sie_block->icptcode) {
+	case 0x10:
+		vcpu->stat.exit_external_request++;
+		break;
+	case 0x14:
+		vcpu->stat.exit_external_interrupt++;
+		break;
+	default:
+		break; /* nothing */
+	}
+	return 0;
+}
+
+static int handle_stop(struct kvm_vcpu *vcpu)
+{
+	vcpu->stat.exit_stop_request++;
+	VCPU_EVENT(vcpu, 3, "%s", "cpu stopped");
+	atomic_clear_mask(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
+	return -ENOTSUPP;
+}
+
+static int handle_validity(struct kvm_vcpu *vcpu)
+{
+	int viwhy = vcpu->arch.sie_block->ipb >> 16;
+	vcpu->stat.exit_validity++;
+	if (viwhy == 0x37) {
+		fault_in_pages_writeable((char __user *)
+				vcpu->kvm->arch.guest_origin +
+				vcpu->arch.sie_block->prefix, PAGE_SIZE);
+		return 0;
+	}
+	VCPU_EVENT(vcpu, 2, "unhandled validity intercept code %d",
+		viwhy);
+	return -ENOTSUPP;
+}
+
+static const intercept_handler_t intercept_funcs[0x48 >> 2] = {
+	[0x00 >> 2] = handle_noop,
+	[0x10 >> 2] = handle_noop,
+	[0x14 >> 2] = handle_noop,
+	[0x20 >> 2] = handle_validity,
+	[0x28 >> 2] = handle_stop,
+};
+
+int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
+{
+	intercept_handler_t func;
+	u8 code = vcpu->arch.sie_block->icptcode;
+
+	if (code & 3 || code > 0x48)
+		return -ENOTSUPP;
+
+	func = intercept_funcs[code >> 2];
+
+	if (func)
+		return func(vcpu);
+
+	return -ENOTSUPP;
+}
+
Index: linux-host/arch/s390/kvm/kvm-s390.c
===================================================================
--- linux-host.orig/arch/s390/kvm/kvm-s390.c
+++ linux-host/arch/s390/kvm/kvm-s390.c
@@ -23,12 +23,17 @@
 #include <asm/lowcore.h>
 #include <asm/pgtable.h>
 
+#include "kvm-s390.h"
 #include "gaccess.h"
 
 #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
 
 struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ "userspace_handled", VCPU_STAT(exit_userspace) },
+	{ "exit_validity", VCPU_STAT(exit_validity) },
+	{ "exit_stop_request", VCPU_STAT(exit_stop_request) },
+	{ "exit_external_request", VCPU_STAT(exit_external_request) },
+	{ "exit_external_interrupt", VCPU_STAT(exit_external_interrupt) },
 	{ NULL }
 };
 
@@ -384,6 +389,7 @@ static void __vcpu_run(struct kvm_vcpu *
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
+	int rc;
 	sigset_t sigsaved;
 
 	vcpu_load(vcpu);
@@ -393,7 +399,45 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_v
 
 	atomic_set_mask(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
 
-	__vcpu_run(vcpu);
+	switch (kvm_run->exit_reason) {
+	case KVM_EXIT_S390_SIEIC:
+		vcpu->arch.sie_block->gpsw.mask = kvm_run->s390_sieic.mask;
+		vcpu->arch.sie_block->gpsw.addr = kvm_run->s390_sieic.addr;
+		break;
+	case KVM_EXIT_UNKNOWN:
+	case KVM_EXIT_S390_RESET:
+		break;
+	default:
+		BUG();
+	}
+
+	might_sleep();
+
+	do {
+		__vcpu_run(vcpu);
+
+		rc = kvm_handle_sie_intercept(vcpu);
+	} while (!signal_pending(current) && !rc);
+
+	if ((rc == 0) && signal_pending(current))
+		rc = -EINTR;
+
+	if (rc == -ENOTSUPP) {
+		/* intercept cannot be handled in-kernel, prepare kvm-run */
+		kvm_run->exit_reason         = KVM_EXIT_S390_SIEIC;
+		kvm_run->s390_sieic.icptcode = vcpu->arch.sie_block->icptcode;
+		kvm_run->s390_sieic.mask     = vcpu->arch.sie_block->gpsw.mask;
+		kvm_run->s390_sieic.addr     = vcpu->arch.sie_block->gpsw.addr;
+		kvm_run->s390_sieic.ipa      = vcpu->arch.sie_block->ipa;
+		kvm_run->s390_sieic.ipb      = vcpu->arch.sie_block->ipb;
+		rc = 0;
+	}
+
+	if (rc == -EREMOTE) {
+		/* intercept was handled, but userspace support is needed
+		 * kvm_run has been prepared by the handler */
+		rc = 0;
+	}
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
Index: linux-host/arch/s390/kvm/kvm-s390.h
===================================================================
--- linux-host.orig/arch/s390/kvm/kvm-s390.h
+++ linux-host/arch/s390/kvm/kvm-s390.h
@@ -13,6 +13,12 @@
 
 #ifndef ARCH_S390_KVM_S390_H
 #define ARCH_S390_KVM_S390_H
+#include <linux/kvm_host.h>
+
+typedef  int (*intercept_handler_t)(struct kvm_vcpu *vcpu);
+
+extern int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu);
+
 #define VM_EVENT(d_kvm, d_loglevel, d_string, d_args...)\
 do { \
 	debug_sprintf_event(d_kvm->arch.dbf, d_loglevel, d_string "\n", \
Index: linux-host/include/asm-s390/kvm_host.h
===================================================================
--- linux-host.orig/include/asm-s390/kvm_host.h
+++ linux-host/include/asm-s390/kvm_host.h
@@ -101,6 +101,10 @@ struct sie_block {
 
 struct kvm_vcpu_stat {
 	u32 exit_userspace;
+	u32 exit_external_request;
+	u32 exit_external_interrupt;
+	u32 exit_stop_request;
+	u32 exit_validity;
 };
 
 struct kvm_vcpu_arch {
Index: linux-host/include/linux/kvm.h
===================================================================
--- linux-host.orig/include/linux/kvm.h
+++ linux-host/include/linux/kvm.h
@@ -74,6 +74,7 @@ struct kvm_irqchip {
 #define KVM_EXIT_INTR             10
 #define KVM_EXIT_SET_TPR          11
 #define KVM_EXIT_TPR_ACCESS       12
+#define KVM_EXIT_S390_SIEIC       13
 
 /* for KVM_RUN, returned by mmap(vcpu_fd, offset=0) */
 struct kvm_run {
@@ -138,6 +139,14 @@ struct kvm_run {
 			__u32 is_write;
 			__u32 pad;
 		} tpr_access;
+		/* KVM_EXIT_S390_SIEIC */
+		struct {
+			__u8 icptcode;
+			__u64 mask; /* psw upper half */
+			__u64 addr; /* psw lower half */
+			__u16 ipa;
+			__u32 ipb;
+		} s390_sieic;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
