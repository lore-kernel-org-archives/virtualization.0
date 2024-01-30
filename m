Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495206A027
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613377; cv=none; b=Y8BNKczymTnjSwhJFSqqe4SS2tptJoxI8roquNDTkUYqmPbv/pvos8vEavm2l2nio6wIWzNg3AqnHZ+STMrQHcf4tpILnfgYzHiDSaDOkZdVy924/0ky4UtnW022Fm+p/M/3FQIv5Uul6a5O235yDBBQ9D+WjdC8/zvZSGZb1qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613377; c=relaxed/simple;
	bh=ehXXPYkjs9fcwAJSYgnOWnp6d6xWZAbB9yb4YVaNJ+c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaMSWL4rBDbGM0KGDa8/AORBtDwW11V37nQ9hN4mL8jr3UKjKQWuju2zhbwApEMbDZE6LsFoSdyUDMLQ9KJwJADi0mllIJTH6JA1q9sVjELjDirjo60Z8Z0mY3floQGhAUhkUSiHTe2VXbGJHqq5es9a7XYRRhs4wzKclgnq2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=jbX6EVvq; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="jbX6EVvq"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B7EBF4059B
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 11:16:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B7EBF4059B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=jbX6EVvq
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.998
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xxWhis5QoQO6
	for <virtualization@lists.linux-foundation.org>;
	Tue, 30 Jan 2024 11:16:14 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 156F4402D7
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 11:16:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 156F4402D7
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-55f3e2ef98bso116547a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 03:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706613372; x=1707218172; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C2FZft6FauqTz4a6mgFsXH5fOXhbWwAcsXYixHIZpik=;
        b=jbX6EVvqgZoOt7NYWOIdIH0ubC1+zSqsg9O0zPeJlKAOekSaCAcJqywHQRe8Wybl6m
         bjHBj3kgifMcfHlzb5FmS8r1fCHGlydS9hFvCL3/H33GU0weOP+HmY0w9f9flbIUTwGM
         3WMRS+fhR+eL6JRUm5FKffcy/ktwdHYmvHwaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613372; x=1707218172;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2FZft6FauqTz4a6mgFsXH5fOXhbWwAcsXYixHIZpik=;
        b=pG2CLL5yijBg3ASZE5poUNDbSfw0nS0YQMxhEYNptNEV+jeW2LeI0zno924wiVjUMd
         mewEu83azKuDxxogyBFiYgupSZ/Un9GhltSlo1CByiucaFGKph7777U4JGNLYDnhW+Pe
         v8ZvIR68ZpA970OSTz45h6fMbwmukkIidAHkySjkgdwRqmhYw96SXK1zB+INYqyyApKN
         KF22Kl79oX+Zq4fLvJd2VbO0yGtPzw6hXDMRPGWS+bjvaqDTYHfyWeeRMqqBsv251f+9
         SGNF0Fjk8ZqywMrE0Nmqk1JAjhB6iRxTlk0aluqLd/1Yilg9qaGIxzcMsJi1xkYsoNfB
         UeNQ==
X-Forwarded-Encrypted: i=0; AJvYcCX/cP5iZXlX1qH+YbV297wZX+uKQStFOFXvTWrzOEJmvJ32LPcJI1J+rpXf34yogAjR+lG/K6wXYrsWWen8LptJwX/IA4jlnwp9GadaaicJXaRZJOmtKzrCRA==
X-Gm-Message-State: AOJu0YxH7WoZXnPNjFbj3W92Zha0RC+Xpd7xik+62BDSvIrfOcyfLctn
	lxJ6v0LXHGdd1NbxI/5nEHCRfVlq7i6GWHaXfb7Ur7aXNLL/TMpcVUXnX17VuNI=
X-Google-Smtp-Source: AGHT+IEMT3X2zvsc4bSoskcD1Q4j1mTrHeLOlnPktNoR8kFYS32umfRbdXFTr6eXS49OA5C1n9722A==
X-Received: by 2002:a05:6402:3106:b0:55e:ff4e:70ad with SMTP id dc6-20020a056402310600b0055eff4e70admr3164992edb.0.1706613372045;
        Tue, 30 Jan 2024 03:16:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7db97000000b00558a3e892b3sm4797173edt.41.2024.01.30.03.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:16:11 -0800 (PST)
Date: Tue, 30 Jan 2024 12:16:09 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Julia Zhang <julia.zhang@amd.com>,
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
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>,
	David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v2 1/1] drm/virtio: Implement device_attach
Message-ID: <ZbjaebswTCxmlwu0@phenom.ffwll.local>
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
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>,
	David Stevens <stevensd@chromium.org>
