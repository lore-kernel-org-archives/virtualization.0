Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1B7357CF3
	for <virtualization@lists.linux.dev>; Thu, 21 May 2026 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330007; cv=none; b=PMWfui/FKLVcV3UuzQDRv/ju1n4rTpctPNYA221PZ+dN+EBAAihHYS3okitsW4SfrG70o32GipzFPbq4wwMSptylNulZz6nDwgSzCY468DN2kkVAK72wAmqmmDHkWJ8gHSYyWGS8/FkjLE2MCEHKEn3Fn3+tnSGBwma75wEskFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330007; c=relaxed/simple;
	bh=ni6G5U+k1G9Sw9K9BmbNeEkePNB5kcEvXutkwaGb5sA=;
	h=From:Date:Subject:MIME-Version:Message-Id:To:Cc:Content-Type; b=EBy1xRICj0VKS+PC4VL5tElj8sA7Xvv6qzHYunjBLs2X2rw1TCaDRvLyyo2eDTi5mJ0dg2ZDND2IP7A3rDhI2NTMKEHYRc/bwwWKxcmD0gteU9FemgfmVelbuJLraqTOnzsXbYDSm2VWZ0RvHJ8ka6EHAxU2PfWV0rUX+tjMEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHpU51gQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHpU51gQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779329986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ViVUeVTHXm/181QtK6ZWvQ/pgMe3DIC+vbJkDxzogvM=;
	b=FHpU51gQw5S7gGnixPJg9aSEznm1qqtzP9RIefNEKVUFgRLxk8IEy7GdG7nK8rMQnMTjHs
	DbLSmwUQlCczNdt/FaTPva/aEDCTYl2GosgPTMuULCxO78TTRVQzfdangrTmIw/kky+52H
	VvqfEz6tEqPIklMpH22z2JLDy39Rsdg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-w0Z4YHTJPDGwqiF3Vi8I7w-1; Wed, 20 May 2026 22:19:45 -0400
X-MC-Unique: w0Z4YHTJPDGwqiF3Vi8I7w-1
X-Mimecast-MFC-AGG-ID: w0Z4YHTJPDGwqiF3Vi8I7w_1779329984
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso3345473b3a.1
        for <virtualization@lists.linux.dev>; Wed, 20 May 2026 19:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779329984; x=1779934784;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViVUeVTHXm/181QtK6ZWvQ/pgMe3DIC+vbJkDxzogvM=;
        b=stiUBhIh7BdW7duhTER43b7Z2z0FCI0qu/OhVA/nr9skSUuqaG5vQn5czT3muA4fQN
         tSdHYyX649QnneJkNM++QLCXKesEZlPD06uke4WPf14QLsY2J1UCwX6oMgTcKgnJgKGO
         JBIWRbQsvRK7VnrpN5JDjd7l1HGu7x5bQEpo952zXPYLz+UkHCRRaXjtkpiOIWNteH9s
         gN1HxGCl43/7DdnBAkVDTQfZhUJ8l/uLoZOQX6QOSKuH9gejY9y2aym+mgYESqp0473P
         d08KiQHMnaH8XDDd0mnW1PZbaptrr501EvWRcq9sJnJH/rhYeE+QO/Fy2jqYqe8kNZ4N
         NRbg==
X-Forwarded-Encrypted: i=1; AFNElJ/v3LyjVGiO+LVfyDjQYDzX28UqHSlj/ajPB1+S1K5493kjs5swV251GDlRGJNFDcc5nbv8MoDmCfH2LD5mag==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZVz2KQnhe5OJtFjqayS7ndsmwToRGRuqjW5QDyiovfdb36cGC
	VjWVKF2TSLBijHM5bz07E0065Mt/6iG3xQpvzUzBz2DiPvf6wO4oKYe8cVoL2jS75j7Avi+pxTa
	XLf2KCW7jNMP6HYbWsXxF434Ahce8nVeVJXPPOCCbIzSRWZYxLPDuF/J7UHS0o19vMm5H
X-Gm-Gg: Acq92OFOSfTx81J+/GMUC5x5uBasyeTgocanB5gVon5l3phsSbaYs79Kw3uYgsYROGs
	j0galDdscd3Z7M9DtidMN5eV4YdCq2gX82eq+nB+YEovqZOPVRTQE/Y0YUphrjOCQ32hxE3YlzC
	UHsEV1IPCb3J0+OMVXx4MkUTBCnVO8lUzyYmr8jPPYfLTLSIhApEQ/mEWbQYUjLCCRemxNNpo0u
	feBRAU+nd4ey8KJeY/chUmNTEl+NN64SciWua5eE4A0sD5z6Qr5lkrfFKRvtd9bVCbostR1SQFr
	5eG8ngaDFr5ETfhXlWPdW1SEkA9ilLeY0wNCCExka/LnXrDBLvkL4O4I4CNz12Hlcp3oP9FcGFo
	k6yc6meK91B9s50lB64191ukD/PhX+1a7Tw6sl8mg8uvSjxptg5mYiYb2oTQ=
X-Received: by 2002:a05:6a00:aa06:b0:82c:d6d3:3190 with SMTP id d2e1a72fcca58-8414ae0ed26mr938746b3a.38.1779329983821;
        Wed, 20 May 2026 19:19:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:aa06:b0:82c:d6d3:3190 with SMTP id d2e1a72fcca58-8414ae0ed26mr938716b3a.38.1779329983304;
        Wed, 20 May 2026 19:19:43 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19f7cc9asm28041546b3a.53.2026.05.20.19.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 19:19:42 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Thu, 21 May 2026 11:19:35 +0900
Subject: [PATCH v2] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260521-virtio-gpu_wait_event-v2-1-5796b3a71d03@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBNUsqKrRIjUWLMxUbNAunvS8
 i3+LxAxEEaYmgIBM0U6XYVsG1gP43ZktFWD5LLnSowsU0h0st1f+jaUNGZ0iSljeM8H1VkhobY
 +oKXn/87L+37DcNH7ZwAAAA==
X-Change-ID: 20260518-virtio-gpu_wait_event-5aa060754f12
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com, 
 syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com, 
 Ryosuke Yasuoka <ryasuoka@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PmvMRjRl1L7W6GoxVK8mRFlJOnS_t6RDeygoUPAZfZc_1779329984
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

Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
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
index f17660a71a3e..0bd69a40857e 100644
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
base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
change-id: 20260518-virtio-gpu_wait_event-5aa060754f12

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>

