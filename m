Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.249.96.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795680062;
	b=jZYNwI/doE/xAeY3z/S5bU12zIXhnQ7oOTlvii32Qbp1O4FuoMaRgCjIzYOtIpLvByU1
	 pso4+lELS+qu3rawoKkFDcQRuksezMKFoIDAdeBVWaGDI6TgxpZgsQkAr55MgpVC3sl7x
	 c2/2NLx9sbGXDU+fB6IecLPFEkS84+XTp4Pw7SuW2UpJ0hj593ty3RX5UBmapp+pprx/U
	 lHohSvU+UUkcchBMi0wE8pFJ+wWRRBZMGl65uNXiA+gdvEDwSdnEE4uhkqZKQ93rm6/xs
	 ve9e0yvjK/LuMP8WR0cmk0+QJ1VHD22rCcKmi5Edy0XMHUNWwop3L0LdoR6CQCCf6pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680062;
	h=DMARC-Filter:Received:X-Original-SENDERIP:X-Original-SENDERCOUNTRY:
	 X-Original-MAILFROM:X-Original-RCPTTO:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Kc2/0p3qS6oS0fgjdWA2m0XtBjYnJDeuGpYF19aCzek=;
	b=WY2DPiPeXdoMkeNrG1CTLjsGU8CdkRqgNr6IC6z++hLANP6dbRH6EU+NFhjPkhUUxfUU
	 aalyQBet/5f9j8OCULUSvb+Faem0V88Cz3TDxUhgngqnuzHGYdg7/3Fd26VgNdzUU8Xbt
	 Fj2MI+qqoZyLpXtAdGjXZX+sPsWkMnA2cutkRlyHE3EJEQ37rDIG55tAoUp9bkL7OfbyA
	 El+0qiGBDA2baVzYh7Yiq9ADW1Sgyk2TtlZaAW7YZ3/ka4l3UtrkQgXL4k7vmTr5vw6lU
	 y1bo/sUik+Uo/u+bqn5P1SjGV0P8mIBbdgpDc5jg99m5yVYTzkc3kspBdqJstwIMTJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uos.ac.kr;
	spf=pass smtp.mailfrom=uos.ac.kr;
	arc=none smtp.remote-ip=203.249.96.39
Received: from sniper.uos.ac.kr (sniper2.uos.ac.kr [203.249.96.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6A606A31C
	for <virtualization@lists.linux.dev>; Thu, 26 Nov 2026 08:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39B6A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uos.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uos.ac.kr
Received: from unknown (HELO localhost.taild276f1.ts.net) (love09010224@uos.ac.kr@1.229.202.195)
	by 203.249.96.39 with ESMTP; 26 Nov 2026 17:00:51 +0900
X-Original-SENDERIP: 1.229.202.195
X-Original-SENDERCOUNTRY: KR, South Korea 
X-Original-MAILFROM: love09010224@uos.ac.kr
X-Original-RCPTTO: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	security@kernel.org
From: Seojin An <love09010224@uos.ac.kr>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	security@kernel.org
Subject: [PATCH] drm/virtio: bound execbuffer commands to control queue size
Date: Thu, 26 Nov 2026 17:00:44 +0900
Message-ID: <20261126080044.2898223-1-love09010224@uos.ac.kr>
X-Mailer: git-send-email 2.43.0
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
stores the command in vmalloc memory. virtio-gpu maps each command page to
one SG entry, then adds a request and response entry before submitting the
chain to the control virtqueue.

With indirect descriptors negotiated, the driver accounts for the chain as
one free ring descriptor. An unprivileged render client can therefore
submit more SG entries than the device Queue Size. A sufficiently large
command also exceeds the u16 index range of a split indirect table, causing
the final SG entries to replace the request and first command descriptors
after the next index wraps.

Reject commands whose page count plus the fixed request and response
exceeds the actual control Queue Size. Perform the check before command
copy, object reservation, fence allocation or queue publication.

This also avoids relying on the current queue error path:
virtio_gpu_queue_ctrl_sgs() only warns when virtqueue_add_sgs() fails, then
advances sequence and pending-command state and returns success.

In a no-vIOMMU QEMU/virgl guest, the malformed chain let a render client
substitute RESOURCE_ATTACH_BACKING, obtain guest physical read/write and
gain initial-namespace uid/euid 0. On a 256-entry control queue, 254
command pages continue to complete and 255 pages now return E2BIG.

AI tools assisted the source audit, reproducer construction and patch
drafting.

Fixes: 5edbb5608256 ("drm/virtio: fix ring free check")
Reported-by: Hyeonjun Hong <hyeonjunhong330@gmail.com>
Reported-by: GEONWOO HAN <gunwoo9643@uos.ac.kr>
Cc: stable@vger.kernel.org
Signed-off-by: Seojin An <love09010224@uos.ac.kr>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 6580ece658704..9aff7f8d5195f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -482,6 +482,8 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	u64 fence_ctx = vgdev->fence_drv.context;
 	struct drm_virtgpu_execbuffer *exbuf = data;
 	struct virtio_gpu_submit submit;
+	u64 command_sgs;
+	unsigned int max_sgs;
 	u32 ring_idx = 0;
 	int ret = -EINVAL;
 
@@ -491,6 +493,17 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	if (exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS)
 		return ret;
 
+	/*
+	 * The command contributes one SG entry per vmalloc page in addition
+	 * to the fixed request and response entries.  Virtio requires both
+	 * direct and indirect descriptor chains to fit the device queue.
+	 * Reject oversized commands before copying or queueing them.
+	 */
+	max_sgs = virtqueue_get_vring_size(vgdev->ctrlq.vq);
+	command_sgs = DIV_ROUND_UP((u64)exbuf->size, PAGE_SIZE);
+	if (max_sgs < 2 || command_sgs > max_sgs - 2)
+		return -E2BIG;
+
 	if (exbuf->flags & VIRTGPU_EXECBUF_RING_IDX) {
 		if (exbuf->ring_idx >= vfpriv->num_rings)
 			return ret;

base-commit: 479e381e77dcde0dfcc9d51e89ff3273da199804
-- 
2.43.0

