Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7356773F
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613039; cv=none; b=FUR5p2mlCjBbGe0S37J4JhMTQ1KAHjOUj54plYoLKV4MOQvgXJNqUijWNYXA245ZgX26erC75LfycgCYw/kDxp7MQSTMvX7wKKFnbVKNHqP76s0iBfxVxGRnz4XDVJojfHgtDMlj5ZXlyZBQ54cEu/8v8T+O+7KTqbCzUnEF2os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613039; c=relaxed/simple;
	bh=ScGBYNpHKYkEISElgUEgqulovKJQ0P6q1dAasqJZO4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKNSEpl4IPKxp7andrdBl9gxnzsrJ6qaH3VRMPnY1af19BCRtYnBgbyIU+HVqSRId+T5oelEeybe+qQRYF8Lwpc1Xr55ejJhM7pRWMNFZhguSBpTW74hxqu9bAmE+xw0UoH+GS2HY0uu3iXT8KoHT3p91CS5oXmbB3YZPEOSTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=ib78z5oq; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="ib78z5oq"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A18E861072
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 11:10:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A18E861072
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=ib78z5oq
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.998
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7jRNfRwnTjzB
	for <virtualization@lists.linux-foundation.org>;
	Tue, 30 Jan 2024 11:10:36 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4EF646106F
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 11:10:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4EF646106F
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-55f35ad4d36so202498a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 03:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706613034; x=1707217834; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7bGttRPgttjMO74kPRnHYy9jYBfJV/qrJlhkxWu5S4=;
        b=ib78z5oqFfEymqqTP31Plm50xMJWYLMAuvVDfy/ieiGN37SodUuJzYZrLCeMLZXkOZ
         kF1sXywOA3bOY7Oe/u9cn9/Ss2+Cw16LfYHpVH1JAVT1AMjmPmL7hDonFA9pZXtIEkhU
         sXFSvhQwerEsLra8qaJ8VTOJvCTY0zneMt81w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613034; x=1707217834;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7bGttRPgttjMO74kPRnHYy9jYBfJV/qrJlhkxWu5S4=;
        b=pUahuAlKQLQNx8cdK3o5SHmDtY+uZOIfJEpc7nAwyNenosB5rS92AlYLTpqKDO6mpg
         1IpVEa3LW3Cl7hiYr8/rtIalhWM3WCEPdKyEJIgEI5FzhGaK1432ZhSncd0NT7Tj1uuH
         za/jVON7/BbMGHkeuX54tzksUaUi/eHZW3axBTGsho0XTFls554fFWIcq8YXpPELHREs
         qc62kuZm3CMsdwiJWIXHNy6jBx9god2+mWk6Hp7ZMeWu6HxUenCdlTMx35mGvGH6F9XV
         prBm17l78g1BQCDzJpRWj2dk7UsEFdrWGB+ZcKSgD7/1B2KBKaSIVM573ESwsu22KKwC
         ABzw==
X-Gm-Message-State: AOJu0Ywf7Q8X0MEJ4D2kYiWKi3cSVRTDeO7nf4YIHKrRkhVdHTQu3v59
	A25veSsL9w+WAmzno/b1iz7u/j1gJQrPX/bQ1sZ3R3sG6ZKjAiYD0y+8iqaQ5N0=
X-Google-Smtp-Source: AGHT+IHoMmTcemQDlc/kUpp8/xk6ukVSnUize3vRgDvU1QC1Uw3N+FYTz16SdFAkr796/zLLxsXvOQ==
X-Received: by 2002:a17:906:6d01:b0:a35:561d:cf5a with SMTP id m1-20020a1709066d0100b00a35561dcf5amr5957342ejr.6.1706613034072;
        Tue, 30 Jan 2024 03:10:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906064d00b00a316d360ac3sm4977863ejb.8.2024.01.30.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:10:33 -0800 (PST)
