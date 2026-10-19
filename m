Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3547086D
	for <virtualization@lists.linux.dev>; Mon, 19 Oct 2026 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421462; cv=none; b=Ce7pNco6+jnQYxpWuyNkT8koS7xz+f6/6sdEogbQ66ODrJn0Q1pMCIq9rZQIus02hYueagNbqmjeUzCtfkpbedI9vUVf0XhNYYDNLEZsitIiVAO2eNAnGEQy66+eH5pwKPPzFX188Ht0I40uJ78PmquYlwzCNIMIZOrDqRMoaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421462; c=relaxed/simple;
	bh=xUw0OtGWE3YcYruRcKbj8kDLimeoXnjyZVgJerQnQ5Y=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=oQIp+xsJnP+BbR8Tm00UCLhhwm/JY9a0xqccKFzr8YDuh3DAZoAFlPE7v4eHgGqxtj1gk+O+AS5NsUrlRft4Z/998KqLa21r4oUz1xMpQmOJpzQaLgFQyBVw7Zm5oDewbRVcl2ehrP8hnzNXoBShjWAO0rDW4L2rB9P/BTkhcFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHo8d1kP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHo8d1kP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7921F000C4;
	Mon, 19 Oct 2026 14:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792421461;
	bh=hyq9kpt52EeduCF34Ldz5oOa2i0ZSPzKj3emAyf0HbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hHo8d1kPwibl8VEIBbU8TbBUiC1A7MvLJgCMDorssFjZOlzn2dZAYYoSerTsp4TN4
	 oQplPDnSwxdDfVTOUqXxkZjUEhwk6YeJ9fksBd2x/S7Y4p16mOjiEPzxeYD7pFUwjL
	 VptA6XpDJGOg/Pv6awHrYZPDi8BKn8wyvzweHR2LMXR3rOAtwb1FwN2vQ0jolJRQrS
	 x8yVIgJq7CnEN6x1BnDCw49BKf+swn3Fdo0zR3RdVgtUefP1FTv0kyOgnNa1Kzp3aC
	 9UcNFxqlujI41MUEC1OquI0vsEes5Fnefz64Jxux77LZgGMnzTuC+gPJFqxamkyTRz
	 4i4lOKovaJ4hQ==
Message-ID: <sashiko-outbox-177522@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] drm/virtio: reclaim pending vbufs
 before tearing down vqs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261019135441.1420968-179-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-179-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:51:00 +0000
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/virtio: missing pending_commands reset in virtio_gpu_reclaim_v=
bufs()
- [High] drm/virtio: race in virtio_gpu_deinit() flushing work before devic=
e reset
- [High] drm/virtio: uninterruptible hang in virtio_gpu_reclaim_vbufs() on =
imported dmabuf
--

commit f24f642758ec3795a40ce21fd3080771f4fdffb2
Author: Anuj Bolewar <bolewara@gmail.com>

drm/virtio: reclaim pending vbufs before tearing down vqs

This commit drains unused vbuffers from the control and cursor virtqueues in
virtio_gpu_deinit() after resetting the device and before deleting the
virtqueues, releasing any held GEM object references and pending
RESOURCE_UNREF objects before the vbufs kmem_cache is destroyed.

Link: https://patch.msgid.link/20260802-virtio-gpu-reclaim-vbufs-v2-1-5767f=
b860691@gmail.com

[ ... ]

> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virti=
o/virtgpu_kms.c
> index 1c15cbf326b78..59173746c9494 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -286,6 +286,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
>  	flush_work(&vgdev->cursorq.dequeue_work);
>  	flush_work(&vgdev->config_changed_work);
>  	virtio_reset_device(vgdev->vdev);
> +	virtio_gpu_reclaim_vbufs(vgdev);
>  	vgdev->vdev->config->del_vqs(vgdev->vdev);
>  }

[Severity: High]
Could flushing the workqueues before virtio_reset_device() in
virtio_gpu_deinit() race with virtio_gpu_reclaim_vbufs() and del_vqs()?

In drivers/gpu/drm/virtio/virtgpu_kms.c:virtio_gpu_deinit():

	flush_work(&vgdev->obj_free_work);
	flush_work(&vgdev->ctrlq.dequeue_work);
	flush_work(&vgdev->cursorq.dequeue_work);
	flush_work(&vgdev->config_changed_work);
	virtio_reset_device(vgdev->vdev);
	virtio_gpu_reclaim_vbufs(vgdev);
	vgdev->vdev->config->del_vqs(vgdev->vdev);

