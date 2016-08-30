From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 2/2] vfio: add virtio pci quirk
Date: Tue, 30 Aug 2016 06:46:12 -0600
Message-ID: <20160830064612.5d8598b3__42960.1068761714$1472561190$gmane$org@t450s.home>
References: <1472523968-9540-1-git-send-email-mst@redhat.com>
	<1472523968-9540-3-git-send-email-mst@redhat.com>
	<20160829212325.32467efc@t450s.home>
	<20160829215220.0efb91b7@t450s.home>
	<20160829225304.17238cfd@t450s.home>
	<20160830081834-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20160830081834-mutt-send-email-mst@kernel.org>
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
Cc: Feng Wu <feng.wu@intel.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>, Yongji Xie <xyjxie@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, virtualization@lists.linux-foundation.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 30 Aug 2016 08:20:38 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Aug 29, 2016 at 10:53:04PM -0600, Alex Williamson wrote:
> > On Mon, 29 Aug 2016 21:52:20 -0600
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > On Mon, 29 Aug 2016 21:23:25 -0600
> > > Alex Williamson <alex.williamson@redhat.com> wrote:
> > >   
> > > > On Tue, 30 Aug 2016 05:27:17 +0300
> > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > >     
> > > > > Modern virtio pci devices can set VIRTIO_F_IOMMU_PLATFORM
> > > > > to signal they are safe to use with an IOMMU.
> > > > > 
> > > > > Without this bit, exposing the device to userspace is unsafe, so probe
> > > > > and fail VFIO initialization unless noiommu is enabled.
> > > > > 
> > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > ---
> > > > >  drivers/vfio/pci/vfio_pci_private.h |   1 +
> > > > >  drivers/vfio/pci/vfio_pci.c         |  14 ++++
> > > > >  drivers/vfio/pci/vfio_pci_virtio.c  | 140 ++++++++++++++++++++++++++++++++++++
> > > > >  drivers/vfio/pci/Makefile           |   1 +
> > > > >  4 files changed, 156 insertions(+)
> > > > >  create mode 100644 drivers/vfio/pci/vfio_pci_virtio.c
> > > > > 
> > > > > diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> > > > > index 2128de8..2bd5616 100644
> > > > > --- a/drivers/vfio/pci/vfio_pci_private.h
> > > > > +++ b/drivers/vfio/pci/vfio_pci_private.h
> > > > > @@ -139,4 +139,5 @@ static inline int vfio_pci_igd_init(struct vfio_pci_device *vdev)
> > > > >  	return -ENODEV;
> > > > >  }
> > > > >  #endif
> > > > > +extern int vfio_pci_virtio_quirk(struct vfio_pci_device *vdev, bool noiommu);
> > > > >  #endif /* VFIO_PCI_PRIVATE_H */
> > > > > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > > > > index d624a52..e93bf0c 100644
> > > > > --- a/drivers/vfio/pci/vfio_pci.c
> > > > > +++ b/drivers/vfio/pci/vfio_pci.c
> > > > > @@ -1236,6 +1236,20 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > > >  		return ret;
> > > > >  	}
> > > > >  
> > > > > +	if (pdev->vendor == PCI_VENDOR_ID_REDHAT_QUMRANET) {      
> > > > 
> > > > Perhaps a vfio_pci_is_virtio() like vga below?  Let's test the device
> > > > ID range initially as well, this test raised a big red flag for me
> > > > whether all devices within this vendor ID were virtio.
> > > >     
> > > > > +		bool noiommu = vfio_is_noiommu_group_dev(&pdev->dev);      
> > > > 
> > > > I think you can use iommu_present() for this and avoid patch 1of2.
> > > > noiommu is mutually exclusive to an iommu being present.  Seems like
> > > > all of this logic should be in the quirk itself, I'm not sure what it
> > > > buys to get the value here but wait until later to use it.  Using
> > > > iommu_present() could also move this test much earlier in
> > > > vfio_pci_probe() making the exit path easier.    
> > > 
> > > Except then I'm reintroducing the bug fixed by 16ab8a5cbea4 since
> > > iommu_present() assumes an IOMMU API based device.  I'll try to think if
> > > there's another way to avoid adding the is_noiommu function.  Thanks,  
> > 
> > I think something like this would do it.
> > 
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -1214,6 +1214,22 @@ static int vfio_pci_probe(struct pci_dev *pdev, const str
> >         if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
> >                 return -EINVAL;
> >  
> > +       /*
> > +        * Filter out virtio devices that do not honor the iommu,
> > +        * but only for real iommu groups.
> > +        */
> > +       if (vfio_pci_is_virtio(pdev)) {
> > +               struct iommu_group *tmp = iommu_group_get(&pdev->dev);
> > +
> > +               if (tmp) {
> > +                       iommu_group_put(tmp);
> > +
> > +                       ret = vfio_pci_virtio_quirk(pdev);
> > +                       if (ret)
> > +                               return ret;
> > +               }
> > +       }
> > +
> >         group = vfio_iommu_group_get(&pdev->dev);
> >         if (!group)
> >                 return -EINVAL;
> > 
> > Thanks,
> > Alex  
> 
> Yes but I think this will also prevent binding
> a vfio-noiommu to this device.
> 
> Arguably this is a separate bug as it's already impossible ...
> but now that we are disabling regular vfio the noiommu
> fallback becomes more important.
> 
> Any hints on how to fix?

I don't follow, prior to noiommu, we'd simply call iommu_group_get() and
rely on the iommu group created by the iommu driver.  Either there is
one and we allow binding to vfio-pci or there is not one and we would
fail.  With noiommu, vfio_iommu_group_get() wraps that call in some
logic that potentially creates an iommu group if noiommu is enabled.
So if we use the real iommu_group_get() prior to that and a group
exists, we know we're not using noiommu and we can test the virtio
device.  If the group doesn't exist here, noiommu plays out the same as
it would otherwise (depending on noiommu enabling), a virtio device can
be bound regardless of its capabilities and features.  I think that's
what we want, right?  Thanks,

Alex

> > > > > +
> > > > > +		ret = vfio_pci_virtio_quirk(vdev, noiommu);
> > > > > +		if (ret) {
> > > > > +			dev_warn(&vdev->pdev->dev,
> > > > > +				 "Failed to setup Virtio for VFIO\n");
> > > > > +			vfio_del_group_dev(&pdev->dev);
> > > > > +			vfio_iommu_group_put(group, &pdev->dev);
> > > > > +			kfree(vdev);
> > > > > +			return ret;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > >  	if (vfio_pci_is_vga(pdev)) {
> > > > >  		vga_client_register(pdev, vdev, NULL, vfio_pci_set_vga_decode);
> > > > >  		vga_set_legacy_decoding(pdev,
> > > > > diff --git a/drivers/vfio/pci/vfio_pci_virtio.c b/drivers/vfio/pci/vfio_pci_virtio.c
> > > > > new file mode 100644
> > > > > index 0000000..e1ecffd
> > > > > --- /dev/null
> > > > > +++ b/drivers/vfio/pci/vfio_pci_virtio.c
> > > > > @@ -0,0 +1,140 @@
> > > > > +/*
> > > > > + * VFIO PCI Intel Graphics support      
> > > >       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    
> > > > > + *
> > > > > + * Copyright (C) 2016 Red Hat, Inc.  All rights reserved.
> > > > > + *	Author: Alex Williamson <alex.williamson@redhat.com>      
> > > > 
> > > > Update.
> > > >     
> > > > > + *
> > > > > + * This program is free software; you can redistribute it and/or modify
> > > > > + * it under the terms of the GNU General Public License version 2 as
> > > > > + * published by the Free Software Foundation.
> > > > > + *
> > > > > + * Register a device specific region through which to provide read-only
> > > > > + * access to the Intel IGD opregion.  The register defining the opregion
> > > > > + * address is also virtualized to prevent user modification.
> > > > > + */
> > > > > +
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/pci.h>
> > > > > +#include <linux/uaccess.h>      
> > > > 
> > > > Are io.h and uaccess.h needed?
> > > >     
> > > > > +#include <linux/vfio.h>
> > > > > +#include <linux/virtio_pci.h>
> > > > > +#include <linux/virtio_config.h>
> > > > > +
> > > > > +#include "vfio_pci_private.h"
> > > > > +
> > > > > +/**
> > > > > + * virtio_pci_find_capability - walk capabilities to find device info.
> > > > > + * @dev: the pci device
> > > > > + * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
> > > > > + *
> > > > > + * Returns offset of the capability, or 0.
> > > > > + */
> > > > > +static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type)      
> > > > 
> > > > Does inlining this really make sense?
> > > >     
> > > > > +{
> > > > > +	int pos;
> > > > > +
> > > > > +	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> > > > > +	     pos > 0;
> > > > > +	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> > > > > +		u8 type;
> > > > > +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> > > > > +							 cfg_type),
> > > > > +				     &type);
> > > > > +
> > > > > +		if (type != cfg_type)
> > > > > +			continue;
> > > > > +
> > > > > +		/* Ignore structures with reserved BAR values */
> > > > > +		if (type != VIRTIO_PCI_CAP_PCI_CFG) {
> > > > > +			u8 bar;
> > > > > +
> > > > > +			pci_read_config_byte(dev, pos +
> > > > > +					     offsetof(struct virtio_pci_cap,
> > > > > +						      bar),
> > > > > +					     &bar);
> > > > > +			if (bar > 0x5)      
> > > > 
> > > > s/0x5/PCI_STD_RESOURCE_END/
> > > >     
> > > > > +				continue;
> > > > > +		}
> > > > > +
> > > > > +		return pos;
> > > > > +	}
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +
> > > > > +int vfio_pci_virtio_quirk(struct vfio_pci_device *vdev, bool noiommu)
> > > > > +{
> > > > > +	struct pci_dev *dev = vdev->pdev;      
> > > > 
> > > > Please use *pdev for consistency with the rest of drivers/vfio/pci/*
> > > > 
> > > > Also, is there any reason to pass the vfio_pci_device?  There's nothing
> > > > vfio here otherwise and we could remove more #includes.
> > > >     
> > > > > +	int common, cfg;
> > > > > +	u32 features;
> > > > > +	u32 offset;
> > > > > +	u8 bar;
> > > > > +
> > > > > +	/* Without an IOMMU, we don't care */
> > > > > +	if (noiommu)
> > > > > +		return 0;
> > > > > +
> > > > > +        /* Virtio only owns devices >= 0x1000 and <= 0x107f: leave the rest. */
> > > > > +        if (dev->device < 0x1000 || dev->device > 0x107f)
> > > > > +                return 0;      
> > > > 
> > > > Whitespace
> > > >     
> > > > > +
> > > > > +	/* Check whether device enforces the IOMMU correctly */
> > > > > +
> > > > > +	/*
> > > > > +	 * All modern devices must have common and cfg capabilities. We use cfg
> > > > > +	 * capability for access so that we don't need to worry about resource
> > > > > +	 * availability. Slow but sure.
> > > > > +	 * Note that all vendor-specific fields we access are little-endian
> > > > > +	 * which matches what pci config accessors expect, so they do byteswap
> > > > > +	 * for us if appropriate.
> > > > > +	 */
> > > > > +	common = virtio_pci_find_capability(dev, VIRTIO_PCI_CAP_COMMON_CFG);
> > > > > +	cfg = virtio_pci_find_capability(dev, VIRTIO_PCI_CAP_PCI_CFG);
> > > > > +	if (!cfg || !common) {
> > > > > +                dev_warn(&dev->dev,
> > > > > +                         "Virtio device lacks common or pci cfg.\n");      
> > > > 
> > > > Whitespace
> > > >     
> > > > > +		return -ENODEV;
> > > > > +	}
> > > > > +
> > > > > +	pci_read_config_byte(dev, common + offsetof(struct virtio_pci_cap,
> > > > > +						    bar),
> > > > > +			     &bar);
> > > > > +	pci_read_config_dword(dev, common + offsetof(struct virtio_pci_cap,
> > > > > +						    offset),
> > > > > +			     &offset);
> > > > > +
> > > > > +	/* Program cfg capability for dword access into common cfg. */
> > > > > +	pci_write_config_byte(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> > > > > +						  cap.bar),
> > > > > +			      bar);
> > > > > +	pci_write_config_dword(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> > > > > +						   cap.length),
> > > > > +			       0x4);
> > > > > +
> > > > > +	/* Select features dword that has VIRTIO_F_IOMMU_PLATFORM. */
> > > > > +	pci_write_config_dword(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> > > > > +						  cap.offset),
> > > > > +			       offset + offsetof(struct virtio_pci_common_cfg,
> > > > > +						 device_feature_select));
> > > > > +	pci_write_config_dword(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> > > > > +						  pci_cfg_data),
> > > > > +			       VIRTIO_F_IOMMU_PLATFORM / 32);
> > > > > +
> > > > > +	/* Get the features dword. */
> > > > > +	pci_write_config_dword(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> > > > > +						  cap.offset),
> > > > > +			       offset + offsetof(struct virtio_pci_common_cfg,
> > > > > +						 device_feature));
> > > > > +	pci_read_config_dword(dev, cfg + offsetof(struct virtio_pci_cfg_cap,
> > > > > +						  pci_cfg_data),
> > > > > +			      &features);
> > > > > +
> > > > > +	/* Does this device obey the platform's IOMMU? If not it's an error. */
> > > > > +	if (!(features & (0x1 << (VIRTIO_F_IOMMU_PLATFORM % 32)))) {
> > > > > +                dev_warn(&dev->dev,
> > > > > +                         "Virtio device lacks VIRTIO_F_IOMMU_PLATFORM.\n");      
> > > > 
> > > > Whitespace
> > > >     
> > > > > +		return -ENODEV;
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> > > > > index 76d8ec0..e9b20e7 100644
> > > > > --- a/drivers/vfio/pci/Makefile
> > > > > +++ b/drivers/vfio/pci/Makefile
> > > > > @@ -1,5 +1,6 @@
> > > > >  
> > > > >  vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
> > > > > +vfio-pci-y += vfio_pci_virtio.o
> > > > >  vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
> > > > >  
> > > > >  obj-$(CONFIG_VFIO_PCI) += vfio-pci.o      
> > > > 
> > > > Thanks,
> > > > Alex    
