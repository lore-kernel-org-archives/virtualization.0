Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A03D47B8;
	Fri, 14 Aug 2026 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737578; cv=none; b=uOktbTZ1LtoYumjNtRTKUCdqZhRnMQORe2Kdf2b0X4Rd8m4KcR6Mwe9YJoHdG6riSssQ0wDH+n8rDUF9Wc9qDdo1TezNmKfeJj1anbqqPUe5VsAiHOb5PmlYZwVrCUe+XQ2cp72w0p08R6JSAR346VK/NGuiHBh9YzGg7l1jmUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737578; c=relaxed/simple;
	bh=e3GEkJSJUEFNA56THMAVxPhJnGgq55nQyBggPt/Y27I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gK/ZrdL4xQWCzNVXKkPtTYOXEt3ulf2p5IoPKF9sG/E/Tb1iezz0wfv+JXUcdmahhiVijBLZFfAlEPo5rrlqVhMFT3q7yD0yMv2sIedmq/dotnsgezN9guUjNSkuDJqqrS5FsUlR5ngpdWfOxS3DZpwU0yeXRnRW5oa09SwhLO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7wvDfOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7wvDfOz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E68F4C2BCB3;
	Fri, 14 Aug 2026 19:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786737578;
	bh=e3GEkJSJUEFNA56THMAVxPhJnGgq55nQyBggPt/Y27I=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=u7wvDfOzv3VN5RhTBftlqrS80hdfSkYT92oOKWvK1VsJhxzAJECvvGug5Kj7qaZVB
	 YO5+kETVw2RPHUwR0a+UXuWzNDdOOFA1zYBpXOWmYe8ajc02AMze89ELmmy+qbKbS6
	 rR4ph1D44M+6rSPfwHOQKuAEtgdeq0PWgfuDx4Wn/2OV5OhwJ2AW4Nhq8tYbgsCNUe
	 0gycpf/W/zPMZ7J45v7T2PBwfxKcgAxHZ40ZPMdcMJvdCtReyl4GPCZKrlgH1fl50C
	 ry+hWuf76UJE0lTWGv9TcryIwDLYFlYVe/rxVv7zmIlyGqQBtbPQqUVCvKSXf6DLsW
	 hMb8scEigW0nA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3523C5B572;
	Fri, 14 Aug 2026 19:59:37 +0000 (UTC)
From: Benjamin Leggett via B4 Relay <devnull+benjamin.edera.io@kernel.org>
Date: Fri, 14 Aug 2026 15:59:36 -0400
Subject: [PATCH] drm/virtio: sync shmem backing on guest-bound transfers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-virtgpu-from-host-sync-v1-1-814e3afb5b08@edera.io>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CIBBFr9KwdmIhVYlXMS5goGUWQDPTNpqmd
 xd18Rcv+e/tSiJTFHXvdsVxI6FaGuhTpzC5MkWg0FiZ3lx7qwfYiJdpXmHkmiFVWUDeBcHq4IP
 B2wXtoJo8cxzp9Qs/no29kwieXcH0zQXO5zbIJAj/43F8AA6LuxyNAAAA
X-Change-ID: 20260814-virtgpu-from-host-sync-81dbd2c75c84
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Sashiko AI review <sashiko-bot@kernel.org>, 
 Benjamin Leggett <benjamin@edera.io>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786737577; l=8547;
 i=benjamin@edera.io; s=20260806; h=from:subject:message-id;
 bh=4hKNfIPVOkjwHDAteH2YUkkO1h3jt9wixwZKxEbzZfs=;
 b=KIP055KX66Qbm+feLcTCwQ3AFaNxkjfREBqf8+UY21Fyfk19gHX2bc1Wpjtzz/3ON3PFURe1c
 P8KOlFpr4FfBnzz+5gKX57kll7DtsyKUMyCX/JUxnItCmIh7Il7f/zf
X-Developer-Key: i=benjamin@edera.io; a=ed25519;
 pk=prj3m3DtYeYw1akLHnM/sXm8eau0Ar/IO93YoYnOr+I=
X-Endpoint-Received: by B4 Relay for benjamin@edera.io/20260806 with
 auth_id=923
