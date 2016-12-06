From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v9 6/6] powerpc/pv-qspinlock: Optimise native unlock path
Date: Tue,  6 Dec 2016 13:09:27 -0500
Message-ID: <1481047767-60255-7-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1481047767-60255-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
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
Cc: xinhui.pan@linux.vnet.ibm.com, peterz@infradead.org, benh@kernel.crashing.org, boqun.feng@gmail.com, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, longman@redhat.com, paulmck@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Avoid a function call under native version of qspinlock. On powerNV,
bafore applying this patch, every unlock is expensive. This small
optimizes enhance the performance.

We use static_key with jump_lable which removes unnecessary loads of
lppaca and its stuff.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/qspinlock_paravirt.h | 18 +++++++++++++++++-
 arch/powerpc/kernel/paravirt.c                |  4 ++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/qspinlock_paravirt.h b/arch/powerpc/include/asm/qspinlock_paravirt.h
index d87cda0..8d39446 100644
--- a/arch/powerpc/include/asm/qspinlock_paravirt.h
+++ b/arch/powerpc/include/asm/qspinlock_paravirt.h
@@ -6,12 +6,14 @@
 #define _ASM_QSPINLOCK_PARAVIRT_H
 
 #include  <asm/qspinlock_paravirt_types.h>
+#include  <linux/jump_label.h>
 
 extern void pv_lock_init(void);
 extern void native_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_init_lock_hash(void);
 extern void __pv_queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
 extern void __pv_queued_spin_unlock(struct qspinlock *lock);
+extern struct static_key_true sharedprocessor_key;
 
 static inline void pv_queued_spin_lock(struct qspinlock *lock, u32 val)
 {
@@ -20,7 +22,21 @@ static inline void pv_queued_spin_lock(struct qspinlock *lock, u32 val)
 
 static inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	pv_lock_op.unlock(lock);
+	/*
+	 * on powerNV and pSeries with jump_label, code will be
+	 *	PowerNV:		pSeries:
+	 *	nop;			b 2f;
+	 *	native unlock		2:
+	 *				pv unlock;
+	 * In this way, we can do unlock quick in native case.
+	 *
+	 * IF jump_label is not enabled, we fall back into
+	 * if condition, IOW, ld && cmp && bne.
+	 */
+	if (static_branch_likely(&sharedprocessor_key))
+		native_queued_spin_unlock(lock);
+	else
+		pv_lock_op.unlock(lock);
 }
 
 static inline void pv_wait(u8 *ptr, u8 val)
diff --git a/arch/powerpc/kernel/paravirt.c b/arch/powerpc/kernel/paravirt.c
index e697b17..a0a000e 100644
--- a/arch/powerpc/kernel/paravirt.c
+++ b/arch/powerpc/kernel/paravirt.c
@@ -140,6 +140,9 @@ struct pv_lock_ops pv_lock_op = {
 };
 EXPORT_SYMBOL(pv_lock_op);
 
+struct static_key_true sharedprocessor_key = STATIC_KEY_TRUE_INIT;
+EXPORT_SYMBOL(sharedprocessor_key);
+
 void __init pv_lock_init(void)
 {
 	if (SHARED_PROCESSOR) {
@@ -149,5 +152,6 @@ void __init pv_lock_init(void)
 		pv_lock_op.unlock = __pv_queued_spin_unlock;
 		pv_lock_op.wait = __pv_wait;
 		pv_lock_op.kick = __pv_kick;
+		static_branch_disable(&sharedprocessor_key);
 	}
 }
-- 
2.4.11