Until virtio_reset_device(vgdev->vdev) completes, the virtio device can sti=
ll
raise virtqueue and config interrupts (virtio_gpu_ctrl_ack(),
virtio_gpu_cursor_ack(), and virtio_gpu_config_changed()), which call
schedule_work() and can re-queue ctrlq.dequeue_work, cursorq.dequeue_work, =
and
config_changed_work after flush_work() has already returned. In the
virtio_gpu_probe() -> err_deinit path, drm_dev_unplug() is not called, so
config_changed_work can also queue new buffers into ctrlq.vq.

Since virtio_reset_device() does not cancel or flush already-scheduled work,
virtio_gpu_dequeue_ctrl_func() and virtio_gpu_dequeue_cursor_func() can run
concurrently with virtio_gpu_reclaim_vbufs() and del_vqs():

	spin_lock(&vgdev->ctrlq.qlock);
	do {
		virtqueue_disable_cb(vgdev->ctrlq.vq);
		reclaim_vbufs(vgdev->ctrlq.vq, &reclaim_list);

	} while (!virtqueue_enable_cb(vgdev->ctrlq.vq));
	spin_unlock(&vgdev->ctrlq.qlock);

Because virtio_gpu_reclaim_vbufs() calls virtqueue_detach_unused_buf() with=
out
holding ctrlq.qlock or cursorq.qlock while dequeue_work is calling
virtqueue_get_buf(), can this corrupt virtqueue descriptor state (such as
vq->split.desc_state[i].data, vq->free_head, and vq->vq.num_free), double-f=
ree
vbuffers, or access the virtqueues while del_vqs() is freeing them?

Additionally, flush_work(&vgdev->obj_free_work) runs before
flush_work(&vgdev->ctrlq.dequeue_work), even though
virtio_gpu_dequeue_ctrl_func() schedules vgdev->obj_free_work via
virtio_gpu_array_put_free_delayed(). Can virtio_gpu_array_put_free_work() e=
nd
up running concurrently with or after virtio_gpu_release() ->
virtio_gpu_free_vbufs() and touch vgdev->vbufs while or after the kmem_cache
is destroyed?

> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio=
/virtgpu_vq.c
> index 8181b22b9b46a..68cf7e4996884 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -207,6 +207,21 @@ static void free_vbuf(struct virtio_gpu_device *vgde=
v,
>  	kmem_cache_free(vgdev->vbufs, vbuf);
>  }
> =20
> +void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
> +{
> +	struct virtio_gpu_vbuffer *vbuf;
> +
> +	while ((vbuf =3D virtqueue_detach_unused_buf(vgdev->ctrlq.vq))) {
> +		if (vbuf->objs)
> +			virtio_gpu_array_put_free(vbuf->objs);
> +		if (vbuf->resp_cb_data)
> +			virtio_gpu_cleanup_object(vbuf->resp_cb_data);
> +		free_vbuf(vgdev, vbuf);
> +	}
> +	while ((vbuf =3D virtqueue_detach_unused_buf(vgdev->cursorq.vq)))
> +		free_vbuf(vgdev, vbuf);
> +}

[Severity: High]
Should virtio_gpu_reclaim_vbufs() also reset vgdev->pending_commands to avo=
id
a use-after-free on vgdev->ctrlq.vq in virtio_gpu_notify()?

Whenever a control buffer is queued via virtio_gpu_queue_ctrl_sgs() (or
virtio_gpu_panic_queue_ctrl_sgs()), vgdev->pending_commands is incremented:

	ret =3D virtqueue_add_sgs(vq, sgs, outcnt, incnt, vbuf, GFP_ATOMIC);
	WARN_ON(ret);

	vbuf->seqno =3D ++vgdev->ctrlq.seqno;
	trace_virtio_gpu_cmd_queue(vq, virtio_gpu_vbuf_ctrl_hdr(vbuf), vbuf->seqno=
);

	atomic_inc(&vgdev->pending_commands);

Several command submission paths (such as virtio_gpu_object_create(),
virtio_gpu_vram_create(), virtio_gpu_mode_dumb_create(),
virtio_gpu_resource_create_ioctl(), virtio_gpu_resource_create_blob_ioctl(),
virtio_gpu_resource_assign_uuid(), virtio_gpu_prepare_imported_obj(), and
virtio_gpu_create_context()) queue vbuffers into vgdev->ctrlq.vq without
immediately calling virtio_gpu_notify(vgdev), leaving vgdev->pending_comman=
ds
non-zero.

When virtio_gpu_reclaim_vbufs() detaches those vbuffers, it does not reset =
or
decrement vgdev->pending_commands, and virtio_gpu_deinit() immediately frees
vgdev->ctrlq.vq via vgdev->vdev->config->del_vqs(vgdev->vdev).

