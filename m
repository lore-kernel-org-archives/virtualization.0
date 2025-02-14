Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B75265CDE
	for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555166; cv=none; b=CGehN7jxU5Tc0sES6cHgqg/S3uB3tzhBHTvw2o5rRE3xELcfabWhIRF3jn+UfYpAitYQjJ88tklUFGhCnnbZ9gpbGekv1o7cz5WBq5MKBu/XciCNMroBIS79Ln9iqDHdQcw9cVNYvccnPorbTR2KSupEwjxOGehED6wDL9F5Duc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555166; c=relaxed/simple;
	bh=VaDaHFXbfympdq/RFMsKB4HK2MmMMXbwWYqSJqqGjVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJE9Jxfcw47gr/SWp0kbWLbA954SfXXxI4SAdjQA2SB/gUWIGwKvlRESOFvC3FCWNMrRjWkinNWzzv36TU9m49fSL/+BAQMSNnTrdrqTkw7EisGNXpy9ccZGO3aXzLsWP7WZNUZONCwyu2OwPZh8TmvmzNHPAWIJbF4CimhbEw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8XUMbud; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8XUMbud"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d0465a8d34so18185685ab.0
        for <virtualization@lists.linux.dev>; Fri, 14 Feb 2025 09:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739555163; x=1740159963; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdHmmXoGeu+JiG7O9/5MQZwbG+iCEqiFjAryJoBKTeE=;
        b=Y8XUMbud81CUfYVclVDvhUJjRBQOe9jXifSC8qFY4KEb1EjUd+Is0/LiKKobYE8Grk
         rhDXCJcoa313WaIhUUPZE/FN5WAeENBy+5UJ5LVyWLeKlk1c2RtEkDf8U2L6PGeMeBTE
         GR3zx/NuqrCE8wLs1OSvtFQphmKtjc0zkJiaXKKPL0weM9SCOaLQi9CXsWDVdnU9I4eW
         gHUFNKnMMersyO1l4bqIzCctthcCPAzSC/ggSCsnVrr5qNM3pOicjMQ6MP6OJCIvnF8S
         9UTk7LHVgPp95cWQtQDJVkkyY9Zya/YW1gXeWKVW4kogRDNHPaO5/yu2cKkgMK4AhdLh
         cnoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555163; x=1740159963;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdHmmXoGeu+JiG7O9/5MQZwbG+iCEqiFjAryJoBKTeE=;
        b=T/b+aVo0iwzRQX4SWS8XlDk+Xzv6ia/0BKsGs1m0bVFfzRNTS6iT/gnabjXovqlk8R
         KHgyazWMT4Af419myPeyRs+pcUHHAk1FoGK5Z6pxDdfAnk6uLDldIZpmUlrL/0i2FiAr
         VveNixTUTo+ZMJWODSW8AsQkqccBJQytjO9E+tuXPkszCLcPpQoiFIqAqCkJOcAWGkFq
         VvvKGCYRbgTousKq3sPy6XMoCRfIPI2zwa4b4PNLaSB5jmtqU/W7FPAnhTnS2bUtGsfE
         5Yfuy3Ruq/DQu2H7H53hTxMi2wmp5Rbeh+Rj+zuV8VWJST8JVOKKOMQLuqOm5aiyCxCp
         FaYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGrt6cJYZmA6aRXCCWZIEcSesdla420NtQyMwnnT/SjGNkwTizBuu6m1KCJBOXnFkogtIZvtGwAfKHLoONUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4YhKm+d/iLSlM9ByrO5klrCfnAT3qhCr0cTyUIhJJDOEfn2H/
	PRUMSR7Cq9Zcp85s9bvdPql9AWLGzCPx8rq3LYSFsWPiuSko+8RsxYzrWNBuKtOgiIGPAu74Kii
	S7rCoDzQmucvEbtYM0z/uEYSBZnw=
X-Gm-Gg: ASbGnctUuNiFsdah/U6qrxbIh5mlEKTJqWwPRAahh9/XDnuV1vH2nD9fP+iVQLaYNYE
	3eqUnH/eZQauYhCPTDPsFZh3/OzdxeXVYjjstR5Unjf5osPdOUvdU/OO67Zmf9FjLLf9ib2AhzL
	jDu08gCy5ovnetkgRxRWb7x31ngw==
X-Google-Smtp-Source: AGHT+IGJFHvnSl9GTHyqhkKVxMP/sSpy01siSVjv+TjhYmIRjgndz+v/byVwlFWN9Q72CCZtRy1DDX8TCXIzWp8/Ges=
X-Received: by 2002:a05:6e02:170d:b0:3d0:1932:7695 with SMTP id
 e9e14a558f8ab-3d28088690fmr2314105ab.8.1739555162697; Fri, 14 Feb 2025
 09:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250126204239.474847-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20250126204239.474847-1-dmitry.osipenko@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 14 Feb 2025 09:45:50 -0800
X-Gm-Features: AWEUYZlbQzYhMxEmBtfBqEpXdqgRBTAayEgifmUEUg9bYiGnlInLT6pNk87gOSE
Message-ID: <CAF6AEGsHY+kh-k+=FqNzf=d=60JqkfFC=+U039XYK-7dTkXZmA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/virtio: Extend blob UAPI with deferred-mapping hinting
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, Asahi Lina <lina@asahilina.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 12:43=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> If userspace never maps GEM object, then BO wastes hostmem space
> because VirtIO-GPU driver maps VRAM BO at the BO's creating time.
>
> Make mappings on-demand by adding new RESOURCE_CREATE_BLOB IOCTL/UAPI
> hinting flag telling that host mapping should be deferred until first
> mapping is made when the flag is set by userspace.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

