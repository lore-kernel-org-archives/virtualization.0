From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 08:09:55 +0200
Message-ID: <20120112060954.GD10319@redhat.com>
References: <87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au>
	<20120111102129.GC20988@redhat.com>
	<87vcoh4r2y.fsf@rustcorp.com.au>
	<1326342719.23910.199.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326342719.23910.199.camel@pasglop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Jan 12, 2012 at 03:31:59PM +1100, Benjamin Herrenschmidt wrote:
> However I can see at least one advantage of what you've done :-) You
> never have to deal with holes in the ring.

Another advantage is the design goal for that ring:
host never needs to copy even if it completes
descriptors out of order. And out of order is something that does not
happen at all with hardware drivers. This is where paravirt is
different.

> > > Two rings do have the advantage of not requiring host side copy, which
> > > copy would surely add to cache pressure.
> > 
> > Well, a simple host could process in-order and leave stuff in the ring I
> > guess.  A smarter host would copy and queue, maybe leave one queue entry
> > in so it doesn't get flooded?
> 
> What's wrong with a ring of descriptors + a ring of completion, with a
> single toggle valid bit to indicate whether a given descriptor is valid
> or not (to avoid the nasty ping pong on the ring head/tails).

First, I don't understand how a valid bit avoids ping poing on the last
descriptor. Second, how do you handle out of order completions?


> > > About inline - it can only help very small buffers.
> > > Which workloads do you have in mind exactly?
> > 
> > It was suggested by others, but I think TCP Acks are the classic one.
> 
> Split headers + data too, tho that means supporting immediate +
> indirect. 
> 
> It makes a lot of sense for command rings as well if we're going to go
> down that route.

I don't see why it makes sense for commands. It's a performance
optimization and commands are off the data path.

> > 12 + 14 + 20 + 40 = 86 bytes with virtio_net_hdr_mrg_rxbuf at the front.
> > 
> > > BTW this seems to be the reverse from what you have in Mar 2001,
> > > see 87mxkjls61.fsf@rustcorp.com.au :)
> > 
> > (s/2001/2011).  Indeed.  Noone shared my optimism that having an open
> > process for a virtio2 would bring more players on board (my original
> > motivation).  But technical requirements are mounting up, which means
> > we're going to get there anyway.
> > 
> > > I am much less concerned with what we do for configuration,
> > > but I do not believe we have learned all performance lessons
> > > from virtio ring1. Is there any reason why we shouldn't be
> > > able to experiment with inline within virtio1 and see
> > > whether that gets us anything?
> > 
> > Inline in the used ring is possible, but those descriptors 8 bytes, vs
> > 24/32.
> > 
> > > If we do a bunch of changes to the ring at once, we can't
> > > figure out what's right, what's wrong, or back out of
> > > mistakes later.
> > > 
> > > Since there are non PCI transports that use the ring,
> > > we really shouldn't make both the configuration and
> > > the ring changes depend on the same feature bit.
> > 
> > Yes, I'm thinking #define VIRTIO_F_VIRTIO2 (-1).  For PCI, this gets
> > mapped into a "are we using the new config layout?".  For others, it
> > gets mapped into a transport-specific feature.
> 
> Or we can use the PCI ProgIf to indicate a different programming
> interface, that way we also use that as an excuse to say that the first
> BAR can either be PIO or MMIO :-)

We can't, legal PCI ProgIf values are defined in PCI spec.

> > (I'm sure you get it, but for the others) This is because I want to be
> > draw a clear line between all the legacy stuff at the same time, not
> > have to support part of it later because someone might not flip the
> > feature bit.
> 
> Cheers,
> Ben.
> 
