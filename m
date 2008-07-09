From: Ingo Molnar <mingo@elte.hu>
Subject: [patch] x86: paravirt spinlocks, !CONFIG_SMP build fixes (was: Re:
	[PATCH RFC 0/4] Paravirtual spinlocks)
Date: Wed, 9 Jul 2008 14:35:03 +0200
Message-ID: <20080709123503.GA13610__7341.28908156908$1215607124$gmane$org@elte.hu>
References: <20080707190749.299430659@goop.org>
	<20080709122852.GA30579@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080709122852.GA30579@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jens Axboe <axboe@kernel.dk>, Nick Piggin <nickpiggin@yahoo.com.au>, Xen devel <xen-devel@lists.xensource.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Christoph Lameter <clameter@linux-foundation.org>, Petr Tesarik <ptesarik@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Virtualization <virtualization@lists.linux-foundation.org>, Thomas Friebel <thomas.friebel@amd.com>
List-Id: virtualization@lists.linuxfoundation.org


* Ingo Molnar <mingo@elte.hu> wrote:

> as there were no fundamental objections in this thread i've created a 
> tip/x86/paravirt-spinlocks topic branch for these patches and started 
> testing them.

small UP build fixes below.

	Ingo

----------------->
commit c77bc635bb0486b0ddbe03012a8662b399ae9cdb
Author: Ingo Molnar <mingo@elte.hu>
Date:   Wed Jul 9 14:33:33 2008 +0200

    x86: paravirt spinlocks, !CONFIG_SMP build fixes
    
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index bba4041..6aa8aed 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -270,11 +270,13 @@ enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
 
 void __init paravirt_use_bytelocks(void)
 {
+#ifdef CONFIG_SMP
 	pv_lock_ops.spin_is_locked = __byte_spin_is_locked;
 	pv_lock_ops.spin_is_contended = __byte_spin_is_contended;
 	pv_lock_ops.spin_lock = __byte_spin_lock;
 	pv_lock_ops.spin_trylock = __byte_spin_trylock;
 	pv_lock_ops.spin_unlock = __byte_spin_unlock;
+#endif
 }
 
 struct pv_info pv_info = {
@@ -461,12 +463,14 @@ struct pv_mmu_ops pv_mmu_ops = {
 };
 
 struct pv_lock_ops pv_lock_ops = {
+#ifdef CONFIG_SMP
 	.spin_is_locked = __ticket_spin_is_locked,
 	.spin_is_contended = __ticket_spin_is_contended,
 
 	.spin_lock = __ticket_spin_lock,
 	.spin_trylock = __ticket_spin_trylock,
 	.spin_unlock = __ticket_spin_unlock,
+#endif
 };
 
 EXPORT_SYMBOL_GPL(pv_time_ops);
diff --git a/include/asm-x86/paravirt.h b/include/asm-x86/paravirt.h
index 65ed02c..b2aba8f 100644
--- a/include/asm-x86/paravirt.h
+++ b/include/asm-x86/paravirt.h
@@ -1387,6 +1387,8 @@ void _paravirt_nop(void);
 
 void paravirt_use_bytelocks(void);
 
+#ifdef CONFIG_SMP
+
 static inline int __raw_spin_is_locked(struct raw_spinlock *lock)
 {
 	return PVOP_CALL1(int, pv_lock_ops.spin_is_locked, lock);
@@ -1412,6 +1414,8 @@ static __always_inline void __raw_spin_unlock(struct raw_spinlock *lock)
 	return PVOP_VCALL1(pv_lock_ops.spin_unlock, lock);
 }
 
+#endif
+
 /* These all sit in the .parainstructions section to tell us what to patch. */
 struct paravirt_patch_site {
 	u8 *instr; 		/* original instructions */
