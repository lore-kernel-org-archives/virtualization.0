Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C263672BD
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 06:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567692; cv=pass; b=NOOaLD5Eykqcoykduz0EYMGbCwXmvR9udaLcrimtSx1F4yGNdFj0YLuhMMTGOeY76BAjVogiumsFTA9R/TaGc/7nGY5XiWE8FMk/bLGYSirsG1dobJ2ZO+UTjy61qPlTt4fWulQnICjzCN56FQh5cXVBxJ3ogMlabIHSaJUnZU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567692; c=relaxed/simple;
	bh=uR/wuDgqDv8yRBShwoMTpLFWaEEuvwSCFtiSUT4qza4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxvZIWROQ8fNQ9VVSD0cJLmETfAYIMiALXsrx4krPL5e4SN0a9vpRGGM7ASXO3aPoMxKRQN0I4kc0MOvWNAW9Fg7zcXjZOIi0NeBDLgLqKAFUH9QXh65m5mYRG5Xcm05mrRWv0AHo+bPHyJZeNpwlz2SOKMtu4YfnJEBPjKeAqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=d9GM4msm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="d9GM4msm"
ARC-Seal: i=1; a=rsa-sha256; t=1778567665; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=J+xalX0YrxiGPQOt+x0j3jnAQqIE3zEm51KRO0nMvQ5sFoHypHYRjxj4yx1qWmVBP5IEFdwk0ENo+0v6S9bV4AbRRU5nCG1onLxbV2ExcfxNCh7ne0Xivu2AKon5NS5bWxYgcm+50eppp/vxpjF0ecxRKr7xOjHoPuSUdYUxXLY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778567665; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=SJ0Qn/UqArX6ZR0ki2ximJ/UxGOhcRuv97GesmuE/Yc=; 
	b=kW6U92gxkAwOpeXbna7SB3qzgMbaP3D5+NNcMsaFqrgYrdjTwv/sipblnoZtG54+SmOfM2JNrhzurYq5BLehn2fL8gyEE0tjma9bku68EqsPIwoe4vrjIHornbFf6UXSFeZlwfU4M9KInaKxohHNHGs43Q71nQuViw2RImEy+vM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778567665;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=SJ0Qn/UqArX6ZR0ki2ximJ/UxGOhcRuv97GesmuE/Yc=;
	b=d9GM4msm40O6Tm0ru7Tu8C1wi5h0KHZskTlvajd8XEI4wAdkipemFSzEO7b1JQxb
	pN1ZMqh/tlT60Ys0FUHFkTSY8SrFobqYhoJQcxOur16uPlDhsTe4f4j44wXOewM1J/A
	ckC+nC0AGVY8VzZgkYdOzkc+dObKcvGrFFGHEG4Q=
Received: by mx.zohomail.com with SMTPS id 1778567662549708.0536854865072;
	Mon, 11 May 2026 23:34:22 -0700 (PDT)
Message-ID: <d1bc8d7d-3a4f-4ede-8266-81cc66bf11b5@collabora.com>
Date: Tue, 12 May 2026 09:34:15 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: move cursor resv lock acquisition to
 prepare_fb