References: <20240129103118.3258781-1-julia.zhang@amd.com>
 <ZbjZJ3qQzdOksnb2@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbjZJ3qQzdOksnb2@phenom.ffwll.local>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Jan 30, 2024 at 12:10:31PM +0100, Daniel Vetter wrote:
> On Mon, Jan 29, 2024 at 06:31:19PM +0800, Julia Zhang wrote:
> > As vram objects don't have backing pages and thus can't implement
> > drm_gem_object_funcs.get_sg_table callback. This removes drm dma-buf
> > callbacks in virtgpu_gem_map_dma_buf()/virtgpu_gem_unmap_dma_buf()
> > and implement virtgpu specific map/unmap/attach callbacks to support
> > both of shmem objects and vram objects.
> > 
> > Signed-off-by: Julia Zhang <julia.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_prime.c | 40 +++++++++++++++++++++++---
> >  1 file changed, 36 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > index 44425f20d91a..b490a5343b06 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > @@ -49,11 +49,26 @@ virtgpu_gem_map_dma_buf(struct dma_buf_attachment *attach,
> >  {
> >  	struct drm_gem_object *obj = attach->dmabuf->priv;
> >  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> > +	struct sg_table *sgt;
> > +	int ret;
> >  
> >  	if (virtio_gpu_is_vram(bo))
> >  		return virtio_gpu_vram_map_dma_buf(bo, attach->dev, dir);
> >  
> > -	return drm_gem_map_dma_buf(attach, dir);
> > +	sgt = drm_prime_pages_to_sg(obj->dev,
> > +				    to_drm_gem_shmem_obj(obj)->pages,
> > +				    obj->size >> PAGE_SHIFT);
> > +	if (IS_ERR(sgt))
> > +		return sgt;
> > +
> > +	ret = dma_map_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
> > +	if (ret) {
> > +		sg_free_table(sgt);
> > +		kfree(sgt);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> > +	return sgt;
> >  }
> >  
> >  static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> > @@ -63,12 +78,29 @@ static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> >  	struct drm_gem_object *obj = attach->dmabuf->priv;
> >  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> >  
> > +	if (!sgt)
> > +		return;
> > +
> >  	if (virtio_gpu_is_vram(bo)) {
> >  		virtio_gpu_vram_unmap_dma_buf(attach->dev, sgt, dir);
> > -		return;
> > +	} else {
> > +		dma_unmap_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
> > +		sg_free_table(sgt);
> > +		kfree(sgt);
> >  	}
> > +}
> > +
> > +static int virtgpu_gem_device_attach(struct dma_buf *dma_buf,
> > +				     struct dma_buf_attachment *attach)
> > +{
> > +	struct drm_gem_object *obj = attach->dmabuf->priv;
> > +	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> > +	int ret = 0;
> > +
> > +	if (!virtio_gpu_is_vram(bo) && obj->funcs->pin)
> > +		ret = obj->funcs->pin(obj);
> >  
> > -	drm_gem_unmap_dma_buf(attach, sgt, dir);
> > +	return ret;
> 
> This doesn't look like what I've expected. There should be no need to
> change the map/unmap functions, especially not for the usual gem bo case.
> We should definitely keep using the exact same code for that. Instead all
> I expected is roughly
> 
> virtgpu_gem_device_attach()
> {
> 	if (virtio_gpu_is_vram(bo)) {
> 		if (can_access_virtio_vram_directly(attach->dev)
> 			return 0;
> 		else
> 			return -EBUSY;
> 	} else {
> 		return drm_gem_map_attach();
> 	}
> }
> 
> Note that I think can_access_virtio_vram_directly() needs to be
> implemented first. I'm not even sure it's possible, might be that all the
> importers need to set the attachment->peer2peer flag. Which is why this
> thing exists really. But that's a pile more work to do.
> 
> Frankly the more I look at the original patch that added vram export
> support the more this just looks like a "pls revert, this is just too
> broken".

The commit I mean is this one: ea5ea3d8a117 ("drm/virtio: support mapping
exported vram"). The commit message definitely needs to cite that one, and
also needs a cc: stable because not rejecting invalid imports is a pretty
big deal.

Also adding David.
-Sima

> 
> We should definitely not open-code any functions for the gem_bo export
> case, which your patch seems to do? Or maybe I'm just extremely confused.
> -Sima
> 
> >  
> >  static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
> > @@ -83,7 +115,7 @@ static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
> >  		.vmap = drm_gem_dmabuf_vmap,
> >  		.vunmap = drm_gem_dmabuf_vunmap,
> >  	},
> > -	.device_attach = drm_gem_map_attach,
> > +	.device_attach = virtgpu_gem_device_attach,
> >  	.get_uuid = virtgpu_virtio_get_uuid,
> >  };
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
