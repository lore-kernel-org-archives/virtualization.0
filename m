From: Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 20/26] x86/paravirt: Enable pv-spinlocks in runtime_patch()
Date: Tue,  7 Apr 2020 22:03:17 -0700
Message-ID: <20200408050323.4237-21-ankur.a.arora@oracle.com>
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

Enable runtime patching of paravirt spinlocks. These can be trivially
enabled because pv_lock_ops are never preemptible -- preemption is
disabled at entry to spin_lock*().

Note that a particular CPU instance might get preempted in the host but
because runtime_patching() is called via stop_machine(), the migration
thread would flush out any kernel threads preempted in the host.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/paravirt.h  | 10 +++++-----
 arch/x86/kernel/paravirt_patch.c | 12 ++++++++++++
 kernel/locking/lock_events.c     |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 694d8daf4983..cb3d0a91c060 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -642,27 +642,27 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
 							u32 val)
 {
-	PVOP_VCALL2(lock.queued_spin_lock_slowpath, lock, val);
+	PVRTOP_VCALL2(lock.queued_spin_lock_slowpath, lock, val);
 }
 
 static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
-	PVOP_VCALLEE1(lock.queued_spin_unlock, lock);
+	PVRTOP_VCALLEE1(lock.queued_spin_unlock, lock);
 }
 
 static __always_inline void pv_wait(u8 *ptr, u8 val)
 {
-	PVOP_VCALL2(lock.wait, ptr, val);
+	PVRTOP_VCALL2(lock.wait, ptr, val);
 }
 
 static __always_inline void pv_kick(int cpu)
 {
-	PVOP_VCALL1(lock.kick, cpu);
+	PVRTOP_VCALL1(lock.kick, cpu);
 }
 
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
-	return PVOP_CALLEE1(bool, lock.vcpu_is_preempted, cpu);
+	return PVRTOP_CALLEE1(bool, lock.vcpu_is_preempted, cpu);
 }
 
 void __raw_callee_save___native_queued_spin_unlock(struct qspinlock *lock);
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_patch.c
index 3eb8c0e720b4..3f8606f2811c 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -152,6 +152,18 @@ int runtime_patch(u8 type, void *insn_buff, void *op,
 
 	/* Nothing whitelisted for now. */
 	switch (type) {
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+	/*
+	 * Preemption is always disabled in the lifetime of a spinlock
+	 * (whether held or while waiting to acquire.)
+	 */
+	case PARAVIRT_PATCH(lock.queued_spin_lock_slowpath):
+	case PARAVIRT_PATCH(lock.queued_spin_unlock):
+	case PARAVIRT_PATCH(lock.wait):
+	case PARAVIRT_PATCH(lock.kick):
+	case PARAVIRT_PATCH(lock.vcpu_is_preempted):
+		break;
+#endif
 	default:
 		pr_warn("type=%d unsuitable for runtime-patching\n", type);
 		return -EINVAL;
diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
index fa2c2f951c6b..c3057e82e6f9 100644
--- a/kernel/locking/lock_events.c
+++ b/kernel/locking/lock_events.c
@@ -115,7 +115,7 @@ static const struct file_operations fops_lockevent = {
 	.llseek = default_llseek,
 };
 
-#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#if defined(CONFIG_PARAVIRT_SPINLOCKS) && !defined(CONFIG_PARAVIRT_RUNTIME)
 #include <asm/paravirt.h>
 
 static bool __init skip_lockevent(const char *name)
-- 
2.20.1
