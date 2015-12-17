From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] virtio_ring: use smp_store_mb
Date: Thu, 17 Dec 2015 14:57:26 +0100
Message-ID: <20151217135726.GA6344@twins.programming.kicks-ass.net>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
	<20151217105238.GA6375@twins.programming.kicks-ass.net>
	<20151217131554-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151217131554-mutt-send-email-mst@redhat.com>
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
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 17, 2015 at 03:16:20PM +0200, Michael S. Tsirkin wrote:
> On Thu, Dec 17, 2015 at 11:52:38AM +0100, Peter Zijlstra wrote:
> > On Thu, Dec 17, 2015 at 12:32:53PM +0200, Michael S. Tsirkin wrote:
> > > +static inline void virtio_store_mb(bool weak_barriers,
> > > +				   __virtio16 *p, __virtio16 v)
> > > +{
> > > +#ifdef CONFIG_SMP
> > > +	if (weak_barriers)
> > > +		smp_store_mb(*p, v);
> > > +	else
> > > +#endif
> > > +	{
> > > +		WRITE_ONCE(*p, v);
> > > +		mb();
> > > +	}
> > > +}
> > 
> > This is a different barrier depending on SMP, that seems wrong.
> 
> Of course it's wrong in the sense that it's
> suboptimal on UP. What we would really like is to
> have, on UP, exactly the same barrier as on SMP.
> This is because a UP guest can run on an SMP host.
> 
> But Linux doesn't provide this ability: if CONFIG_SMP is
> not defined is optimizes most barriers out to a
> compiler barrier.
> 
> Consider for example x86: what we want is xchg (NOT
> mfence - see below for why) but if built without CONFIG_SMP
> smp_store_mb does not include this.

You could of course go fix that instead of mutilating things into
sort-of functional state.

> 
> 
> > smp_mb(), as (should be) used by smp_store_mb() does not provide a
> > barrier against IO. mb() otoh does.
> > 
> > Since this is virtIO I would expect you always want mb().
> 
> No because it's VIRTio not real io :) It just switches to the hyprevisor
> mode - kind of like a function call really.
> The weak_barriers flag is cleared for when it's used
> with real devices with real IO.
> 
> 
> All this is explained in some detail at the top of
> include/linux/virtio.h

I did read that, it didn't make any sense wrt the code below it.

For instance it seems to imply weak_barriers is for smp like stuff while
!weak_barriers is for actual devices.

But then you go use dma_*mb() ops, which are specifially for devices
only for weak_barrier.
