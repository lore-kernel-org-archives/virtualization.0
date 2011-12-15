From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Thu, 15 Dec 2011 10:27:50 +0200
Message-ID: <20111215063004.GA3630@redhat.com>
References: <87pqfzgy6p.fsf@rustcorp.com.au> <87zkf3fiu2.fsf@rustcorp.com.au>
	<20111211094256.GB11504@redhat.com>
	<87boreohhs.fsf@rustcorp.com.au>
	<20111212182533.GB25916@redhat.com>
	<87liqhtdnj.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87liqhtdnj.fsf@rustcorp.com.au>
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
Cc: Sasha Levin <levinsasha928@gmail.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Dec 13, 2011 at 12:51:20PM +1030, Rusty Russell wrote:
> On Mon, 12 Dec 2011 20:25:34 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > By the way, a generic question on virtio-pci: we now have:
> > 
> > /* virtio config->get() implementation */
> > static void vp_get(struct virtio_device *vdev, unsigned offset,
> >                    void *buf, unsigned len)
> > {
> >         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >         void __iomem *ioaddr = vp_dev->ioaddr +
> >                                 VIRTIO_PCI_CONFIG(vp_dev) + offset;
> >         u8 *ptr = buf;
> >         int i;
> > 
> >         for (i = 0; i < len; i++)
> >                 ptr[i] = ioread8(ioaddr + i);
> > }
> > 
> > This means that if configuration is read while
> > it is changed, we might get an inconsistent state,
> > with parts of a 64 bit field coming from old
> > and parts from new value.
> > 
> > Isn't this a problem?
> 
> I don't think so; it's the caller's problem if they need to do locking.
> Is there a caller which needs this?
> 
> Or am I missing something?
> Rusty.


I mean like this in block:



        /* Host must always specify the capacity. */
        vdev->config->get(vdev, offsetof(struct virtio_blk_config,
capacity),
                          &capacity, sizeof(capacity));

        /* If capacity is too big, truncate with warning. */
        if ((sector_t)capacity != capacity) {
                dev_warn(&vdev->dev, "Capacity %llu too large:
truncating\n",
                         (unsigned long long)capacity);
                capacity = (sector_t)-1;
        }


Now let's assume capacity field is changed from 0x8000 to 0x10000
on host. Is it possible that we read two upper bytes
before the change so we see 0x0000....
and 2 lower bytes after the change
so we see 0x....0000 and resulting capacity appears
to be 0?

If no why not?

And what kind of locking can help?

-- 
MST
