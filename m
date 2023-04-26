Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEB0C77B7F
	for <virtualization@archiver.kernel.org>; Wed, 26 Apr 2023 02:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94ADE8206D;
	Wed, 26 Apr 2023 02:12:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94ADE8206D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIyM-ifxH4Cb; Wed, 26 Apr 2023 02:12:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0853E8202C;
	Wed, 26 Apr 2023 02:12:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0853E8202C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A10D7C0036;
	Wed, 26 Apr 2023 02:12:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8492DC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 02:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4BC9840B46
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 02:12:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4BC9840B46
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id my9fUvJDcIZ0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 02:12:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9858D40924
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9858D40924
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Apr 2023 02:12:39 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0Vh0mqr._1682475153; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vh0mqr._1682475153) by smtp.aliyun-inc.com;
 Wed, 26 Apr 2023 10:12:34 +0800
Message-ID: <1682474997.6771185-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v4 virtio 01/10] virtio: allow caller to override device
 id and DMA mask
Date: Wed, 26 Apr 2023 10:09:57 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Shannon Nelson <shannon.nelson@amd.com>
References: <20230425212602.1157-1-shannon.nelson@amd.com>
 <20230425212602.1157-2-shannon.nelson@amd.com>
In-Reply-To: <20230425212602.1157-2-shannon.nelson@amd.com>
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, drivers@pensando.io
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 25 Apr 2023 14:25:53 -0700, Shannon Nelson <shannon.nelson@amd.com> wrote:
> To add a bit of flexibility with various virtio based devices, allow
> the caller to specify a different device id and DMA mask.  This adds
> fields to struct virtio_pci_modern_device to specify an override device
> id check and a DMA mask.
>
> int (*device_id_check)(struct pci_dev *pdev);
> 	If defined by the driver, this function will be called to check
> 	that the PCI device is the vendor's expected device, and will
> 	return the found device id to be stored in mdev->id.device.
> 	This allows vendors with alternative vendor device ids to use
> 	this library on their own device BAR.
>
> u64 dma_mask;
> 	If defined by the driver, this mask will be used in a call to
> 	dma_set_mask_and_coherent() instead of the traditional
> 	DMA_BIT_MASK(64).  This allows limiting the DMA space on
> 	vendor devices with address limitations.
>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/virtio/virtio_pci_modern_dev.c | 37 +++++++++++++++++---------
>  include/linux/virtio_pci_modern.h      |  6 +++++
>  2 files changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 869cb46bef96..1f2db76e8f91 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -218,21 +218,29 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  	int err, common, isr, notify, device;
>  	u32 notify_length;
>  	u32 notify_offset;
> +	int devid;
>
>  	check_offsets();
>
> -	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
> -	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
> -		return -ENODEV;
> -
> -	if (pci_dev->device < 0x1040) {
> -		/* Transitional devices: use the PCI subsystem device id as
> -		 * virtio device id, same as legacy driver always did.
> -		 */
> -		mdev->id.device = pci_dev->subsystem_device;
> +	if (mdev->device_id_check) {
> +		devid = mdev->device_id_check(pci_dev);
> +		if (devid < 0)
> +			return devid;

I would want to know is there any other reason to return the errno?
How about return -ENODEV directly?

Thanks.


> +		mdev->id.device = devid;
>  	} else {
> -		/* Modern devices: simply use PCI device id, but start from 0x1040. */
> -		mdev->id.device = pci_dev->device - 0x1040;
> +		/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
> +		if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
> +			return -ENODEV;
> +
> +		if (pci_dev->device < 0x1040) {
> +			/* Transitional devices: use the PCI subsystem device id as
> +			 * virtio device id, same as legacy driver always did.
> +			 */
> +			mdev->id.device = pci_dev->subsystem_device;
> +		} else {
> +			/* Modern devices: simply use PCI device id, but start from 0x1040. */
> +			mdev->id.device = pci_dev->device - 0x1040;
> +		}
>  	}
>  	mdev->id.vendor = pci_dev->subsystem_vendor;
>
> @@ -260,7 +268,12 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  		return -EINVAL;
>  	}
>
> -	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
> +	if (mdev->dma_mask)
> +		err = dma_set_mask_and_coherent(&pci_dev->dev,
> +						mdev->dma_mask);
> +	else
> +		err = dma_set_mask_and_coherent(&pci_dev->dev,
> +						DMA_BIT_MASK(64));
>  	if (err)
>  		err = dma_set_mask_and_coherent(&pci_dev->dev,
>  						DMA_BIT_MASK(32));
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index c4eeb79b0139..067ac1d789bc 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -38,6 +38,12 @@ struct virtio_pci_modern_device {
>  	int modern_bars;
>
>  	struct virtio_device_id id;
> +
> +	/* optional check for vendor virtio device, returns dev_id or -ERRNO */
> +	int (*device_id_check)(struct pci_dev *pdev);
> +
> +	/* optional mask for devices with limited DMA space */
> +	u64 dma_mask;
>  };
>
>  /*
> --
> 2.17.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
