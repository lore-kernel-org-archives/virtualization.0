From: Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] x86/paravirt: Guard against invalid cpu # in
	pv_vcpu_is_preempted()
Date: Mon, 25 Mar 2019 17:40:46 +0100
Message-ID: <e01da674-cbf0-22f1-7aba-6041f892b689__4717.80996756337$1553532063$gmane$org@suse.com>
References: <20190325155706.26987-1-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190325155706.26987-1-longman@redhat.com>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <longman@redhat.com>, Alok Kataria <akataria@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 25/03/2019 16:57, Waiman Long wrote:
> It was found that passing an invalid cpu number to pv_vcpu_is_preempted()
> might panic the kernel in a VM guest. For example,
> 
> [    2.531077] Oops: 0000 [#1] SMP PTI
>   :
> [    2.532545] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [    2.533321] RIP: 0010:__raw_callee_save___kvm_vcpu_is_preempted+0x0/0x20
> 
> To guard against this kind of kernel panic, check is added to
> pv_vcpu_is_preempted() to make sure that no invalid cpu number will
> be used.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/x86/include/asm/paravirt.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index c25c38a05c1c..4cfb465dcde4 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -671,6 +671,12 @@ static __always_inline void pv_kick(int cpu)
>  
>  static __always_inline bool pv_vcpu_is_preempted(long cpu)
>  {
> +	/*
> +	 * Guard against invalid cpu number or the kernel might panic.
> +	 */
> +	if (WARN_ON_ONCE((unsigned long)cpu >= nr_cpu_ids))
> +		return false;
> +
>  	return PVOP_CALLEE1(bool, lock.vcpu_is_preempted, cpu);
>  }

Can this really happen without being a programming error?

Basically you'd need to guard all percpu area accesses to foreign cpus
this way. Why is this one special?


Juergen
