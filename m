From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Fri, 13 Jan 2012 13:52:28 +1030
Message-ID: <877h0wjngr.fsf@rustcorp.com.au>
References: <20111218101831.GB30374@redhat.com>
	<87bor5nlht.fsf@rustcorp.com.au>
	<20111219091324.GA19535@redhat.com>
	<871us0om2t.fsf@rustcorp.com.au> <20111220113718.GF3913@redhat.com>
	<878vm6daqy.fsf@rustcorp.com.au>
	<20120110170334.GA18404@redhat.com>
	<8762gj6q5r.fsf@rustcorp.com.au>
	<20120111102129.GC20988@redhat.com>
	<87vcoh4r2y.fsf@rustcorp.com.au>
	<20120112060009.GC10319@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120112060009.GC10319@redhat.com>
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

On Thu, 12 Jan 2012 08:00:10 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jan 12, 2012 at 12:31:09PM +1030, Rusty Russell wrote:
> > If we use a 32-bit counter, we also get this though, right?
> > 
> > If counter has changed, it's a config interrupt...
> 
> But we need an exit to read the counter. We can put the counter
> in memory but this looks suspiciously like a simplified VQ -
> so why not use a VQ then?

Because now a driver first gets the data from config space.  But from
then on, they have to get it from the vq, and ignore the config space.
That's a bit weird.

> > > If we do require config VQ anyway, why not use it to notify
> > > guest of config changes? Guest could pre-post an in buffer
> > > and host uses that.
> > 
> > We could, but it's an additional burden on each device.  vqs are cheap,
> > but not free.  And the config area is so damn convenient...
> 
> Not if you start playing with counters, checking it twice,
> reinvent all kind of barriers ...

None of that appears inside the driver, though.  And let's be honest,
it's not *that* bad (very approx code):

static u32 vp_get_gen(struct virtio_pci_device *vp_dev)
{
        u32 gen;
        do {
                gen = ioread32(vp_dev->ioaddr + VIRTIO_PCI_CONFIG_GEN);
        } while (unlikely((gen & 1) == 1));

        virtio_rmb();
        return gen;
}

static bool vp_check_gen(struct virtio_pci_device *vp_dev, u32 gen)
{
        virtio_rmb();
        return ioread32(vp_dev->ioaddr + VIRTIO_PCI_CONFIG_GEN) == gen;
}

static void vp_get32(struct virtio_device *vdev, unsigned offset, u32 *buf)
{
	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
        u32 gen;

        do {
                gen = vp_get_gen(vdev);
                *buf = ioread32(vp_dev->ioaddr + VIRTIO_PCI_CONFIG(vp_dev) + offset);
        } while (unlikely(!vp_check_gen(vp_dev, gen)));
}
...

> > It was suggested by others, but I think TCP Acks are the classic one.
> > 12 + 14 + 20 + 40 = 86 bytes with virtio_net_hdr_mrg_rxbuf at the front.
> 
> That's only the simplest IPv4, right?
> Anyway, this spans multiple descriptors so this complicates allocation
> significantly.

Yes, I think any general-but-useful inline will need to span multiple
descriptors.  That's part of the fun!

Let's get totally crazy and implement our ring in stripes, like:

00 04 08 12 01 05 09 13 02 06 10 14 03 07 11 15

That way consecutive (32-byte) descriptors don't share a cacheline!
(Not serious... quiet.)

> > Yes, I'm thinking #define VIRTIO_F_VIRTIO2 (-1).  For PCI, this gets
> > mapped into a "are we using the new config layout?".  For others, it
> > gets mapped into a transport-specific feature.
> > 
> > (I'm sure you get it, but for the others) This is because I want to be
> > draw a clear line between all the legacy stuff at the same time, not
> > have to support part of it later because someone might not flip the
> > feature bit.
> 
> So my point is, config stuff and ring are completely separate,
> they are different layers.

Absolutely, and we should analyze them separately as well as together.

*But* for maintenance is far easier if we only have to test new
config+new ring and old config+old ring.  They do interact, because
remember, the allocation of the ring changes with new config, too...

Cheers,
Rusty.
