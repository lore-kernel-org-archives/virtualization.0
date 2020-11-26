Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DC9C63697
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 13:57:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA7722228
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 13:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAyZfFBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA7722228
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E89D873F2;
	Thu, 26 Nov 2020 13:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UIcUZxSHJ_IB; Thu, 26 Nov 2020 13:57:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 344A9873A3;
	Thu, 26 Nov 2020 13:57:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DC18C0891;
	Thu, 26 Nov 2020 13:57:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F71FC0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 13:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4B678873A3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 13:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ByzuEmBCkv37
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 13:57:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0054380664
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606399064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QtokPT7Iuur5BQhls5+2fsRgTE4pHnDc+29LL+sl49M=;
 b=BAyZfFBDCMsZP/TAK0kCDfhK96THJCgI1WuyvEujCZnCF22sSjTnhSlXAFfm0tWjxp47N5
 t75thVeV+ZYVIEXU1pchMYD5g7gbq6gfcX7AOCbn8G/826QfRoZeAan0HsMs42tvHvp4Vc
 hVI34CyhONkGB/M3PzFiT7iK84t8r+8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-55-I8ddJ3UXN0ecE6sgmspRGg-1; Thu, 26 Nov 2020 08:57:39 -0500
X-MC-Unique: I8ddJ3UXN0ecE6sgmspRGg-1
Received: by mail-wr1-f71.google.com with SMTP id n13so1329491wrs.10
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 05:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QtokPT7Iuur5BQhls5+2fsRgTE4pHnDc+29LL+sl49M=;
 b=Dgfu59LZ3jjPQVTNjrxJVi0a9GmON+1SY7v4l5LMWFLCEl2BNQ63HPoFpLEvrchzR2
 4oM6PW/XRtQwiDEomus0FyvyBBRGELcthphidUCycqhg1j3Ul3XmGKAyBM/7VxSCjaM6
 D7m6EWMQs49hNYJPPD+AMS3zAbanTio8OqmYhRAMyFyvLQD39eeH0A8sPDnAqgZDDGRu
 8rdtZvzs+O3X4T3GAiYn/w9U3zbLsOgLaHGttfTCxp6BTXCIw3mKtT6r4HhNCNuFF9cs
 RNZQa8Ul7Hu3vWzzzCw3SzxTWuNBKDmk9kr/TCHSxE4PnVZgN5ZmuTAcj7S4evFppv1b
 /Z9g==
X-Gm-Message-State: AOAM532wabZRssqGbWlOkeZlP67cUA33yC4ib1noEIERhFM9kqG3WeE/
 jcwNrhISydZFxeNtkPnxrUrui7HcySJKk7NmIhRglXkSUSj/yM8+DhHzxF13iZLSvLfgdW/3CDl
 DvozYlrtRnzLW/ROmqx1ZbiT3zcybt75Rtn4T5r+RDA==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr4178536wru.352.1606399057838; 
 Thu, 26 Nov 2020 05:57:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnCMtn8p63rFhIcTJsTWUOgADrMR9MrpvyuL1udnsHxPJHLy0IXKBlxktcbDdQYOiOpDt7UA==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr4178509wru.352.1606399057540; 
 Thu, 26 Nov 2020 05:57:37 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id o21sm9190143wra.40.2020.11.26.05.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:57:36 -0800 (PST)
Date: Thu, 26 Nov 2020 08:57:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 02/14] virtio-pci: switch to use devres for modern
 devices
Message-ID: <20201126084708-mutt-send-email-mst@kernel.org>
References: <20201126092604.208033-1-jasowang@redhat.com>
 <20201126092604.208033-3-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201126092604.208033-3-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Nov 26, 2020 at 05:25:52PM +0800, Jason Wang wrote:
> This patch tries to convert the modern device to use devres to manage
> its resources (iomaps). Before this patch the IO address is mapped
> individually according to the capability. After this patch, we simply
> map the whole BAR.

I think the point of mapping capability was e.g. for devices with
huge BARs. We don't want to waste virtual memory for e.g. 32 bit guests.

And in particular the spec says:

	The drivers SHOULD only map part of configuration structure large enough for device operation. The drivers
	MUST handle an unexpectedly large length, but MAY check that length is large enough for device operation.

