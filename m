From: Laurent Vivier <Laurent.Vivier@bull.net>
Subject: Re: [PATCH/RFC 4/4, second shot]KVM uses "account_guest_time()"
Date: Fri, 17 Aug 2007 13:54:52 +0200
Message-ID: <46C58C8C.3080803__42400.0710402199$1187351833$gmane$org@bull.net>
References: <46C4719A.2060308@bull.net> <46C4720F.7030304@bull.net>	
	<46C4725A.4070607@bull.net> <46C4740F.2050701@bull.net>	
	<1187303955.6449.7.camel@localhost.localdomain>
	<46C54FB8.7050504@bull.net>
	<1187339450.6449.115.camel@localhost.localdomain>
	<46C56774.2030009@bull.net> <46C58BD5.3090207@bull.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040100090406010701050908"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46C58BD5.3090207@bull.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <Laurent.Vivier@bull.net>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------040100090406010701050908
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1

KVM updates vtime in task_struct to allow account_guest_time() to modify user,
system and guest time in cpustat accordingly.

--------------040100090406010701050908
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
 name="kvm_account_guest"
Content-Disposition: inline;
 filename="kvm_account_guest"

Index: kvm/drivers/kvm/Kconfig
===================================================================
--- kvm.orig/drivers/kvm/Kconfig	2007-08-17 10:24:46.000000000 +0200
+++ kvm/drivers/kvm/Kconfig	2007-08-17 10:25:25.000000000 +0200
@@ -41,4 +41,10 @@
 	  Provides support for KVM on AMD processors equipped with the AMD-V
 	  (SVM) extensions.
 
+config GUEST_ACCOUNTING
+	bool "Virtual Machine accounting support"
+	depends on KVM
+	---help---
+	  Allows to account CPU time used by the Virtual Machines.
+
 endif # VIRTUALIZATION
Index: kvm/drivers/kvm/kvm.h
===================================================================
--- kvm.orig/drivers/kvm/kvm.h	2007-08-17 10:19:30.000000000 +0200
+++ kvm/drivers/kvm/kvm.h	2007-08-17 10:21:56.000000000 +0200
@@ -589,6 +589,19 @@
 
 int kvm_hypercall(struct kvm_vcpu *vcpu, struct kvm_run *run);
 
+#ifdef CONFIG_GUEST_ACCOUNTING
+static inline ktime_t kvm_guest_enter(void)
+{
+	 return ktime_get();
+}
+
+static inline void kvm_guest_exit(ktime_t enter)
+{
+	 ktime_t delta = ktime_sub(ktime_get(), enter);
+	 current->vtime = ktime_add(current->vtime, delta);
+}
+#endif
+
 static inline int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t gva,
 				     u32 error_code)
 {
Index: kvm/drivers/kvm/svm.c
===================================================================
--- kvm.orig/drivers/kvm/svm.c	2007-08-17 10:22:07.000000000 +0200
+++ kvm/drivers/kvm/svm.c	2007-08-17 10:23:32.000000000 +0200
@@ -1392,6 +1392,9 @@
 	u16 gs_selector;
 	u16 ldt_selector;
 	int r;
+#ifdef CONFIG_GUEST_ACCOUNTING
+	ktime_t now;
+#endif
 
 again:
 	r = kvm_mmu_reload(vcpu);
@@ -1404,6 +1407,9 @@
 	clgi();
 
 	vcpu->guest_mode = 1;
+#ifdef CONFIG_GUEST_ACCOUNTING
+	now = kvm_guest_enter();
+#endif
 	if (vcpu->requests)
 		if (test_and_clear_bit(KVM_TLB_FLUSH, &vcpu->requests))
 		    svm_flush_tlb(vcpu);
@@ -1536,6 +1542,9 @@
 #endif
 		: "cc", "memory" );
 
+#ifdef CONFIG_GUEST_ACCOUNTING
+	kvm_guest_exit(now);
+#endif
 	vcpu->guest_mode = 0;
 
 	if (vcpu->fpu_active) {
Index: kvm/drivers/kvm/vmx.c
===================================================================
--- kvm.orig/drivers/kvm/vmx.c	2007-08-17 10:23:36.000000000 +0200
+++ kvm/drivers/kvm/vmx.c	2007-08-17 10:24:37.000000000 +0200
@@ -2052,6 +2052,9 @@
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	u8 fail;
 	int r;
+#ifdef CONFIG_GUEST_ACCOUNTING
+	ktime_t now;
+#endif
 
 preempted:
 	if (vcpu->guest_debug.enabled)
@@ -2078,6 +2081,9 @@
 	local_irq_disable();
 
 	vcpu->guest_mode = 1;
+#ifdef CONFIG_GUEST_ACCOUNTING
+	now = kvm_guest_enter();
+#endif
 	if (vcpu->requests)
 		if (test_and_clear_bit(KVM_TLB_FLUSH, &vcpu->requests))
 		    vmx_flush_tlb(vcpu);
@@ -2198,6 +2204,9 @@
 		[cr2]"i"(offsetof(struct kvm_vcpu, cr2))
 	      : "cc", "memory" );
 
+#ifdef CONFIG_GUEST_ACCOUNTING
+	kvm_guest_exit(now);
+#endif
 	vcpu->guest_mode = 0;
 	local_irq_enable();
 

--------------040100090406010701050908
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--------------040100090406010701050908--
