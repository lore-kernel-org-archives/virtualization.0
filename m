From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH delta V13 14/14] kvm : Paravirtual ticketlocks support
	for linux guests running on KVM hypervisor
Date: Wed, 14 Aug 2013 01:32:11 +0530
Message-ID: <20130813200211.GA27811__41460.2446173832$1376423789$gmane$org@linux.vnet.ibm.com>
References: <y>
	<1376058122-8248-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<1376058122-8248-15-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
	<20130810193849.GA25260@linux.vnet.ibm.com>
	<520A620B.6070702@zytor.com> <20130813165552.GA6795@gmail.com>
Reply-To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130813165552.GA6795@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@kernel.org>
Cc: jeremy@goop.org, x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, riel@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Suzuki Poulose <suzuki@in.ibm.com>, habanero@linux.vnet.ibm.com, drjones@redhat.com, konrad.wilk@oracle.com, Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, gregkh@suse.de, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

* Ingo Molnar <mingo@kernel.org> [2013-08-13 18:55:52]:

> Would be nice to have a delta fix patch against tip:x86/spinlocks, which 
> I'll then backmerge into that series via rebasing it.
> 

There was a namespace collision of PER_CPU lock_waiting variable when
we have both Xen and KVM enabled. 

Perhaps this week wasn't for me. Had run 100 times randconfig in a loop
for the fix sent earlier :(. 

Ingo, below delta patch should fix it, IIRC, I hope you will be folding this
back to patch 14/14 itself. Else please let me.
I have already run allnoconfig, allyesconfig, randconfig with below patch. But will
test again. This should apply on top of tip:x86/spinlocks.

---8<---
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

Fix Namespace collision for lock_waiting

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index d442471..b8ef630 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -673,7 +673,7 @@ struct kvm_lock_waiting {
 static cpumask_t waiting_cpus;
 
 /* Track spinlock on which a cpu is waiting */
-static DEFINE_PER_CPU(struct kvm_lock_waiting, lock_waiting);
+static DEFINE_PER_CPU(struct kvm_lock_waiting, klock_waiting);
 
 static void kvm_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
 {
@@ -685,7 +685,7 @@ static void kvm_lock_spinning(struct arch_spinlock *lock, __ticket_t want)
 	if (in_nmi())
 		return;
 
-	w = &__get_cpu_var(lock_waiting);
+	w = &__get_cpu_var(klock_waiting);
 	cpu = smp_processor_id();
 	start = spin_time_start();
 
@@ -756,7 +756,7 @@ static void kvm_unlock_kick(struct arch_spinlock *lock, __ticket_t ticket)
 
 	add_stats(RELEASED_SLOW, 1);
 	for_each_cpu(cpu, &waiting_cpus) {
-		const struct kvm_lock_waiting *w = &per_cpu(lock_waiting, cpu);
+		const struct kvm_lock_waiting *w = &per_cpu(klock_waiting, cpu);
 		if (ACCESS_ONCE(w->lock) == lock &&
 		    ACCESS_ONCE(w->want) == ticket) {
 			add_stats(RELEASED_SLOW_KICKED, 1);
