Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7227037F32C
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790439907; cv=none; b=lq2XUmHaAxkLdA6jkd2dydn0hwVgrxkVSzSYWkQ0aGPWVDvWysLZLVUGW0Cg9RCNiU23ZpPKGa/jxNSKkwW7lE251eKrqunhZKjB+Rfjxva1TppEitqRLktXWWR/Vtd4Xg81ekJ7ZYq7XAXncaqn2b5pXPhnkrzLjfM/GsnAEnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790439907; c=relaxed/simple;
	bh=ixeaZErFclci1n8yNGa8V3opsxlJMTYP3hAcmBz8kF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wc15JoijunXoJkylaolrfXl91rhQXqcZnygMebKWcyL5MmXJ+DaYF+wcxgAU1VyAmUMp68K9Gn4lSwQWPQ/Zsfcr/qB/aD90BKUKJQgovln71tAQ9OUWLkVRxeN0Bk84vL06phIVSjLGOHuJKYijGDcLehXerlTCNdR7n9+Tj9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1NNUW1j; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1NNUW1j"
Received: by mail-pz2-f38.google.com with SMTP id d2e1a72fcca58-881d9da69b1so74262b3a.0
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790439899; x=1791044699; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JxTb4rTnxrDZeiosOy7T/2r+lQDYr7z98o9aA1mZOX8=;
        b=N1NNUW1j1V8/1Rhy/k3IV5JwzIbUiP9CNfWD+o1dPy7ztyXI6IDYa3HHZTE5ijoPOH
         DWY6Uc71e1BddYq6fKL8ofTLLBWZS25em/FGIUZaVNSj2TrlcijyWZsZfSLk/TzkOG44
         dBRnd7N7OkM5UrdRQews87DKI+Bzdl1jcS0FuI49DKYZDVI1HsM5auoS6qODkx5K1Ky+
         9NpCs1JUDZBkqBpjSMJfQyksnMqP9JpyllZw5ep2XujBT28sEumnXjnySvVlh/KbZDY0
         VAQsMTuagy5XPECnY9+xkAfubwhdBwN3t5PpDSFM5z1/BMt+4Eo03PRV2EPvf8nh/v4w
         9AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790439899; x=1791044699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JxTb4rTnxrDZeiosOy7T/2r+lQDYr7z98o9aA1mZOX8=;
        b=WcCS9jSJU2eUDhVJw2n89AsQ/ycMzXNtPmiZtTRLwCGphs4jvulqpgLgBYhUpB0pIJ
         QFzLZnOX1EKsOosji815SRieF0Cqov8nYem4XndzgV0h40OgbU1cdU0BR34gTrqXiNsQ
         h0juP58dPP7qoQyCXKt0G84kE5g+Dy5kuB5J0RqLYIeEdQEGl9rXjIYKfXqTRDJ/55sm
         wZjIuTEWAV7HrGqy2M61vzVqV32zzuqGFMzAOFh1v3n4NHMsalEFF2gdmvbUmkamvIwr
         A8EHFvWONw/B0QKe3d4+WPKT0uhbjo364HNkWryShpdE0rL4Kh2qIFPisYSnuihhTNJD
         0RAg==
X-Forwarded-Encrypted: i=1; AKwUvBwLMSZhXDn2Yk9RoN9v3Hwp5QnC3l6k6XVFhffs0uH498yd3Lhb0Tpg0VwP4C4e4D5UhrFIAnCT/iTXdpeZzQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lYKIMJN/9tcjldUOOTY2DDwnZFO8GSQ1UrTVl5rVULopiGyy0K
	yd8lQDPVhn9oINizG3ExWuR4AvjgphDnsiQsQZ5zzz4I4+WSFDx/BlhN
X-Gm-Gg: AYBFou0cQDZLhyFCgUFaUGNBCmMICceI+Cg4VCcoRB68nYGP3vqQC5RPh824BgGND6L
	YIcq3GvvmsNUeLShKzM9cEo5GKbo8coTN8ADyPN4OmRnX0Uv1fdp6UfKxUUK9NRbgZJWg66CQ9G
	6MNzHbTdGDKtt3hWUw0DYjiFULM/1Af+h7wLmV1X/3rAdFiodPdZeSALbKsBuKBTCLrfLMJURgn
	vDTL3FMvIsBRh9X3KAUW4FZhFMxWBsjRsEHhgH48QSJS5AZOKCiyMANY69pNF5Sr3hOrL517Ben
	+fRoGamWyggRjqOfVFDlSndZZsfwuXcy4af8lhJEbg8zg3sG+lWibcc4B4NeAwQKN510jtz174u
	IOTRtNGFbJtKumpd2WnLVP/qHAXTxNEPp/k2JOEC6ZTYvFwrU+GgpchggThBSyjLLw7DwR7FIFG
	JsJYLPCz72aiEZ0baMdEbRWPhv4YLnxZSq2FlS/d2gtKEbk/JbB4AzgNbmVK0XKfepfSIsFEUVQ
	agtRtnoGUH/5VSdZEBUJ55MA6Y=
