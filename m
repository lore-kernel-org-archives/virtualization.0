Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A775B206
	for <virtualization@lists.linux.dev>; Sun, 27 Sep 2026 04:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790482844; cv=none; b=TxnCVHX077B/wsfq+LjObtVo0A6JH80U9cMcUBX1OGV8Nrj8pFUyo+arIeZW27kTDaS3Xl6grVUF+xe3+LfGGCX2mgurrJEu+lWnnsySDJQveWeMHEanWMHURADMB5t/NcPuVAT4zkdVgJMtiRGFQl5YxQr50c/iTmVZDwFxnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790482844; c=relaxed/simple;
	bh=8dqQXg3QV+LIvbqmAhbrfa3IV7zf9uH2hdEdQDihmPA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PIUlny3MW1kYIobQcEHwJpepD3VcCtAQmVTpimiGTKCd6v+8lVSTkZJf6Lx6yZK56iTdJ0Vbw5SkG2nPQXls5m0S5hdNjRX3atQ2DEfwoBfweh+Aivf+J9gL7OcmxFVtiHkmN1s7rwQ7fn1EPLOgGS1xNKSsxbU9VzEiF1wKNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftB0hpDQ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftB0hpDQ"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so683714a91.0
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 21:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790482842; x=1791087642; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eDCmetS7q26pDTAMQ+r7lMzCxwM1hYCU7lPFcoUtvfY=;
        b=ftB0hpDQkFwaG+HaHVy35a6m5zvriqG6M2xsCWqZJ1RkP3ot3XmYln3UjT08RwW5Zp
         eqhGMP5Lot3Vhb8hoFIqWiRv4JrFHfZPQBXHC0P3jBiNC+stYkYYHyWxSGghKDZ6JLfG
         ZNBLSBJZDlbMx4TMSxWB+bb8hAK6FYpZdTghKoBdttoNk2GldQOnuMLh3IcOoyDpSLOq
         gjK7pY7ETdfs//Owatw55/Zssr4LAb/EdS0lfHga/7mU9cbBmmbanXTMQsxjn6yAMSDI
         iLMnTbOb7bN4WaGpXa32K0qyfWroFPdk4SzaidXBHH5iaFN19XEuSDjelcyasqKNgPkR
         Hb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790482842; x=1791087642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eDCmetS7q26pDTAMQ+r7lMzCxwM1hYCU7lPFcoUtvfY=;
        b=gnGpOli4V+LV7zoPfF/dIPYpZe8CNsgV9JMEloaRiwaDVXGffiqiMUSMVHLZ+z5f8E
         JenFFs8yqdK0Hbr16zezvz9E2u0yeDD42RasGghfuA8AVyp8jGdSNjO3xabQhYmDwLYt
         IE/1tqIhkRsrcbElG9Rni8uF/PAv41KfFYG/OSGHTPxue+aITAEYq1weQfUtglY6YZhB
         TzYq1yEznNYmmd8dckxTZtG2mKTyrLR0q1PaSm4XyxIvEQ2LxvHwjQ155UPxvnDbIqqv
         txfoyzVV0iilcoWNwC1M7QYWXW8qXkJqISXZMQw6bYZelJ5OMsBnQvD/Ztgn2B/Fqoae
         QSlA==
X-Forwarded-Encrypted: i=1; AKwUvBwgN1IPG1KC6hbeZX3HU3OJvG+jReXHODCt93+kF1CQrSs9Eh21Onm95oReoUlDMiC9FSLPt14KqA50JF88+w==@lists.linux.dev
X-Gm-Message-State: AFq9FYKK0OaenfHCj5DW9P0b1SdqKiY6AzT2aREVkROc8ggpPJ6VElip
	6uLkiVJQQxcp51vQ21ylXKmQ5z/17YTDLoXil/TMpGNJ7tDj5TjyZTlt
X-Gm-Gg: AYBFou2OHJuGDLPOMUpdaehfQNAPC3X83iZIhhiAY2upF6er1EKAkZ81riXnzjWg+PJ
	Ytc3tzTp0xsdISVMAkH79rOMx7JHNsOFiZV56bKX+dCnaoOqbx5NnADwp1KDlNGKZw8g6SnvlAY
	dS/HrBqG0c4h8fpCIXv4mQsiL1bqN0784SW9Yglq9kkQZmNtW6RKcObpOWBNqkcIwHytiF9EfTz
	Vs+R/ZU2QeGJVLT5OH/ZbntbEFflkYBFCPb0oPiTax1JZ1fAuLU9zII0BnIgZRKgn2mfeWV2Nje
	VwP8OK6swAnfpzKK7PhRH6tiEa5ehPe5FY9LMxJ+YUxHAwlId2JZnQaFGCosI2XpTjxFE5sDn88
	0qYAweZ1T0/My3w4LdXu8HLM6kr7Qduu/6yEnMTadokpG12FRxh0PRabfaO4d2HSprUF+zZdpXR
	oSyMw5Fa5eCUaOBWrgKwsl+Uip7JxgUT9jVbRTaXnbLjL3NUYcgcz6bN9hMb7mGXiVDIqanTkjo
	txEZfFH9q0rcE2i
