From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: [PATCH 4/4] Modify KVM to update guest time accounting.
Date: Mon, 20 Aug 2007 15:14:14 +0200
Message-ID: <46C993A6.3060001__26757.0367585451$1187617917$gmane$org@bull.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000401040104060802040001"
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
To: Ingo Molnar <mingo@elte.hu>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------000401040104060802040001
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1

[PATCH 4/4] Modify KVM to update guest time accounting.

Signed-off-by: Laurent Vivier <Laurent.Vivier@bull.net>
-- 
------------- Laurent.Vivier@bull.net  --------------
          "Software is hard" - Donald Knuth

--------------000401040104060802040001
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="kvm_account_guest"
Content-Disposition: inline;
 filename="kvm_account_guest"

Index: kvm/drivers/kvm/kvm.h
===================================================================
--- kvm.orig/drivers/kvm/kvm.h	2007-08-20 13:23:53.000000000 +0200
+++ kvm/drivers/kvm/kvm.h	2007-08-20 13:23:58.000000000 +0200
@@ -589,6 +589,17 @@ void kvm_mmu_unload(struct kvm_vcpu *vcp
 
 int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
+static inline void kvm_guest_enter(void)
+{
+#ifdef CONFIG_GUEST_ACCOUNTING
+	current->flags |= PF_VCPU;
+#endif
+}
+
+static inline void kvm_guest_exit(void)
+{
+}
+
 static inline int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t gva,
 				     u32 error_code)
 {
Index: kvm/drivers/kvm/svm.c
===================================================================
--- kvm.orig/drivers/kvm/svm.c	2007-08-20 13:23:53.000000000 +0200
+++ kvm/drivers/kvm/svm.c	2007-08-20 13:23:58.000000000 +0200
@@ -1404,6 +1404,7 @@ again:
 	clgi();
 
 	vcpu->guest_mode = 1;
+	kvm_guest_enter();
 	if (vcpu->requests)
 		if (test_and_clear_bit(KVM_TLB_FLUSH, &vcpu->requests))
 		    svm_flush_tlb(vcpu);
@@ -1536,6 +1537,7 @@ again:
 #endif
 		: "cc", "memory" );
 
+	kvm_guest_exit();
 	vcpu->guest_mode = 0;
 
 	if (vcpu->fpu_active) {
Index: kvm/drivers/kvm/vmx.c
===================================================================
--- kvm.orig/drivers/kvm/vmx.c	2007-08-20 13:23:53.000000000 +0200
+++ kvm/drivers/kvm/vmx.c	2007-08-20 13:23:58.000000000 +0200
@@ -2078,6 +2078,7 @@ again:
 	local_irq_disable();
 
 	vcpu->guest_mode = 1;
+	kvm_guest_enter();
 	if (vcpu->requests)
 		if (test_and_clear_bit(KVM_TLB_FLUSH, &vcpu->requests))
 		    vmx_flush_tlb(vcpu);
@@ -2198,6 +2199,7 @@ again:
 		[cr2]"i"(offsetof(struct kvm_vcpu, cr2))
 	      : "cc", "memory" );
 
+	kvm_guest_exit();
 	vcpu->guest_mode = 0;
 	local_irq_enable();
 
Index: kvm/drivers/kvm/Kconfig
===================================================================
--- kvm.orig/drivers/kvm/Kconfig	2007-08-20 13:36:58.000000000 +0200
+++ kvm/drivers/kvm/Kconfig	2007-08-20 13:37:36.000000000 +0200
@@ -13,6 +13,7 @@ config KVM
 	depends on X86 && EXPERIMENTAL
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
+	select GUEST_ACCOUNTING
 	---help---
 	  Support hosting fully virtualized guest machines using hardware
 	  virtualization extensions.  You will need a fairly recent

--------------000401040104060802040001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------000401040104060802040001--
