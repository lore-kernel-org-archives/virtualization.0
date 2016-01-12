From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/4] x86,asm: Re-work smp_store_mb()
Date: Tue, 12 Jan 2016 19:45:27 +0200
Message-ID: <20160112193027-mutt-send-email-mst@redhat.com>
References: <1445975631-17047-1-git-send-email-dave@stgolabs.net>
	<1445975631-17047-4-git-send-email-dave@stgolabs.net>
	<CA+55aFw8d29E26o4eB8VgbZBC5Ot2y9K=T_yE5Dj0dFdyVgOUA@mail.gmail.com>
	<20151027223744.GB11242@worktop.amr.corp.intel.com>
	<20151102201535.GB1707@linux-uzut.site>
	<CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com>
	<20160112150032-mutt-send-email-mst@redhat.com>
	<CA+55aFwqgUQYVbVXLw1=LL6Gs=kXqhkx0tUZOdXnWbqCMdWfXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwqgUQYVbVXLw1=LL6Gs=kXqhkx0tUZOdXnWbqCMdWfXg@mail.gmail.com>
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
Cc: Davidlohr Bueso <dave@stgolabs.net>, Davidlohr Bueso <dbueso@suse.de>, Peter Zijlstra <peterz@infradead.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 12, 2016 at 09:20:06AM -0800, Linus Torvalds wrote:
> On Tue, Jan 12, 2016 at 5:57 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > #ifdef xchgrz
> > /* same as xchg but poking at gcc red zone */
> > #define barrier() do { int ret; asm volatile ("xchgl %0, -4(%%" SP ");": "=r"(ret) :: "memory", "cc"); } while (0)
> > #endif
> 
> That's not safe in general. gcc might be using its redzone, so doing
> xchg into it is unsafe.
> 
> But..
> 
> > Is this a good way to test it?
> 
> .. it's fine for some basic testing. It doesn't show any subtle
> interactions (ie some operations may have different dynamic behavior
> when the write buffers are busy etc), but as a baseline for "how fast
> can things go" the stupid raw loop is fine. And while the xchg into
> the redzoen wouldn't be acceptable as a real implementation, for
> timing testing it's likely fine (ie you aren't hitting the problem it
> can cause).
> 
> > So mfence is more expensive than locked instructions/xchg, but sfence/lfence
> > are slightly faster, and xchg and locked instructions are very close if
> > not the same.
> 
> Note that we never actually *use* lfence/sfence. They are pointless
> instructions when looking at CPU memory ordering, because for pure CPU
> memory ordering stores and loads are already ordered.
> 
> The only reason to use lfence/sfence is after you've used nontemporal
> stores for IO.


By the way, the comment in barrier.h says:

/*
 * Some non-Intel clones support out of order store. wmb() ceases to be
 * a nop for these.
 */

and while the 1st sentence may well be true, if you have
an SMP system with out of order stores, making wmb
not a nop will not help.

Additionally as you point out, wmb is not a nop even
for regular intel CPUs because of these weird use-cases.

Drop this comment?

> That's very very rare in the kernel. So I wouldn't
> worry about those.

Right - I'll leave these alone, whoever wants to optimize this path will
have to do the necessary research.

> But yes, it does sound like mfence is just a bad idea too.
> 
> > There isn't any extra magic behind mfence, is there?
> 
> No.
> 
> I think the only issue is that there has never been any real reason
> for CPU designers to try to make mfence go particularly fast. Nobody
> uses it, again with the exception of some odd loops that use
> nontemporal stores, and for those the cost tends to always be about
> the nontemporal accesses themselves (often to things like GPU memory
> over PCIe), and the mfence cost of a few extra cycles is negligible.
> 
> The reason "lock ; add $0" has generally been the fastest we've found
> is simply that locked ops have been important for CPU designers.
> 
> So I think the patch is fine, and we should likely drop the use of mfence..
> 
>                       Linus

OK so should I repost after a bit more testing?  I don't believe this
will affect the kernel build benchmark, but I'll try :)


-- 
MST
