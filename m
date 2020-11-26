Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14EFC56202
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 13:47:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B4420644
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 13:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dv/MtRJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B4420644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BCBB02E222;
	Thu, 26 Nov 2020 13:47:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6cg+oUmErMts; Thu, 26 Nov 2020 13:47:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9F5AE20494;
	Thu, 26 Nov 2020 13:47:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91B39C0891;
	Thu, 26 Nov 2020 13:47:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B5E5C0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 13:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 05353873D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 13:47:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TA-DBa0YzKRJ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 13:47:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CB74F873CB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 13:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606398419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4fux52JZVbYIP0imVmVjqUi5Uo7xuob2S06QEGrh7kY=;
 b=Dv/MtRJlBTA8v+yrkPcm36N2VjE0Dw0G6cjjGDQPVpc14vZehBoKbU6NFH/R1S2IBZkYhT
 92SqZKmcaQocU/omdKr5WqugGGT0xnnBc9oLgp0zi0lI7i4gF+nifv+Mm2kc+Qo3wk9UmV
 vLQ53yoAHFCV5wnKiWFFkrQ6cbCSsPY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-FHI_6IF0P1mzULyU-iCM6w-1; Thu, 26 Nov 2020 08:46:55 -0500
X-MC-Unique: FHI_6IF0P1mzULyU-iCM6w-1
Received: by mail-wm1-f72.google.com with SMTP id y26so1229062wmj.7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 05:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4fux52JZVbYIP0imVmVjqUi5Uo7xuob2S06QEGrh7kY=;
 b=nMFuXPneJKfON6FyizoqGodui4ANbPG80sAH5P62mpe5slvJiDhGuDX6f4LjO+4PqW
 woY6EgBb1vhDKYH6Op/DnpOLXu0wpcAIruyzcGM5xln3jDNF94tk1BZaK6Wo3MzHMiLl
 3tK949VBpRTHWnL84CFSb6D1abGXY5C31bJ/4sKXCkSWyMQRT9Mx0ZAaZLTslrSEE3R2
 kneOf9NeVPi56quwp7FkdKnmV7laA+fa8gU3b7jgxmBY0S/4POjqFRs5sIm2w4Anij0U
 nx/wzn3uv+wSc3VozP31ay6yOFpE6GNs80+Qi53gxR2Z8XuLiZQexQMJIgpT+4QPGtqc
 zGnQ==
X-Gm-Message-State: AOAM531XAjgjD3vz6PC8EgwEmHF+hQEJMlkkxzJd4tSH44+CxML7IB8l
 Emp3thGbtIKNBacmDnbRkcq6fMDjMi01E85OhXIu9Nd7S2pyj51nkkS9YCe51fGMVYijoOrgLw8
 UP1uLH9t/cAYrpHd05soCN70/nGmZ3TyapPHkLbRXtw==
X-Received: by 2002:adf:e681:: with SMTP id r1mr4144385wrm.348.1606398413850; 
 Thu, 26 Nov 2020 05:46:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxw+3CWLYRpcTsMY8NIsQON707J+gRNov1rZzUPVVJNEemKGfl92Fkv/opMwC56b2e3kVnVBg==
X-Received: by 2002:adf:e681:: with SMTP id r1mr4144365wrm.348.1606398413606; 
 Thu, 26 Nov 2020 05:46:53 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id w17sm9051203wru.82.2020.11.26.05.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:46:52 -0800 (PST)
Date: Thu, 26 Nov 2020 08:46:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 01/14] virtio-pci: do not access iomem via
 virtio_pci_device directly
Message-ID: <20201126084436-mutt-send-email-mst@kernel.org>
References: <20201126092604.208033-1-jasowang@redhat.com>
 <20201126092604.208033-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201126092604.208033-2-jasowang@redhat.com>
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

On Thu, Nov 26, 2020 at 05:25:51PM +0800, Jason Wang wrote:
> Instead of accessing iomem via virito_pci_device directly. Add an
> indirect level

well this patch does not add any indirection it's just refactoring.
which is ok of course let's just say it as is.

