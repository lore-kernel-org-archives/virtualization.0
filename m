Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2789345ED8
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857283; cv=none; b=n4+1/Z+rjxXkuE/ca97UbYFhdez6yTQXbX/cCRcihLrkkB1/5w4obK9+mj/CXFFQSxOm1Ru1H4zPQJH9B3lLiKJhFaQQl1xJrinCf5qvgENyQlaABqzYOOE9hqOzLJrfvqTUoxmONcaTctuEVoSwjDTo6qrYzOYyz6AeEphAGV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857283; c=relaxed/simple;
	bh=gg/aLO8FXGl291zcXQuVqVPtSfhfSZO1lvSMmXb4L20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kAXwXjh2GjdRSuTHfCE7E1iRGpjmOHW/XEB8giCI23BoR5SGMjaRTHzwHEVtroxy53u61qDGF6AcUDtpiO3QzuNtmSz0XZrI1CTPBuxVw1cpMmbmcxD+MKqs20CA9mjzrpikhp7bVKDAanLfxPL96rbowqItfaZmBL5dHZieUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFQSYgwh; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFQSYgwh"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a147688bso1952637a91.1
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857281; x=1790462081; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bwQ10vDhFAWwDcYIO9V2fABJxs02GOextq4IhPQqc6k=;
        b=VFQSYgwhEHw0W8JrqaVoTCM8GFkyUX45HXIgYnU10qfz/L0z0hIDMC9ldSNPFbWeqB
         hivRQxlOgD4Tg/yp4EyEOw0WkKonWwTOGgjbzKD9mJjdn8WxyiJP9oed/xcP7nkhPikk
         60IYJ40wjM9Iehg6tEK596SRpWBy6yvDG6cdwdY6pFmCogWG0igl34E+v40csAfT8y7f
         Qy9ecLpFOHOJK3PoZ2+FXvGcS3+EVadKfSlzmKy3c9cYkZdxcXExNXf/4PiWRrTKon3k
         eWhIDpNJte5onPGG8h02dGIvNhVbcJpYHAoufeT4ACNdPOkMXRXkQj8q/NnXSkaVPadJ
         1JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857281; x=1790462081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bwQ10vDhFAWwDcYIO9V2fABJxs02GOextq4IhPQqc6k=;
        b=wXWlDy0CLuHlrA9D4WS53yvErP8OwYb4knIBuuc84Xg5gC4XZf1aHYzDcgeDH7j+0t
         XHdsbyxRLet1ZTryC9mM/WnWVfwCDxdCiZDDHB2fZF4SXxiDV9P7k/jWfW0ZX/F37aCh
         YeAmtP45lbjnPlXH5dKr0V1TSH7tdeehpvqvhkVumxyU2edifdSvVGwfY1r0R+R02dD6
         ihFch3yWsuz6Lr7Ida3Dec3B39kutZY+U0Xlgp0YXt223KwOXUzWExdnxaGKxfOSQLY+
         iTJhybUDXvflszeqfDXYQjUAF9dDsz0FzGlhgjBx6umoBRjVa64DwYvACYLb/dAPMS1I
         MxWw==
X-Forwarded-Encrypted: i=1; AKwUvBzxvgIp0tPjNmyqBMketYvYDrHnPqtn8dar+fYdcunwBM0F9uvNMvPo1+/T5j5io/1Q580HnS2jZ2jbUXTWRA==@lists.linux.dev
X-Gm-Message-State: AFuF++nuZ5kmAquWJZBkOOlM0LyzaBGNvahipwP4DUO68fyVjEbh0exz
	84fLVWV1yBbCHiBcH5lR3w+aHNhUUSAK+Qy2roMwpEvOyAPZsGz1SgGm