Date: Tue, 30 Jan 2024 12:10:31 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Julia Zhang <julia.zhang@amd.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Honglei Huang <honglei1.huang@amd.com>,
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH v2 1/1] drm/virtio: Implement device_attach
Message-ID: <ZbjZJ3qQzdOksnb2@phenom.ffwll.local>
Mail-Followup-To: Julia Zhang <julia.zhang@amd.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Honglei Huang <honglei1.huang@amd.com>,
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20240129103118.3258781-1-julia.zhang@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129103118.3258781-1-julia.zhang@amd.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Mon, Jan 29, 2024 at 06:31:19PM +0800, Julia Zhang wrote:
> As vram objects don't have backing pages and thus can't implement
> drm_gem_object_funcs.get_sg_table callback. This removes drm dma-buf
> callbacks in virtgpu_gem_map_dma_buf()/virtgpu_gem_unmap_dma_buf()
> and implement virtgpu specific map/unmap/attach callbacks to support
> both of shmem objects and vram objects.
> 
> Signed-off-by: Julia Zhang <julia.zhang@amd.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 40 +++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> index 44425f20d91a..b490a5343b06 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -49,11 +49,26 @@ virtgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
>  {
>  	struct drm_gem_object *obj = attach->dmabuf->priv;
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> +	struct sg_table *sgt;
> +	int ret;
>  
>  	if (virtio_gpu_is_vram(bo))
>  		return virtio_gpu_vram_map_dma_buf(bo, attach->dev, dir);
>  
> -	return drm_gem_map_dma_buf(attach, dir);
> +	sgt = drm_prime_pages_to_sg(obj->dev,
> +				    to_drm_gem_shmem_obj(obj)->pages,
> +				    obj->size >> PAGE_SHIFT);
> +	if (IS_ERR(sgt))
> +		return sgt;
> +
> +	ret = dma_map_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
> +	if (ret) {
> +		sg_free_table(sgt);
> +		kfree(sgt);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return sgt;
>  }
>  
>  static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> @@ -63,12 +78,29 @@ static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
>  	struct drm_gem_object *obj = attach->dmabuf->priv;
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
>  
> +	if (!sgt)
> +		return;
> +
>  	if (virtio_gpu_is_vram(bo)) {
>  		virtio_gpu_vram_unmap_dma_buf(attach->dev, sgt, dir);
> -		return;
> +	} else {
> +		dma_unmap_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
> +		sg_free_table(sgt);
> +		kfree(sgt);
>  	}
> +}
> +
> +static int virtgpu_gem_device_attach(struct dma_buf *dma_buf,
> +				     struct dma_buf_attachment *attach)
> +{
> +	struct drm_gem_object *obj = attach->dmabuf->priv;
> +	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> +	int ret = 0;
> +
> +	if (!virtio_gpu_is_vram(bo) && obj->funcs->pin)
> +		ret = obj->funcs->pin(obj);
>  
> -	drm_gem_unmap_dma_buf(attach, sgt, dir);
> +	return ret;

This doesn't look like what I've expected. There should be no need to
change the map/unmap functions, especially not for the usual gem bo case.
We should definitely keep using the exact same code for that. Instead all
I expected is roughly

virtgpu_gem_device_attach()
{
	if (virtio_gpu_is_vram(bo)) {
		if (can_access_virtio_vram_directly(attach->dev)
			return 0;
		else
			return -EBUSY;
	} else {
		return drm_gem_map_attach();
	}
}

Note that I think can_access_virtio_vram_directly() needs to be
implemented first. I'm not even sure it's possible, might be that all the
importers need to set the attachment->peer2peer flag. Which is why this
thing exists really. But that's a pile more work to do.

Frankly the more I look at the original patch that added vram export
support the more this just looks like a "pls revert, this is just too
broken".

We should definitely not open-code any functions for the gem_bo export
case, which your patch seems to do? Or maybe I'm just extremely confused.
-Sima

>  
>  static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
> @@ -83,7 +115,7 @@ static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
>  		.vmap = drm_gem_dmabuf_vmap,
>  		.vunmap = drm_gem_dmabuf_vunmap,
>  	},
> -	.device_attach = drm_gem_map_attach,
> +	.device_attach = virtgpu_gem_device_attach,
>  	.get_uuid = virtgpu_virtio_get_uuid,
>  };
>  
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
