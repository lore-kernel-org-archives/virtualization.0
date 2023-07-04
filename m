Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 076EFEB64D9
	for <virtualization@archiver.kernel.org>; Tue,  4 Jul 2023 06:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 890A240982;
	Tue,  4 Jul 2023 06:21:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 890A240982
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UMw5CZBt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D67mXd0BibCH; Tue,  4 Jul 2023 06:21:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8519E409A4;
	Tue,  4 Jul 2023 06:21:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8519E409A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57637C0072;
	Tue,  4 Jul 2023 06:21:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D34AC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 06:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E6E5181C81
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 06:21:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6E5181C81
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=UMw5CZBt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f_GKr5AOIPWe
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 06:21:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0DC6581C46
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0DC6581C46
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Jul 2023 06:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688451690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t2SmXZgFnQoS+yb8OXdLl/MHZWbEhLAa6pjpmlK+v+w=;
 b=UMw5CZBt2MHsDtG9LzJPAideAgtO0VgENKrvhHakQHb8GSyFt++c7OsMCkSM6wyw2MtAaf
 jfD8p32unNtOwqiGBb61D87rRqTFIt4T/HMz5675pqAFzm85RAY7NTfE2+j4jsxdXBoOzx
 3vkIvvHTzOKB+ynG1t0nCOZ/vzwDAw8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-QUOX53A3MU2OmtnfeGDsKA-1; Tue, 04 Jul 2023 02:21:29 -0400
X-MC-Unique: QUOX53A3MU2OmtnfeGDsKA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fba857914cso2895477e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Jul 2023 23:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688451688; x=1691043688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t2SmXZgFnQoS+yb8OXdLl/MHZWbEhLAa6pjpmlK+v+w=;
 b=bRsCzYjmd9ymQGWOP3EjG2I6LBqqRfgmoP6YoZrc702QN7uoqNQs4H2TyvE5vExRf4
 VAC+6b4RR0XPbiNJd27e2rDsdJCp/Saj8Qu8jeJvGm91BXo9BX9TGu+y1gzxkXvKOiOn
 5uxx/44YrbB5oVUhHx+Cr1Pz0BRmQ38pv02hqk9v1jCvf7S4Y6enXwLSDQ3E01T60dqn
 xUUf342+peORTx4gjDkSNIyBjp53NWAgX+W1Ha7HHeKMak5kkl+X3j9zs8a3DY19Yj00
 5Lt5948Ydx/Ae6naT5ovpwHfTCMxM/uJNU9YxM0CgSg/uOyC0jBWmfA4GOCS/Ah+JY/J
 ZxqA==
X-Gm-Message-State: ABy/qLa5hAAN1CRbtXLtOyqPJ0W3TFz2os83OiaddvRLhrnAGVoOMsS2
 jWMvZtpm84wbzuc9Y69Wb1UAKOucqKbGq+FoFRUydLiiZiDCNpdQ4DQ697vetZd+L5NF6ywKTo6
 ERX0ULeFRU71bbuRYs2mrJzthJMTnhOqmkU+cSyRQdg==
X-Received: by 2002:a05:6512:33cc:b0:4fb:b615:db86 with SMTP id
 d12-20020a05651233cc00b004fbb615db86mr3240705lfg.7.1688451687936; 
 Mon, 03 Jul 2023 23:21:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZbp4Q7VCGaFmAbp91XFT3IMGNINf29kUoORnN3loVxMj1PI0PC3Zl+hj4x6WbClnPSWkp9Q==
X-Received: by 2002:a05:6512:33cc:b0:4fb:b615:db86 with SMTP id
 d12-20020a05651233cc00b004fbb615db86mr3240681lfg.7.1688451687544; 
 Mon, 03 Jul 2023 23:21:27 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 k16-20020a7bc410000000b003fbc9b9699dsm10663856wmi.45.2023.07.03.23.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 23:21:26 -0700 (PDT)
Date: Tue, 4 Jul 2023 02:21:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: zhenwei pi <pizhenwei@bytedance.com>
Subject: Re: [PATCH] virtio_ring: use u32 for virtio_max_dma_size
Message-ID: <20230704020935-mutt-send-email-mst@kernel.org>
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

Took a while for me to get this, it's confusing.  I think the issue is
really in virtio blk, so I would just change max_size there to size_t
and be done with it.




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
