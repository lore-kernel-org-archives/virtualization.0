From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC] virtio-mmio: Update the device to OASIS spec version
Date: Thu, 15 Jan 2015 18:51:01 +0200
Message-ID: <20150115165101.GA29808@redhat.com>
References: <1419014284-18500-1-git-send-email-pawel.moll@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1419014284-18500-1-git-send-email-pawel.moll@arm.com>
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

On Fri, Dec 19, 2014 at 06:38:04PM +0000, Pawel Moll wrote:
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
> 5. The platform device got a sysfs attribute with the version number.
> 
> 6. Whole 64 bit features are properly handled now (both ways).
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> I had the code typed for months now, but finally (just before
> disappearing for the end-of-year break) got time to test it (and
> fix the bugs), so I though I'd share it at least as RFC.
> 
> It's based on Linus tree still in merge window, but as far as I can
> see all virtio changes have been already pulled, so I don't expect
> any changes in rc1.
> 
> Tested with our custom models (*not* qemu).
> 
> Regards and till next year!
> 
> Pawel
> 
>  drivers/virtio/virtio_mmio.c | 132 +++++++++++++++++++++++++++----------------
>  include/linux/virtio_mmio.h  |  46 +++++++++++----
>  2 files changed, 120 insertions(+), 58 deletions(-)

Thanks!  Looks good overall. Some comments below.


> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 00d115b..d60675a 100644
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
> @@ -159,11 +134,13 @@ static int vm_finalize_features(struct virtio_device *vdev)
>  	/* Give virtio_ring a chance to accept features. */
>  	vring_transport_features(vdev);
>  
> -	/* Make sure we don't have any features > 32 bits! */
> -	BUG_ON((u32)vdev->features != vdev->features);
> +	writel(1, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
> +	writel((vdev->features >> 32) & 0xffffffff,
> +			vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES);
>  
> -	writel(0, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES_SEL);
> -	writel(vdev->features, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);
> +	writel(0, vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
> +	writel(vdev->features & 0xffffffff,
> +			vm_dev->base + VIRTIO_MMIO_DRIVER_FEATURES);
>  
>  	return 0;
>  }
> @@ -275,7 +252,12 @@ static void vm_del_vq(struct virtqueue *vq)
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
> @@ -312,7 +294,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
>  
>  	/* Queue shouldn't already be set up. */
> -	if (readl(vm_dev->base + VIRTIO_MMIO_QUEUE_PFN)) {
> +	if (readl(vm_dev->base + (vm_dev->version == 1 ?
> +			VIRTIO_MMIO_QUEUE_PFN : VIRTIO_MMIO_QUEUE_READY))) {
>  		err = -ENOENT;
>  		goto error_available;
>  	}
> @@ -358,10 +341,35 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
>  
>  	/* Activate the queue */
>  	writel(info->num, vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
> -	writel(VIRTIO_MMIO_VRING_ALIGN,
> -			vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
> -	writel(virt_to_phys(info->queue) >> PAGE_SHIFT,
> -			vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> +	if (vm_dev->version == 1) {
> +		writel(VIRTIO_MMIO_VRING_ALIGN,
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_ALIGN);
> +		writel(virt_to_phys(info->queue) >> PAGE_SHIFT,
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_PFN);
> +	} else {
> +		uint64_t addr = virt_to_phys(info->queue);

Kernel normally uses u64 for this type.

> +
> +		writel(addr & 0xffffffff,
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
> +		writel((addr >> 32) & 0xffffffff,
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
> +
> +		addr += info->num * sizeof(struct vring_desc);
> +		writel(addr & 0xffffffff,
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
> +		writel((addr >> 32) & 0xffffffff,
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);

0xffffffff isn't really needed, is it?

> +
> +		addr += sizeof(struct vring_avail) + info->num * sizeof(__u16);
> +		addr += VIRTIO_MMIO_VRING_ALIGN - 1;
> +		addr &= ~(VIRTIO_MMIO_VRING_ALIGN - 1);


Host no longer knows the alignment, so why is it needed?
In fact, I notice that 4.3.2.3 Virtqueue Layout seems completely wrong:
it corresponds to legacy devices, and it does not
say what "align" is.

I think you shouldn't use VIRTIO_MMIO_VRING_ALIGN in non-legacy code:
it's a legacy thing.




> +		writel(addr & 0xffffffff,
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_USED_LOW);
> +		writel((addr >> 32) & 0xffffffff,
> +				vm_dev->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
> +
> +		writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
> +	}
>  
>  	/* Create the vring */
>  	vq = vring_new_virtqueue(index, info->num, VIRTIO_MMIO_VRING_ALIGN, vdev,
> @@ -381,7 +389,12 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
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
> @@ -439,6 +452,18 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
>  
>  /* Platform device */
>  
> +static ssize_t vm_dev_attr_version_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
> +
> +	return snprintf(buf, PAGE_SIZE, "%lu", vm_dev->version);
> +}
> +
> +static struct device_attribute vm_dev_attr_version =
> +		__ATTR(version, S_IRUGO, vm_dev_attr_version_show, NULL);
> +
>  static int virtio_mmio_probe(struct platform_device *pdev)
>  {
>  	struct virtio_mmio_device *vm_dev;

We already expose feature bits - this one really necessary?

> @@ -476,16 +501,26 @@ static int virtio_mmio_probe(struct platform_device *pdev)
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
> +		 * ID 0 means a dummy (placeholder) device, skip quietly
> +		 * (as in: no error) with no further actions
> +		 */
> +		return 0;

Necessary?
We don't have drivers for this id anyway.

> +	}

Need to also
	1. validate that feature bit VIRTIO_1 is set
	2. validate that ID is not for a legacy device

otherwise device specific drivers might get invoked
on future devices (e.g. when we update balloon for 1.0)
and they not do the right thing.


>  	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
>  
> -	writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
> +	if (vm_dev->version == 1)
> +		writel(PAGE_SIZE, vm_dev->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
> +
> +	device_create_file(&pdev->dev, &vm_dev_attr_version);
>  
>  	platform_set_drvdata(pdev, vm_dev);
>  
> @@ -496,7 +531,8 @@ static int virtio_mmio_remove(struct platform_device *pdev)
>  {
>  	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
>  
> -	unregister_virtio_device(&vm_dev->vdev);
> +	if (vm_dev)
> +		unregister_virtio_device(&vm_dev->vdev);
>  

Will remove ever be called if probe fails?

>  	return 0;
>  }
> diff --git a/include/linux/virtio_mmio.h b/include/linux/virtio_mmio.h
> index 5c7b6f0..d5f3634 100644
> --- a/include/linux/virtio_mmio.h
> +++ b/include/linux/virtio_mmio.h
> @@ -51,21 +51,22 @@
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
>  
> -/* Guest's memory page size in bytes - Write Only */
> +/* Guest's memory page size in bytes - Write Only
> + * LEGACY DEVICES ONLY! */

This is not the preferred style for multi-line comments :)
Also - maybe add a flag to selectively disable legacy
or modern macros?
Might be clearer than comments that, after all, never compile.

>  #define VIRTIO_MMIO_GUEST_PAGE_SIZE	0x028
>  
>  /* Queue selector - Write Only */
> @@ -77,12 +78,18 @@
>  /* Queue size for the currently selected queue - Write Only */
>  #define VIRTIO_MMIO_QUEUE_NUM		0x038
>  
> -/* Used Ring alignment for the currently selected queue - Write Only */
> +/* Used Ring alignment for the currently selected queue - Write Only
> + * LEGACY DEVICES ONLY! */
>  #define VIRTIO_MMIO_QUEUE_ALIGN		0x03c
>  
> -/* Guest's PFN for the currently selected queue - Read Write */
> +/* Guest's PFN for the currently selected queue - Read Write
> + * LEGACY DEVICES ONLY! */
>  #define VIRTIO_MMIO_QUEUE_PFN		0x040
>  
> +/* Ready bit for the currently selected queue - Read Write
> + * NOT FOR LEGACY DEVICES! */
> +#define VIRTIO_MMIO_QUEUE_READY		0x044
> +
>  /* Queue notifier - Write Only */
>  #define VIRTIO_MMIO_QUEUE_NOTIFY	0x050
>  
> @@ -95,6 +102,25 @@
>  /* Device status register - Read Write */
>  #define VIRTIO_MMIO_STATUS		0x070
>  
> +/* Selected queue's Descriptor Table address, 64 bits in two halves
> + * NOT FOR LEGACY DEVICES! */
> +#define VIRTIO_MMIO_QUEUE_DESC_LOW	0x080
> +#define VIRTIO_MMIO_QUEUE_DESC_HIGH	0x084
> +
> +/* Selected queue's Available Ring address, 64 bits in two halves
> + * NOT FOR LEGACY DEVICES! */
> +#define VIRTIO_MMIO_QUEUE_AVAIL_LOW	0x090
> +#define VIRTIO_MMIO_QUEUE_AVAIL_HIGH	0x094
> +
> +/* Selected queue's Used Ring address, 64 bits in two halves
> + * NOT FOR LEGACY DEVICES! */
> +#define VIRTIO_MMIO_QUEUE_USED_LOW	0x0a0
> +#define VIRTIO_MMIO_QUEUE_USED_HIGH	0x0a4
> +
> +/* Configuration atomicity value
> + * NOT FOR LEGACY DEVICES! */
> +#define VIRTIO_MMIO_CONFIG_GENERATION	0x0fc
> +
>  /* The config space is defined by each driver as
>   * the per-driver configuration space - Read Write */
>  #define VIRTIO_MMIO_CONFIG		0x100
> -- 
> 2.1.0
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
