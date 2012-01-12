From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 12:31:09 +1030
Message-ID: <87vcoh4r2y.fsf@rustcorp.com.au>
References: <20111215063004.GA3630@redhat.com> <87zketp9nz.fsf@rustcorp.com.au>
	<20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au>
	<20120111102129.GC20988@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120111102129.GC20988@redhat.com>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 11 Jan 2012 12:21:30 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Jan 11, 2012 at 10:55:52AM +1030, Rusty Russell wrote:
> > On Tue, 10 Jan 2012 19:03:36 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Dec 21, 2011 at 11:03:25AM +1030, Rusty Russell wrote:
> > > > Yes.  The idea that we can alter fields in the device-specific config
> > > > area is flawed.  There may be cases where it doesn't matter, but as an
> > > > idea it was holed to begin with.
> > > > 
> > > > We can reduce probability by doing a double read to check, but there are
> > > > still cases where it will fail.
> > > 
> > > Okay - want me to propose an interface for that?
> > 
> > Had a brief chat with BenH (CC'd).
> > 
> > I think we should deprecate writing to the config space.  Only balloon
> > does it AFAICT, and I can't quite figure out *why* it has an 'active'
> > field.
> 
> Are you sure? I think net writes a mac address.

True.  We'll need to disable that, and come up with another mechanism if
we want it back (a new feature and a VIRTIO_NET_HDR_F_SET_MAC flag in
the virtio_net header?  Or would that mess up vhost_net?).

> > This solves half the problem, of sync guest writes.  For the
> > other half, I suggest a generation counter; odd means inconsistent.  The
> > guest can poll.
> 
> So we get the counter until it's even, get the config, if it's changed
> repeat? Yes it works. However, I would like to have a way to detect
> config change just by looking at memory. ATM we need to read ISR to
> know.  If we used a VQ, the advantage would be that the device can work
> with a single MSIX vector shared by all VQs.

If we use a 32-bit counter, we also get this though, right?

If counter has changed, it's a config interrupt...

> If we do require config VQ anyway, why not use it to notify
> guest of config changes? Guest could pre-post an in buffer
> and host uses that.

We could, but it's an additional burden on each device.  vqs are cheap,
but not free.  And the config area is so damn convenient...

> > BenH also convinced me we should finally make the config space LE if
> > we're going to change things.  Since PCI is the most common transport,
> > guest-endian confuses people.  And it sucks for really weird machines.
> 
> Are we going to keep guest endian for e.g. virtio net header?
> If yes the benefit of switching config space is not that big.
> And changes in devices would affect non-PCI transports.

Yep.  It would only make sense if we do it for everything.  And yes,
it'll mess up everyone who is BE, so it needs to be a feature bit for
them.

> > We should also change the ring (to a single ring, I think).  Descriptors
> > to 24 bytes long (8 byte cookie, 8 byte addr, 4 byte len, 4 byte flags).
> > We might be able to squeeze it into 20 bytes but that means packing.  We
> > should support inline, chained or indirect.  Let the other side ack by
> > setting flag, cookie and len (if written).
> 
> Quite possibly all or some of these things help performance
> but do we have to change the spec before we have experimental
> proof?

We change the spec last, once we know what we're doing, ideally.

> I did experiment with a single ring using tools/virtio and
> I didn't see a measureable performance gain.

Interesting.  It is simpler and more standard than our current design,
but that's not sufficient unless there are other reasons.  Needs further
discussion and testing.

> Two rings do have the advantage of not requiring host side copy, which
> copy would surely add to cache pressure.

Well, a simple host could process in-order and leave stuff in the ring I
guess.  A smarter host would copy and queue, maybe leave one queue entry
in so it doesn't get flooded?

>  Since
> host doesn't change desriptors, we could also
> preformat some descriptors in the current design.
>
> There is a fragmentation problem in theory but it can be alleviated with
> a smart allocator.

Yeah, the complexity scares me...

> About inline - it can only help very small buffers.
> Which workloads do you have in mind exactly?

It was suggested by others, but I think TCP Acks are the classic one.
12 + 14 + 20 + 40 = 86 bytes with virtio_net_hdr_mrg_rxbuf at the front.

> BTW this seems to be the reverse from what you have in Mar 2001,
> see 87mxkjls61.fsf@rustcorp.com.au :)

(s/2001/2011).  Indeed.  Noone shared my optimism that having an open
process for a virtio2 would bring more players on board (my original
motivation).  But technical requirements are mounting up, which means
we're going to get there anyway.

> I am much less concerned with what we do for configuration,
> but I do not believe we have learned all performance lessons
> from virtio ring1. Is there any reason why we shouldn't be
> able to experiment with inline within virtio1 and see
> whether that gets us anything?

Inline in the used ring is possible, but those descriptors 8 bytes, vs
24/32.

> If we do a bunch of changes to the ring at once, we can't
> figure out what's right, what's wrong, or back out of
> mistakes later.
> 
> Since there are non PCI transports that use the ring,
> we really shouldn't make both the configuration and
> the ring changes depend on the same feature bit.

Yes, I'm thinking #define VIRTIO_F_VIRTIO2 (-1).  For PCI, this gets
mapped into a "are we using the new config layout?".  For others, it
gets mapped into a transport-specific feature.

(I'm sure you get it, but for the others) This is because I want to be
draw a clear line between all the legacy stuff at the same time, not
have to support part of it later because someone might not flip the
feature bit.

Cheers,
Rusty.
