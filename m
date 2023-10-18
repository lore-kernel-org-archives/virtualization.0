Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259E2CDB482
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 20:07:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA01C60E85;
	Wed, 18 Oct 2023 20:07:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA01C60E85
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sl8PANBz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gWYwebf7wD0G; Wed, 18 Oct 2023 20:07:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 946CF60073;
	Wed, 18 Oct 2023 20:07:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 946CF60073
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6AB0FC0071;
	Wed, 18 Oct 2023 20:07:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D101FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 20:07:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E16E405AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 20:07:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E16E405AB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sl8PANBz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KaFBFWtDAC2W
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 20:07:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 42477401D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 20:07:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 42477401D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697659660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9aT1ERw8VigVUwXkOFPx4iGmkmyN/TigbvL1nwAjwj8=;
 b=Sl8PANBzOsS0r9d3yw3TYwrWVNSXKg3BilrIdnxnweuHWOSB27PflpXtZ4h+82h6eq1suA
 lRt/HCuvYk2in7DiR86F4eNIfi6CcoRxTvG29SXzVHD9T6QXmmTbHTVxu4cSLWJIDncZr6
 G6UUTSqtw740WrdRK2RHbP8+L9gOoSc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-z56PFNzvMambw1WI7HwRtQ-1; Wed, 18 Oct 2023 16:07:39 -0400
X-MC-Unique: z56PFNzvMambw1WI7HwRtQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4083a670d25so8309995e9.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 13:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697659658; x=1698264458;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aT1ERw8VigVUwXkOFPx4iGmkmyN/TigbvL1nwAjwj8=;
 b=gWjYI9q+CeD0iXZ03lBuLXO7bNzz3m+H0+xmdX6hhgdd1j+TpBqMhXPGbOHbDxX0PF
 F7Tr1o10aSDPrD60NREPGzjYzapuRSN+DFR6CRgCMR5DivB93DxmbOE9rhE+9TZx1CRW
 MirjBJkZcqn0LbqDbmHgTAcZ2ewqCtYCkzvGGxsOwRYl68HzBxF2vog+Xf8EboCgVWF/
 th5Qp5C5XbWyGShPaKu9YTestEGVMEf3NyLUErjvEsqjV28dRbX3Wyq9xDbVG9mVy6yK
 5cdnFKt7mSL9ekjDC9GwPy+wVrl68i0gR31aqmtMVuvdqmbpV+vDAEcVp++ha0U4uJmk
 Trsw==
X-Gm-Message-State: AOJu0YxTaR5MXGPjGZIxWQDADA9zozAgTpa7fb7YfFZydFAApYJHw1Xv
 RAcCHTRzCWlIGQWmI04tqRIZW8xb8PkdDWLD0VLb8pzWLj1GbU1hMAwqkPj7qd0qRvbcuJlhUH4
 4IoonjmSwRdtF6PBt7u60D4dvRFj0I1iM2RRAwxaH4Q==
X-Received: by 2002:a05:600c:4714:b0:405:3d41:5646 with SMTP id
 v20-20020a05600c471400b004053d415646mr331634wmo.2.1697659658208; 
 Wed, 18 Oct 2023 13:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjUxVbNdMeSbctf9AAxasAcc11k2bFYvaUmwqlwCqKP7b0kpQekoogcJqoT+u3+aAfwjCbVQ==
X-Received: by 2002:a05:600c:4714:b0:405:3d41:5646 with SMTP id
 v20-20020a05600c471400b004053d415646mr331624wmo.2.1697659657870; 
 Wed, 18 Oct 2023 13:07:37 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 o36-20020a05600c512400b00405959469afsm2565199wms.3.2023.10.18.13.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 13:07:37 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:07:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 3/4] virtio_pci: add check for common cfg size
Message-ID: <20231018160549-mutt-send-email-mst@kernel.org>
References: <20231010031120.81272-1-xuanzhuo@linux.alibaba.com>
 <20231010031120.81272-4-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20231010031120.81272-4-xuanzhuo@linux.alibaba.com>
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

On Tue, Oct 10, 2023 at 11:11:19AM +0800, Xuan Zhuo wrote:
> Some buggy devices, the common cfg size may not match the features.
> 
> This patch checks the common cfg size for the
> features(VIRTIO_F_NOTIF_CONFIG_DATA, VIRTIO_F_RING_RESET). When the
> common cfg size does not match the corresponding feature, we fail the
> probe and print error message.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_pci_modern.c     | 36 ++++++++++++++++++++++++++
>  drivers/virtio/virtio_pci_modern_dev.c |  2 +-
>  include/linux/virtio_pci_modern.h      |  1 +
>  3 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index d6bb68ba84e5..6a8f5ff05636 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -39,6 +39,39 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
>  		__virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
>  }
>  
> +static int __vp_check_common_size_one_feature(struct virtio_device *vdev, u32 fbit,
> +					    u32 offset, const char *fname)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +
> +	if (!__virtio_test_bit(vdev, fbit))
> +		return 0;
> +
> +	if (likely(vp_dev->mdev.common_len >= offset))
> +		return 0;
> +
> +	dev_err(&vdev->dev,
> +		"virtio: common cfg size(%ld) does not match the feature %s\n",
> +		vp_dev->mdev.common_len, fname);

You made common_len size_t so printing it with %ld is wrong.
Causes warnings at least on on 32 bit.

> +
> +	return -EINVAL;
> +}
> +
> +#define vp_check_common_size_one_feature(vdev, fbit, field) \
> +	__vp_check_common_size_one_feature(vdev, fbit, \
> +		offsetofend(struct virtio_pci_modern_common_cfg, field), #fbit)
> +
> +static int vp_check_common_size(struct virtio_device *vdev)
> +{
> +	if (vp_check_common_size_one_feature(vdev, VIRTIO_F_NOTIF_CONFIG_DATA, queue_notify_data))
> +		return -EINVAL;
> +
> +	if (vp_check_common_size_one_feature(vdev, VIRTIO_F_RING_RESET, queue_reset))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  /* virtio config->finalize_features() implementation */
>  static int vp_finalize_features(struct virtio_device *vdev)
>  {
> @@ -57,6 +90,9 @@ static int vp_finalize_features(struct virtio_device *vdev)
>  		return -EINVAL;
>  	}
>  
> +	if (vp_check_common_size(vdev))
> +		return -EINVAL;
> +
>  	vp_modern_set_features(&vp_dev->mdev, vdev->features);
>  
>  	return 0;
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index 9cb601e16688..33f319da1558 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -292,7 +292,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  	mdev->common = vp_modern_map_capability(mdev, common,
>  				      sizeof(struct virtio_pci_common_cfg), 4,
>  				      0, sizeof(struct virtio_pci_modern_common_cfg),
> -				      NULL, NULL);
> +				      &mdev->common_len, NULL);
>  	if (!mdev->common)
>  		goto err_map_common;
>  	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
> diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> index 067ac1d789bc..edf62bae0474 100644
> --- a/include/linux/virtio_pci_modern.h
> +++ b/include/linux/virtio_pci_modern.h
> @@ -28,6 +28,7 @@ struct virtio_pci_modern_device {
>  	/* So we can sanity-check accesses. */
>  	size_t notify_len;
>  	size_t device_len;
> +	size_t common_len;
>  
>  	/* Capability for when we need to map notifications per-vq. */
>  	int notify_map_cap;
> -- 
> 2.32.0.3.g01195cf9f


dropped this patch for now until the warning can be fixed.
rest of patchset still in.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
