From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6] x86: use lock+addl for smp_mb()
Date: Thu, 9 Nov 2017 10:32:00 +0100
Message-ID: <20171109093200.2562ek7ebdz45gj2@hirez.programming.kicks-ass.net>
References: <1509118355-4890-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1509118355-4890-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, x86@kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Oct 27, 2017 at 07:14:31PM +0300, Michael S. Tsirkin wrote:

> The one difference between lock+add and mfence is that lock+addl does
> not affect clflush, previous patches converted all uses of clflush to
> call mb(), such that changes to smp_mb won't affect it.
> 
> Update mb/rmb/wmb on 32 bit to use the negative offset, too, for
> consistency.

So I briefly spoke to hpa about this patch in Prague, and yes, we should
do this.

By the very simple argument that we already rely on all LOCK prefixed
instructions to fully imply smp_mb().

And yes, there are differences between MFENCE and LOCK prefix, but as
already noted above, those should not have been using smp_mb() in the
first place and should be converted to mb()

So:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>


> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index bfb28ca..3c6ba1e 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -11,11 +11,11 @@
>   */
>  
>  #ifdef CONFIG_X86_32
> -#define mb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "mfence", \
> +#define mb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "mfence", \
>  				      X86_FEATURE_XMM2) ::: "memory", "cc")
> -#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "lfence", \
> +#define rmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "lfence", \
>  				       X86_FEATURE_XMM2) ::: "memory", "cc")
> -#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,0(%%esp)", "sfence", \
> +#define wmb() asm volatile(ALTERNATIVE("lock; addl $0,-4(%%esp)", "sfence", \
>  				       X86_FEATURE_XMM2) ::: "memory", "cc")
>  #else
>  #define mb() 	asm volatile("mfence":::"memory")
> @@ -30,7 +30,11 @@
>  #endif
>  #define dma_wmb()	barrier()
>  
> -#define __smp_mb()	mb()
> +#ifdef CONFIG_X86_32
> +#define __smp_mb()	asm volatile("lock; addl $0,-4(%%esp)" ::: "memory", "cc")
> +#else
> +#define __smp_mb()	asm volatile("lock; addl $0,-4(%%rsp)" ::: "memory", "cc")
> +#endif
>  #define __smp_rmb()	dma_rmb()
>  #define __smp_wmb()	barrier()
>  #define __smp_store_mb(var, value) do { (void)xchg(&var, value); } while (0)
