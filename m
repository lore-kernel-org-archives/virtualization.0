From: Juergen Gross <jgross@suse.com>
Subject: [PATCH 4/6] x86: introduce new pvops function spin_unlock
Date: Thu, 30 Apr 2015 12:54:01 +0200
Message-ID: <1430391243-7112-5-git-send-email-jgross__31428.8644156933$1430453280$gmane$org@suse.com>
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

To speed up paravirtualized spinlock handling when running on bare
metal introduce a new pvops function "spin_unlock". This is a simple
add instruction (possibly with lock prefix) when the kernel is running
on bare metal.

As the patched instruction includes a lock prefix in some
configurations annotate this location to be subject to lock prefix
patching. This is working even if paravirtualization requires a call
instead of the unlock instruction, because patching the lock or it's
replacement is done only if the correct counterpart is found at the
location to be patched.

We even are not dependant on the order of lock prefix and
paravirtualization patching as the sample instruction is subject to
lock prefix patching as well.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h       |  6 ++++++
 arch/x86/include/asm/paravirt_types.h | 11 +++++++++++
 arch/x86/include/asm/spinlock.h       | 24 ++++++++++--------------
 arch/x86/kernel/paravirt-spinlocks.c  | 16 ++++++++++++++++
 arch/x86/kernel/paravirt.c            | 12 ++++++++++++
 arch/x86/kernel/paravirt_patch_32.c   | 25 +++++++++++++++++++++++++
 arch/x86/kernel/paravirt_patch_64.c   | 24 ++++++++++++++++++++++++
 7 files changed, 104 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 318f077..2f39129 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -730,6 +730,11 @@ static __always_inline void __ticket_clear_slowpath(arch_spinlock_t *lock,
 	PVOP_VCALL2(pv_lock_ops.clear_slowpath, lock, head);
 }
 
+static __always_inline void __ticket_unlock(arch_spinlock_t *lock)
+{
+	PVOP_VCALL1_LOCK(pv_lock_ops.unlock, lock);
+}
+
 void pv_lock_activate(void);
 #endif
 
@@ -843,6 +848,7 @@ static inline notrace unsigned long arch_local_irq_save(void)
 #undef PVOP_VCALL0
 #undef PVOP_CALL0
 #undef PVOP_VCALL1
+#undef PVOP_VCALL1_LOCK
 #undef PVOP_CALL1
 #undef PVOP_VCALL2
 #undef PVOP_CALL2
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 3432713..a26af74 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -337,6 +337,7 @@ struct pv_lock_ops {
 	struct paravirt_callee_save lock_spinning;
 	void (*unlock_kick)(struct arch_spinlock *lock, __ticket_t ticket);
 	void (*clear_slowpath)(arch_spinlock_t *lock, __ticket_t head);
+	void (*unlock)(arch_spinlock_t *lock);
 };
 
 /* This contains all the paravirt structures: we get a convenient
@@ -398,6 +399,7 @@ extern struct pv_lock_ops pv_lock_ops;
 unsigned paravirt_patch_nop(void);
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len);
 unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len);
+unsigned paravirt_patch_unlock(void *insnbuf, unsigned len);
 unsigned paravirt_patch_ignore(unsigned len);
 unsigned paravirt_patch_call(void *insnbuf,
 			     const void *target, u16 tgt_clobbers,
@@ -620,6 +622,12 @@ int paravirt_disable_iospace(void);
 	__PVOP_CALL(rettype, op, "", "", PVOP_CALL_ARG1(arg1))
 #define PVOP_VCALL1(op, arg1)						\
 	__PVOP_VCALL(op, "", "", PVOP_CALL_ARG1(arg1))
+/*
+ * Using LOCK_PREFIX_HERE works because the lock prefix or it's replacement
+ * is checked to be present before being replaced.
+ */
+#define PVOP_VCALL1_LOCK(op, arg1)					\
+	__PVOP_VCALL(op, LOCK_PREFIX_HERE, "", PVOP_CALL_ARG1(arg1))
 
 #define PVOP_CALLEE1(rettype, op, arg1)					\
 	__PVOP_CALLEESAVE(rettype, op, "", "", PVOP_CALL_ARG1(arg1))