X-Gm-Gg: AYBFou3YgJgEGUUmpwbCI7Md/JCeHADl48VqpGQ7O4zmivzjKqU61QvgZO3JIc6Fftv
	9QaBPJRjVvKYdxMQbzpGROKbzLA+kLZhpx8bgZHkAmJFIOGRkpLybxDQzM4do8USSdLL/8jozeN
	JkdOHMR4K1XC7LGogrFiyBaxBTw+NFy1nO9Zyp9scjmEpbjTdEr/VdJLqtEzmer31BHbzHZR82H
	D4LPcedmzEzHP4Uvt6uoFPFStIetH9DaJ1DDLX0A1kby0yi6bRpDsVDnVwj54Iyer9peavYq9Hs
	WYCWsLym0yJtxbNoB1EY/lokazNhL7n45/BOlnOhJAAWKVjw8V9ri460BCtLTsyORvAgDYlMQb/
	p3VMFnPcUap4IauFEBxHu1yW9Y82X5qETyImtHeMZu8PzX1SN0m8AAuUiqdBMX2VI9ebR3A8psO
	H3bp0HMr6q2VbWbcy2Gl9Wg15JXTVc23VcdVrAd8DMdf3t2y6GbBeh414p80OqyT/+roNtuDml2
	GcIyebcNK7ak1xTx3j5SwIeiap8HJbzBNWME5ysH/kjX+r0LcL2/7/2g0+qWA0ts1NkinOmwq9x
	dsUof7ICOg==
X-Received: by 2002:a17:90b:39ad:b0:39e:6c69:9b95 with SMTP id 98e67ed59e1d1-39e6c69b29dmr4693412a91.58.1789857281154;
        Sat, 19 Sep 2026 15:34:41 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02526e27dsm1943501a91.0.2026.09.19.15.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:40 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: fix vbuf->objs double-free, fence NULL deref, and sgt error path
Date: Sat, 19 Sep 2026 22:34:39 +0000
Message-ID: <20260919223440.3884176-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix three error-handling bugs in drivers/gpu/drm/virtio/:

1. In virtio_gpu_dequeue_ctrl_func() and vbuf cleanup (virtgpu_vq.c),
   clear entry->objs after freeing so objects are not double-released,
   and fix the vmalloc_to_sgt() error path.
2. In virtio_gpu_cleanup_submit() (virtgpu_submit.c), cancel and free
   out_fence->e when submit fails before drm_event_reserve_init()
   completes.

Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 32cb1e4aa425..84aeea58c700 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -343,8 +343,14 @@ static void virtio_gpu_cleanup_submit(struct virtio_gpu_submit *submit)
 	if (submit->out_fence_fd >= 0)
 		put_unused_fd(submit->out_fence_fd);
 
-	if (submit->out_fence)
+	if (submit->out_fence) {
+		if (submit->out_fence->e && !submit->out_fence->f.seqno) {
+			drm_event_cancel_free(submit->vgdev->ddev,
+					      &submit->out_fence->e->base);
+			submit->out_fence->e = NULL;
+		}
 		dma_fence_put(&submit->out_fence->f);
+	}
 
 	if (submit->sync_file)
 		fput(submit->sync_file->file);
@@ -415,6 +421,9 @@ static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
 	if (err)
 		return err;
 
+	if (!exbuf->size)
+		return -EINVAL;
+
 	submit->buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
 	if (IS_ERR(submit->buf))
 		return PTR_ERR(submit->buf);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c02c03c10d92..115156a680bc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -202,6 +202,10 @@ static void *virtio_gpu_alloc_cmd_cb(struct virtio_gpu_device *vgdev,
 static void free_vbuf(struct virtio_gpu_device *vgdev,
 		      struct virtio_gpu_vbuffer *vbuf)
 {
+	if (vbuf->objs) {
+		virtio_gpu_array_put_free_delayed(vgdev, vbuf->objs);
+		vbuf->objs = NULL;
+	}
 	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
 		kfree(vbuf->resp_buf);
 	kvfree(vbuf->data_buf);
@@ -282,8 +286,6 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 	wake_up(&vgdev->ctrlq.ack_queue);
 
 	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
-		if (entry->objs)
-			virtio_gpu_array_put_free_delayed(vgdev, entry->objs);
 		list_del(&entry->list);
 		free_vbuf(vgdev, entry);
 	}
@@ -517,6 +519,7 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			if (!sgt) {
 				if (fence && vbuf->objs)
 					virtio_gpu_array_unlock_resv(vbuf->objs);
+				free_vbuf(vgdev, vbuf);
 				return -ENOMEM;
 			}
 
@@ -1409,8 +1412,7 @@ virtio_gpu_cmd_resource_assign_uuid(struct virtio_gpu_device *vgdev,
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 
 	vbuf->objs = objs;
-	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
-	return 0;
+	return virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
 
 static void virtio_gpu_cmd_resource_map_cb(struct virtio_gpu_device *vgdev,