X-Original-From: Benjamin Leggett <benjamin@edera.io>
Reply-To: benjamin@edera.io

From: Benjamin Leggett <benjamin@edera.io>

virtio_gpu_cmd_transfer_to_host_{2d,3d}() sync the shmem backing for the
device before the transfer, but nothing syncs for the CPU when a transfer
runs the other way. That breaks two ways. Where the DMA layer bounces, the
device writes into the bounce buffer while the guest keeps reading the
original pages. Where DMA is not coherent, the device writes memory while
the CPU keeps stale cache lines, because nothing reaches
arch_sync_dma_for_cpu(). Either way DRM_IOCTL_VIRTGPU_TRANSFER_FROM_HOST
hands back stale data.

Sashiko originally found this in
https://lore.kernel.org/dri-devel/20260806231002.27B4D1F000E9@smtp.kernel.org
but the suggestion there to fix this with dma_sync_sgtable_for_cpu()
isn't a sufficient fix, for two reasons.

- The transfer is asynchronous. virtio_gpu_cmd_transfer_from_host_3d() only
queues the command, so a sync there would run before the device had written
anything. It belongs on completion, and ahead of any fence signalling.
A waiter woken by the fence would otherwise race the sync and read the
backing pages regardless. It needs its own pass over the reclaim list
rather than a step inside the existing one, because
virtio_gpu_fence_event_process() also signals every earlier fence in the
same context, so any entry in that loop may signal an earlier entry's
fence.

- The transfer is also partial, carrying an offset, a level and a box.
Where the mapping bounces, a sync for the CPU copies the whole mapping
back, so unless the mapping is primed first the regions the device did not
write come back holding whatever the bounce buffer contained, discarding
data the guest owned.

So the fix: Prime the mapping before queueing, tag the vbuffer, and sync
for the CPU on completion before the fence is signalled.

A second transfer must not snapshot the mapping while an earlier one is
still in flight, or the snapshot would predate whatever the CPU wrote once
the earlier fence signalled and the later sync would discard it.

To mitigate this, wait for outstanding fences under the reservation before
priming.

Neither sync copies anything unless the mapping genuinely bounces:
swiotlb_sync_single_for_cpu() and its Xen counterpart look the address up
in the bounce pool and return early when it is absent. On a platform with
non-coherent DMA they still perform the necessary cache maintenance.

The range cannot be narrowed to the box, since for a non-blob resource
virtio_gpu_transfer_from_host_ioctl() rejects a caller-supplied stride and
layer_stride, leaving the layout to the host and the guest with no way to
work out which bytes the device writes. A host3d guest blob does carry
both, so its extent could be bounded, but the sync is left whole there too
rather than special-cased: priming makes the untouched regions round-trip
unchanged either way.

Behaviour changes worth noting:

- TRANSFER_FROM_HOST can now block, where before it returned as soon as the
command was queued. Repeated readbacks of one resource serialise, and a
readback can wait behind an earlier queued command that touched it, since
virtio_gpu_array_add_fence() tags uploads, execbufs and plane flushes
alike with DMA_RESV_USAGE_WRITE. -ERESTARTSYS was already possible here
via dma_resv_lock_interruptible().

- A CPU write racing an in-flight transfer to the same resource is now
lost, where before it survived and the transfer was lost instead. Priming
captures the pages as of queueing, so a write landing before completion is
overwritten by the sync.

- Where a batch of completions contains a guest-bound transfer, the sync
pass delays fence signalling for the whole batch. Only bounced pages are
copied and the swiotlb pool bounds it. A batch with no such transfer is
unaffected.