X-Received: by 2002:a17:90a:dfcc:b0:3a0:cca0:4a8c with SMTP id 98e67ed59e1d1-3a0cca04bf4mr2596078a91.7.1790482841989;
        Sat, 26 Sep 2026 21:20:41 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:3a0c:2ea9:4ab7:bd1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b4f6345fsm5558223a91.1.2026.09.26.21.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 21:20:41 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Hillf Danton <hdanton@sina.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Subject: [PATCH v2] drm/virtio: drop the dedicated vbuf kmem_cache
Date: Sun, 27 Sep 2026 11:20:35 +0700
Message-ID: <20260927042035.19956-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpu_alloc_vbufs() creates a kmem_cache with the fixed name
"virtio-gpu-vbufs" for every device and destroys it from
virtio_gpu_release(), which only runs once the last drm_device
reference is dropped. If a reference outlives the PCI removal (for
instance an open /dev/fbN), a rescan probes the device again while the
old cache still exists:

  kmem_cache of name 'virtio-gpu-vbufs' already exists
  WARNING: mm/slab_common.c:111 at __kmem_cache_create_args
  Call Trace:
   virtio_gpu_alloc_vbufs
   virtio_gpu_init
   virtio_gpu_probe
   ...
   pci_rescan_bus
   rescan_store

kmem_cache_create() then fails and the new device does not probe.

A vbuf is 216 bytes and lands in kmalloc-256 anyway, so the dedicated
cache buys nothing. Use kzalloc()/kfree() and drop the per-device cache.

Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b129b44597a126d2d79
Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v2: (Hillf Danton) drop the dedicated cache and use kzalloc()/kfree()
    instead of sharing one cache across devices.
    v1: https://lore.kernel.org/r/20260926162452.136863-1-ngocthang2710.1999@gmail.com

 drivers/gpu/drm/virtio/virtgpu_drv.h |  3 ---
 drivers/gpu/drm/virtio/virtgpu_kms.c |  8 --------
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++--------------------
 3 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9df4c7117341..2639d9ec0470 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -261,7 +261,6 @@ struct virtio_gpu_device {
 	struct virtio_gpu_queue ctrlq;
 	struct virtio_gpu_queue cursorq;
 	bool vqs_released;
-	struct kmem_cache *vbufs;
 
 	atomic_t pending_commands;
 
@@ -361,8 +360,6 @@ void virtio_gpu_array_put_free_delayed(struct virtio_gpu_device *vgdev,
 void virtio_gpu_array_put_free_work(struct work_struct *work);
 
 /* virtgpu_vq.c */
-int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
-void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1d4d3bf46a20..047b591b5da2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -264,11 +264,6 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		DRM_ERROR("failed to find virt queues\n");
 		goto err_vqs;
 	}
-	ret = virtio_gpu_alloc_vbufs(vgdev);
-	if (ret) {
-		DRM_ERROR("failed to alloc vbufs\n");
-		goto err_vbufs;
-	}
 
 	/* get display info */
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
@@ -324,8 +319,6 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	virtio_reset_device(vgdev->vdev);
 	virtio_gpu_modeset_fini(vgdev);
 err_scanouts:
-	virtio_gpu_free_vbufs(vgdev);
-err_vbufs:
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 err_vqs:
 	dev->dev_private = NULL;
@@ -365,7 +358,6 @@ void virtio_gpu_release(struct drm_device *dev)
 		return;
 
 	virtio_gpu_modeset_fini(vgdev);
-	virtio_gpu_free_vbufs(vgdev);
 	virtio_gpu_cleanup_cap_cache(vgdev);
 
 	if (vgdev->has_host_visible)
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c02c03c10d92..5eb78d69f561 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -70,30 +70,13 @@ void virtio_gpu_cursor_ack(struct virtqueue *vq)
 	schedule_work(&vgdev->cursorq.dequeue_work);
 }
 
-int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev)
-{
-	vgdev->vbufs = kmem_cache_create("virtio-gpu-vbufs",
-					 VBUFFER_SIZE,
-					 __alignof__(struct virtio_gpu_vbuffer),
-					 0, NULL);
-	if (!vgdev->vbufs)
-		return -ENOMEM;
-	return 0;
-}
-
-void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
-{
-	kmem_cache_destroy(vgdev->vbufs);
-	vgdev->vbufs = NULL;
-}
-
 /* For drm_panic */
 static struct virtio_gpu_vbuffer*
 virtio_gpu_panic_get_vbuf(struct virtio_gpu_device *vgdev, int size)
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC);
+	vbuf = kzalloc(VBUFFER_SIZE, GFP_ATOMIC);
 
 	vbuf->buf = (void *)vbuf + sizeof(*vbuf);
 	vbuf->size = size;
@@ -110,7 +93,7 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL | __GFP_NOFAIL);
+	vbuf = kzalloc(VBUFFER_SIZE, GFP_KERNEL | __GFP_NOFAIL);
 
 	BUG_ON(size > MAX_INLINE_CMD_SIZE ||
 	       size < sizeof(struct virtio_gpu_ctrl_hdr));
@@ -205,7 +188,7 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
 		kfree(vbuf->resp_buf);
 	kvfree(vbuf->data_buf);
-	kmem_cache_free(vgdev->vbufs, vbuf);
+	kfree(vbuf);
 }
 
 void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
-- 
2.43.0

