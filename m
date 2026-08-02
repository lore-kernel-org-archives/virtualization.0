Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C53BB115;
	Sun,  2 Aug 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785683741; cv=none; b=NF7nOtex/GOSgGQZBGTCGHQP4HiNDpRcoJj6If7d8yVoZIgGA8a+UATTh3ssO6FACdkjvb3AIP2kTNgCWcL4iXc12mka/BbTGQumZ0+6LoSwlPmQe3Jqm+YwOjwlBTM7l/+Vdm32f7ujmiMiEwD1ehHhilCrqTPSPBbIjRPpuYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785683741; c=relaxed/simple;
	bh=urPKky9iUS+4jnryG34TFm1XyK7+FTAcIVwAzaFOXo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HXvn9oYBhySujr9I5++XQ/Gbo7UyDaij0unvQH8HJ5Y7KpwQgVU6kZvWXAtedsNdPEMjs2+fPKerR4i/4VmPY6aa1GLgsAYeVmg9qFcVnkKEJiVMEekaqn8BN6+uoeZzwu7hOQRXZiNUzfzXzo0IvCcRrEOBFdnV/r7MIS+Wtjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6TclGC2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6TclGC2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5144C19425;
	Sun,  2 Aug 2026 15:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785683741;
	bh=urPKky9iUS+4jnryG34TFm1XyK7+FTAcIVwAzaFOXo8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=m6TclGC2Fsx1eEWDXQT4tcv3jJ2g8ifewviD9qL43EjdZF2oTi6nPvb80q+DvNxWD
	 zJbWEcpsRmYd4YdPSJBK8MSsrBlyJfmdTm5ZA53r1R8n8do1pAil5CVB1BLWCpG5+E
	 NpWhSQ2DN9vuqlYLbiEyawldgow22tBWKph4A6C3kF3r86dyqyVajIUHPh3ESjmnDF
	 oPOOFVk3oznZGbX0P12VHS1nv3ht9TvktvrLCCGPl6FY7Ze5d2tS+KZ6swknmIqGlH
	 IrzP5pNEPJQ9pYQutOhjZGJ0lNpRcYjucH/mEUSW16S2NM4JfO/Jh2necD39nVZdv0
	 gyD+FAFm4HWGw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5E2C55162;
	Sun,  2 Aug 2026 15:15:40 +0000 (UTC)
From: Anuj Bolewar via B4 Relay <devnull+bolewara.gmail.com@kernel.org>
Date: Sun, 02 Aug 2026 20:45:39 +0530
Subject: [PATCH] drm/virtio: reclaim pending vbufs before tearing down vqs
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-virtio-gpu-reclaim-vbufs-v1-1-9947f18b20e2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJaYBUr2JctMMUxyiQKW1MC
 He36vIt/t8hsQonuDQ7KBdJsswV7akBuvt5YpSxGqyxg3HGYhHdZMFpzahMTy8vLCHHhJ1rByL
 n+xDPUPNVOcr7t77e/k45PJi27w+O4wOifY00fAAAAA==
X-Change-ID: 20260802-virtio-gpu-reclaim-vbufs-4816cc8a5bf9
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 syzbot+06f9b2a53ba4a5a47644@syzkaller.appspotmail.com, 
 Anuj Bolewar <bolewara@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785683738; l=3365;
 i=bolewara@gmail.com; s=20260802; h=from:subject:message-id;
 bh=Izg2s1bAooCdMR8KgRv32DrBTVJEQzFdlvpjw9zx8Pk=;
 b=h9UpYnkRd1lshg3i4knVzp2mmcS70EAs631fM2L1vfWoXejfRLFr5wdjYjmmFIl2x2aHrub6k
 ZYLD+9wWZkXAaA0hTCemICJrlbtBADgeCiAmowELimV6O9h/YVTVTof
X-Developer-Key: i=bolewara@gmail.com; a=ed25519;
 pk=XxcXxqFWk9xQziyNEfhS6NRJQR1shqHRRYzkbaYamm0=
X-Endpoint-Received: by B4 Relay for bolewara@gmail.com/20260802 with
 auth_id=907
X-Original-From: Anuj Bolewar <bolewara@gmail.com>
Reply-To: bolewara@gmail.com

From: Anuj Bolewar <bolewara@gmail.com>

virtio_gpu_free_vbufs() destroys the vbufs kmem_cache after the virtqueues
have already been released. Commands that were queued but never completed
by the device leave their vbuffers stranded in the virtqueue, so the cache
still holds live objects when virtio_gpu_deinit() tears everything down.
This triggers a WARNING in virtio_gpu_free_vbufs:

    BUG virtio-gpu-vbufs (Not tainted): Objects remaining in cache
    on __kmem_cache_shutdown()

Drain any buffers still sitting in the control and cursor virtqueues in
virtio_gpu_deinit() after the device has been reset and before the
virtqueues are deleted, following the same pattern used by virtio_console's
remove_vqs(). Each reclaimed buffer is released with free_vbuf(), dropping
the reference on any GEM objects it holds.

Reported-by: syzbot+06f9b2a53ba4a5a47644@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=06f9b2a53ba4a5a47644
Signed-off-by: Anuj Bolewar <bolewara@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 13 +++++++++++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 7449907754a..3e491c80873 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -332,6 +332,7 @@ void virtio_gpu_array_put_free_work(struct work_struct *work);
 /* virtgpu_vq.c */
 int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
+void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
 				    struct virtio_gpu_object_params *params,
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index b4329f28e97..e5a6ae679f3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -298,6 +298,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
 	flush_work(&vgdev->cursorq.dequeue_work);
 	flush_work(&vgdev->config_changed_work);
 	virtio_reset_device(vgdev->vdev);
+	virtio_gpu_reclaim_vbufs(vgdev);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index e5e1af8b8e8..95d7a9ef0d9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -208,6 +208,19 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 	kmem_cache_free(vgdev->vbufs, vbuf);
 }
 
+void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
+{
+	struct virtio_gpu_vbuffer *vbuf;
+
+	while ((vbuf = virtqueue_detach_unused_buf(vgdev->ctrlq.vq))) {
+		if (vbuf->objs)
+			virtio_gpu_array_put_free(vbuf->objs);
+		free_vbuf(vgdev, vbuf);
+	}
+	while ((vbuf = virtqueue_detach_unused_buf(vgdev->cursorq.vq)))
+		free_vbuf(vgdev, vbuf);
+}
+
 static void reclaim_vbufs(struct virtqueue *vq, struct list_head *reclaim_list)
 {
 	struct virtio_gpu_vbuffer *vbuf;

---
base-commit: 2d2338c93da79b3bfe4b6099a931d9468d539952
change-id: 20260802-virtio-gpu-reclaim-vbufs-4816cc8a5bf9

Best regards,
--  
Anuj Bolewar <bolewara@gmail.com>