If an open drm_file later releases a GEM object or closes (calling
virtio_gpu_gem_object_close(), virtio_gpu_free_object(),
virtio_gpu_vram_free(), virtgpu_dma_buf_free_obj(), or
virtio_gpu_driver_postclose() -> virtio_gpu_notify()), virtio_gpu_notify()
has no drm_dev_enter() guard and only checks vgdev->pending_commands:

void virtio_gpu_notify(struct virtio_gpu_device *vgdev)
{
	bool notify;

	if (!atomic_read(&vgdev->pending_commands))
		return;

	spin_lock(&vgdev->ctrlq.qlock);
	atomic_set(&vgdev->pending_commands, 0);
	notify =3D virtqueue_kick_prepare(vgdev->ctrlq.vq);
	spin_unlock(&vgdev->ctrlq.qlock);

	if (notify)
		virtqueue_notify(vgdev->ctrlq.vq);
}

Won't virtio_gpu_notify() see the stale non-zero vgdev->pending_commands and
call virtqueue_kick_prepare() and virtqueue_notify() on the freed
vgdev->ctrlq.vq? Also, if virtio_gpu_array_put_free(vbuf->objs) inside
virtio_gpu_reclaim_vbufs() drops the final reference to a created GEM objec=
t,
virtio_gpu_free_object() synchronously calls virtio_gpu_notify(vgdev), which
would kick vgdev->ctrlq.vq after virtio_reset_device() has already reset the
device while virtqueue_detach_unused_buf() is draining the ring.

[Severity: High]
Can calling virtio_gpu_array_put_free(vbuf->objs) from
virtio_gpu_reclaim_vbufs() hang uninterruptibly in dma_fence_wait() when
releasing an imported DMA-BUF GEM object?

When VIRTGPU_PARAM_RESOURCE_BLOB is enabled without virgl 3D
(vgdev->has_resource_blob && !vgdev->has_virgl_3d), importing a DMA-BUF via
virtgpu_gem_prime_import() creates a GEM object with
obj->funcs =3D &virtgpu_gem_dma_buf_funcs (.free =3D virtgpu_dma_buf_free_o=
bj) and
bo->attached =3D true. If that object is used on the primary plane via
virtio_gpu_primary_plane_update() -> virtio_gpu_resource_flush() and the
50ms wait times out, the vbuf remains in ctrlq.vq holding a reference to the
imported GEM object in vbuf->objs.

During virtio_gpu_remove(), drm_dev_unplug(dev) marks the DRM device
unplugged, drm_atomic_helper_shutdown(dev) drops the plane state's framebuf=
fer
reference, and virtio_gpu_deinit() resets the device and calls
virtio_gpu_reclaim_vbufs(). When virtio_gpu_array_put_free(vbuf->objs) drops
the last reference to the imported object, it triggers
virtgpu_dma_buf_free_obj() -> virtgpu_dma_buf_unmap() ->
virtio_gpu_detach_object_fenced(bo):

int virtio_gpu_detach_object_fenced(struct virtio_gpu_object *bo)
{
	struct virtio_gpu_device *vgdev =3D bo->base.base.dev->dev_private;
	struct virtio_gpu_fence *fence;

	if (!bo->attached)
		return 0;

	fence =3D virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0);
	if (!fence)
		return -ENOMEM;

	virtio_gpu_object_detach(vgdev, bo, fence);
	virtio_gpu_notify(vgdev);

	dma_fence_wait(&fence->f, false);
	dma_fence_put(&fence->f);

	return 0;
}

Inside virtio_gpu_object_detach() -> virtio_gpu_cmd_resource_detach_backing=
()
-> virtio_gpu_queue_fenced_ctrl_buffer() -> virtio_gpu_queue_ctrl_sgs(),
drm_dev_enter() returns false because the device is unplugged:

	if (!drm_dev_enter(vgdev->ddev, &idx)) {
		if (fence && vbuf->objs)
			virtio_gpu_array_unlock_resv(vbuf->objs);
		free_vbuf(vgdev, vbuf);
		return -ENODEV;
	}

Since virtio_gpu_queue_ctrl_sgs() returns -ENODEV before
virtio_gpu_fence_emit() is called, and virtio_gpu_object_detach() ignores t=
his
error, won't dma_fence_wait(&fence->f, false) in
virtio_gpu_detach_object_fenced() sleep forever waiting on a fence that was
never emitted and can never be signaled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-179-sashal@kernel.org?part=3D1
