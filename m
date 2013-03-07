From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] tools/virtio: make barriers stronger.
Date: Thu, 7 Mar 2013 11:29:08 +0200
Message-ID: <20130307092908.GA4129@redhat.com>
References: <1362491468-16681-1-git-send-email-sjur.brandeland@stericsson.com>
	<871ubtcezb.fsf@rustcorp.com.au> <87y5e1b03l.fsf@rustcorp.com.au>
	<87vc95b019.fsf@rustcorp.com.au>
	<20130306102017.GB16921@redhat.com>
	<87a9qfyinr.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87a9qfyinr.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: sjur@brendeland.net, Linus Walleij <linus.walleij@linaro.org>, Erwan Yvin <erwan.yvin@stericsson.com>, virtualization@lists.linux-foundation.org, sjur.brandeland@stericsson.com
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 07, 2013 at 02:48:24PM +1100, Rusty Russell wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> > On Wed, Mar 06, 2013 at 03:54:42PM +1100, Rusty Russell wrote:
> >> In the coming vringh_test, we share an mmap with another userspace process
> >> for testing.  This requires real barriers.
> >> 
> >> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> >> 
> >> diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
> >> index aff61e1..7a63693 100644
> >> --- a/tools/virtio/asm/barrier.h
> >> +++ b/tools/virtio/asm/barrier.h
> >> @@ -3,8 +3,8 @@
> >>  #define mb() __sync_synchronize()
> >>  
> >>  #define smp_mb()	mb()
> >> -# define smp_rmb()	barrier()
> >> -# define smp_wmb()	barrier()
> >> +# define smp_rmb()	mb()
> >> +# define smp_wmb()	mb()
> >>  /* Weak barriers should be used. If not - it's a bug */
> >>  # define rmb()	abort()
> >>  # define wmb()	abort()
> >
> > Hmm this seems wrong on x86 which has strong order in hardware.
> > It should not matter whether the other side is a userspace
> > process or a kernel thread.
> 
> Actually, this code is completely generic now, though overkill for x86 smp_wmb():
> 
> Interestingly, when I try defining them, 32-bit x86 slows down (it seems
> that gcc is using "lock orl $0x0,(%esp)" for __sync_synchronize()).:

Well this depends on which arch you are building for.
We saw this in qemu too, see e.g. include/qemu/atomic.h in qemu.

> On my 32-bit laptop: Intel(R) Core(TM) i5 CPU       M 560  @ 2.67GHz
> 
> Before:
> 	Wall time:1.660000-1.790000(1.682500)
> After:
> 	Wall time:1.930000-3.620000(1.960625)
> 
> 64 bit it's a win:
> On 2.6.32-358.el6.x86_64, gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-3), Intel(R) Xeon(R) CPU           E5620  @ 2.40GHz:
> 
> Before:
> 	real	0m2.937000-8.339000(3.123979)s
> 	user	0m2.811000-8.233000(2.954813)s
> 	sys	0m0.052000-0.154000(0.089396)s
> After:
> 	real	0m2.559000-2.936000(2.726729)s
> 	user	0m2.397000-2.651000(2.506396)s
> 	sys	0m0.055000-0.152000(0.090667)s
> 
> Raw performance doesn't really matter, of course, but it's tempting to
> use these asm barriers for __x86_64__, and use __sync_synchronize()
> everywhere for everyone else.
> 
> Thoughts?
> Rusty.

For smp_mb, I agree.

> diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
> index 7a63693..8de720a 100644
> --- a/tools/virtio/asm/barrier.h
> +++ b/tools/virtio/asm/barrier.h
> @@ -1,11 +1,12 @@
>  #if defined(__i386__) || defined(__x86_64__)
>  #define barrier() asm volatile("" ::: "memory")
> -#define mb() __sync_synchronize()
>  
> -#define smp_mb()	mb()
> -# define smp_rmb()	mb()
> -# define smp_wmb()	mb()
> +#define smp_mb() 	asm volatile("mfence":::"memory")
> +#define smp_rmb()	asm volatile("lfence":::"memory")
> +#define smp_wmb()	asm volatile("sfence" ::: "memory")
> +

Confused. On x86_64, as long as you are not synchronizing with a device
these are not necessary, a compiler barrier will do, unless
there are non-temporal loads/stores, which we don't use.

>  /* Weak barriers should be used. If not - it's a bug */
> +# define mb()	abort()
>  # define rmb()	abort()
>  # define wmb()	abort()
>  #else
