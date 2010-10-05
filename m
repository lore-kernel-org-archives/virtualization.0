From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [RFC PATCH] virtio: (Partially) enable suspend/resume support
Date: Tue, 5 Oct 2010 19:15:31 +0530
Message-ID: <20101005134531.GD8207@amit-laptop.redhat.com>
References: <da50daa251eb982c43fa474de8d4f1303f1ad57f.1285762305.git.amit.shah@redhat.com>
	<20101003155359.GB20285@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20101003155359.GB20285@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Anthony Liguori <anthony@codemonkey.ws>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

(Re-adding Rusty to CC, looks like the linux-foundation ml drops CCs.)

On (Sun) Oct 03 2010 [17:53:59], Michael S. Tsirkin wrote:
> On Wed, Sep 29, 2010 at 05:42:24PM +0530, Amit Shah wrote:
> > Let host know of our state (partial yet) so that the host PCI device is
> > up to where we were when we were suspended.
> > 
> > This is still an RFC as this doesn't completely work: an unused device
> > at the time of suspend will work fine after resume, but a device that
> > has seen some activity doesn't behave well after resume.  Especially,
> > host->guest communication doesn't go through.  This could be due to
> > interrupts/MSI not being wired properly.  I haven't looked at this part
> > of the problem yet.
> > 
> > We also need a per-driver resume callback which can update the devices
> > with driver-specific data.  Eg, for virtio_console, the guest port
> > open/close status will have to be known to the device.
> > 
> > QEMU also starts using the queues as soon as the VIRTIO_PCI_QUEUE_PFN
> > command is sent, so it has to be taught to only start using queues when
> > the device is ready and the queues are set up.
> > 
> > However, I just wanted to send this out to get reactions / comments.
> > 
> > Not-yet-Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > ---
> >  drivers/virtio/virtio_pci.c  |   34 ++++++++++++++++++++++++++++++++++
> >  drivers/virtio/virtio_ring.c |    8 ++++++++
> >  include/linux/virtio.h       |    2 ++
> >  include/linux/virtio_pci.h   |    4 +++-
> >  4 files changed, 47 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> > index ef8d9d5..a3c7f59 100644
> > --- a/drivers/virtio/virtio_pci.c
> > +++ b/drivers/virtio/virtio_pci.c
> > @@ -698,8 +698,42 @@ static int virtio_pci_suspend(struct pci_dev *pci_dev, pm_message_t state)
> >  
> >  static int virtio_pci_resume(struct pci_dev *pci_dev)
> >  {
> > +	struct virtio_pci_device *vp_dev = pci_get_drvdata(pci_dev);
> > +	struct virtio_pci_vq_info *info;
> > +	unsigned long flags;
> > +
> >  	pci_restore_state(pci_dev);
> >  	pci_set_power_state(pci_dev, PCI_D0);
> > +
> > +	iowrite32(vp_dev->vdev.features[0], vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
> 
> need spaces around +

That bit is taken from a place elsewhere in the file -- I guess it's
that way to keep everything on the same line.  But in the final
submission, I'll split up the line as I've done the others below.

> > +	if (vp_dev->msix_used_vectors)
> > +		iowrite16(vp_dev->msix_used_vectors,
> > +			  vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> 
> I think this is wrong, msix_used_vectors is a counter not a vector
> number, try with 2 vectors and it will break I think: this is shared
> vectors configuration.  We just never had a need to remember the config
> vector number, either do remember it, or rely on the fact that it is
> always 0 in our code: and maybe add BUG_ON in vp_request_msix_vectors
> where it is first assigned. The condition would simply be
> msix_enabled.

Yes, I hadn't paid attention to MSI, this helps -- I'll adjust the code
accordingly.

> > +
> > +	spin_lock_irqsave(&vp_dev->lock, flags);
> > +	list_for_each_entry(info, &vp_dev->virtqueues, node) {
> > +		/* Select the queue we're interested in */
> > +		iowrite16(info->queue_index,
> > +			  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_SEL);
> > +
> > +		/* Update the last idx we sent data in */
> > +		iowrite16(virtqueue_get_avail_idx(info->vq),
> > +			  vp_dev->ioaddr + VIRTIO_PCI_AVAIL_IDX);
> 
> Interesting. Could we just reset the ring instead?
> I think this would also solve the qemu problem you
> outline, won't it?

The problem here is qemu doesn't "know" we went into suspend and came
out of it.  When going to suspend, qemu could've received a kick
notification and would've been just about to process some queue entries.
Now when we resume and reset the ring, qemu could crash anyway seeing
invalid index values.  I think that's happening now anyway.

However, I think the current qemu problem I have might be related to me
not introducing memory barriers here.

> > +		if (info->msix_vector != VIRTIO_MSI_NO_VECTOR) {
> > +			iowrite16(info->msix_vector,
> > +				  vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> > +		}
> 
> actually it's probably better to write msix_vector if it is
> VIRTIO_MSI_NO_VECTOR as well, just to make sure
> we are in a known state.  The condition
> should be that msix is enabled in the device.
> 
> Further, please read the value back and verify that it was
> written successfully: on error you get VIRTIO_MSI_NO_VECTOR.

Yes, error handling is to be done yet.

> > +		/* activate the queue */
> > +		iowrite32(virt_to_phys(info->queue) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT,
> > +			  vp_dev->ioaddr + VIRTIO_PCI_QUEUE_PFN);
> > +
> > +	}
> > +	spin_unlock_irqrestore(&vp_dev->lock, flags);
> > +
> > +	vp_set_status(&vp_dev->vdev, VIRTIO_CONFIG_S_DRIVER_OK);
> > +
> >  	return 0;
> >  }
> >  #endif
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 1475ed6..3eb91d1 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -237,6 +237,14 @@ add_head:
> >  }
> >  EXPORT_SYMBOL_GPL(virtqueue_add_buf_gfp);
> >  
> > +u16 virtqueue_get_avail_idx(struct virtqueue *_vq)
> > +{
> > +	struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +	return vq->vring.avail->idx;
> > +}
> > +EXPORT_SYMBOL_GPL(virtqueue_get_avail_idx);
> > +
> >  void virtqueue_kick(struct virtqueue *_vq)
> >  {
> >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index aff5b4f..cdb04ec 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -88,6 +88,8 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
> >  
> >  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
> >  
> > +u16 virtqueue_get_avail_idx(struct virtqueue *vq);
> > +
> 
> This is a bit of a layering violation, in that the avail index
> belongs to the ring internals.

Yes, it is.  This exercise is basically to find out what's needed to
make suspend work; we can design the final solution once we have a
better idea of what's involved.

> Possibly the best solution to expose it
> is to put the index in the ring. This was one of the ideas
> proposed for vring2. Other options include getting rid of the
> index entirely.
> 
> >  /**
> >   * virtio_device - representation of a device using virtio
> >   * @index: unique position on the virtio bus
> > diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
> > index 9a3d7c4..aa3e584 100644
> > --- a/include/linux/virtio_pci.h
> > +++ b/include/linux/virtio_pci.h
> > @@ -55,9 +55,11 @@
> >  /* Vector value used to disable MSI for queue */
> >  #define VIRTIO_MSI_NO_VECTOR            0xffff
> >  
> > +#define VIRTIO_PCI_AVAIL_IDX		24
> > +
> >  /* The remaining space is defined by each driver as the per-driver
> >   * configuration space */
> > -#define VIRTIO_PCI_CONFIG(dev)		((dev)->msix_enabled ? 24 : 20)
> > +#define VIRTIO_PCI_CONFIG(dev)		26
> 
> This will silently break all devices out there, won't it?

Sure it does :-)  (Has to be handled when this is proposed as a fix
officially.)

		Amit
