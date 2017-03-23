From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [REGRESSION] 07ec51480b5e ("virtio_pci: use shared interrupts
	for virtqueues") causes crashes in guest
Date: Thu, 23 Mar 2017 18:41:56 +0200
Message-ID: <20170323184143-mutt-send-email-mst@kernel.org>
References: <43ffa887-a20d-f836-cba8-11196924d82d@redhat.com>
	<e042635f-e30e-45e8-f4a5-b03b9228eec2@redhat.com>
	<20170323151906.GA19376@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170323151906.GA19376@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thorsten Leemhuis <linux@leemhuis.info>, virtualization@lists.linux-foundation.org, Laura Abbott <labbott@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 23, 2017 at 03:19:07PM +0000, Richard W.M. Jones wrote:
> On Thu, Mar 23, 2017 at 01:13:50PM +0800, Jason Wang wrote:
> > >From 312859b596e83a2164a8430343d31fce2a5ad808 Mon Sep 17 00:00:00 2001
> > From: Jason Wang <jasowang@redhat.com>
> > Date: Thu, 23 Mar 2017 13:07:16 +0800
> > Subject: [PATCH] virtio_pci: fix out of bound access for msix_names
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> I tested this, and it does appear to fix the crashes in
> vp_modern_find_vqs.  Therefore:
> 
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> 
> Thanks,
> 
> Rich.

I've queued the fix, thanks everyone!

> >  drivers/virtio/virtio_pci_common.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> > index df548a6..5905349 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -147,7 +147,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> >  {
> >  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> >  	const char *name = dev_name(&vp_dev->vdev.dev);
> > -	int i, err = -ENOMEM, allocated_vectors, nvectors;
> > +	int i, j, err = -ENOMEM, allocated_vectors, nvectors;
> >  	unsigned flags = PCI_IRQ_MSIX;
> >  	bool shared = false;
> >  	u16 msix_vec;
> > @@ -212,7 +212,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> >  	if (!vp_dev->msix_vector_map)
> >  		goto out_disable_config_irq;
> >  
> > -	allocated_vectors = 1; /* vector 0 is the config interrupt */
> > +	allocated_vectors = j = 1; /* vector 0 is the config interrupt */
> >  	for (i = 0; i < nvqs; ++i) {
> >  		if (!names[i]) {
> >  			vqs[i] = NULL;
> > @@ -236,18 +236,19 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> >  			continue;
> >  		}
> >  
> > -		snprintf(vp_dev->msix_names[i + 1],
> > +		snprintf(vp_dev->msix_names[j],
> >  			 sizeof(*vp_dev->msix_names), "%s-%s",
> >  			 dev_name(&vp_dev->vdev.dev), names[i]);
> >  		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> >  				  vring_interrupt, IRQF_SHARED,
> > -				  vp_dev->msix_names[i + 1], vqs[i]);
> > +				  vp_dev->msix_names[j], vqs[i]);
> >  		if (err) {
> >  			/* don't free this irq on error */
> >  			vp_dev->msix_vector_map[i] = VIRTIO_MSI_NO_VECTOR;
> >  			goto out_remove_vqs;
> >  		}
> >  		vp_dev->msix_vector_map[i] = msix_vec;
> > +		j++;
> >  
> >  		/*
> >  		 * Use a different vector for each queue if they are available,
> > -- 
> > 2.7.4
> > 
> 
> 
> -- 
> Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
> Read my programming and virtualization blog: http://rwmj.wordpress.com
> virt-builder quickly builds VMs from scratch
> http://libguestfs.org/virt-builder.1.html
