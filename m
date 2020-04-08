From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 09/26] x86/paravirt: Add runtime_patch()
Date: Tue,  7 Apr 2020 22:03:06 -0700
Message-ID: <20200408050323.4237-10-ankur.a.arora@oracle.com>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <xen-devel-bounces@lists.xenproject.org>
In-Reply-To: <20200408050323.4237-1-ankur.a.arora@oracle.com>
List-Unsubscribe: <https://lists.xenproject.org/mailman/options/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xenproject.org>
List-Help: <mailto:xen-devel-request@lists.xenproject.org?subject=help>
List-Subscribe: <https://lists.xenproject.org/mailman/listinfo/xen-devel>,
 <mailto:xen-devel-request@lists.xenproject.org?subject=subscribe>
Errors-To: xen-devel-bounces@lists.xenproject.org
Sender: "Xen-devel" <xen-devel-bounces@lists.xenproject.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: jgross@suse.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, peterz@infradead.org, hpa@zytor.com, Ankur Arora <ankur.a.arora@oracle.com>, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, vkuznets@redhat.com, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

runtime_patch() generates insn sequences for patching supported pv_ops.
It does this by calling paravirt_patch_default() or native_patch()
dpending on if the target is a paravirt or native pv-op.

In addition, runtime_patch() also whitelists pv-ops that are safe to
patch at runtime.

The static conditions that need to be satisfied to patch safely:
 - Insn sequences under replacement need to execute without preemption.
   This is meant to avoid scenarios where a call-site (ex.
   lock.vcpu_is_preempted) switches between the following sequences:

  lock.vcpu_is_preempted = __raw_callee_save___kvm_vcpu_is_preempted
    0: e8 31 e6 ff ff		callq  0xffffffffffffe636
    4: 66 90			xchg   %ax,%ax      # NOP2

  lock.vcpu_is_preempted = __raw_callee_save___native_vcpu_is_preempted
    0: 31 c0			xor   %rax, %rax
    2: 0f 1f 44 00 00		nopl   0x0(%rax)    # NOP5

   If kvm_vcpu_is_preempted() were preemptible, then, post patching
   we would return to address 4 above, which is in the middle of an
   instruction for native_vcpu_is_preempted().

   Even if this were to be made safe (ex. by changing the NOP2 to be a
   prefix instead of a suffix), it would still not be enough -- since
   we do not want any code from the switched out pv-op to be executing
   after the pv-op has been switched out.

 - Entered only at the beginning: this allows us to use text_poke()
   which uses INT3 as a barrier.

We don't store the address inside any call-sites so the second can be
assumed.

Guaranteeing the first condition boils down to stating that any pv-op
being patched cannot be present/referenced from any call-stack in the
system. pv-ops that are not obviously non-preemptible need to be
enclosed in preempt_disable_runtime_patch()/preempt_enable_runtime_patch().

This should be sufficient because runtime_patch() itself is called from
a stop_machine() context which would would be enough to flush out any
non-preemptible sequences.

Note that preemption in the host is okay: stop_machine() would unwind
any pv-ops sleeping in the host.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/paravirt_types.h |  8 +++++
 arch/x86/kernel/paravirt.c            |  6 +---
 arch/x86/kernel/paravirt_patch.c      | 49 +++++++++++++++++++++++++++
 include/linux/preempt.h               | 17 ++++++++++
 4 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index bc935eec7ec6..3b9f6c105397 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -350,6 +350,12 @@ extern struct paravirt_patch_template native_pv_ops;
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
+/*
+ * Neat trick to map patch type back to the call within the
+ * corresponding structure.
+ */
+#define PARAVIRT_PATCH_OP(ops, type) (*(long *)(&((long **)&(ops))[type]))
+
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
 	[paravirt_opptr] "i" (&(pv_ops.op))
