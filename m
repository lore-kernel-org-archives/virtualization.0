Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.249.96.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703927;
	b=RYqVYos04MKuT7KuT/rMfHCLJk1JAUfXRYEhCCKaEn9azqRypyKsYxRJPI7GOf2EVVIq
	 34CgfViN+IYqu59ngd0xYtY/DHbU6r7YTL4HQmnWhWrySRr/JhkBFilmCKr1FaAf1Gi4l
	 iedBwmvmI337lzUGkSHOCVPSqy/o/YeG9t3blTTrdT/B3u7WVf6Bu4WzPLb1Lf4TfXioV
	 LlkRwpZrUYWR6fAKmCq+qA6Ly0A41xuTWnkuApnesEBePJus9OuMgRLzgs2l6GU7Quxkk
	 BJfOZKVo4nqCaSbtR7cxwomwL43oo+2t0JLUcgEnbODhGLGIxsJp8FVGTwvraKHTvsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703927;
	h=DMARC-Filter:Received:X-Original-SENDERIP:X-Original-SENDERCOUNTRY:
	 X-Original-MAILFROM:X-Original-RCPTTO:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=knjIZkVDllAhP6vEe2V23F2Iuavx9arwvkclxm4MjII=;
	b=BkLMe4v9Q7euuUAW8sJLwR0stNZQISyIgAswOtsd1BK2FAHWakwWdwbuRIXOxHu1OlB3
	 wdlII/a3SmlOthyBWlxjtU4jenoTla2KPaczh6Fjcidq7+c70DlTlLYrQ1VHgVa5zUh5A
	 YT9AOWq0t07qCEcM68j1Oce6+GrjLuNEZnO9x09o3xiMTtCQyNiLg+aRIG7+xHowtwRg4
	 x49MaLo//eKI2Q4MXY0jO+64RwMEP9bvAWTISzvEJJL8hM4I2/f0FudEGEY8ltHkA/BFx
	 VpgsdXq1GFrAZT8JgZXP5oMu0q9PuFjhnTdcG2m87o+MnW3kot95A4SqGgkIVL2Vkfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uos.ac.kr;
	spf=pass smtp.mailfrom=uos.ac.kr;
	arc=none smtp.remote-ip=203.249.96.38
Received: from sniper.uos.ac.kr (sniper.uos.ac.kr [203.249.96.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA2606A321
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 14:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85AA2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uos.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uos.ac.kr
Received: from unknown (HELO localhost.taild276f1.ts.net) (love09010224@uos.ac.kr@1.242.174.244)
	by 203.249.96.38 with ESMTP; 26 Nov 2026 23:38:38 +0900
X-Original-SENDERIP: 1.242.174.244
X-Original-SENDERCOUNTRY: KR, South Korea 
X-Original-MAILFROM: love09010224@uos.ac.kr
X-Original-RCPTTO: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	mst@redhat.com,
	eperezma@redhat.com,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org
From: Seojin An <love09010224@uos.ac.kr>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [PATCH v2] drm/virtio: bound execbuffer commands to control queue size
Date: Thu, 26 Nov 2026 23:38:00 +0900
Message-ID: <20261126143800.3493685-1-love09010224@uos.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-235004@kernel.org>
References: <sashiko-outbox-235004@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM_IOCTL_VIRTGPU_EXECBUFFER accepts a user-controlled command size and
copies the command with vmemdup_user(). For a vmalloc-backed command,
virtio-gpu maps each page to one SG entry, then adds a request and response
entry before submitting the chain to the control virtqueue.

With indirect descriptors negotiated, the driver accounts for the chain as
one free ring descriptor. An unprivileged render client can therefore
submit more SG entries than the device Queue Size. A sufficiently large
split-ring command wraps the indirect table's u16 next index. The device
then consumes a chain different from the one constructed by the driver.

Reject command sizes whose vmalloc page count plus the fixed request and
response exceeds the actual control Queue Size. This execbuffer check does
not depend on the ring layout and applies to both split and packed
virtqueues. The driver creates one command SG entry per page even when
adjacent pages are physically contiguous. Read the queue size inside a
drm_dev_enter()/drm_dev_exit() section so device unplug cannot free the
virtqueue during the lookup.
virtio_gpu_queue_ctrl_sgs() takes a separate lifetime reference for the
later queue operation.

Perform the size check before command copy, object reservation, fence
allocation or queue publication. Oversized execbuffers then cannot reach a
pre-existing error path where virtio_gpu_queue_ctrl_sgs() warns when
virtqueue_add_sgs() fails, advances sequence and pending-command state, and
returns success.

In a no-vIOMMU QEMU/virgl guest, the malformed chain let a render client
substitute RESOURCE_ATTACH_BACKING and obtain guest physical read/write.
The client then gained initial-namespace uid/euid 0. On a 256-entry control
queue, 254 command pages continue to complete and 255 pages return E2BIG.

AI tools assisted the source audit, reproducer construction and patch
drafting.

Fixes: 5edbb5608256 ("drm/virtio: fix ring free check")
Reported-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
Link: https://lore.kernel.org/all/20261126080044.2898223-1-love09010224@uos.ac.kr/
Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
Link: https://lore.kernel.org/all/20261126080044.2898223-1-love09010224@uos.ac.kr/
Suggested-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
Suggested-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
Cc: stable@vger.kernel.org
Signed-off-by: Seojin An <love09010224@uos.ac.kr>
---
Changes in v2:
- Keep this change in virtio-gpu. Maintainer review concluded with no
  virtio-ring change for now.
- Clarify that the driver-side limit covers split and packed virtqueues.
- Protect the control-virtqueue size lookup with
  drm_dev_enter()/drm_dev_exit() so it cannot race virtqueue teardown
  during device unplug.

v1: https://lore.kernel.org/all/20261126080044.2898223-1-love09010224@uos.ac.kr/

tools/virtio exercises virtio_ring, not virtio_gpu_execbuffer_ioctl(), so it
does not cover this driver-side check. A rejection test in that harness would
instead test the core rule that maintainers chose not to add for now. The
Queue Size boundary and exploit-negative case were tested in a QEMU
virtio-gpu guest.

 drivers/gpu/drm/virtio/virtgpu_submit.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 6580ece658704..64d585bfdf626 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -482,7 +482,10 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	u64 fence_ctx = vgdev->fence_drv.context;
 	struct drm_virtgpu_execbuffer *exbuf = data;
 	struct virtio_gpu_submit submit;
+	u64 command_sgs;
+	unsigned int max_sgs;
 	u32 ring_idx = 0;
+	int idx;
 	int ret = -EINVAL;
 
 	if (!vgdev->has_virgl_3d)
@@ -491,6 +494,20 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	if (exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS)
 		return ret;
 
+	/*
+	 * The command contributes one SG entry per vmalloc page in addition
+	 * to the fixed request and response entries.  Virtio requires both
+	 * direct and indirect descriptor chains to fit the device queue.
+	 * Reject oversized commands before copying or queueing them.
+	 */
+	command_sgs = DIV_ROUND_UP((u64)exbuf->size, PAGE_SIZE);
+	if (!drm_dev_enter(dev, &idx))
+		return -ENODEV;
+	max_sgs = virtqueue_get_vring_size(vgdev->ctrlq.vq);
+	drm_dev_exit(idx);
+	if (max_sgs < 2 || command_sgs > max_sgs - 2)
+		return -E2BIG;
+
 	if (exbuf->flags & VIRTGPU_EXECBUF_RING_IDX) {
 		if (exbuf->ring_idx >= vfpriv->num_rings)
 			return ret;
-- 
2.43.0

