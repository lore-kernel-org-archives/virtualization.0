Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1137D110
	for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644679; cv=none; b=r4ACqJLo/Zy0GWkBVu+TqMFkGcR7RhrmvAk5PhzdqI4H4zfBzUlddWIbHEJXqZdCAg6CCla5+v6iFbR/fU5uZdmDoVYscNDBNqCilKpAeSe/goe9rOt2q8+jwVIiDoG8mroHYvjXeWXLuPstB5DlOHVh1ep/JSL7u6azrLYB6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644679; c=relaxed/simple;
	bh=aFOuBcq8s0zAMZGmHPxTn6WLqCn5oqC7GIz+Ls65TFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJrrYaW15I5prVYvWhhjJl1p78GaCr2QwpvSXtqTatxVJ6tg78JTLsnD6Aw26y1u4XXUAQTeTGY60wvn0GR/kFT3OnGYN4tHxfKUzJWQU+X0RMYBwBpWzCyyYccQkPpyE918T2h2lD2tF6lxfXOTByposECttPZdrltgs4kOUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch6woluF; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch6woluF"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab752f6244so463968a91.2
        for <virtualization@lists.linux.dev>; Sat, 10 Oct 2026 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791644677; x=1792249477; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUdWymVuN1GgzXiVTLtzb4zC9ehLS9HDiJgUQVk5Mn4=;
        b=ch6woluFnYNsVyMdJ1ZokEYEmrXZCowsDfDgNnSqQTILlvvLjSFP617PyhuMi5TU4k
         zL0k1oKNXDVLt7c4h3xEptZAaTI6+Wu3K12X2HScrSHkMThfw9XzT5WGK6tgSeOvcLod
         jZc2jFJxiHCfxE/v+fIqc9Myr7Di5eD3t50EMvHqwAt7LJTc8EPxwZI/JK8R544p09iU
         jI2d0/27Ga9TpSHuVcinZTUdJjvQMd8WSheufPCYaTMoaC3GcWNOv+w6SzDqCPmV+hgC
         rl0cZsx4sMpmJrcW025j/bdMbJOqiSs6dpskC92yUczGh4kxowTHa/KgSaxMYEL6VCTB
         DAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791644677; x=1792249477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUdWymVuN1GgzXiVTLtzb4zC9ehLS9HDiJgUQVk5Mn4=;
        b=0WRkxGpNXueYenV7aTf9aYixZgkrMDpflOB/JcGt86AbokEhu/oz+gnB2gdbEkPIQg
         AfWtWxeSQZ7dG4agTJA7gwESYhOyEVWkvDWuYKJ8fnvv0ZdkxwS6QOCcY4pwF07hhMe2
         avHI9U5eqryg+xkbUjtSVHbfS+Wzi6MrMegSAl3HlZtR/GXDHF0LK6EuQqvnXaV7WVf2
         WAteRyUJ95KoXKTqru18WaWbs92dxfXXrbk+2/u48mJWjtvKygBhgxXlhmlyynL913NT
         UO+rd8PdKXhicFURBcZws0U3bbIElPZJPdXXdO8ZNA5fzomz0mQ8lF3kHoO76VZxg94j
         XaLQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNURFg09HA/39kCFPB5TaAsyRXsH7nUuuXdNiTlh2fbV3+SBVa0KOs7oUVT0q3AezqUJJnBJrQfY5y1Gy5FQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ5DtKzbBoPBBaKIVuF5F5yPVTxr5EeDtEiPnjgPc/f+LHYiVU3
	2McZCztnwOLDIic1OyamsZNLiY8VdTZlv/XSXa3V0804QGM1s0wnHtE1
