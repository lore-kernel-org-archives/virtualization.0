From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 15:31:59 +1100
Message-ID: <1326342719.23910.199.camel@pasglop>
References: <20111215063004.GA3630@redhat.com>
	<87zketp9nz.fsf@rustcorp.com.au> <20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au> <20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au> <20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au> <20120111102129.GC20988@redhat.com>
	<87vcoh4r2y.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87vcoh4r2y.fsf@rustcorp.com.au>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization <virtualization@lists.linux-foundation.org>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2012-01-12 at 12:31 +1030, Rusty Russell wrote:

> > Are we going to keep guest endian for e.g. virtio net header?
> > If yes the benefit of switching config space is not that big.
> > And changes in devices would affect non-PCI transports.
> 
> Yep.  It would only make sense if we do it for everything.  And yes,
> it'll mess up everyone who is BE, so it needs to be a feature bit for
> them.

One thing we should do (I might give it a go after LCA) is start
providing sized accessors for it and start converting the guest drivers
in Linux at least to use those.

That way, the accessors could then do the byteswap in the future
transparently if they see the feature bit for the "fixed endian".

We'd have accessors for 8,16,32 and 64-bit quantities, and accessors for
"raw" blobs (already endian neutral such as MAC addresses).

> Interesting.  It is simpler and more standard than our current design,
> but that's not sufficient unless there are other reasons.  Needs further
> discussion and testing.

I think completions shall remain separate. As for having a separate
"available" vs. "descriptors", well, I can find pro and cons.

As it is today, it's more complex than it should be and it would make
things simpler to just have an available ring that contains descriptors
like mostly everything else does.

It would also be slightly more cache friendly (cache misses are a
significant part of the performance issues for things like high speed
networking).

However I can see at least one advantage of what you've done :-) You
never have to deal with holes in the ring.

For example, a typical network driver should always try to allocate a
new skb before it "consumes" one, because otherwise, there's a chance
that it fails to allocate it, leaving a hole in the ring. Many drivers
do it wrong with consequences going all the way to leaving stale DMA
pointers in there....

With your scheme, that problem doesn't exist, and you can batch the
refill which might be more efficient under some circumstances.

But is that worth the gain and the cost in cache line accesses ?
Probably not.

> > Two rings do have the advantage of not requiring host side copy, which
> > copy would surely add to cache pressure.
> 
> Well, a simple host could process in-order and leave stuff in the ring I
> guess.  A smarter host would copy and queue, maybe leave one queue entry
> in so it doesn't get flooded?

What's wrong with a ring of descriptors + a ring of completion, with a
single toggle valid bit to indicate whether a given descriptor is valid
or not (to avoid the nasty ping pong on the ring head/tails).

> > About inline - it can only help very small buffers.
> > Which workloads do you have in mind exactly?
> 
> It was suggested by others, but I think TCP Acks are the classic one.

Split headers + data too, tho that means supporting immediate +
indirect. 

It makes a lot of sense for command rings as well if we're going to go
down that route.

> 12 + 14 + 20 + 40 = 86 bytes with virtio_net_hdr_mrg_rxbuf at the front.
> 
> > BTW this seems to be the reverse from what you have in Mar 2001,
> > see 87mxkjls61.fsf@rustcorp.com.au :)
> 
> (s/2001/2011).  Indeed.  Noone shared my optimism that having an open
> process for a virtio2 would bring more players on board (my original
> motivation).  But technical requirements are mounting up, which means
> we're going to get there anyway.
> 
> > I am much less concerned with what we do for configuration,
> > but I do not believe we have learned all performance lessons
> > from virtio ring1. Is there any reason why we shouldn't be
> > able to experiment with inline within virtio1 and see
> > whether that gets us anything?
> 
> Inline in the used ring is possible, but those descriptors 8 bytes, vs
> 24/32.
> 
> > If we do a bunch of changes to the ring at once, we can't
> > figure out what's right, what's wrong, or back out of
> > mistakes later.
> > 
> > Since there are non PCI transports that use the ring,
> > we really shouldn't make both the configuration and
> > the ring changes depend on the same feature bit.
> 
> Yes, I'm thinking #define VIRTIO_F_VIRTIO2 (-1).  For PCI, this gets
> mapped into a "are we using the new config layout?".  For others, it
> gets mapped into a transport-specific feature.

Or we can use the PCI ProgIf to indicate a different programming
interface, that way we also use that as an excuse to say that the first
BAR can either be PIO or MMIO :-)
 
> (I'm sure you get it, but for the others) This is because I want to be
> draw a clear line between all the legacy stuff at the same time, not
> have to support part of it later because someone might not flip the
> feature bit.

Cheers,
Ben.