@@ -690,6 +698,9 @@ void paravirt_flush_lazy_mmu(void);
 void _paravirt_nop(void);
 u32 _paravirt_ident_32(u32);
 u64 _paravirt_ident_64(u64);
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+void _paravirt_native_ticket_unlock(arch_spinlock_t *lock);
+#endif
 
 #define paravirt_nop	((void *)_paravirt_nop)
 
diff --git a/arch/x86/include/asm/spinlock.h b/arch/x86/include/asm/spinlock.h
index ab76c3e..40a1091 100644
--- a/arch/x86/include/asm/spinlock.h
+++ b/arch/x86/include/asm/spinlock.h
@@ -42,6 +42,10 @@
 extern struct static_key paravirt_ticketlocks_enabled;
 static __always_inline bool static_key_false(struct static_key *key);
 
+static inline void ___ticket_unlock(arch_spinlock_t *lock)
+{
+	__add(&lock->tickets.head, TICKET_LOCK_INC, UNLOCK_LOCK_PREFIX);
+}
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 
 static inline void __ticket_enter_slowpath(arch_spinlock_t *lock)
@@ -64,6 +68,11 @@ static inline void __ticket_clear_slowpath(arch_spinlock_t *lock,
 					   __ticket_t head)
 {
 }
+
+static inline void __ticket_unlock(arch_spinlock_t *lock)
+{
+	___ticket_unlock(lock);
+}
 #endif /* CONFIG_PARAVIRT_SPINLOCKS */
 static inline int  __tickets_equal(__ticket_t one, __ticket_t two)
 {
@@ -131,20 +140,7 @@ static __always_inline int arch_spin_trylock(arch_spinlock_t *lock)
 
 static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
 {
-	if (TICKET_SLOWPATH_FLAG &&
-		static_key_false(&paravirt_ticketlocks_enabled)) {
-		__ticket_t head;
-
-		BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
-
-		head = xadd(&lock->tickets.head, TICKET_LOCK_INC);
-
-		if (unlikely(head & TICKET_SLOWPATH_FLAG)) {
-			head &= ~TICKET_SLOWPATH_FLAG;
-			__ticket_unlock_kick(lock, (head + TICKET_LOCK_INC));
-		}
-	} else
-		__add(&lock->tickets.head, TICKET_LOCK_INC, UNLOCK_LOCK_PREFIX);
+	__ticket_unlock(lock);
 }
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index 5ece813..91273fb 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -22,9 +22,24 @@ static void pv_ticket_clear_slowpath(arch_spinlock_t *lock, __ticket_t head)
 	cmpxchg(&lock->head_tail, old.head_tail, new.head_tail);
 }
 
+static void pv_ticket_unlock(arch_spinlock_t *lock)
+{
+	__ticket_t head;
+
+	BUILD_BUG_ON(((__ticket_t)NR_CPUS) != NR_CPUS);
+
+	head = xadd(&lock->tickets.head, TICKET_LOCK_INC);
+
+	if (unlikely(head & TICKET_SLOWPATH_FLAG)) {
+		head &= ~TICKET_SLOWPATH_FLAG;
+		__ticket_unlock_kick(lock, (head + TICKET_LOCK_INC));
+	}
+}
+
 void pv_lock_activate(void)
 {
 	pv_lock_ops.clear_slowpath = pv_ticket_clear_slowpath;
+	pv_lock_ops.unlock = pv_ticket_unlock;
 }
 EXPORT_SYMBOL_GPL(pv_lock_activate);
 #endif
