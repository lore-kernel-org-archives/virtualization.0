From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv4 2/2] virtio: refactor find_vqs
Date: Tue, 28 Jul 2009 11:33:08 +0300
Message-ID: <20090728083308.GA662__27543.4699179188$1248770201$gmane$org@redhat.com>
References: <cover.1248623150.git.mst@redhat.com>
	<20090726154709.GC21829@redhat.com>
	<200907281244.32124.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200907281244.32124.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, avi@redhat.com, Anthony Liguori <anthony@codemonkey.ws>, amit.shah@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jul 28, 2009 at 12:44:31PM +0930, Rusty Russell wrote:
> On Mon, 27 Jul 2009 01:17:09 am Michael S. Tsirkin wrote:
> > This refactors find_vqs, making it more readable and robust, and fixing
> > two regressions from 2.6.30:
> > - double free_irq causing BUG_ON on device removal
> > - probe failure when vq can't be assigned to msi-x vector
> >   (reported on old host kernels)
> > 
> > An older version of this patch was tested by Amit Shah.
> 
> OK, I've applied both of these; I'd like to see a new test by Amit to
> make sure tho.
> 
> I really like this cleanup!  I looked harder at this code, and my best
> attempts to untangle it further came to very little.  This is what I
> ended up with, but it's all cosmetic and can wait until next merge window.
> See what you think.
> 
> Thanks!
> Rusty.
> 
> virtio_pci: minor MSI-X cleanups
> 
> 1) Rename vp_request_vectors to vp_request_msix_vectors, and take
>    non-MSI-X case out to caller.

I'm not sure this change was for the best: we still have a separate code
path under if !use_msix, only in another place now.  See below.
And this seems to break the symmetry between request_ and free_vectors.

> 2) Comment weird pci_enable_msix API
> 3) Rename vp_find_vq to setup_vq.
> 4) Fix spaces to tabs
> 5) Make nvectors calc internal to vp_try_to_find_vqs()

The other changes look good to me.

> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/virtio/virtio_pci.c |   84 +++++++++++++++++++++++---------------------
>  1 file changed, 45 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -280,25 +280,14 @@ static void vp_free_vectors(struct virti
>  	vp_dev->msix_entries = NULL;
>  }
>  
> -static int vp_request_vectors(struct virtio_device *vdev, int nvectors,
> -			      bool per_vq_vectors)
> +static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
> +				   bool per_vq_vectors)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	const char *name = dev_name(&vp_dev->vdev.dev);
>  	unsigned i, v;
>  	int err = -ENOMEM;
>  
> -	if (!nvectors) {
> -		/* Can't allocate MSI-X vectors, use regular interrupt */
> -		vp_dev->msix_vectors = 0;
> -		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
> -				  IRQF_SHARED, name, vp_dev);
> -		if (err)
> -			return err;
> -		vp_dev->intx_enabled = 1;
> -		return 0;
> -	}
> -
>  	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
>  				       GFP_KERNEL);
>  	if (!vp_dev->msix_entries)
> @@ -311,6 +300,7 @@ static int vp_request_vectors(struct vir
>  	for (i = 0; i < nvectors; ++i)
>  		vp_dev->msix_entries[i].entry = i;
>  
> +	/* pci_enable_msix returns positive if we can't get this many. */
>  	err = pci_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries, nvectors);
>  	if (err > 0)
>  		err = -ENOSPC;
> @@ -356,10 +346,10 @@ error:
>  	return err;
>  }
>  
> -static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
> -				    void (*callback)(struct virtqueue *vq),
> -				    const char *name,
> -				    u16 vector)
> +static struct virtqueue *setup_vq(struct virtio_device *vdev, unsigned index,
> +				  void (*callback)(struct virtqueue *vq),
> +				  const char *name,
> +				  u16 vector)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct virtio_pci_vq_info *info;
> @@ -408,7 +398,7 @@ static struct virtqueue *vp_find_vq(stru
>  	vq->priv = info;
>  	info->vq = vq;
>  
> -	 if (vector != VIRTIO_MSI_NO_VECTOR) {
> +	if (vector != VIRTIO_MSI_NO_VECTOR) {
>  		iowrite16(vector, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
>  		vector = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
>  		if (vector == VIRTIO_MSI_NO_VECTOR) {
> @@ -484,14 +474,36 @@ static int vp_try_to_find_vqs(struct vir
>  			      struct virtqueue *vqs[],
>  			      vq_callback_t *callbacks[],
>  			      const char *names[],
> -			      int nvectors,
> +			      bool use_msix,
>  			      bool per_vq_vectors)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	u16 vector;
> -	int i, err, allocated_vectors;
> +	int i, err, nvectors, allocated_vectors;
>  
> -	err = vp_request_vectors(vdev, nvectors, per_vq_vectors);
> +	if (!use_msix) {
> +		/* Old style: one normal interrupt for change and all vqs. */
> +		vp_dev->msix_vectors = 0;
> +		vp_dev->per_vq_vectors = false;
> +		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
> +				  IRQF_SHARED, dev_name(&vdev->dev), vp_dev);
> +		if (!err)
> +			vp_dev->intx_enabled = 1;

shorter as vp_dev->intx_enabled = !err

> +		return err;

Is that all? Don't we need to create the vqs?

> +	}
> +
> +	if (per_vq_vectors) {
> +		/* Best option: one for change interrupt, one per vq. */
> +		nvectors = 1;
> +		for (i = 0; i < nvqs; ++i)
> +			if (callbacks[i])
> +				++nvectors;
> +	} else {
> +		/* Second best: one for change, shared one for all vqs. */
> +		nvectors = 2;
> +	}
> +
> +	err = vp_request_msix_vectors(vdev, nvectors, per_vq_vectors);
>  	if (err)
>  		goto error_request;
>  
> @@ -504,15 +516,17 @@ static int vp_try_to_find_vqs(struct vir
>  			vector = allocated_vectors++;
>  		else
>  			vector = VP_MSIX_VQ_VECTOR;
> -		vqs[i] = vp_find_vq(vdev, i, callbacks[i], names[i], vector);
> +		vqs[i] = setup_vq(vdev, i, callbacks[i], names[i], vector);
>  		if (IS_ERR(vqs[i])) {
>  			err = PTR_ERR(vqs[i]);
>  			goto error_find;
>  		}
>  		/* allocate per-vq irq if available and necessary */
>  		if (vp_dev->per_vq_vectors && vector != VIRTIO_MSI_NO_VECTOR) {
> -			snprintf(vp_dev->msix_names[vector], sizeof *vp_dev->msix_names,
> -				 "%s-%s", dev_name(&vp_dev->vdev.dev), names[i]);
> +			snprintf(vp_dev->msix_names[vector],
> +				 sizeof *vp_dev->msix_names,
> +				 "%s-%s",
> +				 dev_name(&vp_dev->vdev.dev), names[i]);
>  			err = request_irq(vp_dev->msix_entries[vector].vector,
>  					  vring_interrupt, 0,
>  					  vp_dev->msix_names[vector], vqs[i]);
> @@ -537,28 +551,20 @@ static int vp_find_vqs(struct virtio_dev
>  		       vq_callback_t *callbacks[],
>  		       const char *names[])
>  {
> -	int vectors = 0;
> -	int i, uninitialized_var(err);
> +	int err;
>  
> -	/* How many vectors would we like? */
> -	for (i = 0; i < nvqs; ++i)
> -		if (callbacks[i])
> -			++vectors;
> -
> -	/* We want at most one vector per queue and one for config changes. */
> -	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
> -				 vectors + 1, true);
> +	/* Try MSI-X with one vector per queue. */
> +	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names, true, true);
>  	if (!err)
>  		return 0;
> -	/* Fallback to separate vectors for config and a shared for queues. */
> +	/* Fallback: MSI-X with one vector for config, one shared for queues. */
>  	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
> -				 2, false);
> +				 true, false);
>  	if (!err)
>  		return 0;
>  	/* Finally fall back to regular interrupts. */
> -	err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
> -				 0, false);
> -	return err;
> +	return vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
> +				  false, false);
>  }
>  
>  static struct virtio_config_ops virtio_pci_config_ops = {