> to ease the life of splitting out modern virito-pci

typo

> logic.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 76 ++++++++++++++++++------------
>  1 file changed, 46 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 3d6ae5a5e252..df1481fd400c 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -141,12 +141,13 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
>  static u64 vp_get_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
>  	u64 features;
>  
> -	vp_iowrite32(0, &vp_dev->common->device_feature_select);
> -	features = vp_ioread32(&vp_dev->common->device_feature);
> -	vp_iowrite32(1, &vp_dev->common->device_feature_select);
> -	features |= ((u64)vp_ioread32(&vp_dev->common->device_feature) << 32);
> +	vp_iowrite32(0, &cfg->device_feature_select);
> +	features = vp_ioread32(&cfg->device_feature);
> +	vp_iowrite32(1, &cfg->device_feature_select);
> +	features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
>  
>  	return features;
>  }
> @@ -165,6 +166,7 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>  static int vp_finalize_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
>  	u64 features = vdev->features;
>  
>  	/* Give virtio_ring a chance to accept features. */
> @@ -179,10 +181,10 @@ static int vp_finalize_features(struct virtio_device *vdev)
>  		return -EINVAL;
>  	}
>  
> -	vp_iowrite32(0, &vp_dev->common->guest_feature_select);
> -	vp_iowrite32((u32)vdev->features, &vp_dev->common->guest_feature);
> -	vp_iowrite32(1, &vp_dev->common->guest_feature_select);
> -	vp_iowrite32(vdev->features >> 32, &vp_dev->common->guest_feature);
> +	vp_iowrite32(0, &cfg->guest_feature_select);
> +	vp_iowrite32((u32)vdev->features, &cfg->guest_feature);
> +	vp_iowrite32(1, &cfg->guest_feature_select);
> +	vp_iowrite32(vdev->features >> 32, &cfg->guest_feature);
>  
>  	return 0;
>  }
> @@ -192,6 +194,7 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
>  		   void *buf, unsigned len)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	void __iomem *device = vp_dev->device;
>  	u8 b;
>  	__le16 w;
>  	__le32 l;
> @@ -200,21 +203,21 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
>  
>  	switch (len) {
>  	case 1:
> -		b = ioread8(vp_dev->device + offset);
> +		b = ioread8(device + offset);
>  		memcpy(buf, &b, sizeof b);
>  		break;
>  	case 2:
> -		w = cpu_to_le16(ioread16(vp_dev->device + offset));
> +		w = cpu_to_le16(ioread16(device + offset));
>  		memcpy(buf, &w, sizeof w);
>  		break;
>  	case 4:
> -		l = cpu_to_le32(ioread32(vp_dev->device + offset));
> +		l = cpu_to_le32(ioread32(device + offset));
>  		memcpy(buf, &l, sizeof l);
>  		break;
>  	case 8:
> -		l = cpu_to_le32(ioread32(vp_dev->device + offset));
> +		l = cpu_to_le32(ioread32(device + offset));
>  		memcpy(buf, &l, sizeof l);
> -		l = cpu_to_le32(ioread32(vp_dev->device + offset + sizeof l));
> +		l = cpu_to_le32(ioread32(device + offset + sizeof l));
>  		memcpy(buf + sizeof l, &l, sizeof l);
>  		break;
>  	default:
> @@ -228,6 +231,7 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>  		   const void *buf, unsigned len)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	void __iomem *device = vp_dev->device;
>  	u8 b;
>  	__le16 w;
>  	__le32 l;
> @@ -237,21 +241,21 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>  	switch (len) {
>  	case 1:
>  		memcpy(&b, buf, sizeof b);
> -		iowrite8(b, vp_dev->device + offset);
> +		iowrite8(b, device + offset);
>  		break;
>  	case 2:
>  		memcpy(&w, buf, sizeof w);
> -		iowrite16(le16_to_cpu(w), vp_dev->device + offset);
> +		iowrite16(le16_to_cpu(w), device + offset);
>  		break;
>  	case 4:
>  		memcpy(&l, buf, sizeof l);
> -		iowrite32(le32_to_cpu(l), vp_dev->device + offset);
> +		iowrite32(le32_to_cpu(l), device + offset);
>  		break;
>  	case 8:
>  		memcpy(&l, buf, sizeof l);
> -		iowrite32(le32_to_cpu(l), vp_dev->device + offset);
> +		iowrite32(le32_to_cpu(l), device + offset);
>  		memcpy(&l, buf + sizeof l, sizeof l);
> -		iowrite32(le32_to_cpu(l), vp_dev->device + offset + sizeof l);
> +		iowrite32(le32_to_cpu(l), device + offset + sizeof l);
>  		break;
>  	default:
>  		BUG();
> @@ -261,35 +265,43 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
>  static u32 vp_generation(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	return vp_ioread8(&vp_dev->common->config_generation);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
> +
> +	return vp_ioread8(&cfg->config_generation);
>  }
>  
>  /* config->{get,set}_status() implementations */
>  static u8 vp_get_status(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> -	return vp_ioread8(&vp_dev->common->device_status);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
> +
> +	return vp_ioread8(&cfg->device_status);
>  }
>  
>  static void vp_set_status(struct virtio_device *vdev, u8 status)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
> +
>  	/* We should never be setting status to 0. */
>  	BUG_ON(status == 0);
> -	vp_iowrite8(status, &vp_dev->common->device_status);
> +	vp_iowrite8(status, &cfg->device_status);
>  }
>  
>  static void vp_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
> +
>  	/* 0 status means a reset. */
> -	vp_iowrite8(0, &vp_dev->common->device_status);
> +	vp_iowrite8(0, &cfg->device_status);
>  	/* After writing 0 to device_status, the driver MUST wait for a read of
>  	 * device_status to return 0 before reinitializing the device.
>  	 * This will flush out the status write, and flush in device writes,
>  	 * including MSI-X interrupts, if any.
>  	 */
> -	while (vp_ioread8(&vp_dev->common->device_status))
> +	while (vp_ioread8(&cfg->device_status))
>  		msleep(1);
>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
> @@ -297,11 +309,13 @@ static void vp_reset(struct virtio_device *vdev)
>  
>  static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
>  {
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
> +
>  	/* Setup the vector used for configuration events */
> -	vp_iowrite16(vector, &vp_dev->common->msix_config);
> +	vp_iowrite16(vector, &cfg->msix_config);
>  	/* Verify we had enough resources to assign the vector */
>  	/* Will also flush the write out to device */
> -	return vp_ioread16(&vp_dev->common->msix_config);
> +	return vp_ioread16(&cfg->msix_config);
>  }
>  
>  static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> @@ -407,6 +421,7 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  			      struct irq_affinity *desc)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
>  	struct virtqueue *vq;
>  	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, ctx, desc);
>  
> @@ -417,8 +432,8 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>  	 * this, there's no way to go back except reset.
>  	 */
>  	list_for_each_entry(vq, &vdev->vqs, list) {
> -		vp_iowrite16(vq->index, &vp_dev->common->queue_select);
> -		vp_iowrite16(1, &vp_dev->common->queue_enable);
> +		vp_iowrite16(vq->index, &cfg->queue_select);
> +		vp_iowrite16(1, &cfg->queue_enable);
>  	}
>  
>  	return 0;
> @@ -428,14 +443,15 @@ static void del_vq(struct virtio_pci_vq_info *info)
>  {
>  	struct virtqueue *vq = info->vq;
>  	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
>  
> -	vp_iowrite16(vq->index, &vp_dev->common->queue_select);
> +	vp_iowrite16(vq->index, &cfg->queue_select);
>  
>  	if (vp_dev->msix_enabled) {
>  		vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
> -			     &vp_dev->common->queue_msix_vector);
> +			     &cfg->queue_msix_vector);
>  		/* Flush the write out to device */
> -		vp_ioread16(&vp_dev->common->queue_msix_vector);
> +		vp_ioread16(&cfg->queue_msix_vector);
>  	}
>  
>  	if (!vp_dev->notify_base)
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
