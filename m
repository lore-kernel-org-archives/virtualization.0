From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Tue, 12 Jan 2016 15:57:38 +0200
Message-ID: <20160112150032-mutt-send-email-mst__412.816313519393$1452607088$gmane$org@redhat.com>
References: <1445975631-17047-1-git-send-email-dave@stgolabs.net>
	<1445975631-17047-4-git-send-email-dave@stgolabs.net>
	<CA+55aFw8d29E26o4eB8VgbZBC5Ot2y9K=T_yE5Dj0dFdyVgOUA@mail.gmail.com>
	<20151027223744.GB11242@worktop.amr.corp.intel.com>
	<20151102201535.GB1707@linux-uzut.site>
	<CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 02, 2015 at 04:06:46PM -0800, Linus Torvalds wrote:
> On Mon, Nov 2, 2015 at 12:15 PM, Davidlohr Bueso <dave@stgolabs.net> wrote:
> >
> > So I ran some experiments on an IvyBridge (2.8GHz) and the cost of XCHG is
> > constantly cheaper (by at least half the latency) than MFENCE. While there
> > was a decent amount of variation, this difference remained rather constant.
> 
> Mind testing "lock addq $0,0(%rsp)" instead of mfence? That's what we
> use on old cpu's without one (ie 32-bit).
> 
> I'm not actually convinced that mfence is necessarily a good idea. I
> could easily see it being microcode, for example.
> 
> At least on my Haswell, the "lock addq" is pretty much exactly half
> the cost of "mfence".
> 
>                      Linus

mfence was high on some traces I was seeing, so I got curious, too:

---->
main.c
---->


extern volatile int x;
volatile int x;

#ifdef __x86_64__
#define SP "rsp"
#else
#define SP "esp"
#endif
#ifdef lock
#define barrier() asm("lock; addl $0,0(%%" SP ")" ::: "memory")
#endif
#ifdef xchg
#define barrier() do { int p; int ret; asm volatile ("xchgl %0, %1;": "=r"(ret) : "m"(p): "memory", "cc"); } while (0)
#endif
#ifdef xchgrz
/* same as xchg but poking at gcc red zone */
#define barrier() do { int ret; asm volatile ("xchgl %0, -4(%%" SP ");": "=r"(ret) :: "memory", "cc"); } while (0)
#endif
#ifdef mfence
#define barrier() asm("mfence" ::: "memory")
#endif
#ifdef lfence
#define barrier() asm("lfence" ::: "memory")
#endif
#ifdef sfence
#define barrier() asm("sfence" ::: "memory")
#endif

int main(int argc, char **argv)
{
	int i;
	int j = 1234;

	/*
	 * Test barrier in a loop. We also poke at a volatile variable in an
	 * attempt to make it a bit more realistic - this way there's something
	 * in the store-buffer.
	 */
	for (i = 0; i < 10000000; ++i) {
		x = i - j;
		barrier();
		j = x;
	}

	return 0;
}
---->
Makefile:
---->

ALL = xchg xchgrz lock mfence lfence sfence

CC = gcc
CFLAGS += -Wall -O2 -ggdb
PERF = perf stat -r 10 --log-fd 1 --

all: ${ALL}
clean:
	rm -f ${ALL}
run: all
	for file in ${ALL}; do echo ${PERF} ./$$file ; ${PERF} ./$$file; done

.PHONY: all clean run

${ALL}: main.c
	${CC} ${CFLAGS} -D$@ -o $@ main.c

----->

Is this a good way to test it?

E.g. on my laptop I get:

perf stat -r 10 --log-fd 1 -- ./xchg

 Performance counter stats for './xchg' (10 runs):

         53.236967 task-clock                #    0.992 CPUs utilized            ( +-  0.09% )
                10 context-switches          #    0.180 K/sec                    ( +-  1.70% )
                 0 CPU-migrations            #    0.000 K/sec                  
                37 page-faults               #    0.691 K/sec                    ( +-  1.13% )
       190,997,612 cycles                    #    3.588 GHz                      ( +-  0.04% )
   <not supported> stalled-cycles-frontend 
   <not supported> stalled-cycles-backend  
        80,654,850 instructions              #    0.42  insns per cycle          ( +-  0.01% )
        10,122,372 branches                  #  190.138 M/sec                    ( +-  0.01% )
             4,514 branch-misses             #    0.04% of all branches          ( +-  3.37% )

       0.053642809 seconds time elapsed                                          ( +-  0.12% )

perf stat -r 10 --log-fd 1 -- ./xchgrz

 Performance counter stats for './xchgrz' (10 runs):

         53.189533 task-clock                #    0.997 CPUs utilized            ( +-  0.22% )
                 0 context-switches          #    0.000 K/sec                  
                 0 CPU-migrations            #    0.000 K/sec                  
                37 page-faults               #    0.694 K/sec                    ( +-  0.75% )
       190,785,621 cycles                    #    3.587 GHz                      ( +-  0.03% )
   <not supported> stalled-cycles-frontend 
   <not supported> stalled-cycles-backend  
        80,602,086 instructions              #    0.42  insns per cycle          ( +-  0.00% )
        10,112,154 branches                  #  190.115 M/sec                    ( +-  0.01% )
             3,743 branch-misses             #    0.04% of all branches          ( +-  4.02% )

       0.053343693 seconds time elapsed                                          ( +-  0.23% )

