Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8861DBB3A
	for <virtualization@lists.linux.dev>; Mon,  5 May 2025 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435602; cv=none; b=syKEDF+TVHJ66YoN3FVMFRRbrHVkyvjL4Ks09PgAIZCOqXAWig6pFd+pLxfmlcW6ZR41RJZohEfuoLSIutHiDGTK6ntS1fUP2VRlaa2Kh4KwVlfZwOYftRfI7PLhFzUg1hkKVz6KXgJRJMsVytkaV5pfXwxP0WRxbzdWxXO6uDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435602; c=relaxed/simple;
	bh=OYk5xWoiYBD7378UCy/vdTy18gxwYbd0oasIs8ZX39M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lf4jVz/8rTWFm+3hJNg02ns8gwRznA39AizWsIFgws+uI7Ba0BYL/49oT6ff9EW56rfAXvi3r7bUbRuj8Y2+Lc8eluR1kwelF/CSCytjdIL3Ozw2aXL+5HLYeLViqEGQmzrGJGTZqVpi2OH5ts2xE69zlgWSmttYYr6Be3yraOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eb8tAzIn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eb8tAzIn"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso25434565e9.0
        for <virtualization@lists.linux.dev>; Mon, 05 May 2025 02:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746435599; x=1747040399; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ran6W4sJDMQBCxVZgAL/1b0rzUGuXX9AnOQzXDraEE8=;
        b=eb8tAzInRFiwRmTUVIypQFbvlu1EP+0WRDDDRiu6T5hp2p55cyP4ytQtg53GSbvUJC
         3ON7Bqff/VJ69Bc4KN2j4oLqcGXyPKsRwSSdt4dm4zaVj22i3wMj3D1gOBMpKyQxCRNe
         04fNQ4h1aVZZ+Tvcmt5jEa2Bpf69DrRiIRD3wKVCcB5BoYlLxBK9CTzWkUQLT6ZaeQxk
         BPoFlwBZgp/5FRku0NUJDZl48yBuNDrfOMkBK0YLU7KNsm44AI4NRC9xrr11LW83OnhA
         CaKkdgNeDOznA3eH54ZYJqTrQf7JL8nm+8zo2klZm7BZ14Y60EP9S3tlk0ftqGNOWQxY
         8abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746435599; x=1747040399;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ran6W4sJDMQBCxVZgAL/1b0rzUGuXX9AnOQzXDraEE8=;
        b=leF85UhD4M0rkZssCfG8t9OQ3kjyFJBGrw91LarCLVMKfL2b3PaS+2VOapCxZh4wva
         CffnSa+r8QQHC8PvZIRsNUJ/k4Y7nW06aIutU5VveDtHOPFLm1tkpqvSFlOnQ8y9WjDU
         32V2WE051NELOCt1GR2P8dGUKSVNIBBbsUoZTIg255ttY4Zv2Rkyzi3d4glLZ3XBUq6E
         NiVu0hcllYxeDVn1U0uNgNpW2wK6jjHDDqIcInpWOxRS6reM6IRx/M/YobmO5UFM2EwS
         0Le2zJXc1evc35kbnZyc6K4RjK+79z+f899KBlvGLbKG+OXAMD6QYsncnwekeKfjglzS
         Hy2g==
X-Forwarded-Encrypted: i=1; AJvYcCXRXxNk71AH7PIdaQuIBjZI42dBAm0C0twkVZsr0IXUyudCWkixIqC51Z/JyjEhSDt1gbHjyRuRzmRFqzeVZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMRKXbXeJPR/gM8+T7vtsBz0rB6rfjuRJ83SZ5sCnNgytqB4Gp
	5wAzWthpff12qDDlh3PAKoJgYV/4rZMBNyUbbBy7Fo1NvFHiSmPMnqjJNN12jf0=
X-Gm-Gg: ASbGncuJBlEDAa+wM6hQayQ6Ft9FrYDZfKMT4l1V5pwXAvW0uk4HSZmCQDP9HPYbZL0
	juJxRcJgfyc5Dq3htWKY7KUuraXpd1v6/xX+a+gsUBTMvKkUqKvvWie/x+pctfOtWBSuwXBfid3
	He7hh8HB72qw032eKTdhIg1j7vmXe+5bT1docVejNz10QMmAhf3qQu9jjE0z9+tef8cJuPpTe46
	GxM2gPfa9noJIDzlWeJzcZriReL3wEsY1LMv87unhcn35vXWyT8w9pZg/9F2UHCDN31AVjUHIJZ
	KlfwSrkEzYe++AAMhHMCpcrgPn27j0phcrJSWLvw5HUmsVdHq16uM1vMBj27+ZPV5ST2E0lf7Oi
	spjdN
X-Google-Smtp-Source: AGHT+IHu1aFkaGJDMuAfmjtWFpiOlbSYtoQaF7Z8xjJBAeiyk95dcMoYAZNA/8ikLK7E9LhC6iGaVw==
X-Received: by 2002:a05:600c:698c:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-441bb8483d2mr99825685e9.2.1746435599128;
        Mon, 05 May 2025 01:59:59 -0700 (PDT)
