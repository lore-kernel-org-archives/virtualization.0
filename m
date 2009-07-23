From: Amit Shah <amit.shah@redhat.com>
Subject: Re: qemu-kvm missing some msix capability check
Date: Thu, 23 Jul 2009 19:55:50 +0530
Message-ID: <20090723142550.GA4470__12478.3805608333$1248359331$gmane$org@amit-x200.redhat.com>
References: <20090717130439.GA10081@amit-x200.redhat.com>
	<20090721165400.GB4826@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090721165400.GB4826@redhat.com>
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
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Jul 21 2009 [19:54:00], Michael S. Tsirkin wrote:
> On Fri, Jul 17, 2009 at 06:34:40PM +0530, Amit Shah wrote:
> > Hello,
> > 
> > Using recent qemu-kvm userspace with a slightly older kernel module I
> > get this when using the virtio-net device:

I was getting this with a very recent kernel in the guest with an older
host kernel.

2.6.31-rc3 in the guest and 2.6.29 (F11) kernel in the host.

> > kvm_msix_add: kvm_get_irq_route_gsi failed: No space left on device
> > 
> > ... and the guest doesn't use the net device.
> > 
> > This goes away when using a newer kvm module.
> > 
> > 		Amit
> 
> Could you verify if the following helps please?

This worked for me with your other patches:

guest kernel (on top of Avi's kvm/master):
1. [PATCH 1/2] virtio: Fix memory leak on device removal
2. [PATCH 2/2] virtio: fix double free_irq]

