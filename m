From: Quan Xu <quan.xu03@gmail.com>
Subject: [PATCH RFC v3 1/6] x86/paravirt: Add pv_idle_ops to paravirt ops
Date: Mon, 13 Nov 2017 18:06:00 +0800
Message-ID: <1510567565-5118-2-git-send-email-quan.xu0__42382.4179255918$1511414731$gmane$org@gmail.com>
References: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1510567565-5118-1-git-send-email-quan.xu0@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org, xen-devel@lists.xenproject.org
Cc: Yang Zhang <yang.zhang.wz@gmail.com>, Juergen Gross <jgross@suse.com>, Quan Xu <quan.xu0@gmail.com>, Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Quan Xu <quan.xu0@gmail.com>

So far, pv_idle_ops.poll is the only ops for pv_idle. .poll is called
in idle path which will poll for a while before we enter the real idle
state.

In virtualization, idle path includes several heavy operations
includes timer access(LAPIC timer or TSC deadline timer) which will
hurt performance especially for latency intensive workload like message
passing task. The cost is mainly from the vmexit which is a hardware
context switch between virtual machine and hypervisor. Our solution is
to poll for a while and do not enter real idle path if we can get the
schedule event during polling.

Poll may cause the CPU waste so we adopt a smart polling mechanism to
reduce the useless poll.

Signed-off-by: Yang Zhang <yang.zhang.wz@gmail.com>
Signed-off-by: Quan Xu <quan.xu0@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Alok Kataria <akataria@vmware.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/include/asm/paravirt.h       |    5 +++++
 arch/x86/include/asm/paravirt_types.h |    6 ++++++
 arch/x86/kernel/paravirt.c            |    6 ++++++
 3 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index fd81228..3c83727 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -198,6 +198,11 @@ static inline unsigned long long paravirt_read_pmc(int counter)
 
 #define rdpmcl(counter, val) ((val) = paravirt_read_pmc(counter))
 
+static inline void paravirt_idle_poll(void)
+{
+	PVOP_VCALL0(pv_idle_ops.poll);
+}
+
 static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
 {
 	PVOP_VCALL2(pv_cpu_ops.alloc_ldt, ldt, entries);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 10cc3b9..95c0e3e 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -313,6 +313,10 @@ struct pv_lock_ops {
 	struct paravirt_callee_save vcpu_is_preempted;
 } __no_randomize_layout;
 
+struct pv_idle_ops {
+	void (*poll)(void);
+} __no_randomize_layout;
+
 /* This contains all the paravirt structures: we get a convenient
  * number for each function using the offset which we use to indicate
  * what to patch. */
@@ -323,6 +327,7 @@ struct paravirt_patch_template {
 	struct pv_irq_ops pv_irq_ops;
 	struct pv_mmu_ops pv_mmu_ops;
 	struct pv_lock_ops pv_lock_ops;
+	struct pv_idle_ops pv_idle_ops;
 } __no_randomize_layout;
 
 extern struct pv_info pv_info;
@@ -332,6 +337,7 @@ struct paravirt_patch_template {
 extern struct pv_irq_ops pv_irq_ops;
 extern struct pv_mmu_ops pv_mmu_ops;
 extern struct pv_lock_ops pv_lock_ops;
+extern struct pv_idle_ops pv_idle_ops;
 
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 19a3e8f..67cab22 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -128,6 +128,7 @@ unsigned paravirt_patch_jmp(void *insnbuf, const void *target,
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 		.pv_lock_ops = pv_lock_ops,
 #endif
+		.pv_idle_ops = pv_idle_ops,
 	};
 	return *((void **)&tmpl + type);
 }
@@ -312,6 +313,10 @@ struct pv_time_ops pv_time_ops = {
 	.steal_clock = native_steal_clock,
 };
 
+struct pv_idle_ops pv_idle_ops = {
+	.poll = paravirt_nop,
+};
+
 __visible struct pv_irq_ops pv_irq_ops = {
 	.save_fl = __PV_IS_CALLEE_SAVE(native_save_fl),
 	.restore_fl = __PV_IS_CALLEE_SAVE(native_restore_fl),
@@ -463,3 +468,4 @@ struct pv_mmu_ops pv_mmu_ops __ro_after_init = {
 EXPORT_SYMBOL    (pv_mmu_ops);
 EXPORT_SYMBOL_GPL(pv_info);
 EXPORT_SYMBOL    (pv_irq_ops);
+EXPORT_SYMBOL    (pv_idle_ops);
-- 
1.7.1
