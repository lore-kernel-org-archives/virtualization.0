From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC 3/3] vfio: add virtio pci quirk
Date: Mon, 18 Apr 2016 14:00:06 -0600
Message-ID: <20160418140006.5f68d516@t450s.home>
References: <1460973374-32719-1-git-send-email-mst@redhat.com>
	<1460973374-32719-4-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1460973374-32719-4-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Liu <wei.liu2@citrix.com>, kvm@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Lutomirski <luto@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Feng Wu <feng.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 18 Apr 2016 12:58:28 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Modern virtio pci devices can set VIRTIO_F_IOMMU_PLATFORM
> to signal they are safe to use with an IOMMU.
> 
> Without this bit, exposing the device to userspace is unsafe, so probe
> and fail VFIO initialization unless noiommu is enabled.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vfio/pci/vfio_pci_private.h |   1 +
>  drivers/vfio/pci/vfio_pci.c         |  11 +++
>  drivers/vfio/pci/vfio_pci_virtio.c  | 135 ++++++++++++++++++++++++++++++++++++
>  drivers/vfio/pci/Makefile           |   1 +
>  4 files changed, 148 insertions(+)
>  create mode 100644 drivers/vfio/pci/vfio_pci_virtio.c
> 
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 8a7d546..604d445 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -130,4 +130,5 @@ static inline int vfio_pci_igd_init(struct vfio_pci_device *vdev)
>  	return -ENODEV;
>  }
>  #endif
> +extern int vfio_pci_virtio_quirk(struct vfio_pci_device *vdev, int noiommu);
>  #endif /* VFIO_PCI_PRIVATE_H */
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index d622a41..2bb8c76 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1125,6 +1125,17 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		return ret;
>  	}
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_REDHAT_QUMRANET &&

Virtio really owns this entire vendor ID block?  Apparently nobody told
ivshmem: http://pci-ids.ucw.cz/read/PC/1af4/1110  Even the comment by
virtio_pci_id_table[] suggests virtio is only a subset even if the code
doesn't appear to honor that comment.  I don't know the history there,
but that seems like really inefficient use of an entire, coveted vendor
block.

