From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio-mmio: Update the device to OASIS spec version
Date: Tue, 20 Jan 2015 20:33:52 +0200
Message-ID: <20150120183352.GA3413@redhat.com>
References: <1421777531-15180-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421777531-15180-1-git-send-email-pawel.moll@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 20, 2015 at 06:12:11PM +0000, Pawel Moll wrote:
> This patch add a support for second version of the virtio-mmio device,
> which follows OASIS "Virtual I/O Device (VIRTIO) Version 1.0"
> specification.
> 
> Main changes:
> 
> 1. The control register symbolic names use the new device/driver
>    nomenclature rather than the old guest/host one.
> 
> 2. The driver detect the device version (version 1 is the pre-OASIS
>    spec, version 2 is compatible with fist revision of the OASIS spec)
>    and drives the device accordingly.
> 
> 3. New version uses direct addressing (64 bit address split into two
>    low/high register) instead of the guest page size based one,
>    and addresses each part of the queue (descriptors, available, used)
>    separately.
> 
> 4. The device activity is now explicitly triggered by writing to the
>    "queue ready" register.
> 
> 5. Whole 64 bit features are properly handled now (both ways).
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/virtio/virtio_mmio.c | 131 ++++++++++++++++++++++++++-----------------
>  include/linux/virtio_mmio.h  |  44 ++++++++++++---
>  2 files changed, 118 insertions(+), 57 deletions(-)
> 
> Tested with our custom models (*not* qemu).
> 
> Changes from v1:
> 
> * added legacy/modern checks in probe and finalize_features.
> 
> Changes from RFC:
> 
> * removed the "version" sysfs attribute at its usablity  was questioned
> * added #ifndefs allowing to disable legacy register names in the header
> * started using handy virtqueue_get_used/avail() functions instead of
>   doing all the calculations manually
> * ID 0 special handled by returning -ENODEV instead of 0 - still prints
>   no error (unless you've got DEBUG for drivers/base), but doesn't
>   actually bind the device
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 00d115b..cad5698 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -1,7 +1,7 @@
>  /*
>   * Virtio memory mapped device driver
>   *
> - * Copyright 2011, ARM Ltd.
> + * Copyright 2011-2014, ARM Ltd.
>   *
>   * This module allows virtio devices to be used over a virtual, memory mapped
>   * platform device.
> @@ -50,36 +50,6 @@
>   *
>   *
>   *
> - * Registers layout (all 32-bit wide):
> - *
> - * offset d. name             description
> - * ------ -- ---------------- -----------------
> - *
> - * 0x000  R  MagicValue       Magic value "virt"
> - * 0x004  R  Version          Device version (current max. 1)
> - * 0x008  R  DeviceID         Virtio device ID
> - * 0x00c  R  VendorID         Virtio vendor ID
> - *
> - * 0x010  R  HostFeatures     Features supported by the host
> - * 0x014  W  HostFeaturesSel  Set of host features to access via HostFeatures
> - *
> - * 0x020  W  GuestFeatures    Features activated by the guest
> - * 0x024  W  GuestFeaturesSel Set of activated features to set via GuestFeatures
> - * 0x028  W  GuestPageSize    Size of guest's memory page in bytes
> - *
> - * 0x030  W  QueueSel         Queue selector
> - * 0x034  R  QueueNumMax      Maximum size of the currently selected queue
> - * 0x038  W  QueueNum         Queue size for the currently selected queue
> - * 0x03c  W  QueueAlign       Used Ring alignment for the current queue
> - * 0x040  RW QueuePFN         PFN for the currently selected queue
> - *
> - * 0x050  W  QueueNotify      Queue notifier
> - * 0x060  R  InterruptStatus  Interrupt status register
> - * 0x064  W  InterruptACK     Interrupt acknowledge register
> - * 0x070  RW Status           Device status register
> - *
> - * 0x100+ RW                  Device-specific configuration space
> - *
>   * Based on Virtio PCI driver by Anthony Liguori, copyright IBM Corp. 2007
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
> @@ -145,11 +115,16 @@ struct virtio_mmio_vq_info {
>  static u64 vm_get_features(struct virtio_device *vdev)
>  {
>  	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> +	u64 features;
> +
> +	writel(1, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
> +	features = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
> +	features <<= 32;
>  
> -	/* TODO: Features > 32 bits */
> -	writel(0, vm_dev->base + VIRTIO_MMIO_HOST_FEATURES_SEL);
> +	writel(0, vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
> +	features |= readl(vm_dev->base + VIRTIO_MMIO_DEVICE_FEATURES);
>  
> -	return readl(vm_dev->base + VIRTIO_MMIO_HOST_FEATURES);
> +	return features;
>  }
>  
>  static int vm_finalize_features(struct virtio_device *vdev)
> @@ -159,11 +134,20 @@ static int vm_finalize_features(struct virtio_device *vdev)
>  	/* Give virtio_ring a chance to accept features. */
>  	vring_transport_features(vdev);
>  
> -	/* Make sure we don't have any features > 32 bits! */
> -	BUG_ON((u32)vdev->features != vdev->features);
> +	/* Make sure there is are no mixed devices */
> +	if (vm_dev->version == 2 &&
> +			!__virtio_test_bit(vdev, VIRTIO_F_VERSION_1)) {
> +		dev_err(&vdev->dev, "New virtio-mmio devices (version 2) must provide VIRTIO_F_VERSION_1 feature!\n");
> +		return -EINVAL;
> +	}
> +
> +	writel(1, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
> +	writel((u32)(vdev->features >> 32),
> +			vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES);
>  
> -	writel(0, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES_SEL);
> -	writel(vdev->features, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);
> +	writel(0, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
> +	writel((u32)vdev->features,
> +			vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES);
>  
>  	return 0;
>  }
> @@ -275,7 +259,12 @@ static void vm_del_vq(struct virtqueue *vq)
>  
>  	/* Select and deactivate the queue */
>  	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
> -	writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> +	if (vm_dev->version == 1) {
> +		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> +	} else {
> +		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
> +		WARN_ON(readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
> +	}
>  
>  	size = PAGE_ALIGN(vring_size(info->num, VIRTIO_MMIO_VRING_ALIGN));
>  	free_pages_exact(info->queue, size);
> @@ -312,7 +301,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
>  
>  	/* Queue shouldn't already be set up. */
> -	if (readl(vm_dev->base + VIRTIO_MMIO_QUEUE_PFN)) {
> +	if (readl(vm_dev->base + (vm_dev->version == 1 ?
> +			VIRTIO_MMIO_QUEUE_PFN : VIRTIO_MMIO_QUEUE_READY))) {
>  		err = -ENOENT;
>  		goto error_available;
>  	}
> @@ -356,13 +346,6 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  		info->num /= 2;
>  	}
>  
> -	/* Activate the queue */
> -	writel(info->num, vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
> -	writel(VIRTIO_MMIO_VRING_ALIGN,
> -			vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
> -	writel(virt_to_phys(info->queue) >> PAGE_SHIFT,
> -			vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> -
>  	/* Create the vring */
>  	vq = vring_new_virtqueue(index, info->num, VIRTIO_MMIO_VRING_ALIGN, vdev,
>  				 true, info->queue, vm_notify, callback, name);
> @@ -371,6 +354,33 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  		goto error_new_virtqueue;
>  	}
>  
> +	/* Activate the queue */
> +	writel(info->num, vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
> +	if (vm_dev->version == 1) {
> +		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
> +		writel(virt_to_phys(info->queue) >> PAGE_SHIFT,
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> +	} else {
> +		u64 addr;
> +
> +		addr = virt_to_phys(info->queue);
> +		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
> +		writel((u32)(addr >> 32),
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
> +
> +		addr = virt_to_phys(virtqueue_get_avail(vq));
> +		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
> +		writel((u32)(addr >> 32),
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);
> +
> +		addr = virt_to_phys(virtqueue_get_used(vq));
> +		writel((u32)addr, vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
> +		writel((u32)(addr >> 32),
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
> +
> +		writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
> +	}
> +
>  	vq->priv = info;
>  	info->vq = vq;
>  
> @@ -381,7 +391,12 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  	return vq;
>  
>  error_new_virtqueue:
> -	writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> +	if (vm_dev->version == 1) {
> +		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> +	} else {
> +		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
> +		WARN_ON(readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
> +	}
>  	free_pages_exact(info->queue, size);
>  error_alloc_pages:
>  	kfree(info);
> @@ -476,16 +491,32 @@ static int virtio_mmio_probe(struct platform_device *pdev)
>  
>  	/* Check device version */
>  	vm_dev->version = readl(vm_dev->base + VIRTIO_MMIO_VERSION);
> -	if (vm_dev->version != 1) {
> +	if (vm_dev->version < 1 || vm_dev->version > 2) {
>  		dev_err(&pdev->dev, "Version %ld not supported!\n",
>  				vm_dev->version);
>  		return -ENXIO;
>  	}
>  
>  	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
> +	if (vm_dev->vdev.id.device == 0) {
> +		/*
> +		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
> +		 * with no function. End probing now with no error reported.
> +		 */
> +		return -ENODEV;
> +	}
>  	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
>  
> -	writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
> +	/* Reject legacy-only IDs for version 2 devices */
> +	if (vm_dev->version == 2 &&
> +			virtio_device_is_legacy_only(vm_dev->vdev.id)) {
> +		dev_err(&pdev->dev, "Version 2 not supported for devices %u!\n",
> +				vm_dev->vdev.id.device);
> +		return -ENODEV;
> +	}
> +
> +	if (vm_dev->version == 1)
> +		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
>  
>  	platform_set_drvdata(pdev, vm_dev);
>  
> diff --git a/include/linux/virtio_mmio.h b/include/linux/virtio_mmio.h
> index 5c7b6f0..c4b0968 100644
> --- a/include/linux/virtio_mmio.h
> +++ b/include/linux/virtio_mmio.h
> @@ -51,23 +51,29 @@
>  /* Virtio vendor ID - Read Only */
>  #define VIRTIO_MMIO_VENDOR_ID		0x00c
>  
> -/* Bitmask of the features supported by the host
> +/* Bitmask of the features supported by the device (host)
>   * (32 bits per set) - Read Only */
> -#define VIRTIO_MMIO_HOST_FEATURES	0x010
> +#define VIRTIO_MMIO_DEVICE_FEATURES	0x010
>  
> -/* Host features set selector - Write Only */
> -#define VIRTIO_MMIO_HOST_FEATURES_SEL	0x014
> +/* Device (host) features set selector - Write Only */
> +#define VIRTIO_MMIO_DEVICE_FEATURES_SEL	0x014
>  
> -/* Bitmask of features activated by the guest
> +/* Bitmask of features activated by the driver (guest)
>   * (32 bits per set) - Write Only */
> -#define VIRTIO_MMIO_GUEST_FEATURES	0x020
> +#define VIRTIO_MMIO_DRIVER_FEATURES	0x020
>  
>  /* Activated features set selector - Write Only */
> -#define VIRTIO_MMIO_GUEST_FEATURES_SEL	0x024
> +#define VIRTIO_MMIO_DRIVER_FEATURES_SEL	0x024
> +
> +
> +#ifndef VIRTIO_MMIO_NO_LEGACY /* LEGACY DEVICES ONLY! */
>  
>  /* Guest's memory page size in bytes - Write Only */
>  #define VIRTIO_MMIO_GUEST_PAGE_SIZE	0x028
>  
> +#endif
> +
> +
>  /* Queue selector - Write Only */
>  #define VIRTIO_MMIO_QUEUE_SEL		0x030
>  
> @@ -77,12 +83,21 @@
>  /* Queue size for the currently selected queue - Write Only */
>  #define VIRTIO_MMIO_QUEUE_NUM		0x038
>  
> +
> +#ifndef VIRTIO_MMIO_NO_LEGACY /* LEGACY DEVICES ONLY! */
> +
>  /* Used Ring alignment for the currently selected queue - Write Only */
>  #define VIRTIO_MMIO_QUEUE_ALIGN		0x03c
>  
>  /* Guest's PFN for the currently selected queue - Read Write */
>  #define VIRTIO_MMIO_QUEUE_PFN		0x040
>  
> +#endif
> +
> +
> +/* Ready bit for the currently selected queue - Read Write */
> +#define VIRTIO_MMIO_QUEUE_READY		0x044
> +
>  /* Queue notifier - Write Only */
>  #define VIRTIO_MMIO_QUEUE_NOTIFY	0x050
>  
> @@ -95,6 +110,21 @@
>  /* Device status register - Read Write */
>  #define VIRTIO_MMIO_STATUS		0x070
>  
> +/* Selected queue's Descriptor Table address, 64 bits in two halves */
> +#define VIRTIO_MMIO_QUEUE_DESC_LOW	0x080
> +#define VIRTIO_MMIO_QUEUE_DESC_HIGH	0x084
> +
> +/* Selected queue's Available Ring address, 64 bits in two halves */
> +#define VIRTIO_MMIO_QUEUE_AVAIL_LOW	0x090
> +#define VIRTIO_MMIO_QUEUE_AVAIL_HIGH	0x094
> +
> +/* Selected queue's Used Ring address, 64 bits in two halves */
> +#define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
> +#define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
> +
> +/* Configuration atomicity value */
> +#define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
> +
>  /* The config space is defined by each driver as
>   * the per-driver configuration space - Read Write */
>  #define VIRTIO_MMIO_CONFIG		0x100
> -- 
> 2.1.0
