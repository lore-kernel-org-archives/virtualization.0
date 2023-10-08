Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57E72E95A82
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 10:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C48FB417A9;
	Sun,  8 Oct 2023 10:43:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C48FB417A9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1Csjf6P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c9T4AjGBouHe; Sun,  8 Oct 2023 10:43:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DAB96417B6;
	Sun,  8 Oct 2023 10:42:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DAB96417B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD665C0039;
	Sun,  8 Oct 2023 10:42:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E454C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 10:42:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 65C41401CC
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 10:42:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 65C41401CC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=a1Csjf6P
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DjSyOxpyfFKP
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 10:42:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F76F40199
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 10:42:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F76F40199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696761774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YeFnBygXDkeQ+o9CkyTf5kFBskj2LZ9+3dJaj3enCUM=;
 b=a1Csjf6PfJZ/ipzvnZB5ZBp3v216xuiT6c7cSmTlgGKvwlVGqYnUIlgceEb7xSgMBu4rmp
 nAc85vBQqaeTvausmEprINjxQDX4up2EYxcGEL49d2eVRHL/N4kSnRBmc6vypDVKBt+Myn
 1pIDm2jMswDEw0ejoXhpnwMxLMkebIo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-JnsWFEFaN-WcyrhGTF-sBQ-1; Sun, 08 Oct 2023 06:42:42 -0400
X-MC-Unique: JnsWFEFaN-WcyrhGTF-sBQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a62adedadbso37524566b.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 08 Oct 2023 03:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696761761; x=1697366561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeFnBygXDkeQ+o9CkyTf5kFBskj2LZ9+3dJaj3enCUM=;
 b=VtQJcILHZt+WL0uThMhwfdYMI1ybbRYk8U/LV0zucXwuFedRO/AXcmGKQtQHkG0FBG
 0vIJ+Z8mcsesu6kP/sm2WuwQ2RTnHJjkx9jmpnOVwp9SooWESD4gGZowAX6aX8Wac3rb
 PVK9Phv9x1+6u7QOa0yYJZii0+PcPxPD4kucWhqvhfWREtTbnzP1sgItDvIz7z7aqXI1
 ZN1ILTuSLD27gvHnkzXC1JRTx9gHRBnVBwgSjUhBN7DBJO0nDQS9SULx2FwhN2BpUJWS
 2WY0EF0g3UGFF1IsysRyV8zVf4xsD5Fbvuo6JsQ6cjIQ0DS/CNF7Atp8ArzaRkMY1lKE
 zF/g==
X-Gm-Message-State: AOJu0YwtGv+UC/hQMvOukkiUDs+Xf51drhVlE4zYRLZZfTMW0QnVfCiL
 5+n2JFQTIJ80zr63UzC7ioBNv+sr+mUDtkPQ+cljYk+K6oILoTqr1lJfWbD98iOAg17Q1nAyUez
 xBuaEfdEkjOSbAkUqjpkEiilJJHje2sJ8kT0n9xs04w==
X-Received: by 2002:a17:906:4e:b0:9a2:16e2:353 with SMTP id
 14-20020a170906004e00b009a216e20353mr11974708ejg.6.1696761761603; 
 Sun, 08 Oct 2023 03:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMcJsNUEPLS884sHWM2/c4zBwTl5RPvEh8ZBYQd4P5IdQz3YKf2EgDnIcaiTVFtbEvtNxgqQ==
X-Received: by 2002:a17:906:4e:b0:9a2:16e2:353 with SMTP id
 14-20020a170906004e00b009a216e20353mr11974699ejg.6.1696761761300; 
 Sun, 08 Oct 2023 03:42:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 p26-20020a1709060dda00b0098921e1b064sm5378988eji.181.2023.10.08.03.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 03:42:40 -0700 (PDT)
Date: Sun, 8 Oct 2023 06:42:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v2 1/2] virtio_pci: fix the common map size and add
 check for common size
Message-ID: <20231008063339-mutt-send-email-mst@kernel.org>
References: <20231008093842.87131-1-xuanzhuo@linux.alibaba.com>
 <20231008093842.87131-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20231008093842.87131-2-xuanzhuo@linux.alibaba.com>
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

On Sun, Oct 08, 2023 at 05:38:41PM +0800, Xuan Zhuo wrote:
> Now, the function vp_modern_map_capability() takes the size parameter,
> which corresponds to the size of virtio_pci_common_cfg. As a result,
> this indicates the size of memory area to map.
> 
> However, if the _F_RING_RESET is negotiated, the extra items will be
> used. Therefore, we need to use the size of virtio_pci_modern_common_cfg
> to map more space.
> 
> Meanwhile, this patch removes the feature(_F_RING_ERSET and

typo

> _F_NOTIFICATION_DATA) when the common cfg size does not match
> the corresponding feature.
> 
> Fixes: 0b50cece0b78 ("virtio_pci: introduce helper to get/set queue reset")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_pci_modern.c     | 20 +++++++++++++++++++-
>  drivers/virtio/virtio_pci_modern_dev.c |  4 ++--
>  include/linux/virtio_pci_modern.h      |  1 +
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index d6bb68ba84e5..c0b9d2363ddb 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -22,8 +22,26 @@
>  static u64 vp_get_features(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	u64 features = vp_modern_get_features(&vp_dev->mdev);
> +
> +#define check_feature(feature, field)								\
> +	do {											\
> +		if (features & BIT_ULL(feature)) {						\
> +			u32 offset = offsetofend(struct virtio_pci_modern_common_cfg, field);	\
> +			if (unlikely(vp_dev->mdev.common_len < offset))				\
> +				features &= ~BIT_ULL(feature);					\
> +		}										\
> +	} while (0)
> +
> +	/* For buggy devices, if the common len does not match the feature, we
> +	 * remove the feature.

I don't like doing this in vp_get_features. userspace won't be able
to see the actual device features at all.
Also, we should print an info message at least.

I am still debating with myself whether clearing feature bits
or just failing finalize_features (and thus, probe) is best.


> +	 */
> +	check_feature(VIRTIO_F_NOTIFICATION_DATA, queue_notify_data);
> +	check_feature(VIRTIO_F_RING_RESET, queue_reset);
> +
> +#undef check_feature

this macro's too scary. just pass offset and feature bit as
parameters to an inline function.

>  
> -	return vp_modern_get_features(&vp_dev->mdev);
> +	return features;
>  }
>  
>  static void vp_transport_features(struct virtio_device *vdev, u64 features)
> diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> index aad7d9296e77..33f319da1558 100644
> --- a/drivers/virtio/virtio_pci_modern_dev.c
> +++ b/drivers/virtio/virtio_pci_modern_dev.c
> @@ -291,8 +291,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
>  	err = -EINVAL;
>  	mdev->common = vp_modern_map_capability(mdev, common,
>  				      sizeof(struct virtio_pci_common_cfg), 4,
> -				      0, sizeof(struct virtio_pci_common_cfg),
> -				      NULL, NULL);
> +				      0, sizeof(struct virtio_pci_modern_common_cfg),
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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
