From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC 7/11] virtio_pci: new, capability-aware driver.
Date: Wed, 18 Jan 2012 17:29:49 +0200
Message-ID: <20120118152949.GA2665@redhat.com>
References: <4F0DB2AB.8030506@codemonkey.ws>
	<20120111170859.GA22310@redhat.com>
	<4F0DE62F.6030805@codemonkey.ws>
	<20120111201436.GA27292@redhat.com>
	<4F0DF08F.7010706@codemonkey.ws>
	<1326315726.23910.143.camel@pasglop>
	<20120111220232.GC27292@redhat.com>
	<87wr8x4rye.fsf@rustcorp.com.au>
	<20120113021930.GA15379@redhat.com>
	<1326421962.23910.228.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1326421962.23910.228.camel@pasglop>
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
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization <virtualization@lists.linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Sasha Levin <levinsasha928@gmail.com>, Anthony Liguori <anthony@codemonkey.ws>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jan 13, 2012 at 01:32:42PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2012-01-13 at 04:19 +0200, Michael S. Tsirkin wrote:
> > On Thu, Jan 12, 2012 at 12:12:17PM +1030, Rusty Russell wrote:
> > > On Thu, 12 Jan 2012 00:02:33 +0200, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > Look, we have a race currently. Let us not tie a bug fix to a huge
> > > > rewrite with unclear performance benefits, please.
> > > 
> > > In theory, yes.  In practice, we bandaid it.
> > > 
> > > I think in the short term we change ->get to get the entire sequence
> > > twice, and check it's the same.  Theoretically, still racy, but it does
> > > cut the window.  And we haven't seen the bug yet, either.
> > 
> > I thought about this some more. Since we always get
> > an interrupt on config changes, it seems that a rather
> > robust method would be to just synchronize against that.
> > Something like the below (warning - completely untested).
> > Still need to think about memory barriers, overflow etc.
> > What do you think?
> 
> Your interrupt may take an unpredictable amount of time to arrive, I
> don't see how you can use that as a guarantee.
> 
> Cheers,
> Ben.

In theory yes.
Practically, under current KVM, what would delay it?


> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> > index 03d1984..b5df385 100644
> > --- a/drivers/virtio/virtio_pci.c
> > +++ b/drivers/virtio/virtio_pci.c
> > @@ -57,6 +57,7 @@ struct virtio_pci_device
> >  	unsigned msix_used_vectors;
> >  	/* Whether we have vector per vq */
> >  	bool per_vq_vectors;
> > +	atomic_t config_changes;
> >  };
> >  
> >  /* Constants for MSI-X */
> > @@ -125,6 +126,19 @@ static void vp_finalize_features(struct virtio_device *vdev)
> >  	iowrite32(vdev->features[0], vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
> >  }
> >  
> > +/* wait for pending irq handlers */
> > +static void vp_synchronize_vectors(struct virtio_device *vdev)
> > +{
> > +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > +	int i;
> > +
> > +	if (vp_dev->intx_enabled)
> > +		synchronize_irq(vp_dev->pci_dev->irq);
> > +
> > +	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > +		synchronize_irq(vp_dev->msix_entries[i].vector);
> > +}
> > +
> >  /* virtio config->get() implementation */
> >  static void vp_get(struct virtio_device *vdev, unsigned offset,
> >  		   void *buf, unsigned len)
> > @@ -134,9 +148,20 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
> >  				VIRTIO_PCI_CONFIG(vp_dev) + offset;
> >  	u8 *ptr = buf;
> >  	int i;
> > -
> > -	for (i = 0; i < len; i++)
> > -		ptr[i] = ioread8(ioaddr + i);
> > +	int uninitialized_var(c);
> > +	c = atomic_read(&vp_dev->config_changes);
> > +	/* Make sure read is done before we get the first config byte */
> > +	rmb();
> > +	do {
> > +		for (i = 0; i < len; i++)
> > +			ptr[i] = ioread8(ioaddr + i);
> > +		/* Synchronize with config interrupt */
> > +		vp_synchronize_vectors(vdev);
> > +		/*
> > +		 * For multi-byte fields, we might get a config change interrupt
> > +		 * between byte reads. If this happens, retry the read.
> > +		 */
> > +	} while (c != atomic_read(&vp_dev->config_changes))
> >  }
> >  
> >  /* the config->set() implementation.  it's symmetric to the config->get()
> > @@ -169,19 +194,6 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
> >  	iowrite8(status, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
> >  }
> >  
> > -/* wait for pending irq handlers */
> > -static void vp_synchronize_vectors(struct virtio_device *vdev)
> > -{
> > -	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > -	int i;
> > -
> > -	if (vp_dev->intx_enabled)
> > -		synchronize_irq(vp_dev->pci_dev->irq);
> > -
> > -	for (i = 0; i < vp_dev->msix_vectors; ++i)
> > -		synchronize_irq(vp_dev->msix_entries[i].vector);
> > -}
> > -
> >  static void vp_reset(struct virtio_device *vdev)
> >  {
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> > @@ -213,6 +225,8 @@ static irqreturn_t vp_config_changed(int irq, void *opaque)
> >  	drv = container_of(vp_dev->vdev.dev.driver,
> >  			   struct virtio_driver, driver);
> >  
> > +	atomic_inc(&vp_dev->config_changes);
> > +
> >  	if (drv && drv->config_changed)
> >  		drv->config_changed(&vp_dev->vdev);
> >  	return IRQ_HANDLED;
> > @@ -646,6 +660,7 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
> >  	vp_dev->vdev.config = &virtio_pci_config_ops;
> >  	vp_dev->pci_dev = pci_dev;
> >  	INIT_LIST_HEAD(&vp_dev->virtqueues);
> > +	atomic_set(&vp_dev->config_changes, 0);
> >  	spin_lock_init(&vp_dev->lock);
> >  
> >  	/* Disable MSI/MSIX to bring device to a known good state. */
> 
