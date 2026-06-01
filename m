Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6E19D8AC
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300426; cv=none; b=CLCQtbuVRrXxJ5Na3V2c26aTwEqV2D/dbxdYJWHBsdUg/sMCc2cqh2BPuMReFHUTZJGisBJ0iF8ln88eNWgOmFrCwxlCV7BDoirTH6pLbsKo8qJZkdJrNjpYDBp1Eq1sW7jw6aXDOXNUMthGQJ+Ap5tKP0yWspWaQR61qkoEAno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300426; c=relaxed/simple;
	bh=CRwG2rJGEDYFeLkd5jVVham1q7EYVpz41iExl2XpiIs=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=IWG8CMlsuzMxwIk9YqoL0MAFGowvyAzGuEE0bdQFIyWXjXDQvg6oa7co3nNTz28lgj+1j35LPV6umblCPeR8E8+7SdtvIIzfsUEUjOulUe+nkrN+O2gvggwQufRxEfGPaeJc8lKDZNYyD6GbDZ5MM+3F1M6KKyjBxJHYFvhLwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U4/n6ebd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4/n6ebd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780300423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zIqhrXUwwJrpCl1gMsGp42AZVtWIyb4Pqr0eIXGPoJc=;
	b=U4/n6ebdYaxZzsw72VnRp1eBYLDP/dLhrr3RLoqLxqSXB3JOTWT5dj6ddBJnlSe3N3oBZC
	WV28R7VDpPs/q6n0spEepPXizjL1nRwMzXT/TYi6bl2dTGYISYvwySnvR+kaITPf3qOlid
	TXJ/uO6Zh6B0RW2XN/SGGf7532oqgUc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-vGwjzvruMVWsqrs7RPPJFA-1; Mon, 01 Jun 2026 03:53:42 -0400
X-MC-Unique: vGwjzvruMVWsqrs7RPPJFA-1
X-Mimecast-MFC-AGG-ID: vGwjzvruMVWsqrs7RPPJFA_1780300421
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c3315d31so11866685ad.3
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 00:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780300421; x=1780905221;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIqhrXUwwJrpCl1gMsGp42AZVtWIyb4Pqr0eIXGPoJc=;
        b=TSyfRX8f3VOxwgIMFOhoPohYKrdjeJtEhYxnddiawjmzrDYEHwQfl60eQkr1MEA5XX
         noz7ErLYSvglL9S5QaB3x2Yai5y+eHO3Vc3ov2KARnGZVG7fKdAxGuMps7nzi+0Y5UVF
         ZYOHmMa2WjpMjBQL654G8xUTViIy4pSz9a5CF3aQnigErZjFMEGf8mt+E8wGt9Pa9YhI
         TEtsGK3ZJm9o2IIdb2OikhyFW1fTvfNCld9+Kf2cxPKRwALo6gDrWY2Efmffdp4LWq8H
         dLNT5D6HjS4kfxMUByc5EjrReY+xcKe0OnrBjRpKv2C3h2NxP3nNOgO/LV0ON0ZXwZqy
         BIBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IW8DRP2xvhuOpTk72aJHntrnwJ4pl/UFLwi1xDwXNdoZDYVcHGTPH42Qu9sySXo7/9arkxYYYcz1tIzHnAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxO1PzzwXKhXiEnQUOP0ThAIQRSAkyMnknJIeM0xF2rjBB96rC1
	0OB+uSsmNvWjon6LGpzTbp48bMO+ilM4T6kVKUEGvL/9BcYl+k4LUWlFSIQ6dg7VFmHGG1ztJST
	XgqfuvOdNuq6ouYhWaTw2yjPOjovorLMtoqSLrgYmPjJoKH+y3StaxECEpPR3IlDgkMY5
X-Gm-Gg: Acq92OGkTVp/iPoi0c7veuwvWhgbgriJwJcz8fCIj76OyWgBZ2AVonk0QNOck1IeRs8
	xvcVbF7S5f0oz45vhmsYRb1QdTu6cdp1CBkIsa/O/dOrwrbyb71+zl+zJq8yJHuila/NrB4Zw2s
	AGB2LTLTQWiWVQAAGZPc//RxjJZ2tLZR+re8X6TllMQG6BGt619ZpQi+tgVy829WjUwCmi7MuHR
	mw/aGBFarfFTTY5IqtG1GgsUBZhu8XwpZfRQ51FKApIiOSa4P2nlzT4PdbE/jbwLI1FHsOgECVd
	DYUXbSCI+8IqFhfqlpf57pTAvSgkzmFSA7hZVH+Blp6gwMTOkSaOk/0GXS6SgkR+8QljXMyfToM
	YfE0lAE1Mcl/KWBYjI65yCDC+R7cfEFD3+ZHOGB62SQeg3+YlfRAtE4/Eg3x8zulr8Lhi0w==
X-Received: by 2002:a17:902:f78b:b0:2bf:9760:b953 with SMTP id d9443c01a7336-2bf9760bc6bmr96883285ad.14.1780300421002;
        Mon, 01 Jun 2026 00:53:41 -0700 (PDT)
X-Received: by 2002:a17:902:f78b:b0:2bf:9760:b953 with SMTP id d9443c01a7336-2bf9760bc6bmr96883055ad.14.1780300420534;
        Mon, 01 Jun 2026 00:53:40 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e7483sm93308075ad.14.2026.06.01.00.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 00:53:40 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Mon, 01 Jun 2026 16:53:15 +0900
Subject: [PATCH v3] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260601-virtio-gpu_wait_event-v3-1-89530517a98a@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2po+LKgr/8MQUukAs5CStlYN6
 b9biVuX5yT33BUCesIA52oFj4kCubmA2lXQT2YekZEtDJLLmmtxZIl8JMfG5dE9DcUOE86RaWN
 4zRt9GISEsl08DvTaute28EQhOv/ebpL82l9Rij/FJJlgujnVN2UaYbm6eLSTifve3aHNOX8A0
 PGvlrsAAAA=
X-Change-ID: 20260518-virtio-gpu_wait_event-5aa060754f12
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ryosuke Yasuoka <ryasuoka@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C5ur4GVovPWX65pK0sYcOJc9886pWyChROW_ag9yxeE_1780300421
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
wait_event() without any abort condition when waiting for virtqueue
space. If the host device stops processing commands, these waits block
indefinitely inside a drm_dev_enter/exit() critical section. Since
drm_dev_unplug(), which is called in device removal and system shutdown
call path, blocks on synchronize_srcu() until all critical sections
complete, device removal and system shutdown also hang.

Add a vqs_released flag to virtio_gpu_device and include it in the
wait_event() condition. Set the flag and wake up both queues in a new
virtio_gpu_release_vqs() helper, called before drm_dev_unplug() in both
virtio_gpu_remove() and virtio_gpu_shutdown(). When the flag is set, the
wait returns immediately and the command is aborted, following the same
cleanup path as drm_dev_enter() failure.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
Changes in v3:
- Remove Reported-by and Closes tag from commit msg because they are not
  related to this fix.
- Link to v2: https://lore.kernel.org/r/20260521-virtio-gpu_wait_event-v2-1-5796b3a71d03@redhat.com

Changes in v2:
- Update the commit message.
- Replace wait_event_timeout() with wait_event() using a compound
condition that includes a new vqs_released flag.
- Add virtio_gpu_release_vqs() helper to set the flag and wake up
both queues, called before drm_dev_unplug() in remove and shutdown
paths.
- Remove the hardcoded 5-second timeout. Recovery is now driven by
the driver flag instead of an arbitrary timeout value.
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 15 +++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++++++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a5ce96fb8a1d..e4fe5e0780f9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -119,10 +119,24 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 	return ret;
 }
 
+/*
+ * Release pending virtqueue waits so the drm_dev_enter/exit() critical
+ * sections complete before drm_dev_unplug() blocks on synchronize_srcu().
+ */
+static void virtio_gpu_release_vqs(struct drm_device *dev)
+{
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+
+	vgdev->vqs_released = true;
+	wake_up_all(&vgdev->ctrlq.ack_queue);
+	wake_up_all(&vgdev->cursorq.ack_queue);
+}
+
 static void virtio_gpu_remove(struct virtio_device *vdev)
 {
 	struct drm_device *dev = vdev->priv;
 
+	virtio_gpu_release_vqs(dev);
 	drm_dev_unplug(dev);
 	drm_atomic_helper_shutdown(dev);
 	virtio_gpu_deinit(dev);
@@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_device *vdev)
 {
 	struct drm_device *dev = vdev->priv;
 
+	virtio_gpu_release_vqs(dev);
 	/* stop talking to the device */
 	drm_dev_unplug(dev);
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 2f3531950aa4..5f7bb6cc6ba7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -235,6 +235,7 @@ struct virtio_gpu_device {
 
 	struct virtio_gpu_queue ctrlq;
 	struct virtio_gpu_queue cursorq;
+	bool vqs_released;
 	struct kmem_cache *vbufs;
 
 	atomic_t pending_commands;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 67865810a2e7..8057a9b7356d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	if (vq->num_free < elemcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
 		virtio_gpu_notify(vgdev);
-		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
+		wait_event(vgdev->ctrlq.ack_queue,
+			   vq->num_free >= elemcnt || vgdev->vqs_released);
+		/*
+		 * Set by virtio_gpu_release_vqs() to unblock
+		 * synchronize_srcu() wait in drm_dev_unplug().
+		 */
+		if (vgdev->vqs_released) {
+			if (fence && vbuf->objs)
+				virtio_gpu_array_unlock_resv(vbuf->objs);
+			free_vbuf(vgdev, vbuf);
+			drm_dev_exit(idx);
+			return -ENODEV;
+		}
 		goto again;
 	}
 
@@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->cursorq.qlock);
-		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
+		wait_event(vgdev->cursorq.ack_queue,
+			   vq->num_free >= outcnt || vgdev->vqs_released);
+		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
+		if (vgdev->vqs_released) {
+			free_vbuf(vgdev, vbuf);
+			drm_dev_exit(idx);
+			return;
+		}
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
 	} else {

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260518-virtio-gpu_wait_event-5aa060754f12

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>

