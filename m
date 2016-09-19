From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v7 4/6] powerpc: lib/locks.c: Add cpu yield/wake helper
	function
Date: Mon, 19 Sep 2016 05:23:55 -0400
Message-ID: <1474277037-15200-5-git-send-email-xinhui.pan__4714.15942670337$1474262821$gmane$org@linux.vnet.ibm.com>
References: <1474277037-15200-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1474277037-15200-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: xinhui.pan@linux.vnet.ibm.com, peterz@infradead.org, benh@kernel.crashing.org, waiman.long@hpe.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, paulmck@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Add two corresponding helper functions to support pv-qspinlock.

For normal use, __spin_yield_cpu will confer current vcpu slices to the
target vcpu(say, a lock holder). If target vcpu is not specified or it
is in running state, such conferging to lpar happens or not depends.

Because hcall itself will introduce latency and a little overhead. And
we do NOT want to suffer any latency on some cases, e.g. in interrupt handler.
The second parameter *confer* can indicate such case.

__spin_wake_cpu is simpiler, it will wake up one vcpu regardless of its
current vcpu state.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/spinlock.h |  4 +++
 arch/powerpc/lib/locks.c            | 59 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 6aef8dd..abb6b0f 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -56,9 +56,13 @@
 /* We only yield to the hypervisor if we are in shared processor mode */
 #define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
 extern void __spin_yield(arch_spinlock_t *lock);
+extern void __spin_yield_cpu(int cpu, int confer);
+extern void __spin_wake_cpu(int cpu);
 extern void __rw_yield(arch_rwlock_t *lock);
 #else /* SPLPAR */
 #define __spin_yield(x)	barrier()
+#define __spin_yield_cpu(x,y) barrier()
+#define __spin_wake_cpu(x) barrier()
 #define __rw_yield(x)	barrier()
 #define SHARED_PROCESSOR	0
 #endif
diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
index 6574626..892df7d 100644
--- a/arch/powerpc/lib/locks.c
+++ b/arch/powerpc/lib/locks.c
@@ -23,6 +23,65 @@
 #include <asm/hvcall.h>
 #include <asm/smp.h>
 
+/*
+ * confer our slices to a specified cpu and return. If it is already running or
+ * cpu is -1, then we will check confer. If confer is NULL, we will return
+ * otherwise we confer our slices to lpar.
+ */
+void __spin_yield_cpu(int cpu, int confer)
+{
+	unsigned int holder_cpu = cpu, yield_count;
+
+	if (cpu == -1)
+		goto yield_to_lpar;
+
+	BUG_ON(holder_cpu >= nr_cpu_ids);
+	yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
+
+	/* if cpu is running, confer slices to lpar conditionally*/
+	if ((yield_count & 1) == 0)
+		goto yield_to_lpar;
+
+	plpar_hcall_norets(H_CONFER,
+		get_hard_smp_processor_id(holder_cpu), yield_count);
+	return;
+
+yield_to_lpar:
+	if (confer)
+		plpar_hcall_norets(H_CONFER, -1, 0);
+}
+EXPORT_SYMBOL_GPL(__spin_yield_cpu);
+
+void __spin_wake_cpu(int cpu)
+{
+	unsigned int holder_cpu = cpu;
+
+	BUG_ON(holder_cpu >= nr_cpu_ids);
+	/*
+	 * NOTE: we should always do this hcall regardless of
+	 * the yield_count of the holder_cpu.
+	 * as thers might be a case like below;
+	 * CPU 	1				2
+	 *				yielded = true
+	 *	if (yielded)
+	 * 	__spin_wake_cpu()
+	 * 				__spin_yield_cpu()
+	 *
+	 * So we might lose a wake if we check the yield_count and
+	 * return directly if the holder_cpu is running.
+	 * IOW. do NOT code like below.
+	 *  yield_count = be32_to_cpu(lppaca_of(holder_cpu).yield_count);
+	 *  if ((yield_count & 1) == 0)
+	 *  	return;
+	 *
+	 * a PROD hcall marks the target_cpu proded, which cause the next cede or confer
+	 * called on the target_cpu invalid.
+	 */
+	plpar_hcall_norets(H_PROD,
+		get_hard_smp_processor_id(holder_cpu));
+}
+EXPORT_SYMBOL_GPL(__spin_wake_cpu);
+
 #ifndef CONFIG_QUEUED_SPINLOCKS
 void __spin_yield(arch_spinlock_t *lock)
 {
-- 
2.4.11
