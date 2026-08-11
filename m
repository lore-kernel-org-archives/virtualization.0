Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F35B3B19A9
	for <virtualization@lists.linux.dev>; Tue, 11 Aug 2026 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463395; cv=pass; b=mbwGiMkydQ+tZfSc52Ev7l1NK8W90golfx4VWghd+DxHr84+h4+YdjZLnsZ6GlfFW3v8HSKtfmh1iKxTbDLs1ocIeQvD8MJm0phFhgUpJfbeg0PpyxJSh+xTq1MhV2yO46lqFgyeL0e8B5n2mtRBXh5lLa+SKpb3HNP2aiH9VRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463395; c=relaxed/simple;
	bh=CVVOR1DtQRfbI1f/+QElcrYREMqfgwytIXwI5VouXu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YGLG9r7St2hTdCATvcCM0Dh30Plt1MWwcB9y3tFq+Vd1F8qk1iWztJw5fcELHRn0APvisxnBYLRe8PanPRvJ4/2g8TimTtbwniM0F8Do3BPJbJ/LxcIB7q++sWYquVvqX+vh0+bW36Lfs1S4pdEjMDat5uHEFcI7jwcQi2GUlko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Lq/b1qSs; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Lq/b1qSs"
ARC-Seal: i=1; a=rsa-sha256; t=1786463371; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IPbOA7iqYU4NZ+6LG31zWs11yB242BhxW7HJqDty6P6eky+C7Yrsz+pe9iIkk3QT4bqWAuUiFrAwT8BRXeHbKxNFlNmPnqb3NDIuEcB9LK/0p5wQJbUGhq8MKG+c7nvK2A2SmWha5akxrcvJ81XT4NAJXV39QG888Z/fl4NyMXU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1786463371; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wJ+mE/6pcm4lW/l9xvOfruk8A2xPzxyqDey8hIf/l5U=; 
	b=AMCSv6Io8pKITmE2viU0V7/4Bd1w0bGz2GsRXid+8ChOqS0DDlHX0nE9LWU28lgY0Rr+6muznjNb/0SkJKxMQhNeOuVcQK1atX5cYayqQxOMwfMQfhVT5VdYsSZZmV8TcGqkXdbKLNEkF5ctS+Oka95s7wzwkBbzWIIVcWEshaA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1786463371;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wJ+mE/6pcm4lW/l9xvOfruk8A2xPzxyqDey8hIf/l5U=;
	b=Lq/b1qSsRAoPEXX7g9mx3mFNbcho/oNs7UuxztajAgkQXCbZG++IWLuGo3H6Brer
	NPUa9D5LtvJm9aZujJq1QPdJc2hEvwv+/vn2726FPKEN4+oft163blIxp/gjAZcdtMM
	Gg87rgJh21tZvWIAc9eSuz3MC1RxNdUbwYkiz6CM=
Received: by mx.zohomail.com with SMTPS id 1786463370473304.88449999785416;
	Tue, 11 Aug 2026 08:49:30 -0700 (PDT)
