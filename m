Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C81C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 13:57:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D2C7A83312;
	Wed,  6 Apr 2022 13:57:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ux5GeZmCh5c6; Wed,  6 Apr 2022 13:57:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6377E8308A;
	Wed,  6 Apr 2022 13:57:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3D05C0083;
	Wed,  6 Apr 2022 13:57:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE386C0012;
 Wed,  6 Apr 2022 13:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 32FAE8308A;
 Wed,  6 Apr 2022 13:57:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E18i8qy98cW3; Wed,  6 Apr 2022 13:57:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64E0682F92;
 Wed,  6 Apr 2022 13:57:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E2F912FC;
 Wed,  6 Apr 2022 06:57:06 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E682C3F73B;
 Wed,  6 Apr 2022 06:57:01 -0700 (PDT)
Message-ID: <db5a6daa-bfe9-744f-7fc5-d5167858bc3e@arm.com>
Date: Wed, 6 Apr 2022 14:56:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] iommu: Replace uses of IOMMU_CAP_CACHE_COHERENCY with
 dev_is_dma_coherent()
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, Christian Benvenuti <benve@cisco.com>,
 Cornelia Huck <cohuck@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 iommu@lists.linux-foundation.org, Jason Wang <jasowang@redhat.com>,
 Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Nelson Escobar <neescoba@cisco.com>,
 netdev@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
References: <1-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2022-04-05 17:16, Jason Gunthorpe wrote:
> vdpa and usnic are trying to test if IOMMU_CACHE is supported. The correct
> way to do this is via dev_is_dma_coherent()

Not necessarily...

Disregarding the complete disaster of PCIe No Snoop on Arm-Based 
systems, there's the more interesting effectively-opposite scenario 
where an SMMU bridges non-coherent devices to a coherent interconnect. 
It's not something we take advantage of yet in Linux, and it can only be 
properly described in ACPI, but there do exist situations where 
IOMMU_CACHE is capable of making the device's traffic snoop, but 
dev_is_dma_coherent() - and device_get_dma_attr() for external users - 
would still say non-coherent because they can't assume that the SMMU is 
enabled and programmed in just the right way.

I've also not thought too much about how things might look with S2FWB 
thrown into the mix in future...

Robin.

> like the DMA API does. If
> IOMMU_CACHE is not supported then these drivers won't work as they don't
> call any coherency-restoring routines around their DMAs.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/infiniband/hw/usnic/usnic_uiom.c | 16 +++++++---------
>   drivers/vhost/vdpa.c                     |  3 ++-
>   2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
> index 760b254ba42d6b..24d118198ac756 100644
> --- a/drivers/infiniband/hw/usnic/usnic_uiom.c
> +++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
> @@ -42,6 +42,7 @@
>   #include <linux/list.h>
>   #include <linux/pci.h>
>   #include <rdma/ib_verbs.h>
> +#include <linux/dma-map-ops.h>
>   
>   #include "usnic_log.h"
>   #include "usnic_uiom.h"
> @@ -474,6 +475,12 @@ int usnic_uiom_attach_dev_to_pd(struct usnic_uiom_pd *pd, struct device *dev)
>   	struct usnic_uiom_dev *uiom_dev;
>   	int err;
>   
> +	if (!dev_is_dma_coherent(dev)) {
> +		usnic_err("IOMMU of %s does not support cache coherency\n",
> +				dev_name(dev));
> +		return -EINVAL;
> +	}
> +
>   	uiom_dev = kzalloc(sizeof(*uiom_dev), GFP_ATOMIC);
>   	if (!uiom_dev)
>   		return -ENOMEM;
> @@ -483,13 +490,6 @@ int usnic_uiom_attach_dev_to_pd(struct usnic_uiom_pd *pd, struct device *dev)
>   	if (err)
>   		goto out_free_dev;
>   
> -	if (!iommu_capable(dev->bus, IOMMU_CAP_CACHE_COHERENCY)) {
> -		usnic_err("IOMMU of %s does not support cache coherency\n",
> -				dev_name(dev));
> -		err = -EINVAL;
> -		goto out_detach_device;
> -	}
> -
>   	spin_lock(&pd->lock);
>   	list_add_tail(&uiom_dev->link, &pd->devs);
>   	pd->dev_cnt++;
> @@ -497,8 +497,6 @@ int usnic_uiom_attach_dev_to_pd(struct usnic_uiom_pd *pd, struct device *dev)
>   
>   	return 0;
>   
> -out_detach_device:
> -	iommu_detach_device(pd->domain, dev);
>   out_free_dev:
>   	kfree(uiom_dev);
>   	return err;
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 4c2f0bd062856a..05ea5800febc37 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -22,6 +22,7 @@
>   #include <linux/vdpa.h>
>   #include <linux/nospec.h>
>   #include <linux/vhost.h>
> +#include <linux/dma-map-ops.h>
>   
>   #include "vhost.h"
>   
> @@ -929,7 +930,7 @@ static int vhost_vdpa_alloc_domain(struct vhost_vdpa *v)
>   	if (!bus)
>   		return -EFAULT;
>   
> -	if (!iommu_capable(bus, IOMMU_CAP_CACHE_COHERENCY))
> +	if (!dev_is_dma_coherent(dma_dev))
>   		return -ENOTSUPP;
>   
>   	v->domain = iommu_domain_alloc(bus);
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