> +	    ((ret = vfio_pci_virtio_quirk(vdev, ret)))) {

Please don't set variables like this unless necessary.

if (vendor...) {
   ret = vfio_pci_virtio_quir...
   if (ret) {
       ...

> +		dev_warn(&vdev->pdev->dev,
> +			 "Failed to setup Virtio for VFIO\n");
> +		vfio_del_group_dev(&pdev->dev);
> +		vfio_iommu_group_put(group, &pdev->dev);
> +		kfree(vdev);
> +		return ret;
> +	}
> +
> +
>  	if (vfio_pci_is_vga(pdev)) {
>  		vga_client_register(pdev, vdev, NULL, vfio_pci_set_vga_decode);
>  		vga_set_legacy_decoding(pdev,
> diff --git a/drivers/vfio/pci/vfio_pci_virtio.c b/drivers/vfio/pci/vfio_pci_virtio.c
> new file mode 100644
> index 0000000..1a32064
> --- /dev/null
> +++ b/drivers/vfio/pci/vfio_pci_virtio.c
> @@ -0,0 +1,135 @@
> +/*
> + * VFIO PCI Intel Graphics support
> + *
> + * Copyright (C) 2016 Red Hat, Inc.  All rights reserved.
> + *	Author: Alex Williamson <alex.williamson@redhat.com>
> + *

Update

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Register a device specific region through which to provide read-only
> + * access to the Intel IGD opregion.  The register defining the opregion
> + * address is also virtualized to prevent user modification.

Update

> + */
> +
> +#include <linux/io.h>
> +#include <linux/pci.h>
> +#include <linux/uaccess.h>
> +#include <linux/vfio.h>
> +#include <linux/virtio_pci.h>
> +#include <linux/virtio_config.h>

I don't see where io or uaccess are needed here.

> +
> +#include "vfio_pci_private.h"
> +
> +/**
> + * virtio_pci_find_capability - walk capabilities to find device info.
> + * @dev: the pci device
> + * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
> + *
> + * Returns offset of the capability, or 0.
> + */
> +static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type)

This is called from probe code, why inline?  There's already a function
with this exact same name in virtio code, can we come up with something
unique to avoid confusion?

> +{
> +	int pos;
> +
> +	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> +	     pos > 0;
> +	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> +		u8 type;
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +							 cfg_type),
> +				     &type);
> +
> +		if (type != cfg_type)
> +			continue;
> +
> +		/* Ignore structures with reserved BAR values */
> +		if (type != VIRTIO_PCI_CAP_PCI_CFG) {
> +			u8 bar;
> +
> +			pci_read_config_byte(dev, pos +
> +					     offsetof(struct virtio_pci_cap,
> +						      bar),
> +					     &bar);
> +			if (bar > 0x5)
> +				continue;
> +		}
> +
> +		return pos;
> +	}
> +	return 0;
> +}
> +
> +
> +int vfio_pci_virtio_quirk(struct vfio_pci_device *vdev, int noiommu)
> +{
> +	struct pci_dev *dev = vdev->pdev;
> +	int common, cfg;
> +	u32 features;
> +	u32 offset;
> +	u8 bar;
> +
> +	/* Without an IOMMU, we don't care */
> +	if (noiommu)
> +		return 0;
> +	/* Check whether device enforces the IOMMU correctly */
> +
> +	/*
> +	 * All modern devices must have common and cfg capabilities. We use cfg
> +	 * capability for access so that we don't need to worry about resource
> +	 * availability. Slow but sure.
> +	 * Note that all vendor-specific fields we access are little-endian
> +	 * which matches what pci config accessors expect, so they do byteswap
> +	 * for us if appropriate.
> +	 */
> +	common = virtio_pci_find_capability(dev, VIRTIO_PCI_CAP_COMMON_CFG);
> +	cfg = virtio_pci_find_capability(dev, VIRTIO_PCI_CAP_PCI_CFG);
> +	if (!cfg || !common) {
> +                dev_warn(&dev->dev,
> +                         "Virtio device lacks common or pci cfg.\n");

White space

> +		return -ENODEV;
> +	}
> +
> +	pci_read_config_byte(dev, common + offsetof(struct virtio_pci_cap,
> +						    bar),
> +			     &bar);
> +	pci_read_config_dword(dev, common + offsetof(struct virtio_pci_cap,
> +						    offset),
> +			     &offset);
> +
> +	/* Program cfg capability for dword access into common cfg. */
> +	pci_write_config_byte(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> +						  cap.bar),
> +			      bar);
> +	pci_write_config_dword(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> +						   cap.length),
> +			       0x4);
> +
> +	/* Select features dword that has VIRTIO_F_IOMMU_PLATFORM. */
> +	pci_write_config_dword(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> +						  cap.offset),
> +			       offset + offsetof(struct virtio_pci_common_cfg,
> +						 device_feature_select));
> +	pci_write_config_dword(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> +						  pci_cfg_data),
> +			       VIRTIO_F_IOMMU_PLATFORM / 32);
> +
> +	/* Get the features dword. */
> +	pci_write_config_dword(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> +						  cap.offset),
> +			       offset + offsetof(struct virtio_pci_common_cfg,
> +						 device_feature));
> +	pci_read_config_dword(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> +						  pci_cfg_data),
> +			      &features);
> +
> +	/* Does this device obey the platform's IOMMU? If not it's an error. */
> +	if (!(features & (0x1 << (VIRTIO_F_IOMMU_PLATFORM % 32)))) {
> +                dev_warn(&dev->dev,
> +                         "Virtio device lacks VIRTIO_F_IOMMU_PLATFORM.\n");

White space

> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 76d8ec0..e9b20e7 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -1,5 +1,6 @@
>  
>  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> +vfio-pci-y += vfio_pci_virtio.o
>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
>  
>  obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
