From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: share config interrupt between virtio
	devices
Date: Mon, 1 Sep 2014 11:12:17 +0300
Message-ID: <20140901081217.GC20700@redhat.com>
References: <1409550114-8186-1-git-send-email-akong@redhat.com>
	<20140901063730.GB20186@redhat.com>
	<20140901075802.GB3546@zen.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140901075802.GB3546@zen.nay.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Sep 01, 2014 at 03:58:02PM +0800, Amos Kong wrote:
> On Mon, Sep 01, 2014 at 09:37:30AM +0300, Michael S. Tsirkin wrote:
> >
> 
> Hi Michael,
> 
> > On Mon, Sep 01, 2014 at 01:41:54PM +0800, Amos Kong wrote:
> > > One VM only has 128 msix interrupt, virtio-config interrupt
> > > has less workload. This patch shares one normal interrupt
> 
> Thanks for your quick reply.
> 
> > normal == INT#x? Please don't call it normal. The proper name is
> > "legacy INT#x".
>  
> OK
> 
> > So you are trying to use legacy INT#x at the same time
> > with MSI-X?  This does not work: the PCI spec says:
> > 	While enabled for MSI or MSI-X
> > 	operation, a function is prohibited from using its INTx# pin (if
> > 	implemented) to request
> > 	service (MSI, MSI-X, and INTx# are mutually exclusive).
> 
> It means we can't use interrupt and triggered-interrupt together for
> one PCI device. I will study this problem.
>  
> > does the patch work for you? If it does it might be a (minor) spec
> > violation in kvm.
> 
> I did some basic testing (multiple nics, scp, ping, etc), it works.

It's quite likely there were no config interrupts in your
basic test. Trigger some event that requires a config interrupt
to function. For example, drop link and see if guest notices this.

> > Besides, INT#x really leads to terrible performance because
> > sharing is forced even if there aren't many devices.
> > 
> > Why do we need INT#x?
> > How about setting IRQF_SHARED for the config interrupt
> > while using MSI-X?
> > You'd have to read ISR to check that the interrupt was
> > intended for your device.
>  
> I have a draft patch to share one MSI-X for all virtio-config, it has
> some problem in hotplugging devices. I will continue this way.
>  
> > > for configuration between virtio devices.
> > > 
> > > Signed-off-by: Amos Kong <akong@redhat.com>
> > > ---
> > >  drivers/virtio/virtio_pci.c | 41 ++++++++++++++++-------------------------
> > >  1 file changed, 16 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> > > index 3d1463c..b1263b3 100644
> > > --- a/drivers/virtio/virtio_pci.c
> > > +++ b/drivers/virtio/virtio_pci.c
> > > @@ -52,6 +52,7 @@ struct virtio_pci_device
> > >  	/* Name strings for interrupts. This size should be enough,
> > >  	 * and I'm too lazy to allocate each name separately. */
> > >  	char (*msix_names)[256];
> > > +	char config_msix_name[256];
> > >  	/* Number of available vectors */
> > >  	unsigned msix_vectors;
> > >  	/* Vectors allocated, excluding per-vq vectors if any */
> > > @@ -282,12 +283,6 @@ static void vp_free_vectors(struct virtio_device *vdev)
> > >  			free_cpumask_var(vp_dev->msix_affinity_masks[i]);
> > >  
> > >  	if (vp_dev->msix_enabled) {
> > > -		/* Disable the vector used for configuration */
> > > -		iowrite16(VIRTIO_MSI_NO_VECTOR,
> > > -			  vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> > > -		/* Flush the write out to device */
> > > -		ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> > > -
> > >  		pci_disable_msix(vp_dev->pci_dev);
> > >  		vp_dev->msix_enabled = 0;
> > >  	}
> > > @@ -339,24 +334,18 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> > >  		goto error;
> > >  	vp_dev->msix_enabled = 1;
> > >  
> > > -	/* Set the vector used for configuration */
> > > -	v = vp_dev->msix_used_vectors;
> > > -	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> > > +	/* Set shared IRQ for configuration */
> > > +	snprintf(vp_dev->config_msix_name, sizeof(*vp_dev->msix_names),
> > >  		 "%s-config", name);
> > > -	err = request_irq(vp_dev->msix_entries[v].vector,
> > > -			  vp_config_changed, 0, vp_dev->msix_names[v],
> > > +	err = request_irq(vp_dev->pci_dev->irq,
> > > +			  vp_config_changed,
> > > +			  IRQF_SHARED,
> > > +			  vp_dev->config_msix_name,
> > >  			  vp_dev);
> > > -	if (err)
> > > -		goto error;
> > > -	++vp_dev->msix_used_vectors;
> > > -
> > > -	iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> > > -	/* Verify we had enough resources to assign the vector */
> > > -	v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> > > -	if (v == VIRTIO_MSI_NO_VECTOR) {
> > > -		err = -EBUSY;
> > > +	if (!err)
> > > +		vp_dev->intx_enabled = 1;
> > > +	else
> > >  		goto error;
> > > -	}
> > >  
> > >  	if (!per_vq_vectors) {
> > >  		/* Shared vector for all VQs */
> > > @@ -535,14 +524,16 @@ static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > >  			goto error_request;
> > >  	} else {
> > >  		if (per_vq_vectors) {
> > > -			/* Best option: one for change interrupt, one per vq. */
> > > -			nvectors = 1;
> > > +			/* Best option: one normal interrupt for change,
> > > +			   one msix per vq. */
> > > +			nvectors = 0;
> > >  			for (i = 0; i < nvqs; ++i)
> > >  				if (callbacks[i])
> > >  					++nvectors;
> > >  		} else {
> > > -			/* Second best: one for change, shared for all vqs. */
> > > -			nvectors = 2;
> > > +			/* Second best: one normal interrupt for
> > > +			   change, share one msix for all vqs. */
> > > +			nvectors = 1;
> > >  		}
> > >  
> > >  		err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
> > > -- 
> > > 1.9.3
> > --
> > To unsubscribe from this list: send the line "unsubscribe kvm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> 			Amos.
