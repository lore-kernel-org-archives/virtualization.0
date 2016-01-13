From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Wed, 13 Jan 2016 18:20:28 +0200
Message-ID: <20160113174645-mutt-send-email-mst@redhat.com>
References: <CA+55aFw8d29E26o4eB8VgbZBC5Ot2y9K=T_yE5Dj0dFdyVgOUA@mail.gmail.com>
	<20151027223744.GB11242@worktop.amr.corp.intel.com>
	<20151102201535.GB1707@linux-uzut.site>
	<CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com>
	<20160112150032-mutt-send-email-mst@redhat.com>
	<CA+55aFwqgUQYVbVXLw1=LL6Gs=kXqhkx0tUZOdXnWbqCMdWfXg@mail.gmail.com>
	<56956276.1090705@kernel.org>
	<CA+55aFxhoGB9dBArw5iy0C0RhJEVRLLPR42w--KLSn5WM2sVRQ@mail.gmail.com>
	<CALCETrWBxiAb8KHjBfb2rRhX3KrbLfc3bzhfQnyCdE3G4mnsSA@mail.gmail.com>
	<CA+55aFyuR1YCZjC9++E4kpvRxgoM4sqzhNaS27EZPFh9CuKjYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyuR1YCZjC9++E4kpvRxgoM4sqzhNaS27EZPFh9CuKjYg@mail.gmail.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 12, 2016 at 01:37:38PM -0800, Linus Torvalds wrote:
> On Tue, Jan 12, 2016 at 12:59 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > Here's an article with numbers:
> >
> > http://shipilev.net/blog/2014/on-the-fence-with-dependencies/
> 
> Well, that's with the busy loop and one set of code generation. It
> doesn't show the "oops, deeper stack isn't even in the cache any more
> due to call chains" issue.

It's an interesting read, thanks!

So sp is read on return from function I think.  I added a function and sure
enough, it slows the add 0(sp) variant down. It's still faster than mfence for
me though! Testing code + results below. Reaching below stack, or
allocating extra 4 bytes above the stack pointer gives us back the performance.


> But yes:
> 
> > I think they're suggesting using a negative offset, which is safe as
> > long as it doesn't page fault, even though we have the redzone
> > disabled.
> 
> I think a negative offset might work very well. Partly exactly
> *because* we have the redzone disabled: we know that inside the
> kernel, we'll never have any live stack frame accesses under the stack
> pointer, so "-4(%rsp)" sounds good to me. There should never be any
> pending writes in the write buffer, because even if it *was* live, it
> would have been read off first.
> 
> Yeah, it potentially does extend the stack cache footprint by another
> 4 bytes, but that sounds very benign.
> 
> So perhaps it might be worth trying to switch the "mfence" to "lock ;
> addl $0,-4(%rsp)" in the kernel for x86-64, and remove the alternate
> for x86-32.
>
>
> I'd still want to see somebody try to benchmark it. I doubt it's
> noticeable, but making changes because you think it might save a few
> cycles without then even measuring it is just wrong.
> 
>                  Linus

I'll try this in the kernel now, will report, though I'm
not optimistic a high level benchmark can show this
kind of thing.


---------------
main.c:
---------------

extern volatile int x;
volatile int x;

#ifdef __x86_64__
#define SP "rsp"
#else
#define SP "esp"
#endif


#ifdef lock
#define barrier() do { int p; asm volatile ("lock; addl $0,%0" ::"m"(p): "memory"); } while (0)
#endif
#ifdef locksp
#define barrier() asm("lock; addl $0,0(%%" SP ")" ::: "memory")
#endif
#ifdef lockrz
#define barrier() asm("lock; addl $0,-4(%%" SP ")" ::: "memory")
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

void __attribute__ ((noinline)) test(int i, int *j)
{
	/*
	 * Test barrier in a loop. We also poke at a volatile variable in an
	 * attempt to make it a bit more realistic - this way there's something
	 * in the store-buffer.
	 */
	x = i - *j;
	barrier();
	*j = x;
}

int main(int argc, char **argv)
{
	int i;
	int j = 1234;

	for (i = 0; i < 10000000; ++i)
		test(i, &j);

	return 0;
}
---------------

ALL = xchg xchgrz lock locksp lockrz mfence lfence sfence

CC = gcc
CFLAGS += -Wall -O2 -ggdb
PERF = perf stat -r 10 --log-fd 1 --
TIME = /usr/bin/time -f %e
FILTER = cat

all: ${ALL}
clean:
	rm -f ${ALL}
run: all
	for file in ${ALL}; do echo ${RUN} ./$$file "|" ${FILTER}; ${RUN} ./$$file | ${FILTER}; done
perf time: run
time: RUN=${TIME}
perf: RUN=${PERF}
perf: FILTER=grep elapsed

.PHONY: all clean run perf time

xchgrz: CFLAGS += -mno-red-zone

${ALL}: main.c
	${CC} ${CFLAGS} -D$@ -o $@ main.c

--------------------------------------------
perf stat -r 10 --log-fd 1 -- ./xchg | grep elapsed
       0.080420565 seconds time elapsed                                          ( +-  2.31% )
perf stat -r 10 --log-fd 1 -- ./xchgrz | grep elapsed
       0.087798571 seconds time elapsed                                          ( +-  2.58% )
perf stat -r 10 --log-fd 1 -- ./lock | grep elapsed
       0.083023724 seconds time elapsed                                          ( +-  2.44% )
perf stat -r 10 --log-fd 1 -- ./locksp | grep elapsed
       0.102880750 seconds time elapsed                                          ( +-  0.13% )
perf stat -r 10 --log-fd 1 -- ./lockrz | grep elapsed
       0.084917420 seconds time elapsed                                          ( +-  3.28% )
perf stat -r 10 --log-fd 1 -- ./mfence | grep elapsed
       0.156014715 seconds time elapsed                                          ( +-  0.16% )
perf stat -r 10 --log-fd 1 -- ./lfence | grep elapsed
       0.077731443 seconds time elapsed                                          ( +-  0.12% )
perf stat -r 10 --log-fd 1 -- ./sfence | grep elapsed
       0.036655741 seconds time elapsed                                          ( +-  0.21% )
