Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1B40BE8
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="citIFqB1"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5A3B4014E
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 10:22:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A5A3B4014E
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=citIFqB1
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.098
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YHE7D__TE-8p
	for <virtualization@lists.linux-foundation.org>;
	Wed, 10 Jan 2024 10:22:41 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4B817435DB
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 10:22:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B817435DB
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a28af5d7531so110707966b.1
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Jan 2024 02:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1704882159; x=1705486959; darn=lists.linux-foundation.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vonBdAg0LvaEk2nAqSFMFVmE1JxOhD+qsQeHCGVzxOw=;
        b=citIFqB1N9L+qvn0cSHQjbwTPCYCY/wzi1i3kYqi7eiFqqRJJBdnsvC72eCrtGJwRK
         sk2X7jp7CIScvKgKDE/ieedixCt0fSdvyR8ClYNV+4xCobFqV7Aa9UvwR+zShAw5UlOW
         VZ/PySs78b6D5KAJIQ2vin8KfTETHEl7rc43I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704882159; x=1705486959;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vonBdAg0LvaEk2nAqSFMFVmE1JxOhD+qsQeHCGVzxOw=;
        b=bWFsHkKepMoF2Y7r6+VaI18jSYl0dhN+ALgUuPuntwB+jxwX3uqX3/ofgO4RUOr4C3
         dP2nXdBIn8ZekTr/IGbTcdJVPkTN4uDZB2zPVWCx3JxXzwerz6yVaIUKP2J56htsqCKJ
         pnZmA4kF2bJJI/IkkF2g0ZDm6bmdBN7O6MquGGA18fGf+OVFbxPQqzwTPCg5VtdCNGI8
         J8/4fQvYL41yeIR4TYJLORtbRaNROK++xC8w/iZw8LPX7HBiZltK+HYN6fXS7qSod9p9
         x9PtnUc26Xl8wZhoDKw9/CNm4oFspP9mIl71N5RhYiSbOKi/brUMIHPfijNP0WwEKnyd
         0I+g==
X-Gm-Message-State: AOJu0YwvaOISu3e3kCcGIzvmR8djw65RWjzE4wjlErSWosROsgUdltNB
	TOOZurdrMHUaVBn4y7uSkxoCVefaOeujDA==
X-Google-Smtp-Source: AGHT+IF5Uo918ULQU9RGKMANCVKPSw+ES0zssHEYG5DvBYZMTxDb2s5Y+S7wmbD7j4Hg22z/hjoGrg==
X-Received: by 2002:a17:907:d13:b0:a2b:339:f6b5 with SMTP id gn19-20020a1709070d1300b00a2b0339f6b5mr1541268ejc.1.1704882159309;
        Wed, 10 Jan 2024 02:22:39 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id lg24-20020a170906f89800b00a2811f7ae1esm1944226ejb.21.2024.01.10.02.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 02:22:38 -0800 (PST)
Date: Wed, 10 Jan 2024 11:22:36 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Julia Zhang <julia.zhang@amd.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Honglei Huang <honglei1.huang@amd.com>,
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH 1/1] drm/virtio: Implement device_attach
Message-ID: <ZZ5v7Fm-Iccw7nJR@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Julia Zhang <julia.zhang@amd.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux-foundation.org,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Marek =?utf-8?B?T2zFocOhaw==?= <marek.olsak@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Honglei Huang <honglei1.huang@amd.com>,
	Chen Jiqian <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
References: <20240110095627.227454-1-julia.zhang@amd.com>
 <20240110095627.227454-2-julia.zhang@amd.com>
 <8ce0d90d-c751-4250-8656-fcab27aec6c2@amd.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ce0d90d-c751-4250-8656-fcab27aec6c2@amd.com>
X-Operating-System: Linux phenom 6.5.0-4-amd64 

On Wed, Jan 10, 2024 at 11:19:37AM +0100, Christian König wrote:
> Am 10.01.24 um 10:56 schrieb Julia Zhang:
> > drm_gem_map_attach() requires drm_gem_object_funcs.get_sg_table to be
> > implemented, or else return ENOSYS. Virtio has no get_sg_table
> > implemented for vram object. To fix this, add a new device_attach to
> > call drm_gem_map_attach() for shmem object and return 0 for vram object
> > instead of calling drm_gem_map_attach for both of these two kinds of
> > object.
> 
> Well as far as I can see this is nonsense from the DMA-buf side of things.
> 
> SG tables are always needed as long as you don't re-import the same object
> into your driver and then you shouldn't end up in this function in the first
> place.
> 
> So that drm_gem_map_attach() requires get_sg_table to be implemented is
> intentional and should never be overridden like this.

See my reply, tldr; you're allowed to reject ->attach with -EBUSY to
handle exactly this case of non-shareable buffer types. But definitely
don't silently fail, that's a "we'll oops on map_attachment" kind of bug
:-)
-Sima

> 
> Regards,
> Christian.
> 
> > 
> > Signed-off-by: Julia Zhang <julia.zhang@amd.com>
> > ---
> >   drivers/gpu/drm/virtio/virtgpu_prime.c | 14 +++++++++++++-
> >   1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > index 44425f20d91a..f0b0ff6f3813 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> > @@ -71,6 +71,18 @@ static void virtgpu_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
> >   	drm_gem_unmap_dma_buf(attach, sgt, dir);
> >   }
> > +static int virtgpu_gem_device_attach(struct dma_buf *dma_buf,
> > +				     struct dma_buf_attachment *attach)
> > +{
> > +	struct drm_gem_object *obj = attach->dmabuf->priv;
> > +	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
> > +
> > +	if (virtio_gpu_is_vram(bo))
> > +		return 0;
> > +
> > +	return drm_gem_map_attach(dma_buf, attach);
> > +}
> > +
> >   static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
> >   	.ops = {
> >   		.cache_sgt_mapping = true,
> > @@ -83,7 +95,7 @@ static const struct virtio_dma_buf_ops virtgpu_dmabuf_ops =  {
> >   		.vmap = drm_gem_dmabuf_vmap,
> >   		.vunmap = drm_gem_dmabuf_vunmap,
> >   	},
> > -	.device_attach = drm_gem_map_attach,
> > +	.device_attach = virtgpu_gem_device_attach,
> >   	.get_uuid = virtgpu_virtio_get_uuid,
> >   };
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