X-Gm-Gg: AYBFou2kGq0uaH/TUBWDIALpAZYz9i4jJd3an1sukisZmL7oyOe/Bf/Rdf1YFiSVR09
	sUtir6zwgmph600AsNu4PlqXAdGsRvev++eODJzTA27nmB2hOyumj3RQ0wQ2jNdMS14GZM9QouY
	XMGb3uvA7wLLMu31oZHu4OkHlVSRZkCgsVkWP1ItH7Lq47+AFIrJvTWNtc1QzZdpSF+w2zLWzey
	jTI5dllRyUgKpfvfkbVQoCgnnln8BfRXOfGh06tfgRqbIQtXqPmo5r59wD9wSS/yzh/elBjKhZN
	GprhyIbG7djig0Anu5vX7e9AxRGpdXUmfiHmeayFfXTErR3JL6KKd6CUuB7rqsj/p90cR8e4ukr
	UPrZFIl/rQi9R1CKEWSB134FM0qed4AV5OSM9wwljG3D9/3q/vkFp9HsCYQ6j4JpjNOaDChPb80
	ZJd7mdP0655awGYCaDiTXxSLCEarO5pNdqOSSPKi+JVm9eWtO0+wTSx6pwo6W/4Y11kXsqZw==
X-Received: by 2002:a17:90b:3b84:b0:3ab:1b19:78f4 with SMTP id 98e67ed59e1d1-3ab3a3a11a1mr4404697a91.6.1791644676645;
        Sat, 10 Oct 2026 08:04:36 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7a80:50::3cf:2d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab397920b4sm4828242a91.4.2026.10.10.08.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 08:04:35 -0700 (PDT)
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
Subject: [PATCH v3] drm/virtio: share one vbuf cache across all devices
Date: Sat, 10 Oct 2026 22:04:29 +0700
Message-ID: <20261010150429.17036-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtio_gpu_alloc_vbufs() creates a kmem_cache with the fixed name
"virtio-gpu-vbufs" for every virtio-gpu device and destroys it from
virtio_gpu_release(), which only runs once the last drm_device
reference is dropped.

Two live virtio-gpu devices are enough to hit this: the second
kmem_cache_create() call finds the name already taken and
kmem_cache_sanity_check() WARNs. This reproduces at plain boot with
two "-device virtio-gpu-pci" on the QEMU command line, no sysfs
remove/rescan or held-open fd needed.

  kmem_cache of name 'virtio-gpu-vbufs' already exists
  WARNING: mm/slab_common.c:111 at __kmem_cache_create_args
  Call Trace:
   virtio_gpu_alloc_vbufs
   virtio_gpu_init
   virtio_gpu_probe
   ...

syzbot found the same WARNing through a different path: open an
fbdev node, then remove and rescan its PCI device over sysfs. The
drm_device reference the open fd holds delays virtio_gpu_release(),
so the old cache is still around when the rescan probes the device
again and calls virtio_gpu_alloc_vbufs() a second time.

Either way kmem_cache_create() still returns a valid (merged) cache,
so the device keeps working; the WARN is not a probe failure. But it
is a real defect: as the comment next to the check says, a duplicate
name "confuses slabtop, et al", and it is exactly what syzbot and
any panic_on_warn setup treat as a crash.

The vbuf size is the same for every device, so create the cache once
at module init and destroy it at module exit instead of per device.

Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b129b44597a126d2d79
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
No Fixes: tag. I could not pin down which commit introduced the
dedicated per-device cache (dc5698e80cf7, the original driver commit,
still used a plain kzalloc() pool); happy to add the right one if
someone can point to it.

v3: back to one cache shared at module scope (Dmitry), not kzalloc()/
    kfree() (v2) -- kmem_cache keeps the allocation off the general
    kmalloc slabs for this latency-sensitive path. Commit message
    corrected: the duplicate-name WARN does not fail the probe (the
    cache still gets created, merged with the existing one), and the
    trigger is any two live virtio-gpu devices, not just the syzbot
    remove/rescan path. Tested with two "-device virtio-gpu-pci" at
    once, and with one device torn down and rescanned while its fbdev
    node stays open.
    v2: https://lore.kernel.org/r/20260927042035.19956-1-ngocthang2710.1999@gmail.com
    v1: https://lore.kernel.org/r/20260926162452.136863-1-ngocthang2710.1999@gmail.com

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

