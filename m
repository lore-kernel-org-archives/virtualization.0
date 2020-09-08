Return-Path: <SRS0=DDSL=CR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BDDC43461
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 09:58:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A5321D7A
	for <virtualization@archiver.kernel.org>; Tue,  8 Sep 2020 09:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b6cEBE6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A5321D7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BAAB687272;
	Tue,  8 Sep 2020 09:58:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KJ21vgVUtrs3; Tue,  8 Sep 2020 09:58:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C3318571C;
	Tue,  8 Sep 2020 09:58:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CC2CC0859;
	Tue,  8 Sep 2020 09:58:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EA14C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4D4858665E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:58:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eG-UFJxxAYdW
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:58:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 46A7486637
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:58:24 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id w1so15394251edr.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Sep 2020 02:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=aLJYrm5bOjZd8IZxBRURG7tcIZly4NiWd1EjKr3Vqfg=;
 b=b6cEBE6njyXvZevcnqFZzEoXBFtDdCvYCkNrDwZNfhuKbJExzPQU7/msU4sYTd9qen
 t7N65xdspMnc5iK2UaZ6awIAJhnUswLYotvlUeI5TKUX2QzHS9UNyOVSGdyB4cwZxZVy
 3sn3/rJhRkWOVW8TWAIcE8fuE9DhfQvgPVt+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=aLJYrm5bOjZd8IZxBRURG7tcIZly4NiWd1EjKr3Vqfg=;
 b=S1gEWef5P1FLDzR9K1CHZvZL679clb6EU4SD0RD5BH73kHNZulR59/0onsawvpMcbF
 C1hVtRN+ec65TA6EKoglrfHIpA+FlrR2L4/6iODVMq38tKCSIzpWP+Qpcg6WNlY/kRYg
 GEYrP0wWkpHmKFTb7/NR++lNwyrAF8c5Gbu8gE2eyYb+1i+u47uU0o+xZSuFYsZ7dw1b
 zoe4+2lQz1Rfw0mKmQRnOOQ5mEqiYWE2KlaI7VMdY0gbz+QVQGuM94JjDeXgdaTW2mWo
 99WsdlOkazbwEgzkO3o5qQbLzqEMEbTNreXyMCk914Y3AVWTWRNaDOv7FIvNV8v8XLVE
 1IRQ==
X-Gm-Message-State: AOAM532Z7ND7tvmhlutkSfK+FIEq9eCKoENvsQpoXY5pvzPOEOgggtI7
 BWs1D9JWoo868PoM1WfNIOKEFH+Wb7KNXjOb
X-Google-Smtp-Source: ABdhPJw/Z7glRjkptNRj0qyVEzDSlDhIfCzudDaFL00qxvdRc+SQk3yofJBPi3m6TSbiWuo2ewZk7w==
X-Received: by 2002:a05:6000:83:: with SMTP id
 m3mr25405078wrx.165.1599555443634; 
 Tue, 08 Sep 2020 01:57:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id i16sm29552687wrq.73.2020.09.08.01.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:57:22 -0700 (PDT)
Date: Tue, 8 Sep 2020 10:57:21 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] drm/virtio: drop quirks handling
Message-ID: <20200908085721.GJ2352366@phenom.ffwll.local>
Mail-Followup-To: Gerd Hoffmann <kraxel@redhat.com>,
 dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20200908064741.1010-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200908064741.1010-1-kraxel@redhat.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
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

On Tue, Sep 08, 2020 at 08:47:41AM +0200, Gerd Hoffmann wrote:
> These days dma ops can be overridden per device, and the virtio core

"can be overridden" or "are"? The comment above vring_use_dma_api()
suggests that's not yet done. If that's wrong then I think updating the
comment would be really good.
-Daniel

> uses that to handle the dma quirks transparently for the rest of the
> kernel.  So we can drop the virtio_has_dma_quirk() checks, just use
> the dma api unconditionally and depend on the virtio core having setup
> dma_ops as needed.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_object.c | 19 ++++++-------------
>  drivers/gpu/drm/virtio/virtgpu_vq.c     | 16 ++++++----------
>  2 files changed, 12 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 729f98ad7c02..9c35ce64ff9e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -141,7 +141,6 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  					struct virtio_gpu_mem_entry **ents,
>  					unsigned int *nents)
>  {
> -	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>  	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>  	struct scatterlist *sg;
>  	int si, ret;
> @@ -162,15 +161,11 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  		return -EINVAL;
>  	}
>  
> -	if (use_dma_api) {
> -		shmem->mapped = dma_map_sg(vgdev->vdev->dev.parent,
> -					   shmem->pages->sgl,
> -					   shmem->pages->nents,
> -					   DMA_TO_DEVICE);
> -		*nents = shmem->mapped;
> -	} else {
> -		*nents = shmem->pages->nents;
> -	}
> +	shmem->mapped = dma_map_sg(vgdev->vdev->dev.parent,
> +				   shmem->pages->sgl,
> +				   shmem->pages->nents,
> +				   DMA_TO_DEVICE);
> +	*nents = shmem->mapped;
>  
>  	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
>  			      GFP_KERNEL);
> @@ -180,9 +175,7 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  	}
>  
>  	for_each_sg(shmem->pages->sgl, sg, *nents, si) {
> -		(*ents)[si].addr = cpu_to_le64(use_dma_api
> -					       ? sg_dma_address(sg)
> -					       : sg_phys(sg));
> +		(*ents)[si].addr = cpu_to_le64(sg_dma_address(sg));
>  		(*ents)[si].length = cpu_to_le32(sg->length);
>  		(*ents)[si].padding = 0;
>  	}
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index c93c2db35aaf..1c1d2834547d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -599,13 +599,11 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>  	struct virtio_gpu_transfer_to_host_2d *cmd_p;
>  	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>  	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>  
> -	if (use_dma_api)
> -		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
> -				       shmem->pages->sgl, shmem->pages->nents,
> -				       DMA_TO_DEVICE);
> +	dma_sync_sg_for_device(vgdev->vdev->dev.parent,
> +			       shmem->pages->sgl, shmem->pages->nents,
> +			       DMA_TO_DEVICE);
>  
>  	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>  	memset(cmd_p, 0, sizeof(*cmd_p));
> @@ -1015,13 +1013,11 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>  	struct virtio_gpu_transfer_host_3d *cmd_p;
>  	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
>  	struct virtio_gpu_object_shmem *shmem = to_virtio_gpu_shmem(bo);
>  
> -	if (use_dma_api)
> -		dma_sync_sg_for_device(vgdev->vdev->dev.parent,
> -				       shmem->pages->sgl, shmem->pages->nents,
> -				       DMA_TO_DEVICE);
> +	dma_sync_sg_for_device(vgdev->vdev->dev.parent,
> +			       shmem->pages->sgl, shmem->pages->nents,
> +			       DMA_TO_DEVICE);
>  
>  	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
>  	memset(cmd_p, 0, sizeof(*cmd_p));
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
