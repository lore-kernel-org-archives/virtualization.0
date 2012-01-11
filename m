From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Wed, 11 Jan 2012 12:21:30 +0200
Message-ID: <20120111102129.GC20988@redhat.com>
References: <20111215063004.GA3630@redhat.com> <87zketp9nz.fsf@rustcorp.com.au>
	<20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8762gj6q5r.fsf@rustcorp.com.au>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sasha Levin <levinsasha928@gmail.com>, Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 11, 2012 at 10:55:52AM +1030, Rusty Russell wrote:
> On Tue, 10 Jan 2012 19:03:36 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Wed, Dec 21, 2011 at 11:03:25AM +1030, Rusty Russell wrote:
> > > Yes.  The idea that we can alter fields in the device-specific config
> > > area is flawed.  There may be cases where it doesn't matter, but as an
> > > idea it was holed to begin with.
> > > 
> > > We can reduce probability by doing a double read to check, but there are
> > > still cases where it will fail.
> > 
> > Okay - want me to propose an interface for that?
> 
> Had a brief chat with BenH (CC'd).
> 
> I think we should deprecate writing to the config space.  Only balloon
> does it AFAICT, and I can't quite figure out *why* it has an 'active'
> field.

Are you sure? I think net writes a mac address.

> This solves half the problem, of sync guest writes.  For the
> other half, I suggest a generation counter; odd means inconsistent.  The
> guest can poll.

So we get the counter until it's even, get the config, if it's changed
repeat? Yes it works. However, I would like to have a way to detect
config change just by looking at memory. ATM we need to read ISR to
know.  If we used a VQ, the advantage would be that the device can work
with a single MSIX vector shared by all VQs.

If we do require config VQ anyway, why not use it to notify
guest of config changes? Guest could pre-post an in buffer
and host uses that.


> BenH also convinced me we should finally make the config space LE if
> we're going to change things.  Since PCI is the most common transport,
> guest-endian confuses people.  And it sucks for really weird machines.

Are we going to keep guest endian for e.g. virtio net header?
If yes the benefit of switching config space is not that big.
And changes in devices would affect non-PCI transports.

> We should also change the ring (to a single ring, I think).  Descriptors
> to 24 bytes long (8 byte cookie, 8 byte addr, 4 byte len, 4 byte flags).
> We might be able to squeeze it into 20 bytes but that means packing.  We
> should support inline, chained or indirect.  Let the other side ack by
> setting flag, cookie and len (if written).

Quite possibly all or some of these things help performance
but do we have to change the spec before we have experimental
proof?

I did experiment with a single ring using tools/virtio and
I didn't see a measureable performance gain. Two rings
do have the advantage of not requiring host side copy,
which copy would surely add to cache pressure.  Since
host doesn't change desriptors, we could also
preformat some descriptors in the current design.
There is a fragmentation problem in theory but it can be alleviated with
a smart allocator. About inline - it can only help very small buffers.
Which workloads do you have in mind exactly?


> Moreover, I think we should make all these changes at once (at least, in
> the spec).  That makes it a big change, and it'll take longer to
> develop, but makes it easy in the long run to differentiate legacy and
> modern virtio.
> 
> Thoughts?
> Rusty.

BTW this seems to be the reverse from what you have in Mar 2001,
see 87mxkjls61.fsf@rustcorp.com.au :)

I am much less concerned with what we do for configuration,
but I do not believe we have learned all performance lessons
from virtio ring1. Is there any reason why we shouldn't be
able to experiment with inline within virtio1 and see
whether that gets us anything?
If we do a bunch of changes to the ring at once, we can't
figure out what's right, what's wrong, or back out of
mistakes later.

Since there are non PCI transports that use the ring,
we really shouldn't make both the configuration and
the ring changes depend on the same feature bit.

-- 
MST
