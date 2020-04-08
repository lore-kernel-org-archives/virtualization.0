From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 23/26] x86/kvm: Add worker to trigger runtime patching
Date: Tue,  7 Apr 2020 22:03:20 -0700
Message-ID: <20200408050323.4237-24-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, Ankur Arora <ankur.a.arora@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Make __pv_init_lock_hash() conditional on either paravirt spinlocks
being enabled (via kvm_pv_spinlock()) or if paravirt spinlocks
might get enabled (runtime patching via CONFIG_PARAVIRT_RUNTIME.)

Also add a handler for CPUID reprobe which can trigger this patching.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/kernel/kvm.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 31f5ecfd3907..1cb7eab805a6 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -35,6 +35,7 @@
 #include <asm/hypervisor.h>
 #include <asm/tlb.h>
 #include <asm/cpuidle_haltpoll.h>
+#include <asm/text-patching.h>
 
 static int kvmapf = 1;
 
@@ -909,12 +910,15 @@ void __init kvm_spinlock_init(void)
 	if (num_possible_cpus() == 1)
 		return;
 
-	if (!kvm_pv_spinlock())
-		return;
-
-	__pv_init_lock_hash();
+	/*
+	 * Allocate if pv_spinlocks are enabled or if we might
+	 * end up patching them in later.
+	 */
+	if (kvm_pv_spinlock() || IS_ENABLED(CONFIG_PARAVIRT_RUNTIME))
+		__pv_init_lock_hash();
 }
-
+#else	/* !CONFIG_PARAVIRT_SPINLOCKS */
+static inline bool kvm_pv_spinlock(void) { return false; }
 #endif	/* CONFIG_PARAVIRT_SPINLOCKS */
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
@@ -952,3 +956,23 @@ void arch_haltpoll_disable(unsigned int cpu)
 }
 EXPORT_SYMBOL_GPL(arch_haltpoll_disable);
 #endif
+
+#ifdef CONFIG_PARAVIRT_RUNTIME
+void kvm_trigger_reprobe_cpuid(struct work_struct *work)
+{
+	mutex_lock(&text_mutex);
+
+	paravirt_stage_zero();
+
+	kvm_pv_steal_clock();
+	kvm_pv_tlb();
+	paravirt_runtime_patch(false);
+
+	paravirt_stage_zero();
+
+	kvm_pv_spinlock();
+	paravirt_runtime_patch(true);
+
+	mutex_unlock(&text_mutex);
+}
+#endif /* CONFIG_PARAVIRT_RUNTIME */
-- 
2.20.1