X-Received: by 2002:a05:6a00:4099:b0:87c:3660:fa76 with SMTP id d2e1a72fcca58-87e9b69f43fmr6347352b3a.34.1790439898653;
        Sat, 26 Sep 2026 09:24:58 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:a00e:c90a:972a:c5a2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea19800esm2323249b3a.10.2026.09.26.09.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 09:24:58 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Subject: [PATCH] drm/virtio: share one vbuf cache across all devices
Date: Sat, 26 Sep 2026 23:24:52 +0700
Message-ID: <20260926162452.136863-1-ngocthang2710.1999@gmail.com>
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

The vbuf size is the same for every device, so create the cache once
at module init and destroy it at module exit instead of per device.

Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b129b44597a126d2d79
Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 13 ++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h |  5 ++---
 drivers/gpu/drm/virtio/virtgpu_kms.c |  8 --------
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 26 ++++++++++++++------------
 4 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 2aaa7cb08085..eec6f73a4c15 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -283,6 +283,10 @@ static int __init virtio_gpu_driver_init(void)
 	struct pci_dev *pdev;
 	int ret;
 
+	ret = virtio_gpu_vbufs_init();
+	if (ret)
+		return ret;
+
 	pdev = pci_get_device(PCI_VENDOR_ID_REDHAT_QUMRANET,
 			      PCI_DEVICE_ID_VIRTIO_GPU,
 			      NULL);
@@ -291,7 +295,7 @@ static int __init virtio_gpu_driver_init(void)
 			VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM);
 		if (ret) {
 			pci_dev_put(pdev);
-			return ret;
+			goto err_vbufs;
 		}
 	}
 
@@ -305,12 +309,19 @@ static int __init virtio_gpu_driver_init(void)
 		pci_dev_put(pdev);
 	}
 
+	if (ret)
+		goto err_vbufs;
+	return 0;
+
+err_vbufs:
+	virtio_gpu_vbufs_exit();
 	return ret;
 }
 
 static void __exit virtio_gpu_driver_exit(void)
 {
 	unregister_virtio_driver(&virtio_gpu_driver);
+	virtio_gpu_vbufs_exit();
 }
 
 module_init(virtio_gpu_driver_init);
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9df4c7117341..f6009fc8472f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -261,7 +261,6 @@ struct virtio_gpu_device {
 	struct virtio_gpu_queue ctrlq;
 	struct virtio_gpu_queue cursorq;
 	bool vqs_released;
-	struct kmem_cache *vbufs;
 
 	atomic_t pending_commands;
 
@@ -361,8 +360,8 @@ void virtio_gpu_array_put_free_delayed(struct virtio_gpu_device *vgdev,
 void virtio_gpu_array_put_free_work(struct work_struct *work);
 
 /* virtgpu_vq.c */
-int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
-void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
+int virtio_gpu_vbufs_init(void);
+void virtio_gpu_vbufs_exit(void);
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
index c02c03c10d92..769b6e70feda 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -70,21 +70,23 @@ void virtio_gpu_cursor_ack(struct virtqueue *vq)
 	schedule_work(&vgdev->cursorq.dequeue_work);
 }
 
-int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev)
+/* Shared by all devices: a per-device cache would collide by name. */
+static struct kmem_cache *virtio_gpu_vbufs;
+
+int virtio_gpu_vbufs_init(void)
 {
-	vgdev->vbufs = kmem_cache_create("virtio-gpu-vbufs",
-					 VBUFFER_SIZE,
-					 __alignof__(struct virtio_gpu_vbuffer),
-					 0, NULL);
-	if (!vgdev->vbufs)
+	virtio_gpu_vbufs = kmem_cache_create("virtio-gpu-vbufs",
+					     VBUFFER_SIZE,
+					     __alignof__(struct virtio_gpu_vbuffer),
+					     0, NULL);
+	if (!virtio_gpu_vbufs)
 		return -ENOMEM;
 	return 0;
 }
 
-void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
+void virtio_gpu_vbufs_exit(void)
 {
-	kmem_cache_destroy(vgdev->vbufs);
-	vgdev->vbufs = NULL;
+	kmem_cache_destroy(virtio_gpu_vbufs);
 }
 
 /* For drm_panic */
@@ -93,7 +95,7 @@ virtio_gpu_panic_get_vbuf(struct virtio_gpu_device *vgdev, int size)
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC);
+	vbuf = kmem_cache_zalloc(virtio_gpu_vbufs, GFP_ATOMIC);
 
 	vbuf->buf = (void *)vbuf + sizeof(*vbuf);
 	vbuf->size = size;
@@ -110,7 +112,7 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL | __GFP_NOFAIL);
+	vbuf = kmem_cache_zalloc(virtio_gpu_vbufs, GFP_KERNEL | __GFP_NOFAIL);
 
 	BUG_ON(size > MAX_INLINE_CMD_SIZE ||
 	       size < sizeof(struct virtio_gpu_ctrl_hdr));
@@ -205,7 +207,7 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
 		kfree(vbuf->resp_buf);
 	kvfree(vbuf->data_buf);
-	kmem_cache_free(vgdev->vbufs, vbuf);
+	kmem_cache_free(virtio_gpu_vbufs, vbuf);
 }
 
 void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
-- 
2.43.0

