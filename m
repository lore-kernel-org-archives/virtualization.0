Return-Path: <SRS0=6YK7=MJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CDAC6377A
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 20:41:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D4B661182
	for <virtualization@archiver.kernel.org>; Sat, 17 Jul 2021 20:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D4B661182
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB335401B3;
	Sat, 17 Jul 2021 20:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hsv3r5tCrYLl; Sat, 17 Jul 2021 20:41:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F3541400C5;
	Sat, 17 Jul 2021 20:41:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1635C0010;
	Sat, 17 Jul 2021 20:41:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8270AC000E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68EBA607BD
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eKyvgajcwlfb
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:41:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 70B9D6061C
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 20:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626554490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FtGc+IHQ0C+9y0thZVluKFOOTrHiaHYoODtiCUquSJ8=;
 b=XIe0cwBCmizKIk4Pw92jZcvTwpxe2JVDGRo4uDnXra8EIgZTu38l0DU+ia7gJ0xtsaQt/y
 aGeCWrl3hcmxIrOSWes+x06S0f/TY7+PF208dbDXW15lB7GMK1jb7G+xorLq/Ig1JUIzcs
 wZ74oZF9YGfCRO8/RGxlzEMjpJZJ1ms=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-U1fD1u0uM9GbPxaFetXLcg-1; Sat, 17 Jul 2021 16:41:28 -0400
X-MC-Unique: U1fD1u0uM9GbPxaFetXLcg-1
Received: by mail-wr1-f70.google.com with SMTP id
 r11-20020a5d52cb0000b02901309f5e7298so6876582wrv.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Jul 2021 13:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FtGc+IHQ0C+9y0thZVluKFOOTrHiaHYoODtiCUquSJ8=;
 b=egCDgz+WPnPVfM93pk7dgd6X9pBHwP4Ay0w1leYHDRbo8/0PwYI2/GAaBdp1f+H8Ht
 QwrP8WydVA/KIT134B4EaLmuJoOQSWzO0WXPrlz8QFVZXWIG2g/HPJEp0Bu0JMuZHFMU
 L2Ugy5GjNVNDXm8WMro9Q23PhY6NJiczDCYsJNlgORvFbwA7MZsHhYp4IuekSavMIfax
 +oNxpGNBSVMru1Wx8JIVjVYfC787ENR4VKbplX660RF1F5WU+4+ydcaaGjWuiMZTF+wO
 jX/SuwchzTSjtZcmLYPaoqQIqG9y8+2VTp5x3zLXX/PNqOmoKcs4WcvCPe30C2N2Mn5m
 0g2A==
X-Gm-Message-State: AOAM531SmwK+nP1ebwTQ2vmfe8MvlbqbuX2jORTroN7hwMxBTJhw8KnP
 a+ISN52hgfVDsaMKtfgL36ZqdrdJ4kvcqk/W6D4t30WO3lpD8+C1WMVgr5sidEU4cK+HGKyb2OD
 UUPDK9jzI1IfAvgf/GyM1k+/zOGO9YQTdgLluolSWpQ==
X-Received: by 2002:a1c:4384:: with SMTP id
 q126mr18283516wma.115.1626554487287; 
 Sat, 17 Jul 2021 13:41:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqP/LDPxHUMXmZLOf3iYHZ+HEhPNoxx5Db5e1VAnJwxQxCRMCiEBe6bdGT59KLukZzOhy2qw==
X-Received: by 2002:a1c:4384:: with SMTP id
 q126mr18283504wma.115.1626554487124; 
 Sat, 17 Jul 2021 13:41:27 -0700 (PDT)
Received: from redhat.com ([2.55.29.175])
 by smtp.gmail.com with ESMTPSA id z13sm14875912wro.79.2021.07.17.13.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jul 2021 13:41:26 -0700 (PDT)
Date: Sat, 17 Jul 2021 16:41:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 3/4] virtio: Protect vqs list access
Message-ID: <20210717164007-mutt-send-email-mst@kernel.org>
References: <20210717074258.1463313-1-parav@nvidia.com>
 <20210717074258.1463313-4-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210717074258.1463313-4-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Sat, Jul 17, 2021 at 10:42:57AM +0300, Parav Pandit wrote:
> VQs may be accessed to mark the device broken while they are
> created/destroyed. Hence protect the access to the vqs list.
> 
> Fixes: e2dcdfe95c0b ("virtio: virtio_break_device() to mark all virtqueues broken.")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  drivers/virtio/virtio.c      | 1 +
>  drivers/virtio/virtio_ring.c | 8 ++++++++
>  include/linux/virtio.h       | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 4b15c00c0a0a..a0d81e35ec4b 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -355,6 +355,7 @@ int register_virtio_device(struct virtio_device *dev)
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
>  
>  	INIT_LIST_HEAD(&dev->vqs);
> +	rwlock_init(&dev->vqs_list_lock);
>  
>  	/*
>  	 * device_add() causes the bus infrastructure to look for a matching

Let's just use a simple spinlock. I don't think we are worried about
scaling the breaking of devices to multiple CPUs.

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d2e1a7a21171..66a91dec39d9 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1755,7 +1755,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  			cpu_to_le16(vq->packed.event_flags_shadow);
>  	}
>  
> +	write_lock(&vdev->vqs_list_lock);
>  	list_add_tail(&vq->vq.list, &vdev->vqs);
> +	write_unlock(&vdev->vqs_list_lock);
>  	return &vq->vq;
>  
>  err_desc_extra:
> @@ -2229,7 +2231,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	memset(vq->split.desc_state, 0, vring.num *
>  			sizeof(struct vring_desc_state_split));
>  
> +	write_lock(&vdev->vqs_list_lock);
>  	list_add_tail(&vq->vq.list, &vdev->vqs);
> +	write_unlock(&vdev->vqs_list_lock);
>  	return &vq->vq;
>  
>  err_extra:
> @@ -2291,7 +2295,9 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  {
>  	struct vring_virtqueue *vq = to_vvq(_vq);
>  
> +	write_lock(&vq->vq.vdev->vqs_list_lock);
>  	list_del(&_vq->list);
> +	write_unlock(&vq->vq.vdev->vqs_list_lock);
>  
>  	if (vq->we_own_ring) {
>  		if (vq->packed_ring) {
> @@ -2386,12 +2392,14 @@ void virtio_break_device(struct virtio_device *dev)
>  {
>  	struct virtqueue *_vq;
>  
> +	read_lock(&dev->vqs_list_lock);
>  	list_for_each_entry(_vq, &dev->vqs, list) {
>  		struct vring_virtqueue *vq = to_vvq(_vq);
>  
>  		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
>  		smp_store_release(&vq->broken, true);
>  	}
> +	read_unlock(&dev->vqs_list_lock);
>  }
>  EXPORT_SYMBOL_GPL(virtio_break_device);
>  
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b1894e0323fa..1cf77d480ef3 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -115,6 +115,7 @@ struct virtio_device {
>  	const struct virtio_config_ops *config;
>  	const struct vringh_config_ops *vringh_config;
>  	struct list_head vqs;
> +	rwlock_t vqs_list_lock;
>  	u64 features;
>  	void *priv;
>  };
> -- 
> 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
