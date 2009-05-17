From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCHv6 4/4] virtio_pci: optional MSI-X support
Date: Mon, 18 May 2009 00:30:49 +0300
Message-ID: <4A108209.4070805__35625.3453567207$1242595932$gmane$org@redhat.com>
References: <cover.1242297977.git.mst@redhat.com>
	<20090514105541.GE3120@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090514105541.GE3120@redhat.com>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Michael S. Tsirkin wrote:
> This implements optional MSI-X support in virtio_pci.
> MSI-X is used whenever the host supports at least 2 MSI-X
> vectors: 1 for configuration changes and 1 for virtqueues.
> Per-virtqueue vectors are allocated if enough vectors
> available.
>
> +static int vp_request_vectors(struct virtio_device *vdev, unsigned max_vqs)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	const char *name = dev_name(&vp_dev->vdev.dev);
> +	unsigned i, v;
> +	int err = -ENOMEM;
> +	/* We want at most one vector per queue and one for config changes.
> +	 * Fallback to separate vectors for config and a shared for queues.
> +	 * Finally fall back to regular interrupts. */
> +	int options[] = { max_vqs + 1, 2 };
> +	int nvectors = max(options[0], options[1]);
> +
> +	vp_dev->msix_entries = kmalloc(nvectors * sizeof *vp_dev->msix_entries,
> +				       GFP_KERNEL);
> +	if (!vp_dev->msix_entries)
> +		goto error_entries;
> +	vp_dev->msix_names = kmalloc(nvectors * sizeof *vp_dev->msix_names,
> +				     GFP_KERNEL);
> +	if (!vp_dev->msix_names)
> +		goto error_names;
> +
> +	for (i = 0; i < nvectors; ++i)
> +		vp_dev->msix_entries[i].entry = i;
> +
> +	err = vp_enable_msix(vp_dev->pci_dev, vp_dev->msix_entries,
> +			     options, ARRAY_SIZE(options));
> +	if (err < 0) {
> +		/* Can't allocate enough MSI-X vectors, use regular interrupt */
> +		vp_dev->msix_vectors = 0;
> +		err = request_irq(vp_dev->pci_dev->irq, vp_interrupt,
> +				  IRQF_SHARED, name, vp_dev);
> +		if (err)
> +			goto error_irq;
> +		vp_dev->intx_enabled = 1;
> +	} else {
> +		vp_dev->msix_vectors = err;
> +		vp_dev->msix_enabled = 1;
> +
> +		/* Set the vector used for configuration */
> +		v = vp_dev->msix_used_vectors;
> +		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> +			 "%s-config", name);
> +		err = request_irq(vp_dev->msix_entries[v].vector,
> +				  vp_config_changed, 0, vp_dev->msix_names[v],
> +				  vp_dev);
> +		if (err)
> +			goto error_irq;
> +		++vp_dev->msix_used_vectors;
> +
> +		iowrite16(v, vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> +		/* Verify we had enough resources to assign the vector */
> +		v = ioread16(vp_dev->ioaddr + VIRTIO_MSI_CONFIG_VECTOR);
> +		if (v == VIRTIO_MSI_NO_VECTOR) {
> +			err = -EBUSY;
> +			goto error_irq;
> +		}
> +	}
> +
> +	if (vp_dev->msix_vectors && vp_dev->msix_vectors != max_vqs + 1) {
> +		/* Shared vector for all VQs */
> +		v = vp_dev->msix_used_vectors;
> +		snprintf(vp_dev->msix_names[v], sizeof *vp_dev->msix_names,
> +			 "%s-virtqueues", name);
> +		err = request_irq(vp_dev->msix_entries[v].vector,
> +				  vp_vring_interrupt, 0, vp_dev->msix_names[v],
> +				  vp_dev);
> +		if (err)
> +			goto error_irq;
> +		++vp_dev->msix_used_vectors;
> +	}
> +	return 0;
> +error_irq:
> +	vp_free_vectors(vdev);
> +	kfree(vp_dev->msix_names);
> +error_names:
> +	kfree(vp_dev->msix_entries);
> +error_entries:
> +	return err;
> +}
> +
> @@ -272,12 +412,43 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
>  	vq->priv = info;
>  	info->vq = vq;
>  
> +	/* allocate per-vq vector if available and necessary */
> +	if (callback && vp_dev->msix_used_vectors < vp_dev->msix_vectors) {
> +		vector = vp_dev->msix_used_vectors;
> +		snprintf(vp_dev->msix_names[vector], sizeof *vp_dev->msix_names,
> +			 "%s-%s", dev_name(&vp_dev->vdev.dev), name);
> +		err = request_irq(vp_dev->msix_entries[vector].vector,
> +				  vring_interrupt, 0,
> +				  vp_dev->msix_names[vector], vq);
> +		if (err)
> +			goto out_request_irq;
> +		info->vector = vector;
> +		++vp_dev->msix_used_vectors;
> +	} else
> +		vector = VP_MSIX_VQ_VECTOR;
> +
> +	 if (callback && vp_dev->msix_enabled) {
> +		iowrite16(vector, vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> +		vector = ioread16(vp_dev->ioaddr + VIRTIO_MSI_QUEUE_VECTOR);
> +		if (vector == VIRTIO_MSI_NO_VECTOR) {
> +			err = -EBUSY;
> +			goto out_assign;
> +		}
> +	}
> +
>   

I'm not sure I understand how the vq -> msi mapping works.  Do we 
actually support an arbitrary mapping, or just either linear or n:1?

I don't mind the driver being limited, but the device interface should 
be flexible.  We'll want to deal with limited vector availability soon.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