Message-ID: <bf859b59-3f56-4d26-a86e-c01efc2d6f74@collabora.com>
Date: Tue, 11 Aug 2026 18:49:25 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/virtio: use the DMA API for resource backing on Xen
To: benjamin@edera.io, David Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260806-virtgpu-xen-dma-v1-1-e499b345bbad@edera.io>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260806-virtgpu-xen-dma-v1-1-e499b345bbad@edera.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 8/7/26 01:54, Benjamin Leggett via B4 Relay wrote:
> From: Benjamin Leggett <benjamin@edera.io>
> 
> On a Xen PV domain page addresses bear no relation to the real machine
> addresses the host would have to use to reach it.
> virtio_ring.c handles this correctly, vring_use_map_api() returns true
> for any xen_domain() regardless of VIRTIO_F_ACCESS_PLATFORM.
> 
> virtio-gpu makes the same decision independently, but its copy
> looks only at the feature bit:
> 
> 	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
> 
> QEMU does not set iommu_platform on virtio-vga by default, so
> VIRTIO_F_ACCESS_PLATFORM is not negotiated, use_dma_api is false, and
> virtio_gpu_object_shmem_init() describes the framebuffer's backing pages
> to the host with sg_phys().  Those are guest-physical addresses. In a PV
> domain they resolve, on the host side, to pages belonging to some other
> domain, so the host scans out unrelated memory.
> 
> Move the decision into virtio_gpu_use_dma_api() and give it the
> xen_domain() check, like vring_use_map_api() has. This
> additionally enables the dma_sync_sgtable_for_device() calls in
> virtgpu_vq.c, which are required for correctness whenever swiotlb
> is in play.
> 
> Reproduced with a Xen 4.21 PV dom0 nested inside QEMU 8.2 with
> virtio-vga, on both a distro 6.8 kernel and 6.18 LTS. A PVH dom0
> works fine and doesn't need this fix because it is identity-mapped,
> only PV dom0s are affected.
> 
> Fixes: a3b815f09bb8 ("drm/virtio: add iommu support.")
> Signed-off-by: Ben Leggett <benjamin@edera.io>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h    | 20 ++++++++++++++++++++
>  drivers/gpu/drm/virtio/virtgpu_object.c |  2 +-
>  drivers/gpu/drm/virtio/virtgpu_vq.c     |  6 +++---
>  3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 17a6a4d26516..09da7973387e 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -43,6 +43,8 @@
>  #include <drm/drm_probe_helper.h>
>  #include <drm/virtgpu_drm.h>
>  
> +#include <xen/xen.h>
> +
>  #define DRIVER_NAME "virtio_gpu"
>  #define DRIVER_DESC "virtio GPU"
>  
> @@ -60,6 +62,24 @@
>  /* See virtio_gpu_ctx_create. One additional character for NULL terminator. */
>  #define DEBUG_NAME_MAX_LEN 65
>  
> +/*
> + * Whether the host must be told about resource backing pages by DMA address
> + * rather than guest-physical address.
> + *
> + * This mirrors vring_use_map_api() in drivers/virtio/virtio_ring.c, including
> + * its xen_domain() case.
> + */
> +static inline bool virtio_gpu_use_dma_api(const struct virtio_device *vdev)
> +{
> +	if (!virtio_has_dma_quirk(vdev))
> +		return true;
> +
> +	if (xen_domain())
> +		return true;
> +
> +	return false;
> +}
> +
>  struct virtio_gpu_object_params {
>  	unsigned long size;
>  	bool dumb;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
> index 9bc0bd68c314..49899485be6f 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_object.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_object.c
> @@ -173,7 +173,7 @@ static int virtio_gpu_object_shmem_init(struct virtio_gpu_device *vgdev,
>  					struct virtio_gpu_mem_entry **ents,
>  					unsigned int *nents)
>  {
> -	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
> +	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>  	struct scatterlist *sg;
>  	struct sg_table *pages;
>  	int si;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 905b1f42cd98..568fefd713e0 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -764,7 +764,7 @@ int virtio_gpu_panic_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>  	struct virtio_gpu_transfer_to_host_2d *cmd_p;
>  	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
> +	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>  
>  	if (virtio_gpu_is_shmem(bo) && use_dma_api)
>  		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> @@ -795,7 +795,7 @@ void virtio_gpu_cmd_transfer_to_host_2d(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>  	struct virtio_gpu_transfer_to_host_2d *cmd_p;
>  	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
> +	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>  
>  	if (virtio_gpu_is_shmem(bo) && use_dma_api)
>  		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> @@ -1231,7 +1231,7 @@ void virtio_gpu_cmd_transfer_to_host_3d(struct virtio_gpu_device *vgdev,
>  	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
>  	struct virtio_gpu_transfer_host_3d *cmd_p;
>  	struct virtio_gpu_vbuffer *vbuf;
> -	bool use_dma_api = !virtio_has_dma_quirk(vgdev->vdev);
> +	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
>  
>  	if (virtio_gpu_is_shmem(bo) && use_dma_api)
>  		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
> 
> ---
> base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
> change-id: 20260806-virtgpu-xen-dma-559fab712250
> 
> Best regards,

Looks okay, though I'm not familiar with Xen. Will apply to -next in a
day if nobody will have objections.

Acked-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry
