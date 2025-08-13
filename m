Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB41DE2D7;
	Wed, 13 Aug 2025 06:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066101; cv=none; b=fi55yu6d9Qf7Pg25FHV+IjRArsEwMnuur1fYvqy9DnNV+3lyRgyZ/3Z6mTkmFsfzAKzfepDueQ8tE8yVPXkCJvi4u8DXQrYC9ShsYj5/EKUufMlK/ctsii3dWfrklHhDWzDrd6ecgc3luScWjL0yIDVpDsTENBHIzuSdbxvduKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066101; c=relaxed/simple;
	bh=9lXBpt4mIMT6d2TGJJvZMhjb/fpze1Qddkv0CbIjggs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkNewr4TJv3ZIUlVCGmYdZa+Mhv9wKiWQusIxOtT3yUPGRjtYnn7fIi4JpQnHHN9X8LwPHJ789Qouffge5gDmp8df8IbAprRIOkVxm+6NY2nje5rhLb7kXBJYS/l/+2bMVfJQP/thqSrEnDG3iBFc+NekgQC7D7cGgN5qwG1GzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnbyHweD; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnbyHweD"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-747e41d5469so7090277b3a.3;
        Tue, 12 Aug 2025 23:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755066099; x=1755670899; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ST3OBHUDmupawOhRPYNVodoxTLlNYfnl/2sDqaHKqM=;
        b=UnbyHweD1lzyfM0MEmXAf3hblD20vrEN50qubhnmSgQWua9FxbnhfPM4uTRt+rteAl
         fZ+AbdyN0+axwF4hFXk+lAL3yswn3UWQCC2FwT14NcoRgxwVzipBskQkpYobxKg//z2c
         AJ9vovUmoxiuR8Sunnv4Bt0hVrtXoI09EzRbbVW9Y+TE4NbjQobvqbB1r1kP6plrwWOI
         aFa0JG1p845zEH/ObNsXfZ5r3pSJ/DIbMRxWVkC15FXmjUG4nxpDO+Z4RDZRiSu8aXf0
         4eyLcKZ+4ClqRjA8A4Cuf2kWLLCg5WOnMbQXVWMIo+nbb1jOl2m+oIYCuWDnEaMpWH1H
         h6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755066099; x=1755670899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ST3OBHUDmupawOhRPYNVodoxTLlNYfnl/2sDqaHKqM=;
        b=Ele1c6qY8hIYQ1swnivRffyZzUqZ/kNQsoBB33A7Srk8Q6v8BxHB2IT3WlTX9a22Wr
         UE3VeImHzoNKzvrzM/Vudq+IPIHmUQcTKoecp3d5Xb73CfWM8ym94Z9iKelN84DfO5Nj
         g4w9+NNKvDosjFXZx/wz2Skrb1okJtwOyYaMvFLvSaJhf8zNHz61eEb4Kbeqo/+lH1Z2
         PBCPGr9qWOo0cmO/lSFwqH5xJvcoZND9kmNHHQ/DRe0bfN7VMZfyN7iea8cJdhg7FvYm
         HqMJjCXn9iXyGy7EJNR9e/ITOvWp8Vv+y4Uazp4PRpZkVETuSa4WqvKsoV6ilhzW0hjd
         aG2g==
X-Forwarded-Encrypted: i=1; AJvYcCV9/t47mVeQfo46QB6x7F9kx4ZPC/FC68bpWCdBq6w7AtMxdSMAqemztI+eD1mjZed1fqqH8sr4kqUW7pZLya8=@lists.linux.dev, AJvYcCWHfpYwskS0XlOLt746lYq+ev/rZG+cwqNjrwOaBGm/gWpVbnzEcg7DplNUvKpiU2P1L4ToRvK0vdj/bhw6ufEzLjYjCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzV+S/6AZvdwOYSiWoXf0jsFQ34csuvDZLYvjQE+1yp0rSvrL3o
	TlhC3JPk/1vA0iC/ge6Qs1uScbXBHSBiuqUc2D+T4KiahIb1RA84fyzB
X-Gm-Gg: ASbGnct/FNX0NcByj6yZti7/uGjMFzuBfpFdtzC90ATiiJLeBRcyO6j9X/p8a9BL4SM
	NPRDzrVI+OR30gzNb88mp0Q46mam3MfcMenCRhzBB7sY3PILRKyymL+pUHbqHam0qmwiB/G4CW7
	GUbjkWhNqYX7StmEC80q9SKEApznLpTdKXAfQjOFeRPxX6RHhDxMVgYtb7F9nkKAAlHViYOKV9b
	Kvid0XUaRRDj6dfEGS55MuYHFhpOut9OKmN8gtmVO80xvxQFyYv58CRqEOcUSIhnsJkfKAfde4Q
	QtOgfLkH/CIOhJYBmy8K7XF9x8kxxd92Wj55R7g5IvccNxxygd/7uU5/X6PemlRnyqfR/p2yoS7
	H1Ohi9PEH7B1BRXJbngE=