I suppose we could have just added a new blob_flag, but then userspace
would need to probe the kernel to see whether the new flag was
supported.  (Which isn't a big deal, that sort of thing is done in
many places.)  But extending the struct does make it more transparent
to userspace.  Either way,

Reviewed-by: Rob Clark <robdclark@gmail.com


> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
>  drivers/gpu/drm/virtio/virtgpu_gem.c   |  9 ++++++++
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c |  1 +
>  drivers/gpu/drm/virtio/virtgpu_vram.c  | 30 +++++++++++++++++++++-----
>  include/uapi/drm/virtgpu_drm.h         |  4 ++++
>  5 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virti=
o/virtgpu_drv.h
> index 64c236169db8..e5db91a3e8ba 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -85,6 +85,7 @@ struct virtio_gpu_object_params {
>         uint32_t blob_mem;
>         uint32_t blob_flags;
>         uint64_t blob_id;
> +       uint32_t blob_hints;
>  };
>
>  struct virtio_gpu_object {
> @@ -483,6 +484,7 @@ struct sg_table *virtio_gpu_vram_map_dma_buf(struct v=
irtio_gpu_object *bo,
>  void virtio_gpu_vram_unmap_dma_buf(struct device *dev,
>                                    struct sg_table *sgt,
>                                    enum dma_data_direction dir);
> +void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
>
>  /* virtgpu_submit.c */
>  int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
> diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virti=
o/virtgpu_gem.c
> index 7db48d17ee3a..c902b68cc25a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_gem.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
> @@ -103,12 +103,21 @@ int virtio_gpu_mode_dumb_mmap(struct drm_file *file=
_priv,
>                               struct drm_device *dev,
>                               uint32_t handle, uint64_t *offset_p)
>  {
> +       struct virtio_gpu_object_vram *vram;
> +       struct virtio_gpu_object *bo;
>         struct drm_gem_object *gobj;
>
>         BUG_ON(!offset_p);
>         gobj =3D drm_gem_object_lookup(file_priv, handle);
>         if (gobj =3D=3D NULL)
>                 return -ENOENT;
> +
> +       bo =3D gem_to_virtio_gpu_obj(gobj);
> +       if (virtio_gpu_is_vram(bo)) {
> +               vram =3D to_virtio_gpu_vram(bo);
> +               virtio_gpu_vram_map_deferred(vram);
> +       }
> +
>         *offset_p =3D drm_vma_node_offset_addr(&gobj->vma_node);
>         drm_gem_object_put(gobj);
>         return 0;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/vir=
tio/virtgpu_ioctl.c
> index e4f76f315550..51544ee8d3c3 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -489,6 +489,7 @@ static int verify_blob(struct virtio_gpu_device *vgde=
v,
>         params->size =3D rc_blob->size;
>         params->blob =3D true;
>         params->blob_flags =3D rc_blob->blob_flags;
> +       params->blob_hints =3D rc_blob->blob_hints;
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virt=
io/virtgpu_vram.c
> index 25df81c02783..d72c93e06a4a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> @@ -41,6 +41,11 @@ static int virtio_gpu_vram_mmap(struct drm_gem_object =
*obj,
>         if (!(bo->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
>                 return -EINVAL;
>
> +       virtio_gpu_vram_map_deferred(vram);
> +
> +       if (vram->map_state =3D=3D STATE_INITIALIZING)
> +               virtio_gpu_notify(vgdev);
> +
>         wait_event(vgdev->resp_wq, vram->map_state !=3D STATE_INITIALIZIN=
G);
>         if (vram->map_state !=3D STATE_OK)
>                 return -EINVAL;
> @@ -215,14 +220,29 @@ int virtio_gpu_vram_create(struct virtio_gpu_device=
 *vgdev,
>
>         virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params, N=
ULL,
>                                             0);
> -       if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {
> -               ret =3D virtio_gpu_vram_map(&vram->base);
> -               if (ret) {
> -                       virtio_gpu_vram_free(obj);
> -                       return ret;
> +       if (!(params->blob_hints & DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPI=
NG)) {
> +               if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) =
{
> +                       ret =3D virtio_gpu_vram_map(&vram->base);
> +                       if (ret) {
> +                               virtio_gpu_vram_free(obj);
> +                               return ret;
> +                       }
>                 }
>         }
>
>         *bo_ptr =3D &vram->base;
>         return 0;
>  }
> +
> +void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
> +{
> +       static DEFINE_MUTEX(map_lock);
> +
> +       if (!(vram->base.blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
> +               return;
> +
> +       mutex_lock(&map_lock);
> +       if (!drm_mm_node_allocated(&vram->vram_node))
> +               virtio_gpu_vram_map(&vram->base);
> +       mutex_unlock(&map_lock);
> +}
> diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_dr=
m.h
> index c2ce71987e9b..3004a1d08570 100644
> --- a/include/uapi/drm/virtgpu_drm.h
> +++ b/include/uapi/drm/virtgpu_drm.h
> @@ -194,6 +194,10 @@ struct drm_virtgpu_resource_create_blob {
>         __u32 cmd_size;
>         __u64 cmd;
>         __u64 blob_id;
> +
> +#define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
> +       __u32 blob_hints;
> +       __u32 pad2;
>  };
>
>  #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
> --
> 2.47.1
>
