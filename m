Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40A4C7EE22
	for <virtualization@archiver.kernel.org>; Wed, 10 May 2023 03:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8931260D9D;
	Wed, 10 May 2023 03:40:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8931260D9D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EVoevbxc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WUelVK2qYPyK; Wed, 10 May 2023 03:40:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C40AA60AF2;
	Wed, 10 May 2023 03:40:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C40AA60AF2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EC4FC0036;
	Wed, 10 May 2023 03:40:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63F88C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30E1560C04
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:40:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30E1560C04
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vpmIA6-AgW74
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:40:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BA5260AF2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BA5260AF2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 May 2023 03:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683690001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ilszrs00TODsaAhkjjmVgACd8lBO14dcaz8No+ER70=;
 b=EVoevbxceq6Qz3rGYBYF6tcJypjrAkCWJwpTFy6Sf27SiNbVrg0ofd8cQGXm9WhSiGZOte
 okF0R9hNP25r+bna7hy8DdTA9MLm2tYgbOK03HHEhe3oRguDZCCnCXLWdIarAzwDtw/ge1
 3ADD0yPTPOPSRt9KLneKQS15gZvmwx4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-vgd3P2rfNmewC2sPki13Vw-1; Tue, 09 May 2023 23:39:59 -0400
X-MC-Unique: vgd3P2rfNmewC2sPki13Vw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-50bc88edf7eso6306996a12.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 May 2023 20:39:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683689998; x=1686281998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ilszrs00TODsaAhkjjmVgACd8lBO14dcaz8No+ER70=;
 b=FLONRhijBrwZSmRuG2wdO6djdEvyHQMljLBMF51iuPylGeJuo7ktO9/6Frf/hw4m2C
 3wowKkLtMg8S350HPJNXTmnNKftxw7Ai1f+J7o9znNOgtz4MEqHPdfkSiJiN5iCY4gtD
 QUYmMgmIl2yidJAF6VJGhMUBRvgv2xaRjJJ5Icy7z8lGL5yDoksJFC+T1H4qr4wjJl+/
 GBFLADv6XShFZLdgtaurcLpCOZabJQ16UHBpZYnSEys3qOadP5jPqsl3KJYQVqrAswlr
 SkrBHHrJzojL0z9fj8GHXGpoWKW6XFKbCcgW5Bj/1+naesKd7VD8E/wiGdI4jKHJUY3h
 Dzlg==
X-Gm-Message-State: AC+VfDy4tqOcfYH1Z0Jl4LaTsHeSxVIqu+x6N69EVmhKi5tl71Cpq6wt
 f0qp/QGm9zMrdgt9hOT+21tue+YH2blNAx5giRt+kfaMxTMR/1uMuRtfIWxsF+yeO5PEbJT2NyD
 7eeBspH9gEmNe6xnupHl/cMTSAen6p8+iLMO7+7Na8g==
X-Received: by 2002:a17:907:2d1f:b0:968:db2f:383 with SMTP id
 gs31-20020a1709072d1f00b00968db2f0383mr7058382ejc.53.1683689998604; 
 Tue, 09 May 2023 20:39:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6e4C3/BG6wV/XTr+xIJQUwTiA+N8VWNnD508NvKQeOAB5vhL+ur2ZiXI2EQ+4DxWmFekJGWw==
X-Received: by 2002:a17:907:2d1f:b0:968:db2f:383 with SMTP id
 gs31-20020a1709072d1f00b00968db2f0383mr7058374ejc.53.1683689998334; 
 Tue, 09 May 2023 20:39:58 -0700 (PDT)
Received: from redhat.com ([176.119.195.36]) by smtp.gmail.com with ESMTPSA id
 jx27-20020a170907761b00b0094a82a236cbsm2090991ejc.129.2023.05.09.20.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 May 2023 20:39:57 -0700 (PDT)
Date: Tue, 9 May 2023 23:39:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Message-ID: <20230509233929-mutt-send-email-mst@kernel.org>
References: <20230510025437.377807-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20230510025437.377807-1-pizhenwei@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, Joerg Roedel <jroedel@suse.de>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Wed, May 10, 2023 at 10:54:37AM +0800, zhenwei pi wrote:
> Both split ring and packed ring use 32bits to describe the length of
> a descriptor: see struct vring_desc and struct vring_packed_desc.
> This means the max segment size supported by virtio is U32_MAX.
> 
> An example of virtio_max_dma_size in virtio_blk.c:
>   u32 v, max_size;
> 
>   max_size = virtio_max_dma_size(vdev);  -> implicit convert
>   err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SIZE_MAX,
>                              struct virtio_blk_config, size_max, &v);
>   max_size = min(max_size, v);
> 
> There is a risk during implicit convert here, once virtio_max_dma_size
> returns 4G, max_size becomes 0.
> 
> Fixes: e6d6dd6c875e ("virtio: Introduce virtio_max_dma_size()")
> Cc: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>


is this a theoretical concern or do you manage to trigger this
somehow?

> ---
>  drivers/virtio/virtio_ring.c | 12 ++++++++----
>  include/linux/virtio.h       |  2 +-
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c5310eaf8b46..55cfecf030a1 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -289,12 +289,16 @@ static bool vring_use_dma_api(const struct virtio_device *vdev)
>  	return false;
>  }
>  
> -size_t virtio_max_dma_size(const struct virtio_device *vdev)
> +u32 virtio_max_dma_size(const struct virtio_device *vdev)
>  {
> -	size_t max_segment_size = SIZE_MAX;
> +	u32 max_segment_size = U32_MAX;
>  
> -	if (vring_use_dma_api(vdev))
> -		max_segment_size = dma_max_mapping_size(vdev->dev.parent);
> +	if (vring_use_dma_api(vdev)) {
> +		size_t max_dma_size = dma_max_mapping_size(vdev->dev.parent);
> +
> +		if (max_dma_size < max_segment_size)
> +			max_segment_size = max_dma_size;
> +	}
>  
>  	return max_segment_size;
>  }
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b93238db94e3..1a605f408329 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -147,7 +147,7 @@ int virtio_device_restore(struct virtio_device *dev);
>  #endif
>  void virtio_reset_device(struct virtio_device *dev);
>  
> -size_t virtio_max_dma_size(const struct virtio_device *vdev);
> +u32 virtio_max_dma_size(const struct virtio_device *vdev);
>  
>  #define virtio_device_for_each_vq(vdev, vq) \
>  	list_for_each_entry(vq, &vdev->vqs, list)
> -- 
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
