From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/6] x86/mm/tlb: Flush remote and local TLBs
	concurrently
Date: Mon, 27 May 2019 11:47:10 +0200
Message-ID: <20190527094710.GU2623__8084.14059444971$1558950467$gmane$org@hirez.programming.kicks-ass.net>
References: <20190525082203.6531-1-namit@vmware.com>
	<20190525082203.6531-6-namit@vmware.com>
	<08b21fb5-2226-7924-30e3-31e4adcfc0a3@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <08b21fb5-2226-7924-30e3-31e4adcfc0a3@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Juergen Gross <jgross@suse.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Hemminger <sthemmin@microsoft.com>, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, May 25, 2019 at 10:54:50AM +0200, Juergen Gross wrote:
> On 25/05/2019 10:22, Nadav Amit wrote:

> > diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> > index 946f8f1f1efc..3a156e63c57d 100644
> > --- a/arch/x86/include/asm/paravirt_types.h
> > +++ b/arch/x86/include/asm/paravirt_types.h
> > @@ -211,6 +211,12 @@ struct pv_mmu_ops {
> >  	void (*flush_tlb_user)(void);
> >  	void (*flush_tlb_kernel)(void);
> >  	void (*flush_tlb_one_user)(unsigned long addr);
> > +	/*
> > +	 * flush_tlb_multi() is the preferred interface. When it is used,
> > +	 * flush_tlb_others() should return false.
> 
> This comment does not make sense. flush_tlb_others() return type is
> void.

I suspect that is an artifact from before the static_key; an attempt to
make the pv interface less awkward.

Something like the below would work for KVM I suspect, the others
(Hyper-V and Xen are more 'interesting').

---
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -580,7 +580,7 @@ static void __init kvm_apf_trap_init(voi
 
 static DEFINE_PER_CPU(cpumask_var_t, __pv_tlb_mask);
 
-static void kvm_flush_tlb_others(const struct cpumask *cpumask,
+static void kvm_flush_tlb_multi(const struct cpumask *cpumask,
 			const struct flush_tlb_info *info)
 {
 	u8 state;
@@ -594,6 +594,9 @@ static void kvm_flush_tlb_others(const s
 	 * queue flush_on_enter for pre-empted vCPUs
 	 */
 	for_each_cpu(cpu, flushmask) {
+		if (cpu == smp_processor_id())
+			continue;
+
 		src = &per_cpu(steal_time, cpu);
 		state = READ_ONCE(src->preempted);
 		if ((state & KVM_VCPU_PREEMPTED)) {
@@ -603,7 +606,7 @@ static void kvm_flush_tlb_others(const s
 		}
 	}
 
-	native_flush_tlb_others(flushmask, info);
+	native_flush_tlb_multi(flushmask, info);
 }
 
 static void __init kvm_guest_init(void)
@@ -628,9 +631,8 @@ static void __init kvm_guest_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_PV_TLB_FLUSH) &&
 	    !kvm_para_has_hint(KVM_HINTS_REALTIME) &&
 	    kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
-		pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
+		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
 		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
-		static_key_disable(&flush_tlb_multi_enabled.key);
 	}
 
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
