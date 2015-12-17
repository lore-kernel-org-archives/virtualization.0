From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_ring: use smp_store_mb
Date: Thu, 17 Dec 2015 15:26:29 +0200
Message-ID: <20151217151705-mutt-send-email-mst@redhat.com>
References: <1450347932-16325-1-git-send-email-mst@redhat.com>
	<20151217112222.GC6375@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20151217112222.GC6375@twins.programming.kicks-ass.net>
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
Cc: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Dec 17, 2015 at 12:22:22PM +0100, Peter Zijlstra wrote:
> On Thu, Dec 17, 2015 at 12:32:53PM +0200, Michael S. Tsirkin wrote:
> > Seems to give a speedup on my box but I'm less sure about this one.  E.g. as
> > xchng faster than mfence on all/most intel CPUs? Anyone has an opinion?
> 
> Would help if you Cc people who would actually know this :-)

Good point. Glad you still saw this. Thanks!

> Yes, we've recently established that xchg is indeed faster than mfence
> on at least recent machines, see:
> 
>   lkml.kernel.org/r/CA+55aFynbkeuUGs9s-q+fLY6MeRBA6MjEyWWbbe7A5AaqsAknw@mail.gmail.com
> 
> > +static inline void virtio_store_mb(bool weak_barriers,
> > +				   __virtio16 *p, __virtio16 v)
> > +{
> > +#ifdef CONFIG_SMP
> > +	if (weak_barriers)
> > +		smp_store_mb(*p, v);
> > +	else
> > +#endif
> > +	{
> > +		WRITE_ONCE(*p, v);
> > +		mb();
> > +	}
> > +}
> 
> Note that virtio_mb() is weirdly inconsistent with virtio_[rw]mb() in
> that they use dma_* ops for weak_barriers, while virtio_mb() uses
> smp_mb().

It's a hack really. I think I'll clean it up a bit to
make it more consistent.

To simplify things, you may consider things before
the optimization brought in by
	commit 9e1a27ea42691429e31f158cce6fc61bc79bb2e9
	Author: Alexander Duyck <alexander.h.duyck@redhat.com>
	Date:   Mon Apr 13 21:03:49 2015 +0930

	    virtio_ring: Update weak barriers to use dma_wmb/rmb

> As previously stated, smp_mb() does not cover the same memory domains as
> dma_mb() would.

I know.  We used to consistently do the right thing on SMP,
but on UP Linux does not have good portable APIs for us
to use. So we hack around with what's available which is
typically stronger than what's really needed.

I guess no one cares about UP that much.

The Alexander came and tried to optimize UP using
dma_wmb/dma_rmb. I guess he did not find dma_mb so
left it as is.

Maybe we should make virtio depend on SMP, and be done with it,
but the amount of code to maintain !SMP is small enough
to not be worth the potential pain to users (if any).



-- 
MST
