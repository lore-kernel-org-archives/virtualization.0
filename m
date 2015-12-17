From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_ring: use smp_store_mb
Date: Thu, 17 Dec 2015 16:33:44 +0200
Message-ID: <20151217161124-mutt-send-email-mst@redhat.com>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
	<20151217105238.GA6375@twins.programming.kicks-ass.net>
	<20151217131554-mutt-send-email-mst@redhat.com>
	<20151217135726.GA6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151217135726.GA6344@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 17, 2015 at 02:57:26PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 17, 2015 at 03:16:20PM +0200, Michael S. Tsirkin wrote:
> > On Thu, Dec 17, 2015 at 11:52:38AM +0100, Peter Zijlstra wrote:
> > > On Thu, Dec 17, 2015 at 12:32:53PM +0200, Michael S. Tsirkin wrote:
> > > > +static inline void virtio_store_mb(bool weak_barriers,
> > > > +				   __virtio16 *p, __virtio16 v)
> > > > +{
> > > > +#ifdef CONFIG_SMP
> > > > +	if (weak_barriers)
> > > > +		smp_store_mb(*p, v);
> > > > +	else
> > > > +#endif
> > > > +	{
> > > > +		WRITE_ONCE(*p, v);
> > > > +		mb();
> > > > +	}
> > > > +}
> > > 
> > > This is a different barrier depending on SMP, that seems wrong.
> > 
> > Of course it's wrong in the sense that it's
> > suboptimal on UP. What we would really like is to
> > have, on UP, exactly the same barrier as on SMP.
> > This is because a UP guest can run on an SMP host.
> > 
> > But Linux doesn't provide this ability: if CONFIG_SMP is
> > not defined is optimizes most barriers out to a
> > compiler barrier.
> > 
> > Consider for example x86: what we want is xchg (NOT
> > mfence - see below for why) but if built without CONFIG_SMP
> > smp_store_mb does not include this.
> 
> You could of course go fix that instead of mutilating things into
> sort-of functional state.

Yes, we'd just need to touch all architectures, all for
the sake of UP which almost no one uses.
Basically, we need APIs that explicitly are
for talking to another kernel on a different CPU on
the same SMP system, and implemented identically
between CONFIG_SMP and !CONFIG_SMP on all architectures.

Do you think this is something of general usefulness,
outside virtio?

> > 
> > 
> > > smp_mb(), as (should be) used by smp_store_mb() does not provide a
> > > barrier against IO. mb() otoh does.
> > > 
> > > Since this is virtIO I would expect you always want mb().
> > 
> > No because it's VIRTio not real io :) It just switches to the hyprevisor
> > mode - kind of like a function call really.
> > The weak_barriers flag is cleared for when it's used
> > with real devices with real IO.
> > 
> > 
> > All this is explained in some detail at the top of
> > include/linux/virtio.h
> 
> I did read that, it didn't make any sense wrt the code below it.
> 
> For instance it seems to imply weak_barriers is for smp like stuff while
> !weak_barriers is for actual devices.
> 
> But then you go use dma_*mb() ops, which are specifially for devices
> only for weak_barrier.

Yes the dma_*mb thing is a kind of an interface misuse.
It's an optimization for UP introduced here:

commit 9e1a27ea42691429e31f158cce6fc61bc79bb2e9
Author: Alexander Duyck <alexander.h.duyck@redhat.com>
Date:   Mon Apr 13 21:03:49 2015 +0930

    virtio_ring: Update weak barriers to use dma_wmb/rmb 
    This change makes it so that instead of using smp_wmb/rmb which varies
    depending on the kernel configuration we can can use dma_wmb/rmb which for
    most architectures should be equal to or slightly more strict than
    smp_wmb/rmb.
    
    The advantage to this is that these barriers are available to uniprocessor
    builds as well so the performance should improve under such a
    configuration.
    
    Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

but given the confusion this causes, I'm inclined to revert
this, and later switch to for cleaner API if that
appears. Cc Alexander (at the new address).


-- 
MST