X-Google-Smtp-Source: AGHT+IEcTztVLi+UwZHZ0a2lGY69Y011yXfIdJLL6J3nKQcw2Coh7E6JYmUMTFdAFtBh6CYhcaokWw==
X-Received: by 2002:a05:6a20:244b:b0:240:7ed:402b with SMTP id adf61e73a8af0-240a8b76ba5mr3616066637.33.1755066099386;
        Tue, 12 Aug 2025 23:21:39 -0700 (PDT)
Received: from Terra ([2001:df0:b240:417c:391a:2d23:2970:dee9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce89132sm31303296b3a.29.2025.08.12.23.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 23:21:39 -0700 (PDT)
From: Athul Raj Kollareth <krathul3152@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org
Cc: Athul Raj Kollareth <krathul3152@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: clean up minor codestyle issues
Date: Wed, 13 Aug 2025 11:51:05 +0530
Message-ID: <20250813062109.5326-1-krathul3152@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix codestyle warnings and errors generated by CHECKPATCH in virtio
source files.

Signed-off-by: Athul Raj Kollareth <krathul3152@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c |  3 +--
 drivers/gpu/drm/virtio/virtgpu_kms.c     | 20 ++++++++++----------
 drivers/gpu/drm/virtio/virtgpu_object.c  |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_plane.c   |  2 +-
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  2 ++
 5 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index e5805ca646c7..c3315935d8bc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -131,9 +131,8 @@ static void virtio_gpu_crtc_atomic_flush(struct drm_crtc *crtc,
 	 * in the plane update callback, and here we just check
 	 * whenever we must force the modeset.
 	 */
-	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
+	if (drm_atomic_crtc_needs_modeset(crtc_state))
 		output->needs_modeset = true;
-	}
 }
 
 static const struct drm_crtc_helper_funcs virtio_gpu_crtc_helper_funcs = {
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 7dfb2006c561..1c15cbf326b7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -162,18 +162,18 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_VIRGL))
 		vgdev->has_virgl_3d = true;
 #endif
-	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID))
 		vgdev->has_edid = true;
-	}
-	if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
+
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC))
 		vgdev->has_indirect = true;
-	}
-	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID)) {
+
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_UUID))
 		vgdev->has_resource_assign_uuid = true;
-	}
-	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_BLOB)) {
+
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_RESOURCE_BLOB))
 		vgdev->has_resource_blob = true;
-	}
+
 	if (virtio_get_shm_region(vgdev->vdev, &vgdev->host_visible_region,
 				  VIRTIO_GPU_SHM_ID_HOST_VISIBLE)) {
 		if (!devm_request_mem_region(&vgdev->vdev->dev,
@@ -193,9 +193,9 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 			    (unsigned long)vgdev->host_visible_region.addr,
 			    (unsigned long)vgdev->host_visible_region.len);
 	}
-	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_CONTEXT_INIT)) {
+
+	if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_CONTEXT_INIT))
 		vgdev->has_context_init = true;
-	}
 
 	DRM_INFO("features: %cvirgl %cedid %cresource_blob %chost_visible",
 		 vgdev->has_virgl_3d    ? '+' : '-',
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 5517cff8715c..e6363c887500 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -47,6 +47,7 @@ int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *resid)
 		*resid = handle + 1;
 	} else {
 		int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);
+
 		if (handle < 0)
 			return handle;
 		*resid = handle + 1;
@@ -56,9 +57,8 @@ int virtio_gpu_resource_id_get(struct virtio_gpu_device *vgdev, uint32_t *resid)
 
 static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t id)
 {
-	if (!virtio_gpu_virglrenderer_workaround) {
+	if (!virtio_gpu_virglrenderer_workaround)
 		ida_free(&vgdev->resource_ida, id - 1);
-	}
 }
 
 void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 698ea7adb951..29e4b458ae57 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -120,7 +120,7 @@ static int virtio_gpu_plane_atomic_check(struct drm_plane *plane,
 	crtc_state = drm_atomic_get_crtc_state(state,
 					       new_plane_state->crtc);
 	if (IS_ERR(crtc_state))
-                return PTR_ERR(crtc_state);
+		return PTR_ERR(crtc_state);
 
 	ret = drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
 						  DRM_PLANE_NO_SCALING,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 55a15e247dd1..8181b22b9b46 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -248,6 +248,7 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 		if (resp->type != cpu_to_le32(VIRTIO_GPU_RESP_OK_NODATA)) {
 			if (le32_to_cpu(resp->type) >= VIRTIO_GPU_RESP_ERR_UNSPEC) {
 				struct virtio_gpu_ctrl_hdr *cmd;
+
 				cmd = virtio_gpu_vbuf_ctrl_hdr(entry);
 				DRM_ERROR_RATELIMITED("response 0x%x (command 0x%x)\n",
 						      le32_to_cpu(resp->type),
@@ -468,6 +469,7 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 	if (vbuf->data_size) {
 		if (is_vmalloc_addr(vbuf->data_buf)) {
 			int sg_ents;
+
 			sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
 					     &sg_ents);
 			if (!sgt) {
-- 
2.50.1