I also wonder how would this interact with cases where device memory is
mapped for different reasons, such as for MSI table access, into userspace
as it has resources such as virtio mem, etc.
E.g. don't e.g. intel CPUs disallow mapping the same address twice
with different attributes?

> This simplify the work of splitting modern device logic into an
> separate module.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_common.c |  10 --
>  drivers/virtio/virtio_pci_common.h |   2 +
>  drivers/virtio/virtio_pci_legacy.c |  13 ++-
>  drivers/virtio/virtio_pci_modern.c | 141 +++++++++--------------------
>  4 files changed, 54 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 222d630c41fc..e786701fa1b4 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -527,11 +527,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  	INIT_LIST_HEAD(&vp_dev->virtqueues);
>  	spin_lock_init(&vp_dev->lock);
>  
> -	/* enable the device */
> -	rc = pci_enable_device(pci_dev);
> -	if (rc)
> -		goto err_enable_device;
> -
>  	if (force_legacy) {
>  		rc = virtio_pci_legacy_probe(vp_dev);
>  		/* Also try modern mode if we can't map BAR0 (no IO space). */
> @@ -559,11 +554,8 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
>  err_register:
>  	if (vp_dev->ioaddr)
>  	     virtio_pci_legacy_remove(vp_dev);
> -	else
> -	     virtio_pci_modern_remove(vp_dev);
>  err_probe:
>  	pci_disable_device(pci_dev);
> -err_enable_device:
>  	if (reg_dev)
>  		put_device(&vp_dev->vdev.dev);
>  	else
> @@ -582,8 +574,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
>  
>  	if (vp_dev->ioaddr)
>  		virtio_pci_legacy_remove(vp_dev);
> -	else
> -		virtio_pci_modern_remove(vp_dev);
>  
>  	pci_disable_device(pci_dev);
>  	put_device(dev);
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index b2f0eb4067cb..1d23420f7ed6 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -49,6 +49,8 @@ struct virtio_pci_device {
>  	u8 __iomem *isr;
>  
>  	/* Modern only fields */
> +	/* The IO mapping for the BARs */
> +	void __iomem * const *base;
>  	/* The IO mapping for the PCI config space (non-legacy mode) */
>  	struct virtio_pci_common_cfg __iomem *common;
>  	/* Device-specific data (non-legacy mode)  */
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index d62e9835aeec..890f155ff48c 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -214,14 +214,19 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>  	struct pci_dev *pci_dev = vp_dev->pci_dev;
>  	int rc;
>  
> +	rc = pci_enable_device(pci_dev);
> +	if (rc)
> +		return rc;
> +
> +	rc = -ENODEV;
>  	/* We only own devices >= 0x1000 and <= 0x103f: leave the rest. */
>  	if (pci_dev->device < 0x1000 || pci_dev->device > 0x103f)
> -		return -ENODEV;
> +		goto err_id;
>  
>  	if (pci_dev->revision != VIRTIO_PCI_ABI_VERSION) {
>  		printk(KERN_ERR "virtio_pci: expected ABI version %d, got %d\n",
>  		       VIRTIO_PCI_ABI_VERSION, pci_dev->revision);
> -		return -ENODEV;
> +		goto err_id;
>  	}
>  
>  	rc = dma_set_mask(&pci_dev->dev, DMA_BIT_MASK(64));
> @@ -241,7 +246,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>  
>  	rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
>  	if (rc)
> -		return rc;
> +		goto err_id;
>  
>  	rc = -ENOMEM;
>  	vp_dev->ioaddr = pci_iomap(pci_dev, 0, 0);
> @@ -267,6 +272,8 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
>  
>  err_iomap:
>  	pci_release_region(pci_dev, 0);
> +err_id:
> +	pci_disable_device(pci_dev);
>  	return rc;
>  }
>  
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index df1481fd400c..33cc21b818de 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -63,15 +63,15 @@ static void vp_iowrite64_twopart(u64 val,
>  	vp_iowrite32(val >> 32, hi);
>  }
>  
> -static void __iomem *map_capability(struct pci_dev *dev, int off,
> +static void __iomem *map_capability(struct virtio_pci_device *vp_dev, int off,
>  				    size_t minlen,
>  				    u32 align,
> -				    u32 start, u32 size,
> +				    u32 size,
>  				    size_t *len)
>  {
> +	struct pci_dev *dev = vp_dev->pci_dev;
>  	u8 bar;
>  	u32 offset, length;
> -	void __iomem *p;
>  
>  	pci_read_config_byte(dev, off + offsetof(struct virtio_pci_cap,
>  						 bar),
> @@ -81,31 +81,13 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
>  	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
>  			      &length);
>  
> -	if (length <= start) {
> -		dev_err(&dev->dev,
> -			"virtio_pci: bad capability len %u (>%u expected)\n",
> -			length, start);
> -		return NULL;
> -	}
> -
> -	if (length - start < minlen) {
> +	if (length < minlen) {
>  		dev_err(&dev->dev,
>  			"virtio_pci: bad capability len %u (>=%zu expected)\n",
>  			length, minlen);
>  		return NULL;
>  	}
>  
> -	length -= start;
> -
> -	if (start + offset < offset) {

why kill wrap around?

> -		dev_err(&dev->dev,
> -			"virtio_pci: map wrap-around %u+%u\n",
> -			start, offset);
> -		return NULL;
> -	}
> -
> -	offset += start;
> -
>  	if (offset & (align - 1)) {
>  		dev_err(&dev->dev,
>  			"virtio_pci: offset %u not aligned to %u\n",
> @@ -129,12 +111,7 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
>  		return NULL;
>  	}
>  
> -	p = pci_iomap_range(dev, bar, offset, length);
> -	if (!p)
> -		dev_err(&dev->dev,
> -			"virtio_pci: unable to map virtio %u@%u on bar %i\n",
> -			length, offset, bar);
> -	return p;
> +	return vp_dev->base[bar] + offset;
>  }
>  
>  /* virtio config->get_features() implementation */
> @@ -369,27 +346,21 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  	vp_iowrite64_twopart(virtqueue_get_used_addr(vq),
>  			     &cfg->queue_used_lo, &cfg->queue_used_hi);
>  
> -	if (vp_dev->notify_base) {
> -		/* offset should not wrap */
> -		if ((u64)off * vp_dev->notify_offset_multiplier + 2
> -		    > vp_dev->notify_len) {
> -			dev_warn(&vp_dev->pci_dev->dev,
> -				 "bad notification offset %u (x %u) "
> -				 "for queue %u > %zd",
> -				 off, vp_dev->notify_offset_multiplier,
> -				 index, vp_dev->notify_len);
> -			err = -EINVAL;
> -			goto err_map_notify;
> -		}
> -		vq->priv = (void __force *)vp_dev->notify_base +
> -			off * vp_dev->notify_offset_multiplier;
> -	} else {
> -		vq->priv = (void __force *)map_capability(vp_dev->pci_dev,
> -					  vp_dev->notify_map_cap, 2, 2,
> -					  off * vp_dev->notify_offset_multiplier, 2,
> -					  NULL);
> +	/* offset should not wrap */
> +	if ((u64)off * vp_dev->notify_offset_multiplier + 2
> +		> vp_dev->notify_len) {
> +		dev_warn(&vp_dev->pci_dev->dev,
> +			 "bad notification offset %u (x %u) "
> +			 "for queue %u > %zd",
> +			 off, vp_dev->notify_offset_multiplier,
> +			 index, vp_dev->notify_len);
> +		err = -EINVAL;
> +		goto err_map_notify;
>  	}
>  
> +	vq->priv = (void __force *)vp_dev->notify_base +
> +		off * vp_dev->notify_offset_multiplier;
> +
>  	if (!vq->priv) {
>  		err = -ENOMEM;
>  		goto err_map_notify;
> @@ -400,15 +371,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>  		msix_vec = vp_ioread16(&cfg->queue_msix_vector);
>  		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
>  			err = -EBUSY;
> -			goto err_assign_vector;
> +			goto err_map_notify;
>  		}
>  	}
>  
>  	return vq;
>  
> -err_assign_vector:
> -	if (!vp_dev->notify_base)
> -		pci_iounmap(vp_dev->pci_dev, (void __iomem __force *)vq->priv);
>  err_map_notify:
>  	vring_del_virtqueue(vq);
>  	return ERR_PTR(err);
> @@ -454,9 +422,6 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  		vp_ioread16(&cfg->queue_msix_vector);
>  	}
>  
> -	if (!vp_dev->notify_base)
> -		pci_iounmap(vp_dev->pci_dev, (void __force __iomem *)vq->priv);
> -
>  	vring_del_virtqueue(vq);
>  }
>  
> @@ -700,6 +665,10 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
>  
>  	check_offsets();
>  
> +	err = pcim_enable_device(pci_dev);
> +	if (err)
> +		return err;
> +
>  	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
>  	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
>  		return -ENODEV;
> @@ -753,23 +722,24 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
>  					    IORESOURCE_IO | IORESOURCE_MEM,
>  					    &vp_dev->modern_bars);
>  
> -	err = pci_request_selected_regions(pci_dev, vp_dev->modern_bars,
> -					   "virtio-pci-modern");
> +	err = pcim_iomap_regions(pci_dev, vp_dev->modern_bars,
> +				 "virtio-pci-modern");
>  	if (err)
>  		return err;
>  
> +	vp_dev->base = pcim_iomap_table(pci_dev);
> +
>  	err = -EINVAL;
> -	vp_dev->common = map_capability(pci_dev, common,
> +	vp_dev->common = map_capability(vp_dev, common,
>  					sizeof(struct virtio_pci_common_cfg), 4,
> -					0, sizeof(struct virtio_pci_common_cfg),
> +					sizeof(struct virtio_pci_common_cfg),
>  					NULL);
>  	if (!vp_dev->common)
> -		goto err_map_common;
> -	vp_dev->isr = map_capability(pci_dev, isr, sizeof(u8), 1,
> -				     0, 1,
> -				     NULL);
> +		goto err;
> +	vp_dev->isr = map_capability(vp_dev, isr, sizeof(u8), 1,
> +				     1, NULL);
>  	if (!vp_dev->isr)
> -		goto err_map_isr;
> +		goto err;
>  
>  	/* Read notify_off_multiplier from config space. */
>  	pci_read_config_dword(pci_dev,
> @@ -787,29 +757,21 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
>  						cap.offset),
>  			      &notify_offset);
>  
> -	/* We don't know how many VQs we'll map, ahead of the time.
> -	 * If notify length is small, map it all now.
> -	 * Otherwise, map each VQ individually later.
> -	 */
> -	if ((u64)notify_length + (notify_offset % PAGE_SIZE) <= PAGE_SIZE) {
> -		vp_dev->notify_base = map_capability(pci_dev, notify, 2, 2,
> -						     0, notify_length,
> -						     &vp_dev->notify_len);
> -		if (!vp_dev->notify_base)
> -			goto err_map_notify;
> -	} else {
> -		vp_dev->notify_map_cap = notify;
> -	}
> +	vp_dev->notify_base = map_capability(vp_dev, notify, 2, 2,
> +					     notify_length,
> +					     &vp_dev->notify_len);
> +	if (!vp_dev->notify_base)
> +		goto err;
>  
>  	/* Again, we don't know how much we should map, but PAGE_SIZE
>  	 * is more than enough for all existing devices.
>  	 */
>  	if (device) {
> -		vp_dev->device = map_capability(pci_dev, device, 0, 4,
> -						0, PAGE_SIZE,
> +		vp_dev->device = map_capability(vp_dev, device, 0, 4,
> +						PAGE_SIZE,
>  						&vp_dev->device_len);
>  		if (!vp_dev->device)
> -			goto err_map_device;
> +			goto err;
>  
>  		vp_dev->vdev.config = &virtio_pci_config_ops;
>  	} else {
> @@ -822,26 +784,7 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
>  
>  	return 0;
>  
> -err_map_device:
> -	if (vp_dev->notify_base)
> -		pci_iounmap(pci_dev, vp_dev->notify_base);
> -err_map_notify:
> -	pci_iounmap(pci_dev, vp_dev->isr);
> -err_map_isr:
> -	pci_iounmap(pci_dev, vp_dev->common);
> -err_map_common:
> +err:
>  	return err;
>  }
>  
> -void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
> -{
> -	struct pci_dev *pci_dev = vp_dev->pci_dev;
> -
> -	if (vp_dev->device)
> -		pci_iounmap(pci_dev, vp_dev->device);
> -	if (vp_dev->notify_base)
> -		pci_iounmap(pci_dev, vp_dev->notify_base);
> -	pci_iounmap(pci_dev, vp_dev->isr);
> -	pci_iounmap(pci_dev, vp_dev->common);
> -	pci_release_selected_regions(pci_dev, vp_dev->modern_bars);
> -}
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