qemu-kvm (on top of Avi's qemu-kvm/master):
1. [PATCHv2] qemu-kvm: routing table update thinko fix
2. [PATCH 2/2] qemu-kvm: broken MSI routing work-around
3. [PATCH] qemu-kvm: fix error handling in msix vector add

Tested-by: Amit Shah <amit.shah@redhat.com>

> ---
> 
> virtio: retry on vector assignment failure
> 
> virtio currently fails to find any vqs if the device supports msi-x but
> fails to assign it to a queue.  Turns out, this actually happens for old
> host kernels which can't allocate a gsi for the vector. As a result
> guest does not use virtio net.  Fix this by disabling msi on
> such failures and falling back on regular interrupts.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
> index 9dcc368..567c972 100644
> --- a/drivers/virtio/virtio_pci.c
> +++ b/drivers/virtio/virtio_pci.c
> @@ -273,26 +273,35 @@ static void vp_free_vectors(struct virtio_device *vdev)
>  }
>  
>  static int vp_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
> -			  int *options, int noptions)
> +			  int nvectors)
>  {
> -	int i;
> -	for (i = 0; i < noptions; ++i)
> -		if (!pci_enable_msix(dev, entries, options[i]))
> -			return options[i];
> -	return -EBUSY;
> +	int err = pci_enable_msix(dev, entries, nvectors);
> +	if (err > 0)
> +		err = -ENOSPC;
> +	return err;
>  }
>  
> -static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
> +static int vp_request_irq(struct virtio_device *vdev)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	int err;
> +	/* Can't allocate enough MSI-X vectors, use regular interrupt */
> +	vp_dev->msix_vectors = 0;
> +	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
> +			  IRQF_SHARED, dev_name(&vp_dev->vdev.dev), vp_dev);
> +	if (err)
> +		return err;
> +	vp_dev->intx_enabled = 1;
> +	return 0;
> +}
> +
> +static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs,
> +			      int nvectors)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	const char *name = dev_name(&vp_dev->vdev.dev);
>  	unsigned i, v;
>  	int err = -ENOMEM;
> -	/* We want at most one vector per queue and one for config changes.
> -	 * Fallback to separate vectors for config and a shared for queues.
> -	 * Finally fall back to regular interrupts. */
> -	int options[] = { max_vqs + 1, 2 };
> -	int nvectors = max(options[0], options[1]);
>  
>  	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
>  				       GFP_KERNEL);
> @@ -307,37 +316,29 @@ static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
>  		vp_dev->msix_entries[i].entry = i;
>  
>  	err = vp_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries,
> -			     options, ARRAY_SIZE(options));
> -	if (err < 0) {
> -		/* Can't allocate enough MSI-X vectors, use regular interrupt */
> -		vp_dev->msix_vectors = 0;
> -		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
> -				  IRQF_SHARED, name, vp_dev);
> -		if (err)
> -			goto error_irq;
> -		vp_dev->intx_enabled = 1;
> -	} else {
> -		vp_dev->msix_vectors = err;
> -		vp_dev->msix_enabled = 1;
> -
> -		/* Set the vector used for configuration */
> -		v = vp_dev->msix_used_vectors;
> -		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> -			 "%s-config", name);
> -		err = request_irq(vp_dev->msix_entries[v].vector,
> -				  vp_config_changed, 0, vp_dev->msix_names[v],
> -				  vp_dev);
> -		if (err)
> -			goto error_irq;
> -		++vp_dev->msix_used_vectors;
> -
> -		iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> -		/* Verify we had enough resources to assign the vector */
> -		v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> -		if (v == VIRTIO_MSI_NO_VECTOR) {
> -			err = -EBUSY;
> -			goto error_irq;
> -		}
> +			     nvectors);
> +	if (err)
> +		goto error_enable;
> +	vp_dev->msix_vectors = nvectors;
> +	vp_dev->msix_enabled = 1;
> +
> +	/* Set the vector used for configuration */
> +	v = vp_dev->msix_used_vectors;
> +	snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> +		 "%s-config", name);
> +	err = request_irq(vp_dev->msix_entries[v].vector,
> +			  vp_config_changed, 0, vp_dev->msix_names[v],
> +			  vp_dev);
> +	if (err)
> +		goto error_irq;
> +	++vp_dev->msix_used_vectors;
> +
> +	iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> +	/* Verify we had enough resources to assign the vector */
> +	v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> +	if (v == VIRTIO_MSI_NO_VECTOR) {
> +		err = -EBUSY;
> +		goto error_irq;
>  	}
>  
>  	if (vp_dev->msix_vectors && vp_dev->msix_vectors != max_vqs + 1) {
> @@ -355,9 +356,12 @@ static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
>  	return 0;
>  error_irq:
>  	vp_free_vectors(vdev);
> +error_enable:
>  	kfree(vp_dev->msix_names);
> +	vp_dev->msix_names = NULL;
>  error_names:
>  	kfree(vp_dev->msix_entries);
> +	vp_dev->msix_entries = NULL;
>  error_entries:
>  	return err;
>  }
> @@ -499,24 +503,24 @@ static void vp_del_vqs(struct virtio_device *vdev)
>  
>  	vp_free_vectors(vdev);
>  	kfree(vp_dev->msix_names);
> +	vp_dev->msix_names = NULL;
>  	kfree(vp_dev->msix_entries);
> +	vp_dev->msix_entries = NULL;
>  }
>  
> -/* the config->find_vqs() implementation */
> -static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> -		       struct virtqueue *vqs[],
> -		       vq_callback_t *callbacks[],
> -		       const char *names[])
> +static int vp_try_to_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> +			      struct virtqueue *vqs[],
> +			      vq_callback_t *callbacks[],
> +			      const char *names[],
> +			      int max_vectors,
> +			      int nvectors)
>  {
> -	int vectors = 0;
>  	int i, err;
>  
> -	/* How many vectors would we like? */
> -	for (i = 0; i < nvqs; ++i)
> -		if (callbacks[i])
> -			++vectors;
> -
> -	err = vp_request_vectors(vdev, vectors);
> +	if (nvectors)
> +		err = vp_request_vectors(vdev, max_vectors, nvectors);
> +	else
> +		err = vp_request_irq(vdev);
>  	if (err)
>  		goto error_request;
>  
> @@ -534,6 +538,34 @@ error_request:
>  	return PTR_ERR(vqs[i]);
>  }
>  
> +/* the config->find_vqs() implementation */
> +static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> +		       struct virtqueue *vqs[],
> +		       vq_callback_t *callbacks[],
> +		       const char *names[])
> +{
> +	/* We want at most one vector per queue and one for config changes.
> +	 * Fallback to separate vectors for config and a shared for queues.
> +	 * Finally fall back to regular interrupts. */
> +	int options[] = { 1, 2, 0 };
> +	int vectors = 0;
> +	int i, uninitialized_var(err);
> +
> +	/* How many vectors would we like? */
> +	for (i = 0; i < nvqs; ++i)
> +		if (callbacks[i])
> +			++vectors;
> +	options[0] = vectors + 1;
> +
> +	for (i = 0; i < ARRAY_SIZE(options); ++i) {
> +		err = vp_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
> +					 vectors, options[i]);
> +		if (!err)
> +			break;
> +	}
> +	return err;
> +}
> +
>  static struct virtio_config_ops virtio_pci_config_ops = {
>  	.get		= vp_get,
>  	.set		= vp_set,

		Amit