perf stat -r 10 --log-fd 1 -- ./lock

 Performance counter stats for './lock' (10 runs):

         53.096434 task-clock                #    0.997 CPUs utilized            ( +-  0.16% )
                 0 context-switches          #    0.002 K/sec                    ( +-100.00% )
                 0 CPU-migrations            #    0.000 K/sec                  
                37 page-faults               #    0.693 K/sec                    ( +-  0.98% )
       190,796,621 cycles                    #    3.593 GHz                      ( +-  0.02% )
   <not supported> stalled-cycles-frontend 
   <not supported> stalled-cycles-backend  
        80,601,376 instructions              #    0.42  insns per cycle          ( +-  0.01% )
        10,112,074 branches                  #  190.447 M/sec                    ( +-  0.01% )
             3,475 branch-misses             #    0.03% of all branches          ( +-  1.33% )

       0.053252678 seconds time elapsed                                          ( +-  0.16% )

perf stat -r 10 --log-fd 1 -- ./mfence

 Performance counter stats for './mfence' (10 runs):

        126.376473 task-clock                #    0.999 CPUs utilized            ( +-  0.21% )
                 0 context-switches          #    0.002 K/sec                    ( +- 66.67% )
                 0 CPU-migrations            #    0.000 K/sec                  
                36 page-faults               #    0.289 K/sec                    ( +-  0.84% )
       456,147,770 cycles                    #    3.609 GHz                      ( +-  0.01% )
   <not supported> stalled-cycles-frontend 
   <not supported> stalled-cycles-backend  
        80,892,416 instructions              #    0.18  insns per cycle          ( +-  0.00% )
        10,163,220 branches                  #   80.420 M/sec                    ( +-  0.01% )
             4,653 branch-misses             #    0.05% of all branches          ( +-  1.27% )

       0.126539273 seconds time elapsed                                          ( +-  0.21% )

perf stat -r 10 --log-fd 1 -- ./lfence

 Performance counter stats for './lfence' (10 runs):

         47.617861 task-clock                #    0.997 CPUs utilized            ( +-  0.06% )
                 0 context-switches          #    0.002 K/sec                    ( +-100.00% )
                 0 CPU-migrations            #    0.000 K/sec                  
                36 page-faults               #    0.764 K/sec                    ( +-  0.45% )
       170,767,856 cycles                    #    3.586 GHz                      ( +-  0.03% )
   <not supported> stalled-cycles-frontend 
   <not supported> stalled-cycles-backend  
        80,581,607 instructions              #    0.47  insns per cycle          ( +-  0.00% )
        10,108,508 branches                  #  212.284 M/sec                    ( +-  0.00% )
             3,320 branch-misses             #    0.03% of all branches          ( +-  1.12% )

       0.047768505 seconds time elapsed                                          ( +-  0.07% )

perf stat -r 10 --log-fd 1 -- ./sfence

 Performance counter stats for './sfence' (10 runs):

         20.156676 task-clock                #    0.988 CPUs utilized            ( +-  0.45% )
                 3 context-switches          #    0.159 K/sec                    ( +- 12.15% )
                 0 CPU-migrations            #    0.000 K/sec                  
                36 page-faults               #    0.002 M/sec                    ( +-  0.87% )
        72,212,225 cycles                    #    3.583 GHz                      ( +-  0.33% )
   <not supported> stalled-cycles-frontend 
   <not supported> stalled-cycles-backend  
        80,479,149 instructions              #    1.11  insns per cycle          ( +-  0.00% )
        10,090,785 branches                  #  500.618 M/sec                    ( +-  0.01% )
             3,626 branch-misses             #    0.04% of all branches          ( +-  3.59% )

       0.020411208 seconds time elapsed                                          ( +-  0.52% )


So mfence is more expensive than locked instructions/xchg, but sfence/lfence
are slightly faster, and xchg and locked instructions are very close if
not the same.

I poked at some 10 intel and AMD machines and the numbers are different
but the results seem more or less consistent with this.

From size point of view xchg is longer and xchgrz pokes at the red zone
which seems unnecessarily hacky, so good old lock+addl is probably the
best.

There isn't any extra magic behind mfence, is there?
E.g. I think lock orders accesses to WC memory as well,
so apparently mb() can be redefined unconditionally, without
looking at XMM2:

--->
x86: drop mfence in favor of lock+addl

mfence appears to be way slower than a locked instruction - let's use
lock+add unconditionally, same as we always did on old 32-bit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

I'll play with this some more before posting this as a
non-stand alone patch. Is there a macro-benchmark where mb
is prominent?

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index a584e1c..f0d36e2 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -15,15 +15,15 @@
  * Some non-Intel clones support out of order store. wmb() ceases to be a
  * nop for these.
  */
-#define mb() alternative("lock; addl $0,0(%%esp)", "mfence", X86_FEATURE_XMM2)
+#define mb() asm volatile("lock; addl $0,0(%%esp)":::"memory")
 #define rmb() alternative("lock; addl $0,0(%%esp)", "lfence", X86_FEATURE_XMM2)
 #define wmb() alternative("lock; addl $0,0(%%esp)", "sfence", X86_FEATURE_XMM)
 #else
+#define mb()	asm volatile("lock; addl $0,0(%%rsp)":::"memory")
 #define rmb()	asm volatile("lfence":::"memory")
 #define wmb()	asm volatile("sfence" ::: "memory")
 #endif
 
 #ifdef CONFIG_X86_PPRO_FENCE
 #define dma_rmb()	rmb()
 #else

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