To: Deepanshu Kartikey <kartikey406@gmail.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com, stable@vger.kernel.org
References: <20260512020718.108044-1-kartikey406@gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20260512020718.108044-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 5/12/26 05:07, Deepanshu Kartikey wrote:
> virtio_gpu_cursor_plane_update() allocates a virtio_gpu_object_array,
> locks its dma_resv, and queues a fenced transfer to the host. The
> lock acquisition can fail in two ways:
> 
>   - dma_resv_lock_interruptible() returns -EINTR when a signal is
>     delivered while waiting for the reservation lock.
>   - dma_resv_reserve_fences() returns -ENOMEM if it fails to allocate
>     a fence slot; in this case lock_resv unlocks before returning.
> 
> The return value was ignored, so the cursor path could proceed with
> the resv lock not held. The queue path then walks the object array
> and calls dma_resv_add_fence(), which requires the lock; with lockdep
> enabled this trips dma_resv_assert_held():
> 
>   WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840
>   Call Trace:
>    virtio_gpu_array_add_fence
>    virtio_gpu_queue_ctrl_sgs
>    virtio_gpu_queue_fenced_ctrl_buffer
>    virtio_gpu_cursor_plane_update
>    drm_atomic_helper_commit_planes
>    drm_atomic_helper_commit_tail
>    commit_tail
>    drm_atomic_helper_commit
>    drm_atomic_commit
>    drm_atomic_helper_update_plane
>    __setplane_atomic
>    drm_mode_cursor_universal
>    drm_mode_cursor_common
>    drm_mode_cursor_ioctl
>    drm_ioctl
>    __x64_sys_ioctl
> 
> Beyond the WARN, mutating the dma_resv fence list without the lock
> races with concurrent readers/writers and can corrupt the list.
> 
> The DRM atomic helpers do not allow .atomic_update to fail: by the
> time it runs, the commit has been signed off to userspace and there
> is no clean rollback path. Move the fallible work -- objs allocation,
> dma_resv locking, and fence slot reservation -- into
> virtio_gpu_plane_prepare_fb, which is the designated callback for
> resource acquisition and may return errors that the framework
> handles by rolling back the commit. Stash the prepared object array
> on virtio_gpu_plane_state so the update step can consume it.
> 
> Make virtio_gpu_plane_cleanup_fb release the objs if the commit was
> rolled back before update ran (i.e., objs not consumed). The queue
> path already unlocks the resv after attaching the fence (vq.c:411)
> and frees the array via put_free_delayed after host completion
> (vq.c:271), so the update step only needs to clear vgplane_st->objs
> to transfer ownership.
> 
> Simplify virtio_gpu_cursor_plane_update to a no-fail queue submission
> that hands the prepared, locked objs to the queue path.
> 
> The bug was reported by syzbot, triggered via fault injection
> (fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
> -ENOMEM branch in dma_resv_reserve_fences().
> 
> Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
> Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20260510053025.100224-1-kartikey406@gmail.com/T/ [v1]
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2: Move resv lock acquisition from .atomic_update (which must not
>     fail) to .prepare_fb (which may), per maintainer review of v1.
>     The previous approach of silently skipping the cursor update on
>     lock failure violated the atomic-commit contract with userspace.
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 38 ++++++++++++++++++++------
>  2 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index f17660a71a3e..e51f959dce46 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -198,6 +198,7 @@ struct virtio_gpu_framebuffer {
>  struct virtio_gpu_plane_state {
>  	struct drm_plane_state base;
>  	struct virtio_gpu_fence *fence;
> +	struct virtio_gpu_object_array *objs;
>  };
>  #define to_virtio_gpu_plane_state(x) \
>  	container_of(x, struct virtio_gpu_plane_state, base)
> diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
> index a126d1b25f46..b0511ace89e6 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_plane.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
> @@ -381,6 +381,23 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
>  			goto err_fence;
>  	}
>  
> +	if (plane->type == DRM_PLANE_TYPE_CURSOR && bo->dumb) {
> +		struct virtio_gpu_object_array *objs;
> +
> +		objs = virtio_gpu_array_alloc(1);
> +		if (!objs) {
> +			ret = -ENOMEM;
> +			goto err_fence;
> +		}
> +		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
> +		ret = virtio_gpu_array_lock_resv(objs);
> +		if (ret) {
> +			virtio_gpu_array_put_free(objs);
> +			goto err_fence;
> +		}
> +		vgplane_st->objs = objs;
> +	}
> +
>  	return 0;
>  
>  err_fence:
> @@ -417,6 +434,12 @@ static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
>  		vgplane_st->fence = NULL;
>  	}
>  
> +	if (vgplane_st->objs) {
> +		virtio_gpu_array_unlock_resv(vgplane_st->objs);
> +		virtio_gpu_array_put_free(vgplane_st->objs);
> +		vgplane_st->objs = NULL;
> +	}
> +
>  	obj = state->fb->obj[0];
>  	if (drm_gem_is_imported(obj))
>  		virtio_gpu_cleanup_imported_obj(obj);
> @@ -452,21 +475,18 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
>  	}
>  
>  	if (bo && bo->dumb && (plane->state->fb != old_state->fb)) {
> -		/* new cursor -- update & wait */
> -		struct virtio_gpu_object_array *objs;
> -
> -		objs = virtio_gpu_array_alloc(1);
> -		if (!objs)
> -			return;
> -		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
> -		virtio_gpu_array_lock_resv(objs);
> +		/* objs and fence were prepared in virtio_gpu_plane_prepare_fb;
> +		 * the resv is already locked. The queue path takes ownership
> +		 * of objs and unlocks the resv after attaching the fence.
> +		 */
>  		virtio_gpu_cmd_transfer_to_host_2d
>  			(vgdev, 0,
>  			 plane->state->crtc_w,
>  			 plane->state->crtc_h,
> -			 0, 0, objs, vgplane_st->fence);
> +			 0, 0, vgplane_st->objs, vgplane_st->fence);
>  		virtio_gpu_notify(vgdev);
>  		dma_fence_wait(&vgplane_st->fence->f, true);
> +		vgplane_st->objs = NULL;
>  	}
>  
>  	if (plane->state->fb != old_state->fb) {

I'm getting lockup with this patch applied and now see that
virtio_gpu_resource_flush() also locks BO.

Easiest option might be to add uninterruptible variant of
virtio_gpu_array_lock_resv(). Could you please try it for v3?

-- 
Best regards,
Dmitry
