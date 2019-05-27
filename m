From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 5/6] x86/mm/tlb: Flush remote and local TLBs
	concurrently
Date: Mon, 27 May 2019 14:32:06 +0200
Message-ID: <20190527123206.GC2623@hirez.programming.kicks-ass.net>
References: <20190525082203.6531-1-namit@vmware.com>
	<20190525082203.6531-6-namit@vmware.com>
	<08b21fb5-2226-7924-30e3-31e4adcfc0a3@suse.com>
	<20190527094710.GU2623@hirez.programming.kicks-ass.net>
	<e9c0dc1f-799a-b6e3-8d41-58f0a6b693cd@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <e9c0dc1f-799a-b6e3-8d41-58f0a6b693cd@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Juergen Gross <jgross@suse.com>, Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, May 27, 2019 at 12:21:59PM +0200, Paolo Bonzini wrote:
> On 27/05/19 11:47, Peter Zijlstra wrote:

> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -580,7 +580,7 @@ static void __init kvm_apf_trap_init(voi
> >  
> >  static DEFINE_PER_CPU(cpumask_var_t, __pv_tlb_mask);
> >  
> > -static void kvm_flush_tlb_others(const struct cpumask *cpumask,
> > +static void kvm_flush_tlb_multi(const struct cpumask *cpumask,
> >  			const struct flush_tlb_info *info)
> >  {
> >  	u8 state;
> > @@ -594,6 +594,9 @@ static void kvm_flush_tlb_others(const s
> >  	 * queue flush_on_enter for pre-empted vCPUs
> >  	 */
> >  	for_each_cpu(cpu, flushmask) {
> > +		if (cpu == smp_processor_id())
> > +			continue;
> > +
> 
> Even this would be just an optimization; the vCPU you're running on
> cannot be preempted.  You can just change others to multi.

Yeah, I know, but it felt weird so I added the explicit skip. No strong
feelings though.