@@ -383,6 +389,8 @@ unsigned paravirt_patch_default(u8 type, void *insn_buff, unsigned long addr, un
 unsigned paravirt_patch_insns(void *insn_buff, unsigned len, const char *start, const char *end);
 
 unsigned native_patch(u8 type, void *insn_buff, unsigned long addr, unsigned len);
+int runtime_patch(u8 type, void *insn_buff, void *op, unsigned long addr,
+		  unsigned int len);
 
 int paravirt_disable_iospace(void);
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 8c511cc4d4f4..c4128436b05a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -117,11 +117,7 @@ void __init native_pv_lock_init(void)
 unsigned paravirt_patch_default(u8 type, void *insn_buff,
 				unsigned long addr, unsigned len)
 {
-	/*
-	 * Neat trick to map patch type back to the call within the
-	 * corresponding structure.
-	 */
-	void *opfunc = *((void **)&pv_ops + type);
+	void *opfunc = (void *)PARAVIRT_PATCH_OP(pv_ops, type);
 	unsigned ret;
 
 	if (opfunc == NULL)
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index 3eff63c090d2..3eb8c0e720b4 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/stringify.h>
+#include <linux/errno.h>
 
 #include <asm/paravirt.h>
 #include <asm/asm-offsets.h>
@@ -124,3 +125,51 @@ unsigned int native_patch(u8 type, void *insn_buff, unsigned long addr,
 
 	return paravirt_patch_default(type, insn_buff, addr, len);
 }
+
+#ifdef CONFIG_PARAVIRT_RUNTIME
+/**
+ * runtime_patch - Generate patching code for a native/paravirt op
+ * @type: op type to generate code for
+ * @insn_buff: destination buffer
+ * @op: op target
+ * @addr: call site address
+ * @len: length of insn_buff
+ *
+ * Note that pv-ops are only suitable for runtime patching if they are
+ * non-preemptible. This is necessary for two reasons: we don't want to
+ * be overwriting insn sequences which might be referenced from call-stacks
+ * (and thus would be returned to), and we want patching to act as a barrier
+ * so no code from now stale paravirt ops should execute after an op has
+ * changed.
+ *
+ * Return: size of insn sequence on success, -EINVAL on error.
+ */
+int runtime_patch(u8 type, void *insn_buff, void *op,
+		  unsigned long addr, unsigned int len)
+{
+	void *native_op;
+	int used = 0;
+
+	/* Nothing whitelisted for now. */
+	switch (type) {
+	default:
+		pr_warn("type=%d unsuitable for runtime-patching\n", type);
+		return -EINVAL;
+	}
+
+	if (PARAVIRT_PATCH_OP(pv_ops, type) != (long)op)
+		PARAVIRT_PATCH_OP(pv_ops, type) = (long)op;
+
+	native_op = (void *)PARAVIRT_PATCH_OP(native_pv_ops, type);
+
+	/*
+	 * Use native_patch() to get the right insns if we are switching
+	 * back to a native_op.
+	 */
+	if (op == native_op)
+		used = native_patch(type, insn_buff, addr, len);
+	else
+		used = paravirt_patch_default(type, insn_buff, addr, len);
+	return used;
+}
+#endif /* CONFIG_PARAVIRT_RUNTIME */
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index bc3f1aecaa19..c569d077aab2 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -203,6 +203,13 @@ do { \
 		__preempt_schedule(); \
 } while (0)
 
+/*
+ * preempt_enable_no_resched() so we don't add any preemption points until
+ * after the caller has returned.
+ */
+#define preempt_enable_runtime_patch()	preempt_enable_no_resched()
+#define preempt_disable_runtime_patch()	preempt_disable()
+
 #else /* !CONFIG_PREEMPTION */
 #define preempt_enable() \
 do { \
@@ -217,6 +224,12 @@ do { \
 } while (0)
 
 #define preempt_check_resched() do { } while (0)
+
+/*
+ * NOP, if there's no preemption.
+ */
+#define preempt_disable_runtime_patch()	do { } while (0)
+#define preempt_enable_runtime_patch()	do { } while (0)
 #endif /* CONFIG_PREEMPTION */
 
 #define preempt_disable_notrace() \
@@ -250,6 +263,8 @@ do { \
 #define preempt_enable_notrace()		barrier()
 #define preemptible()				0
 
+#define preempt_disable_runtime_patch()	do { } while (0)
+#define preempt_enable_runtime_patch()	do { } while (0)
 #endif /* CONFIG_PREEMPT_COUNT */
 
 #ifdef MODULE
@@ -260,6 +275,8 @@ do { \
 #undef preempt_enable_no_resched
 #undef preempt_enable_no_resched_notrace
 #undef preempt_check_resched
+#undef preempt_disable_runtime_patch
+#undef preempt_enable_runtime_patch
 #endif
 
 #define preempt_set_need_resched() \
-- 
2.20.1
