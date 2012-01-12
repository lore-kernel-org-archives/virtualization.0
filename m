From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 12 Jan 2012 08:51:32 +0200
Message-ID: <20120112065132.GF10319@redhat.com>
References: <871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au>
	<20120111102129.GC20988@redhat.com>
	<87vcoh4r2y.fsf@rustcorp.com.au>
	<1326342719.23910.199.camel@pasglop>
	<20120112060954.GD10319@redhat.com>
	<1326349714.23910.207.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326349714.23910.207.camel@pasglop>
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

On Thu, Jan 12, 2012 at 05:28:34PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2012-01-12 at 08:09 +0200, Michael S. Tsirkin wrote:
> > On Thu, Jan 12, 2012 at 03:31:59PM +1100, Benjamin Herrenschmidt wrote:
> > > However I can see at least one advantage of what you've done :-) You
> > > never have to deal with holes in the ring.
> > 
> > Another advantage is the design goal for that ring:
> > host never needs to copy even if it completes
> > descriptors out of order. And out of order is something that does not
> > happen at all with hardware drivers. This is where paravirt is
> > different.
> 
> Actually out of order can happen with tagged command queue for SCSI or
> ATA, tho I'm not 100% familiar with how things like AHCI handle this.
> 
> > > > > Two rings do have the advantage of not requiring host side copy, which
> > > > > copy would surely add to cache pressure.
> > > > 
> > > > Well, a simple host could process in-order and leave stuff in the ring I
> > > > guess.  A smarter host would copy and queue, maybe leave one queue entry
> > > > in so it doesn't get flooded?
> > > 
> > > What's wrong with a ring of descriptors + a ring of completion, with a
> > > single toggle valid bit to indicate whether a given descriptor is valid
> > > or not (to avoid the nasty ping pong on the ring head/tails).
> > 
> > First, I don't understand how a valid bit avoids ping poing on the last
> > descriptor. Second, how do you handle out of order completions?
> 
> A toggle means the valid bit is never cleared, it just changes polarity
> every time you go around the ring. So there's never a write back to 0.

Ah, OK. Still we might have a cache line bouncing back
and forth as host rechecks this valid bit while guest
toggles it.

This also gets nasty with e.g. inline data.



> Out of order is something I hadn't thought about (I was most probably
> too focused on virtio-net) and is indeed a PITA. It's doable with rings
> but can get nasty.
> 
> I'll give that more thought in the next week, and Rusty and I shall play
> with userspace models based on your tool.

You might want to add more workloads - I have modeled stream transmit,
but e.g. ping pong is also interesting.

One othe rinteresting thing is that
in practice host often runs on the same CPU as guest.
This is the fastest way to run the host for when it
does not do a lot of work as most data is cached. And there amount of sharing
is less important than reducing cache consumption.

Again this is different from real hardware.

> > > > > About inline - it can only help very small buffers.
> > > > > Which workloads do you have in mind exactly?
> > > > 
> > > > It was suggested by others, but I think TCP Acks are the classic one.
> > > 
> > > Split headers + data too, tho that means supporting immediate +
> > > indirect. 
> > > 
> > > It makes a lot of sense for command rings as well if we're going to go
> > > down that route.
> > 
> > I don't see why it makes sense for commands. It's a performance
> > optimization and commands are off the data path.
> 
> Oh just code simplification not having to dequeue a descriptor, allocate
> a buffer, etc... but a lot of that can be buried in helpers indeed.
> 
> > We can't, legal PCI ProgIf values are defined in PCI spec.
> 
> Hrm, more or less yes, I suppose we should stay away from that then,
> do we use revision ID for anything in virtio-land ?
> 
> Cheers,
> Ben.
> 
