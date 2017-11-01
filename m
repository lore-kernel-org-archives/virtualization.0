From: Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2 1/2] x86/paravirt: Add kernel parameter to choose
	paravirt lock type
Date: Wed,  1 Nov 2017 16:58:53 -0400
Message-ID: <1509569934-4919-2-git-send-email-longman@redhat.com>
References: <1509569934-4919-1-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1509569934-4919-1-git-send-email-longman@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Juergen Gross <jgross@suse.com>, Rusty Russell <rusty@rustcorp.com.au>, kvm@vger.kernel.org, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Waiman Long <longman@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org, Alok Kataria <akataria@vmware.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Currently, there are 3 different lock types that can be chosen for
the x86 architecture:

 - qspinlock
 - pvqspinlock
 - unfair lock

One of the above lock types will be chosen at boot time depending on
a number of different factors.

Ideally, the hypervisors should be able to pick the best performing
lock type for the current VM configuration. That is not currently
the case as the performance of each lock type are affected by many
different factors like the number of vCPUs in the VM, the amount vCPU
overcommitment, the CPU type and so on.

Generally speaking, unfair lock performs well for VMs with a small
number of vCPUs. Native qspinlock may perform better than pvqspinlock
if there is vCPU pinning and there is no vCPU over-commitment.

This patch adds a new kernel parameter to allow administrator to
choose the paravirt spinlock type to be used. VM administrators can
experiment with the different lock types and choose one that can best
suit their need, if they want to. Hypervisor developers can also use
that to experiment with different lock types so that they can come
up with a better algorithm to pick the best lock type.

The hypervisor paravirt spinlock code will override this new parameter
in determining if pvqspinlock should be used. The parameter, however,
will override Xen's xen_nopvspin in term of disabling unfair lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++
 arch/x86/include/asm/paravirt.h                 |  9 ++++++
 arch/x86/kernel/kvm.c                           |  3 ++
 arch/x86/kernel/paravirt.c                      | 40 ++++++++++++++++++++++++-
 arch/x86/xen/spinlock.c                         | 12 ++++----
 5 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f7df49d..c98d9c7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3275,6 +3275,13 @@
 			[KNL] Number of legacy pty's. Overwrites compiled-in
 			default number.
 
+	pvlock_type=	[X86,PV_OPS]
+			Specify the paravirt spinlock type to be used.
+			Options are:
+			queued - native queued spinlock
+			pv     - paravirt queued spinlock
+			unfair - simple TATAS unfair lock
+
 	quiet		[KNL] Disable most log messages
 
 	r128=		[HW,DRM]
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 12deec7..c8f9ad9 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -690,6 +690,15 @@ static __always_inline bool pv_vcpu_is_preempted(long cpu)
 
 #endif /* SMP && PARAVIRT_SPINLOCKS */
 
+enum pv_spinlock_type {
+	locktype_auto	  = 0,
+	locktype_queued   = 1,
+	locktype_paravirt = 2,
+	locktype_unfair   = 4,
+};
+
+extern enum pv_spinlock_type pv_spinlock_type;
+
 #ifdef CONFIG_X86_32
 #define PV_SAVE_REGS "pushl %ecx; pushl %edx;"
 #define PV_RESTORE_REGS "popl %edx; popl %ecx;"
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 8bb9594..3faee63 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -646,6 +646,9 @@ void __init kvm_spinlock_init(void)
 	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
 		return;
 
+	if (pv_spinlock_type & (locktype_queued|locktype_unfair))
+		return;
+
 	__pv_init_lock_hash();
 	pv_lock_ops.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
 	pv_lock_ops.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 041096b..aee6756 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -115,11 +115,48 @@ unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
 	return 5;
 }
 
+/*
+ * The kernel argument "pvlock_type=" can be used to explicitly specify
+ * which type of spinlocks to be used. Currently, there are 3 options:
+ * 1) queued - the native queued spinlock
+ * 2) pv     - the paravirt queued spinlock (if CONFIG_PARAVIRT_SPINLOCKS)
+ * 3) unfair - the simple TATAS unfair lock
+ *
+ * If this argument is not specified, the kernel will automatically choose
+ * an appropriate one depending on X86_FEATURE_HYPERVISOR and hypervisor
+ * specific settings.
+ */
+enum pv_spinlock_type __read_mostly pv_spinlock_type = locktype_auto;
+
+static int __init pvlock_setup(char *s)
+{
+	if (!s)
+		return -EINVAL;
+
+	if (!strcmp(s, "queued"))
+		pv_spinlock_type = locktype_queued;
+	else if (!strcmp(s, "pv"))
+		pv_spinlock_type = locktype_paravirt;
+	else if (!strcmp(s, "unfair"))
+		pv_spinlock_type = locktype_unfair;
+	else
+		return -EINVAL;
+
+	pr_info("PV lock type = %s (%d)\n", s, pv_spinlock_type);
+	return 0;
+}
+
+early_param("pvlock_type", pvlock_setup);
+
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
 
 void __init native_pv_lock_init(void)
 {
-	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (pv_spinlock_type == locktype_unfair)
+		return;
+
+	if (!static_cpu_has(X86_FEATURE_HYPERVISOR) ||
+	   (pv_spinlock_type == locktype_queued))
 		static_branch_disable(&virt_spin_lock_key);
 }
 
@@ -473,3 +510,4 @@ struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
 EXPORT_SYMBOL    (pv_mmu_ops);
 EXPORT_SYMBOL_GPL(pv_info);
 EXPORT_SYMBOL    (pv_irq_ops);
+EXPORT_SYMBOL    (pv_spinlock_type);
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 1e1462d..d5f79ac 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -81,8 +81,9 @@ void xen_init_lock_cpu(int cpu)
 	int irq;
 	char *name;
 
-	if (!xen_pvspin) {
-		if (cpu == 0)
+	if (!xen_pvspin ||
+	   (pv_spinlock_type & (locktype_queued|locktype_unfair))) {
+		if ((cpu == 0) && !pv_spinlock_type)
 			static_branch_disable(&virt_spin_lock_key);
 		return;
 	}
@@ -109,7 +110,8 @@ void xen_init_lock_cpu(int cpu)
 
 void xen_uninit_lock_cpu(int cpu)
 {
-	if (!xen_pvspin)
+	if (!xen_pvspin ||
+	   (pv_spinlock_type & (locktype_queued|locktype_unfair)))
 		return;
 
 	unbind_from_irqhandler(per_cpu(lock_kicker_irq, cpu), NULL);
@@ -130,8 +132,8 @@ void xen_uninit_lock_cpu(int cpu)
  */
 void __init xen_init_spinlocks(void)
 {
-
-	if (!xen_pvspin) {
+	if (!xen_pvspin ||
+	   (pv_spinlock_type & (locktype_queued|locktype_unfair))) {
 		printk(KERN_DEBUG "xen: PV spinlocks disabled\n");
 		return;
 	}
-- 
1.8.3.1
