From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 26/26] x86/kvm: Add hint change notifier for KVM_HINT_REALTIME
Date: Tue,  7 Apr 2020 22:03:23 -0700
Message-ID: <20200408050323.4237-27-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: peterz@infradead.org, hpa@zytor.com, jpoimboe@redhat.com, namit@vmware.com, mhiramat@kernel.org, jgross@suse.com, bp@alien8.de, vkuznets@redhat.com, pbonzini@redhat.com, boris.ostrovsky@oracle.com, mihai.carabas@oracle.com, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, virtualization@lists.linux-foundation.org, Ankur Arora <ankur.a.arora@oracle.com>, Joao Martins <joao.m.martins@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Add a blocking notifier that triggers when the host sends a hint
change notification.

Suggested-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/kvm_para.h | 10 ++++++++++
 arch/x86/kernel/kvm.c           | 16 ++++++++++++++++
 include/asm-generic/kvm_para.h  |  8 ++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 5a7ca5639c2e..54c3c7a3225e 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_KVM_PARA_H
 #define _ASM_X86_KVM_PARA_H
 
+#include <linux/notifier.h>
 #include <asm/processor.h>
 #include <asm/alternative.h>
 #include <uapi/asm/kvm_para.h>
@@ -96,6 +97,9 @@ extern void kvm_disable_steal_time(void);
 void do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
 void kvm_callback_vector(struct pt_regs *regs);
 
+void kvm_realtime_notifier_register(struct notifier_block *nb);
+void kvm_realtime_notifier_unregister(struct notifier_block *nb);
+
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 void __init kvm_spinlock_init(void);
 #else /* !CONFIG_PARAVIRT_SPINLOCKS */
@@ -137,6 +141,14 @@ static inline void kvm_disable_steal_time(void)
 {
 	return;
 }
+
+static inline void kvm_realtime_notifier_register(struct notifier_block *nb)
+{
+}
+
+static inline void kvm_realtime_notifier_unregister(struct notifier_block *nb)
+{
+}
 #endif
 
 #endif /* _ASM_X86_KVM_PARA_H */
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 163b7a7ec5f9..35ba4a837027 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -951,6 +951,20 @@ void __init kvm_spinlock_init(void)
 static inline bool kvm_pv_spinlock(void) { return false; }
 #endif	/* CONFIG_PARAVIRT_SPINLOCKS */
 
+static BLOCKING_NOTIFIER_HEAD(realtime_notifier);
+
+void kvm_realtime_notifier_register(struct notifier_block *nb)
+{
+	blocking_notifier_chain_register(&realtime_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(kvm_realtime_notifier_register);
+
+void kvm_realtime_notifier_unregister(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&realtime_notifier, nb);
+}
+EXPORT_SYMBOL_GPL(kvm_realtime_notifier_unregister);
+
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 
 static void kvm_disable_host_haltpoll(void *i)
@@ -1004,6 +1018,8 @@ void kvm_trigger_reprobe_cpuid(struct work_struct *work)
 	paravirt_runtime_patch(true);
 
 	mutex_unlock(&text_mutex);
+
+	blocking_notifier_call_chain(&realtime_notifier, 0, NULL);
 }
 
 static DECLARE_WORK(trigger_reprobe, kvm_trigger_reprobe_cpuid);
diff --git a/include/asm-generic/kvm_para.h b/include/asm-generic/kvm_para.h
index 4a575299ad62..d443531b49ac 100644
--- a/include/asm-generic/kvm_para.h
+++ b/include/asm-generic/kvm_para.h
@@ -33,4 +33,12 @@ static inline bool kvm_para_available(void)
 	return false;
 }
 
+static inline void kvm_realtime_notifier_register(struct notifier_block *nb)
+{
+}
+
+static inline void kvm_realtime_notifier_unregister(struct notifier_block *nb)
+{
+}
+
 #endif
-- 
2.20.1
