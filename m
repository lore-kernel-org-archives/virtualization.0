From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: [PATCH RFC V7 7/12] x86/pvticketlock: use callee-save for
	lock_spinning
Date: Fri, 20 Apr 2012 01:45:00 +0530
Message-ID: <20120419201456.5411.85454.sendpatchset__9135.79952107302$1334866545$gmane$org@codeblue>
References: <20120419201209.5411.43877.sendpatchset@codeblue>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120419201209.5411.43877.sendpatchset@codeblue>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>
Cc: Andrew Jones <drjones@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, Virtualization <virtualization@lists.linux-foundation.org>, Andi Kleen <andi@firstfloor.org>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Attilio Rao <attilio.rao@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>, Xen Devel <xen-devel@lists.xensource.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Although the lock_spinning calls in the spinlock code are on the
uncommon path, their presence can cause the compiler to generate many
more register save/restores in the function pre/postamble, which is in
the fast path.  To avoid this, convert it to using the pvops callee-save
calling convention, which defers all the save/restores until the actual
function is called, keeping the fastpath clean.

Signed-off-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Tested-by: Attilio Rao <attilio.rao@citrix.com> 
Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/x86/include/asm/paravirt.h       |    2 +-
 arch/x86/include/asm/paravirt_types.h |    2 +-
 arch/x86/kernel/paravirt-spinlocks.c  |    2 +-
 arch/x86/xen/spinlock.c               |    3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 4bcd146..9769096 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -754,7 +754,7 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 static __always_inline void __ticket_lock_spinning(struct arch_spinlock *lock,
 							__ticket_t ticket)
 {
-	PVOP_VCALL2(pv_lock_ops.lock_spinning, lock, ticket);
+	PVOP_VCALLEE2(pv_lock_ops.lock_spinning, lock, ticket);
 }
 
 static __always_inline void ____ticket_unlock_kick(struct arch_spinlock *lock,
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 005e24d..5e0c138 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -330,7 +330,7 @@ struct arch_spinlock;
 #include <asm/spinlock_types.h>
 
 struct pv_lock_ops {
-	void (*lock_spinning)(struct arch_spinlock *lock, __ticket_t ticket);
+	struct paravirt_callee_save lock_spinning;
 	void (*unlock_kick)(struct arch_spinlock *lock, __ticket_t ticket);
 };
 
diff --git a/arch/x86/kernel/paravirt-spinlocks.c b/arch/x86/kernel/paravirt-spinlocks.c
index c2e010e..4251c1d 100644
--- a/arch/x86/kernel/paravirt-spinlocks.c
+++ b/arch/x86/kernel/paravirt-spinlocks.c
@@ -9,7 +9,7 @@
 
 struct pv_lock_ops pv_lock_ops = {
 #ifdef CONFIG_SMP
-	.lock_spinning = paravirt_nop,
+	.lock_spinning = __PV_IS_CALLEE_SAVE(paravirt_nop),
 	.unlock_kick = paravirt_nop,
 #endif
 };
diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index c9bf890..b0cdde1 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -173,6 +173,7 @@ out:
 	local_irq_restore(flags);
 	spin_time_accum_blocked(start);
 }
+PV_CALLEE_SAVE_REGS_THUNK(xen_lock_spinning);
 
 static void xen_unlock_kick(struct arch_spinlock *lock, __ticket_t next)
 {
@@ -232,7 +233,7 @@ void __init xen_init_spinlocks(void)
 		return;
 	}
 
-	pv_lock_ops.lock_spinning = xen_lock_spinning;
+	pv_lock_ops.lock_spinning = PV_CALLEE_SAVE(xen_lock_spinning);
 	pv_lock_ops.unlock_kick = xen_unlock_kick;
 }
