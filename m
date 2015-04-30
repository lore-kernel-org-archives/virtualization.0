From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 6/6] x86: remove no longer needed paravirt_ticketlocks_enabled
Date: Thu, 30 Apr 2015 12:54:03 +0200
Message-ID: <1430391243-7112-7-git-send-email-jgross__41509.7396624789$1430453302$gmane$org@suse.com>
References: <1430391243-7112-1-git-send-email-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1430391243-7112-1-git-send-email-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, xen-devel@lists.xensource.com, konrad.wilk@oracle.com, david.vrabel@citrix.com, boris.ostrovsky@oracle.com, jeremy@goop.org, chrisw@sous-sol.org, akataria@vmware.com, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, gleb@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>
List-Id: virtualization@lists.linuxfoundation.org

With the paravirtualized spinlock unlock function being a pvops
function paravirt_ticketlocks_enabled is no longer needed. Remove it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/spinlock.h      |  3 ---
 arch/x86/kernel/kvm.c                | 14 --------------
 arch/x86/kernel/paravirt-spinlocks.c |  4 +---
 arch/x86/xen/spinlock.c              | 23 -----------------------
 4 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index 40a1091..2ac8118 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -39,9 +39,6 @@
 /* How long a lock should spin before we consider blocking */
 #define SPIN_THRESHOLD	(1 << 15)
 
-extern struct static_key paravirt_ticketlocks_enabled;
-static __always_inline bool static_key_false(struct static_key *key);
-
 static inline void ___ticket_unlock(arch_spinlock_t *lock)
 {
 	__add(&lock->tickets.head, TICKET_LOCK_INC, UNLOCK_LOCK_PREFIX);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c3b4b43..27d815a 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -834,18 +834,4 @@ void __init kvm_spinlock_init(void)
 	pv_lock_activate();
 }
 
-static __init int kvm_spinlock_init_jump(void)
-{
-	if (!kvm_para_available())
-		return 0;
-	if (!kvm_para_has_feature(KVM_FEATURE_PV_UNHALT))
-		return 0;
-
-	static_key_slow_inc(&paravirt_ticketlocks_enabled);
-	printk(KERN_INFO "KVM setup paravirtual spinlock\n");
-
-	return 0;
-}
-early_initcall(kvm_spinlock_init_jump);
-
 #endif	/* CONFIG_PARAVIRT_SPINLOCKS */
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 91273fb..6b5f33c 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -40,6 +40,7 @@ void pv_lock_activate(void)
 {
 	pv_lock_ops.clear_slowpath = pv_ticket_clear_slowpath;
 	pv_lock_ops.unlock = pv_ticket_unlock;
+	pr_info("paravirtual spinlocks activated\n");
 }
 EXPORT_SYMBOL_GPL(pv_lock_activate);
 #endif
@@ -53,6 +54,3 @@ struct pv_lock_ops pv_lock_ops = {
 #endif
 };
 EXPORT_SYMBOL(pv_lock_ops);
-
-struct static_key paravirt_ticketlocks_enabled = STATIC_KEY_INIT_FALSE;
-EXPORT_SYMBOL(paravirt_ticketlocks_enabled);
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 988c895..a125d67 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -265,10 +265,6 @@ void xen_uninit_lock_cpu(int cpu)
 
 
 /*
- * Our init of PV spinlocks is split in two init functions due to us
- * using paravirt patching and jump labels patching and having to do
- * all of this before SMP code is invoked.
- *
  * The paravirt patching needs to be done _before_ the alternative asm code
  * is started, otherwise we would not patch the core kernel code.
  */
@@ -286,25 +282,6 @@ void __init xen_init_spinlocks(void)
 	pv_lock_activate();
 }
 
-/*
- * While the jump_label init code needs to happend _after_ the jump labels are
- * enabled and before SMP is started. Hence we use pre-SMP initcall level
- * init. We cannot do it in xen_init_spinlocks as that is done before
- * jump labels are activated.
- */
-static __init int xen_init_spinlocks_jump(void)
-{
-	if (!xen_pvspin)
-		return 0;
-
-	if (!xen_domain())
-		return 0;
-
-	static_key_slow_inc(&paravirt_ticketlocks_enabled);
-	return 0;
-}
-early_initcall(xen_init_spinlocks_jump);
-
 static __init int xen_parse_nopvspin(char *arg)
 {
 	xen_pvspin = false;
-- 
2.1.4