Tested under QEMU on x86 with swiotlb=force and virtio-vga-gl
iommu_platform=on, which forces both preconditions required to hit the
original bug.

Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260806231002.27B4D1F000E9@smtp.kernel.org/
Signed-off-by: Benjamin Leggett <benjamin@edera.io>
---
This depends on 6a736d2f9d0c ("drm/virtio: use the DMA API for resource backing on Xen"), currently in
drm-misc-fixes only, so it needs to go through the same branch.
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 19 +++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_vq.c    | 30 ++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 626aadf680bd..550c732947f6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -192,6 +192,9 @@ struct virtio_gpu_vbuffer {
 	struct list_head list;
 
 	uint32_t seqno;
+
+	/* guest-bound transfer whose shmem backing needs a CPU sync */
+	bool sync_for_cpu;
 };
 
 struct virtio_gpu_output {
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7c1..88320275eadb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -261,6 +261,25 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 	if (ret != 0)
 		goto err_put_free;
 
+	if (virtio_gpu_is_shmem(bo) && virtio_gpu_use_dma_api(vgdev->vdev)) {
+		/*
+		 * The sync on completion restores the whole mapping, so an
+		 * earlier transfer has to be done before this one snapshots it.
+		 * Otherwise the snapshot predates anything the CPU wrote once
+		 * that transfer's fence signalled, and the later sync would
+		 * discard it. Nothing can add a fence behind our back here,
+		 * since doing so takes the reservation we already hold.
+		 */
+		long wait = dma_resv_wait_timeout(objs->objs[0]->resv,
+						  DMA_RESV_USAGE_WRITE, true,
+						  MAX_SCHEDULE_TIMEOUT);
+
+		if (wait < 0) {
+			ret = wait;
+			goto err_unlock;
+		}
+	}
+
 	fence = virtio_gpu_fence_alloc(vgdev, vgdev->fence_drv.context, 0);
 	if (!fence) {
 		ret = -ENOMEM;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 5e9b7b192db0..c419df8ff31f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -256,6 +256,23 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 	} while (!virtqueue_enable_cb(vgdev->ctrlq.vq));
 	spin_unlock(&vgdev->ctrlq.qlock);
 
+	/*
+	 * Sync guest-bound transfers before signalling anything, so that a
+	 * waiter cannot read the backing pages while what the device wrote is
+	 * still in a bounce buffer. This cannot be folded into the loop below:
+	 * virtio_gpu_fence_event_process() also signals every earlier fence in
+	 * the same context, so any entry there may signal this entry's fence.
+	 */
+	list_for_each_entry(entry, &reclaim_list, list) {
+		if (entry->sync_for_cpu) {
+			struct virtio_gpu_object *bo =
+				gem_to_virtio_gpu_obj(entry->objs->objs[0]);
+
+			dma_sync_sgtable_for_cpu(vgdev->vdev->dev.parent,
+						 bo->base.sgt, DMA_FROM_DEVICE);
+		}
+	}
+
 	list_for_each_entry(entry, &reclaim_list, list) {
 		resp = (struct virtio_gpu_ctrl_hdr *)entry->resp_buf;
 
@@ -1238,12 +1255,25 @@ void virtio_gpu_cmd_transfer_from_host_3d(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(objs->objs[0]);
 	struct virtio_gpu_transfer_host_3d *cmd_p;
 	struct virtio_gpu_vbuffer *vbuf;
+	bool use_dma_api = virtio_gpu_use_dma_api(vgdev->vdev);
 
 	cmd_p = virtio_gpu_alloc_cmd(vgdev, &vbuf, sizeof(*cmd_p));
 	memset(cmd_p, 0, sizeof(*cmd_p));
 
 	vbuf->objs = objs;
 
+	if (virtio_gpu_is_shmem(bo) && use_dma_api) {
+		/*
+		 * The device writes only the requested box, so prime the
+		 * mapping with the current contents: otherwise the sync on
+		 * completion would hand back whatever a bounce buffer held for
+		 * the regions the device does not touch.
+		 */
+		dma_sync_sgtable_for_device(vgdev->vdev->dev.parent,
+					    bo->base.sgt, DMA_TO_DEVICE);
+		vbuf->sync_for_cpu = true;
+	}
+
 	cmd_p->hdr.type = cpu_to_le32(VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D);
 	cmd_p->hdr.ctx_id = cpu_to_le32(ctx_id);
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);

---
base-commit: 6a736d2f9d0c6e6217fe7532bc4c50ceca71db78
change-id: 20260814-virtgpu-from-host-sync-81dbd2c75c84

Best regards,
-- 
Benjamin Leggett <benjamin@edera.io>