@@ -34,6 +49,7 @@ struct pv_lock_ops pv_lock_ops = {
 	.lock_spinning = __PV_IS_CALLEE_SAVE(paravirt_nop),
 	.unlock_kick = paravirt_nop,
 	.clear_slowpath = paravirt_nop,
+	.unlock = _paravirt_native_ticket_unlock,
 #endif
 };
 EXPORT_SYMBOL(pv_lock_ops);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index c614dd4..5c5e9f1 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -57,6 +57,13 @@ u64 _paravirt_ident_64(u64 x)
 	return x;
 }
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+void _paravirt_native_ticket_unlock(arch_spinlock_t *lock)
+{
+	___ticket_unlock(lock);
+}
+#endif
+
 void __init default_banner(void)
 {
 	printk(KERN_INFO "Booting paravirtualized kernel on %s\n",
@@ -153,6 +160,11 @@ unsigned paravirt_patch_default(u8 type, u16 clobbers, void *insnbuf,
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insnbuf, len);
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+	else if (opfunc == _paravirt_native_ticket_unlock)
+		ret = paravirt_patch_unlock(insnbuf, len);
+#endif
+
 	else if (type == PARAVIRT_PATCH(pv_cpu_ops.iret) ||
 		 type == PARAVIRT_PATCH(pv_cpu_ops.irq_enable_sysexit) ||
 		 type == PARAVIRT_PATCH(pv_cpu_ops.usergs_sysret32) ||
diff --git a/arch/x86/kernel/paravirt_patch_32.c b/arch/x86/kernel/paravirt_patch_32.c
index d9f32e6..628c23b 100644
--- a/arch/x86/kernel/paravirt_patch_32.c
+++ b/arch/x86/kernel/paravirt_patch_32.c
@@ -1,4 +1,6 @@
 #include <asm/paravirt.h>
+#include <asm/spinlock.h>
+#include <linux/stringify.h>
 
 DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
 DEF_NATIVE(pv_irq_ops, irq_enable, "sti");
@@ -12,6 +14,14 @@ DEF_NATIVE(pv_mmu_ops, read_cr3, "mov %cr3, %eax");
 DEF_NATIVE(pv_cpu_ops, clts, "clts");
 DEF_NATIVE(pv_cpu_ops, read_tsc, "rdtsc");
 
+DEF_NATIVE(, unlock1, UNLOCK_LOCK_PREFIX
+		      "addb $"__stringify(__TICKET_LOCK_INC)", (%eax)");
+DEF_NATIVE(, unlock2, UNLOCK_LOCK_PREFIX
+		      "addw $"__stringify(__TICKET_LOCK_INC)", (%eax)");
+
+extern void __unlock_wrong_size(void)
+	__compiletime_error("Bad argument size for unlock");
+
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
 {
 	/* arg in %eax, return in %eax */
@@ -24,6 +34,21 @@ unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 	return 0;
 }
 
+unsigned paravirt_patch_unlock(void *insnbuf, unsigned len)
+{
+	switch (sizeof(__ticket_t)) {
+	case __X86_CASE_B:
+		return paravirt_patch_insns(insnbuf, len,
+					    start__unlock1, end__unlock1);
+	case __X86_CASE_W:
+		return paravirt_patch_insns(insnbuf, len,
+					    start__unlock2, end__unlock2);
+	default:
+		__unlock_wrong_size();
+	}
+	return 0;
+}
+
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len)
 {
diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index a1da673..dc4d9af 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -1,5 +1,6 @@
 #include <asm/paravirt.h>
 #include <asm/asm-offsets.h>
+#include <asm/spinlock.h>
 #include <linux/stringify.h>
 
 DEF_NATIVE(pv_irq_ops, irq_disable, "cli");
@@ -21,6 +22,14 @@ DEF_NATIVE(pv_cpu_ops, swapgs, "swapgs");
 DEF_NATIVE(, mov32, "mov %edi, %eax");
 DEF_NATIVE(, mov64, "mov %rdi, %rax");
 
+DEF_NATIVE(, unlock1, UNLOCK_LOCK_PREFIX
+			"addb $"__stringify(__TICKET_LOCK_INC)", (%rdi)");
+DEF_NATIVE(, unlock2, UNLOCK_LOCK_PREFIX
+			"addw $"__stringify(__TICKET_LOCK_INC)", (%rdi)");
+
+extern void __unlock_wrong_size(void)
+	__compiletime_error("Bad argument size for unlock");
+
 unsigned paravirt_patch_ident_32(void *insnbuf, unsigned len)
 {
 	return paravirt_patch_insns(insnbuf, len,
@@ -33,6 +42,21 @@ unsigned paravirt_patch_ident_64(void *insnbuf, unsigned len)
 				    start__mov64, end__mov64);
 }
 
+unsigned paravirt_patch_unlock(void *insnbuf, unsigned len)
+{
+	switch (sizeof(__ticket_t)) {
+	case __X86_CASE_B:
+		return paravirt_patch_insns(insnbuf, len,
+					    start__unlock1, end__unlock1);
+	case __X86_CASE_W:
+		return paravirt_patch_insns(insnbuf, len,
+					    start__unlock2, end__unlock2);
+	default:
+		__unlock_wrong_size();
+	}
+	return 0;
+}
+
 unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 		      unsigned long addr, unsigned len)
 {
-- 
2.1.4
