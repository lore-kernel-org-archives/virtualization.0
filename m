From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v3 1/2] paravirt/locks: use new static key for controlling
	call of virt_spin_lock()
Date: Wed,  6 Sep 2017 19:36:24 +0200
Message-ID: <20170906173625.18158-2-jgross__48583.5312786095$1504719434$gmane$org@suse.com>
References: <20170906173625.18158-1-jgross@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170906173625.18158-1-jgross@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, virtualization@lists.linux-foundation.org
Cc: Juergen Gross <jgross@suse.com>, jeremy@goop.org, peterz@infradead.org, chrisw@sous-sol.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, longman@redhat.com, akataria@vmware.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

There are cases where a guest tries to switch spinlocks to bare metal
behavior (e.g. by setting "xen_nopvspin" boot parameter). Today this
has the downside of falling back to unfair test and set scheme for
qspinlocks due to virt_spin_lock() detecting the virtualized
environment.

Add a static key controlling whether virt_spin_lock() should be
called or not. When running on bare metal set the new key to false.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/qspinlock.h     | 11 ++++++++++-
 arch/x86/kernel/paravirt-spinlocks.c |  6 ++++++
 arch/x86/kernel/smpboot.c            |  2 ++
 kernel/locking/qspinlock.c           |  4 ++++
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/qspinlock.h b/arch/x86/include/asm/qspinlock.h
index 48a706f641f2..308dfd0714c7 100644
--- a/arch/x86/include/asm/qspinlock.h
+++ b/arch/x86/include/asm/qspinlock.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_X86_QSPINLOCK_H
 #define _ASM_X86_QSPINLOCK_H
 
+#include <linux/jump_label.h>
 #include <asm/cpufeature.h>
 #include <asm-generic/qspinlock_types.h>
 #include <asm/paravirt.h>
@@ -46,10 +47,14 @@ static inline void queued_spin_unlock(struct qspinlock *lock)
 #endif
 
 #ifdef CONFIG_PARAVIRT
+DECLARE_STATIC_KEY_TRUE(virt_spin_lock_key);
+
+void native_pv_lock_init(void) __init;
+
 #define virt_spin_lock virt_spin_lock
 static inline bool virt_spin_lock(struct qspinlock *lock)
 {
-	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
+	if (!static_branch_likely(&virt_spin_lock_key))
 		return false;
 
 	/*
@@ -65,6 +70,10 @@ static inline bool virt_spin_lock(struct qspinlock *lock)
 
 	return true;
 }
+#else
+static inline void native_pv_lock_init(void)
+{
+}
 #endif /* CONFIG_PARAVIRT */
 
 #include <asm-generic/qspinlock.h>
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 8f2d1c9d43a8..2fc65ddea40d 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -42,3 +42,9 @@ struct pv_lock_ops pv_lock_ops = {
 #endif /* SMP */
 };
 EXPORT_SYMBOL(pv_lock_ops);
+
+void __init native_pv_lock_init(void)
+{
+	if (!static_cpu_has(X86_FEATURE_HYPERVISOR))
+		static_branch_disable(&virt_spin_lock_key);
+}
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 54b9e89d4d6b..21500d3ba359 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -77,6 +77,7 @@
 #include <asm/i8259.h>
 #include <asm/realmode.h>
 #include <asm/misc.h>
+#include <asm/qspinlock.h>
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
@@ -1381,6 +1382,7 @@ void __init native_smp_prepare_boot_cpu(void)
 	/* already set me in cpu_online_mask in boot_cpu_init() */
 	cpumask_set_cpu(me, cpu_callout_mask);
 	cpu_set_state_online(me);
+	native_pv_lock_init();
 }
 
 void __init native_smp_cpus_done(unsigned int max_cpus)
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 294294c71ba4..838d235b87ef 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -76,6 +76,10 @@
 #define MAX_NODES	4
 #endif
 
+#ifdef CONFIG_PARAVIRT
+DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
+#endif
+
 /*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
-- 
2.12.3
