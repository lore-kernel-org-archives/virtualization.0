From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 4/9] x86/mm/tlb: Flush remote and local TLBs
	concurrently
Date: Mon, 22 Jul 2019 21:14:33 +0200
Message-ID: <20190722191433.GD6698@worktop.programming.kicks-ass.net>
References: <20190719005837.4150-1-namit@vmware.com>
	<20190719005837.4150-5-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190719005837.4150-5-namit@vmware.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nadav Amit <namit@vmware.com>
Cc: Sasha Levin <sashal@kernel.org>, Juergen Gross <jgross@suse.com>, linux-hyperv@vger.kernel.org, x86@kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jul 18, 2019 at 05:58:32PM -0700, Nadav Amit wrote:
> @@ -709,8 +716,9 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
>  	 * doing a speculative memory access.
>  	 */
>  	if (info->freed_tables) {
> -		smp_call_function_many(cpumask, flush_tlb_func_remote,
> -			       (void *)info, 1);
> +		__smp_call_function_many(cpumask, flush_tlb_func_remote,
> +					 flush_tlb_func_local,
> +					 (void *)info, 1);
>  	} else {
>  		/*
>  		 * Although we could have used on_each_cpu_cond_mask(),
> @@ -737,7 +745,8 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
>  			if (tlb_is_not_lazy(cpu))
>  				__cpumask_set_cpu(cpu, cond_cpumask);
>  		}
> -		smp_call_function_many(cond_cpumask, flush_tlb_func_remote,
> +		__smp_call_function_many(cond_cpumask, flush_tlb_func_remote,
> +					 flush_tlb_func_local,
>  					 (void *)info, 1);
>  	}
>  }

Do we really need that _local/_remote distinction? ISTR you had a patch
that frobbed flush_tlb_info into the csd and that gave space
constraints, but I'm not seeing that here (probably a wise, get stuff
merged etc..).

struct __call_single_data {
        struct llist_node          llist;                /*     0     8 */
        smp_call_func_t            func;                 /*     8     8 */
        void *                     info;                 /*    16     8 */
        unsigned int               flags;                /*    24     4 */

        /* size: 32, cachelines: 1, members: 4 */
        /* padding: 4 */
        /* last cacheline: 32 bytes */
};

struct flush_tlb_info {
        struct mm_struct *         mm;                   /*     0     8 */
        long unsigned int          start;                /*     8     8 */
        long unsigned int          end;                  /*    16     8 */
        u64                        new_tlb_gen;          /*    24     8 */
        unsigned int               stride_shift;         /*    32     4 */
        bool                       freed_tables;         /*    36     1 */

        /* size: 40, cachelines: 1, members: 6 */
        /* padding: 3 */
        /* last cacheline: 40 bytes */
};

IIRC what you did was make void *__call_single_data::info the last
member and a union until the full cacheline size (64). Given the above
that would get us 24 bytes for csd, leaving us 40 for that
flush_tlb_info.

But then we can still do something like the below, which doesn't change
things and still gets rid of that dual function crud, simplifying
smp_call_function_many again.

Index: linux-2.6/arch/x86/include/asm/tlbflush.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/tlbflush.h
+++ linux-2.6/arch/x86/include/asm/tlbflush.h
@@ -546,8 +546,9 @@ struct flush_tlb_info {
 	unsigned long		start;
 	unsigned long		end;
 	u64			new_tlb_gen;
-	unsigned int		stride_shift;
-	bool			freed_tables;
+	unsigned int		cpu;
+	unsigned short		stride_shift;
+	unsigned char		freed_tables;
 };
 
 #define local_flush_tlb() __flush_tlb()
Index: linux-2.6/arch/x86/mm/tlb.c
===================================================================
--- linux-2.6.orig/arch/x86/mm/tlb.c
+++ linux-2.6/arch/x86/mm/tlb.c
@@ -659,6 +659,27 @@ static void flush_tlb_func_remote(void *
 	flush_tlb_func_common(f, false, TLB_REMOTE_SHOOTDOWN);
 }
 
+static void flush_tlb_func(void *info)
+{
+	const struct flush_tlb_info *f = info;
+	enum tlb_flush_reason reason = TLB_REMOTE_SHOOTDOWN;
+	bool local = false;
+
+	if (f->cpu == smp_processor_id()) {
+		local = true;
+		reason = (f->mm == NULL) ? TLB_LOCAL_SHOOTDOWN : TLB_LOCAL_MM_SHOOTDOWN;
+	} else {
+		inc_irq_stat(irq_tlb_count);
+
+		if (f->mm && f->mm != this_cpu_read(cpu_tlbstate.loaded_mm))
+			return;
+
+		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
+	}
+
+	flush_tlb_func_common(f, local, reason);
+}
+
 static bool tlb_is_not_lazy(int cpu)
 {
 	return !per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