Received: from [127.0.1.1] (adsl-186.37.6.163.tellas.gr. [37.6.163.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28045sm170432475e9.35.2025.05.05.01.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 01:59:58 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 05 May 2025 11:59:14 +0300
Subject: [PATCH 1/3] virtgpu: add virtio_gpu_queue_cleanup()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-virtgpu-queue-cleanup-v1-v1-1-810923da2b1e@linaro.org>
References: <20250505-virtgpu-queue-cleanup-v1-v1-0-810923da2b1e@linaro.org>
In-Reply-To: <20250505-virtgpu-queue-cleanup-v1-v1-0-810923da2b1e@linaro.org>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, dri-devel@lists.freedesktop.org, 
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6535;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=OYk5xWoiYBD7378UCy/vdTy18gxwYbd0oasIs8ZX39M=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm9HSDRMQVdPRnJuMjFRazVtV01uOEp3ZVUrVG5jClZhdDFDV0dpTFlZdFBLK3BT
 ZnFKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKYUJoK0N3QUt
 DUkIzS2Nkd2YzNEowSlBrRC8wVkNaa0JaV0dDNVhEV2dlSi9EMitpaEdaTWJNR2FiOVBjenE0cA
 o4eUd3VCtGcFVyY3hYU0R5d055MlFoazFKNmhFaHlnM3ZhMFBHelU2OVQ5NXRJM3ZWNHZBelRzb
 lhhSFdJSmpwCndaQlhqNjlJQzFpTFBrM3IrZkhpaWVPakU0UHZxOUpIZDcvY3pmSVhLRWlBNXNJ
 bW1DYTRkZHI0YTFBb2JOR3cKaXhDbDlPb2lFb0Z5aGJrQzJWUDVWV0R3T2REeDk2LzkzeUxmVkx
 HL2h0NWxrOUN6Y09zMUNycmRMbyt6cE9rNQptMXBOVGxBNis0WDF2UjJlWnZRclVRdStmN2ZGQl
 QySmhEeXh3WjhYZXoxelNSSG4zSGZGVjFzVXNDSUZhK0hsCkhKWTJSemlVYTdLUUoxQm9wRFg5Q
 TNKWEVHNXQ5K09vMzlZRkQ4c0J6UmgyRTAySUxSZkVhaUV5MDdqbEtKaXEKMEs1b1JhcHdneTZu
 MWIzQjJ6WmpUbjVNcVFjUUVGTSt1dGVnbUpJM2tYMjNBMnB2a3l3c0c0L0pWRnZUeENBMApQbzA
 rOGNZRzU5NklENVdUN2U1czVCcHhUK2lMV2hMMzJZNXpWNDhiN3UvU3dHWmxsbFd2a25LUVZyZE
 szZXMyClM1b2RSbnhwMjlLN1oxMEJSS3BFSzZ2NExrWGR4NHZ2VHRtMThkRUhKamYxdklhSy92K
 1E2eFdwU2duRGpOMzUKMkR2bUdWeWRPWjNYZW54dzd6UElVTCtpdEdOQkVqdnZ3M0sza2FmaDBW
 NVJzd1RJZ2UzcUVHVmg3Y2o2MXZUYQpOL3R6L04yd0QvRTJ2SUpnK3p5MHpodG0rTXc1RTJUNys
 rNlpQK1B4REFlb3JIQ1Q5Qkt2VnM0U0NJT0J2dW1yCkl0RzcwUT09Cj04Nkx6Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1

When virtio_gpu_remove() is called, the queues are flushed and used
buffers from the virtqueues are freed. However, the VIRTIO device might
have left unused buffers in the avail rings, resulting in memory leaks.
KASAN, slab debug and drm_mm_takedown all report the errors:

 BUG virtio-gpu-vbufs: Objects remaining in virtio-gpu-vbufs on
 __kmem_cache_shutdown()
 <- Snipped backtrace ->
 Object 0xffffff801b07c008 @offset=8
 Allocated in virtio_gpu_get_vbuf.isra.0+0x38/0xb0 age=4314 cpu=3
 pid=540
  kmem_cache_alloc+0x330/0x3a8
  virtio_gpu_get_vbuf.isra.0+0x38/0xb0
  virtio_gpu_cmd_resource_create_3d+0x60/0x1f0
  virtio_gpu_object_create+0x388/0x468
  virtio_gpu_resource_create_ioctl+0x1f0/0x420
  drm_ioctl_kernel+0x170/0x248
  drm_ioctl+0x33c/0x680
  __arm64_sys_ioctl+0xdc/0x128
  invoke_syscall+0x84/0x1c8
  el0_svc_common.constprop.0+0x11c/0x150
  do_el0_svc+0x38/0x50
  el0_svc+0x38/0x70
  el0t_64_sync_handler+0x120/0x130
  el0t_64_sync+0x190/0x198

 ------------[ cut here ]------------
 kmem_cache_destroy virtio-gpu-vbufs: Slab cache still has objects when
 called from virtio_gpu_free_vbufs+0x48/0x70
 WARNING: CPU: 0 PID: 483 at mm/slab_common.c:498
 kmem_cache_destroy+0x114/0x178
 <- Snipped info ->

 ------------[ cut here ]------------
 Memory manager not clean during takedown.
 <- Snipped info ->
 ---[ end trace 0000000000000000 ]---
 [drm:drm_mm_takedown] *ERROR* node [001000eb + 00000080]: inserted at
  drm_mm_insert_node_in_range+0x48c/0x6a8
  drm_vma_offset_add+0x84/0xb0
  drm_gem_create_mmap_offset+0x50/0x70
  __drm_gem_shmem_create+0x94/0x1d8
  drm_gem_shmem_create+0x1c/0x30
  virtio_gpu_object_create+0x68/0x468
  virtio_gpu_resource_create_ioctl+0x1f0/0x420
  drm_ioctl_kernel+0x170/0x248
  drm_ioctl+0x33c/0x680
  __arm64_sys_ioctl+0xdc/0x128
  invoke_syscall+0x84/0x1c8
  el0_svc_common.constprop.0+0x11c/0x150
  do_el0_svc+0x38/0x50
  el0_svc+0x38/0x70
  el0t_64_sync_handler+0x120/0x130
  el0t_64_sync+0x190/0x198
 [drm:drm_mm_takedown] *ERROR* node [0010016b + 000000eb]: inserted at
 <- Snipped info ->

The leaked objects are also reported in /sys/kernel/debug/kmemleak.

This commit adds a cleanup function that is called from
virtio_gpu_deinit().

The function cleans up any unused buffers from the virtqueues and calls
the appropriate freeing functions. This is safe to do so because
virtio_gpu_deinit() calls virtio_reset_device() before calling the
cleanup function, ensuring no one is going to read from the virtqueues.

The cleanup function checks for used buffers on the queues, and
additionally calls virtqueue_detach_unused_buf on each queue to get any
buffers that did not have time to be processed by the VIRTIO backend.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 55 ++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f17660a71a3e7a22b5d4fefa6b754c227a294037..b3d367be6f204dbc98bf1c6e5c43a37ac8c0d8b3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -419,6 +419,7 @@ void virtio_gpu_cursor_ack(struct virtqueue *vq);
 void virtio_gpu_dequeue_ctrl_func(struct work_struct *work);
 void virtio_gpu_dequeue_cursor_func(struct work_struct *work);
 void virtio_gpu_panic_notify(struct virtio_gpu_device *vgdev);
+void virtio_gpu_queue_cleanup(struct virtio_gpu_device *vgdev);
 void virtio_gpu_notify(struct virtio_gpu_device *vgdev);
 
 int
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 7dfb2006c561ca13b15d979ddb8bf2d753e35dad..da70d9248072b64786a5d48b71bccaa80b8aae8f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -286,6 +286,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
 	flush_work(&vgdev->cursorq.dequeue_work);
 	flush_work(&vgdev->config_changed_work);
 	virtio_reset_device(vgdev->vdev);
+	virtio_gpu_queue_cleanup(vgdev);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 55a15e247dd1ad53a2b43b19fca8879b956f0e1a..fd150827e413cedcec4d82b0da8d792cb67e243f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -299,6 +299,61 @@ void virtio_gpu_dequeue_cursor_func(struct work_struct *work)
 	wake_up(&vgdev->cursorq.ack_queue);
 }
 
+/* deallocate all in-flight virtqueue elements */
+void virtio_gpu_queue_cleanup(struct virtio_gpu_device *vgdev)
+{
+	struct list_head reclaim_list;
+	struct virtio_gpu_vbuffer *entry, *tmp;
+
+	INIT_LIST_HEAD(&reclaim_list);
+	spin_lock(&vgdev->ctrlq.qlock);
+	do {
+		virtqueue_disable_cb(vgdev->ctrlq.vq);
+		reclaim_vbufs(vgdev->ctrlq.vq, &reclaim_list);
+	} while (!virtqueue_enable_cb(vgdev->ctrlq.vq));
+	/* detach unused buffers */
+	while ((entry = virtqueue_detach_unused_buf(vgdev->ctrlq.vq)) != NULL) {
+		if (entry->resp_cb)
+			entry->resp_cb(vgdev, entry);
+		if (entry->objs)
+			virtio_gpu_array_put_free(entry->objs);
+		free_vbuf(vgdev, entry);
+	}
+	spin_unlock(&vgdev->ctrlq.qlock);
+
+	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
+		if (entry->resp_cb)
+			entry->resp_cb(vgdev, entry);
+		if (entry->objs)
+			virtio_gpu_array_put_free(entry->objs);
+		list_del(&entry->list);
+		free_vbuf(vgdev, entry);
+	}
+
+	spin_lock(&vgdev->cursorq.qlock);
+	do {
+		virtqueue_disable_cb(vgdev->cursorq.vq);
+		reclaim_vbufs(vgdev->cursorq.vq, &reclaim_list);
+	} while (!virtqueue_enable_cb(vgdev->cursorq.vq));
+	spin_unlock(&vgdev->cursorq.qlock);
+	while ((entry = virtqueue_detach_unused_buf(vgdev->cursorq.vq)) != NULL) {
+		if (entry->resp_cb)
+			entry->resp_cb(vgdev, entry);
+		if (entry->objs)
+			virtio_gpu_array_put_free(entry->objs);
+		free_vbuf(vgdev, entry);
+	}
+
+	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
+		if (entry->resp_cb)
+			entry->resp_cb(vgdev, entry);
+		if (entry->objs)
+			virtio_gpu_array_put_free(entry->objs);
+		list_del(&entry->list);
+		free_vbuf(vgdev, entry);
+	}
+}
+
 /* Create sg_table from a vmalloc'd buffer. */
 static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
 {

-- 
2.47.2

