From: Waiman Long <longman@redhat.com>
Subject: [PATCH-tip v2 2/2] x86/xen: Deprecate xen_nopvspin
Date: Wed,  1 Nov 2017 16:58:54 -0400
Message-ID: <1509569934-4919-3-git-send-email-longman__26466.7544085116$1509569991$gmane$org@redhat.com>
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

With the new pvlock_type kernel parameter, xen_nopvspin is no longer
needed. This patch deprecates the xen_nopvspin parameter by removing
its documentation and treating it as an alias of "pvlock_type=queued".

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  4 ----
 arch/x86/xen/spinlock.c                         | 19 +++++++------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c98d9c7..683a817 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4596,10 +4596,6 @@
 				the unplug protocol
 			never -- do not unplug even if version check succeeds
 
-	xen_nopvspin	[X86,XEN]
-			Disables the ticketlock slowpath using Xen PV
-			optimizations.
-
 	xen_nopv	[X86]
 			Disables the PV optimizations forcing the HVM guest to
 			run as generic HVM guest with no PV drivers.
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index d5f79ac..19e2e75 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -20,7 +20,6 @@
 
 static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
 static DEFINE_PER_CPU(char *, irq_name);
-static bool xen_pvspin = true;
 
 #include <asm/qspinlock.h>
 
@@ -81,12 +80,8 @@ void xen_init_lock_cpu(int cpu)
 	int irq;
 	char *name;
 
-	if (!xen_pvspin ||
-	   (pv_spinlock_type & (locktype_queued|locktype_unfair))) {
-		if ((cpu == 0) && !pv_spinlock_type)
-			static_branch_disable(&virt_spin_lock_key);
+	if (pv_spinlock_type & (locktype_queued|locktype_unfair))
 		return;
-	}
 
 	WARN(per_cpu(lock_kicker_irq, cpu) >= 0, "spinlock on CPU%d exists on IRQ%d!\n",
 	     cpu, per_cpu(lock_kicker_irq, cpu));
@@ -110,8 +105,7 @@ void xen_init_lock_cpu(int cpu)
 
 void xen_uninit_lock_cpu(int cpu)
 {
-	if (!xen_pvspin ||
-	   (pv_spinlock_type & (locktype_queued|locktype_unfair)))
+	if (pv_spinlock_type & (locktype_queued|locktype_unfair))
 		return;
 
 	unbind_from_irqhandler(per_cpu(lock_kicker_irq, cpu), NULL);
@@ -132,8 +126,7 @@ void xen_uninit_lock_cpu(int cpu)
  */
 void __init xen_init_spinlocks(void)
 {
-	if (!xen_pvspin ||
-	   (pv_spinlock_type & (locktype_queued|locktype_unfair))) {
+	if (pv_spinlock_type & (locktype_queued|locktype_unfair)) {
 		printk(KERN_DEBUG "xen: PV spinlocks disabled\n");
 		return;
 	}
@@ -147,10 +140,12 @@ void __init xen_init_spinlocks(void)
 	pv_lock_ops.vcpu_is_preempted = PV_CALLEE_SAVE(xen_vcpu_stolen);
 }
 
+/* TODO: To be removed in a future kernel version */
 static __init int xen_parse_nopvspin(char *arg)
 {
-	xen_pvspin = false;
+	pr_warn("xen_nopvspin is deprecated, replace it with \"pvlock_type=queued\"!\n");
+	if (!pv_spinlock_type)
+		pv_spinlock_type = locktype_queued;
 	return 0;
 }
 early_param("xen_nopvspin", xen_parse_nopvspin);
-
-- 
1.8.3.1
