Received: from mail-pj2-f17.google.com (mail-pj2-f17.google.com [74.125.227.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1885937AA6D
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789854759; cv=none; b=cg6dj1aw6nzeCVzsYX8AylkGL1sU8NTGdzWaae04nTQGNYCXCtPrcsCHTLrS9WAcdFuC1bMZuaN438OyeAW47bxI/TY5vQ8jmz6RXSOfMx4OKJdskbNYTk1qK9ERgb+8nyKjhtjt+d4QSFyl+eY+ZSGc2jN3yIE0uCGnSKqJUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789854759; c=relaxed/simple;
	bh=NE6kyRSM9D9+ObNWClCJeHTHbyuytLFmTKruJmNdFlc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZhwQjbd8rIM5PU9E58cO3FL1OF0wjfHdfZLdZqtcETWsHA5lcz2vTBBhOHBsUyiRIeiv3PSjCAHtobgflKcYuUaBnIIufFNcqzI0yhJJ9spBIRPtSQgD8OaeYOXem/Tuzm6JyjaD/7Op0mh0m2siEsY+w0kCviS2c5Nj7TFEGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKcAvD89; arc=none smtp.client-ip=74.125.227.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKcAvD89"
Received: by mail-pj2-f17.google.com with SMTP id d9443c01a7336-2db1ca06a25so12602695ad.2
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789854753; x=1790459553; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4UB+obLd5sZwu+zoy2b+DbkHvLbMMvfZd67jH6/qC/s=;
        b=hKcAvD898y/xbyLJxt+Ul3f8Zp5hhvpcOL4VoouniCBu2qGZW3PHm3/QztjIHGN2qZ
         +gKQdnF8Z5FxWt1WONIvZiizk4GEv8zzhkNBtG9wZjSTCX7tHKHFw5QeODaNFVJ1jzRk
         H1GMD2h9CkY61G5Zj0gwUaLClQLT6GoVj73Cpa6Bc4De9JNBIkZt89O2rewas5tNHHgY
         oDFJmxkSvKUPu6isab2EijBixKTLPRIhgxBrRxYb7+1/MkWojUdxnG9wNQ1R2AeH6HoN
         H1JEQMVhXqgt1PoXyjotvBvQt01wT0hF7kieMSvpsKdc1HdK+wyy0urcYecGwU8bYRCD
         iVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789854753; x=1790459553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4UB+obLd5sZwu+zoy2b+DbkHvLbMMvfZd67jH6/qC/s=;
        b=sT4sUXx5G2FXl1VTLMasf1Xy2On3SyUAwNUUO1N/3DP77KwCZQ6X6vsV1RvL39hYpd
         6W2+s+W0eYaLQ81LemEKjx/obruUjbmCD6n5gYm7YsZHxVwkVkG6UcR/fPupEwHYNygV
         5RbgnkNkS1u2TnC+pvAEPAprmGFBy58LE9t7jYDyglfifqNV6oKgFDzzsKEEOLKEkGeF
         R0lnK7lFvRXaotRYLB4JDBdZXlACJW2NhFZnzUfn6h2f6QWtnoDJeWcqezZamFdOV1Q2
         I6x/+wAR15TVCLaFLwZT4AmBx1aAhgsUChhz+RtWL69Akc72IC0uT/6p27l3VFCgg0jf
         9D8g==
X-Forwarded-Encrypted: i=1; AKwUvBwg2oifVNfYOjj+zM4DLYUDyTPxIQqIyynSSxZh2S3nmXg34qV0MI5UxW64ycgt7QJW4z5nLro5vYIqoH45kQ==@lists.linux.dev
X-Gm-Message-State: AFuF++n0gK+09dAJzgd3gDgK8NVTfIKqnBePb5OwA2gyMeJtipv/+iy9
	5RnAonTcfeUs8gF0/2/AR3Kzfu/Nqs/V0EUekrecSK/8G9LLEkmkZQixfTGIF+pl
X-Gm-Gg: AYBFou3sW4OvfhABWOX2rDexJ7of8iDWqli1FHbTrt11dntyyNDjyOCQ7HUKc8O7gtO
	VLPuwe9lVKAhae855LQwn4lyQ8Q6W2Swee+bAbA9gRq9LocgrQKXp5TJGIDF3mHr7NHx5lqel/9
	ozNYjyTPyB97fcWSs3qEI9XTq8GDYqpSROwigIdGOVczfec9ttpwXtk/pqNHkm4dumJehUmcKIc
	JAS2YVDnWQswD0nhS8VQPEOwcf2SXtz4ynlSwfa4G22/sNROsfESyXHr5/nPrSxPR0aeDWPkikR
	HL3zB++4aa7Q6B5qqMRVsEGvLoFsRngj/O2U5o/ct4qJtiGNQx483MwkMnuKhAA8s6wgorVHynY
	gQUd5u+9PT+IFto2VDICnIxAfOjzDC+85hLVYm47/CJePvWwZTBe4h9rVaexup+XeNF1xmTdPju
	AY62VYn+0++4+dWGMzUMMwd5RijraYKzfE1LKUDd4DJgx1Kr2UHNEfVFDlDLpuldBd5MHB/zEJD
	qXgOx0F1HGK+fESW31WixnpZgQoSWFStGiTnWdEor7Ov0MGDyETVY2cb10Gxq0bGD/I53jAdX1G
	1u44rzVEHg==
X-Received: by 2002:a17:902:fc45:b0:2dd:c100:80b1 with SMTP id d9443c01a7336-2ddc100811dmr48563035ad.44.1789854753097;
        Sat, 19 Sep 2026 14:52:33 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc180395fsm12881915ad.81.2026.09.19.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:52:32 -0700 (PDT)
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
Subject: [PATCH] drm/virtio: fix 0-byte blob ZERO_SIZE_PTR, GEM leak, and context_init rollback
Date: Sat, 19 Sep 2026 21:52:32 +0000
Message-ID: <20260919215232.3470178-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix multiple issues in virtio-gpu VRAM mapping, blob creation, and context
initialization:

1. In virtio_gpu_vram_mmap(), set vram->map_state = STATE_ERR if deferred
   virtio_gpu_vram_map() fails so callers do not treat an unmapped VRAM
   node as valid.
2. In verify_blob(), reject rc_blob->size == 0 or size values that wrap
   PAGE_ALIGN() to prevent kvmalloc_array(0, ...) from returning
   ZERO_SIZE_PTR.
3. In virtio_gpu_gem_create(), virtio_gpu_resource_create_ioctl(), and
   virtio_gpu_resource_create_blob_ioctl(), use drm_gem_object_put()
   instead of drm_gem_object_release() on error so the BO's free callback
   is properly invoked.
4. In virtio_gpu_context_init_ioctl(), stage context parameters into local
   variables and only commit them to vfpriv after all parameters and
   ring_idx_mask have been validated.

Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vram object")
Fixes: 85c83ea915ed ("drm/virtio: implement context init: allocate an array of fence contexts")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 66c3f6f74e9c..d2f0b8a3f172 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -45,7 +45,7 @@ static int virtio_gpu_gem_create(struct drm_file *file,
 
 	ret = drm_gem_handle_create(file, &obj->base.base, &handle);
 	if (ret) {
-		drm_gem_object_release(&obj->base.base);
+		drm_gem_object_put(&obj->base.base);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 3d8e4ccdb7c1..fb7225d91752 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -185,7 +185,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 
 	ret = drm_gem_handle_create(file, obj, &handle);
 	if (ret) {
-		drm_gem_object_release(obj);
+		drm_gem_object_put(obj);
 		return ret;
 	}
 
@@ -490,6 +490,9 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 			return -EINVAL;
 	}
 
+	if (rc_blob->size == 0 || rc_blob->size > ULONG_MAX - PAGE_SIZE + 1)
+		return -EINVAL;
+
 	params->blob_mem = rc_blob->blob_mem;
 	params->size = rc_blob->size;
 	params->blob = true;
@@ -557,14 +560,14 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 	if (params.blob_flags & VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE) {
 		ret = virtio_gpu_resource_assign_uuid(vgdev, bo);
 		if (ret) {
-			drm_gem_object_release(obj);
+			drm_gem_object_put(obj);
 			return ret;
 		}
 	}
 
 	ret = drm_gem_handle_create(file, obj, &handle);
 	if (ret) {
-		drm_gem_object_release(obj);
+		drm_gem_object_put(obj);
 		return ret;
 	}
 
@@ -616,6 +619,15 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 		goto out_unlock;
 	}
 
+	u32 context_init = vfpriv->context_init;
+	u32 num_rings = vfpriv->num_rings;
+	u64 ring_idx_mask = vfpriv->ring_idx_mask;
+	bool explicit_debug_name = vfpriv->explicit_debug_name;
+	bool num_rings_set = (vfpriv->base_fence_ctx != 0);
+	char debug_name[DEBUG_NAME_MAX_LEN];
+
+	memcpy(debug_name, vfpriv->debug_name, sizeof(debug_name));
+
 	for (i = 0; i < num_params; i++) {
 		param = ctx_set_params[i].param;
 		value = ctx_set_params[i].value;
@@ -633,16 +645,16 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 			}
 
 			/* Context capset ID already set */
-			if (vfpriv->context_init &
+			if (context_init &
 			    VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) {
 				ret = -EINVAL;
 				goto out_unlock;
 			}
 
-			vfpriv->context_init |= value;
+			context_init |= value;
 			break;
 		case VIRTGPU_CONTEXT_PARAM_NUM_RINGS:
-			if (vfpriv->base_fence_ctx) {
+			if (num_rings_set) {
 				ret = -EINVAL;
 				goto out_unlock;
 			}
@@ -652,30 +664,31 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 				goto out_unlock;
 			}
 
-			vfpriv->base_fence_ctx = dma_fence_context_alloc(value);
-			vfpriv->num_rings = value;
+			num_rings = value;
+			num_rings_set = true;
 			break;
 		case VIRTGPU_CONTEXT_PARAM_POLL_RINGS_MASK:
-			if (vfpriv->ring_idx_mask) {
+			if (ring_idx_mask) {
 				ret = -EINVAL;
 				goto out_unlock;
 			}
 
-			vfpriv->ring_idx_mask = value;
+			ring_idx_mask = value;
 			break;
 		case VIRTGPU_CONTEXT_PARAM_DEBUG_NAME:
-			if (vfpriv->explicit_debug_name) {
+			if (explicit_debug_name) {
 				ret = -EINVAL;
 				goto out_unlock;
 			}
 
-			ret = strncpy_from_user(vfpriv->debug_name,
+			memset(debug_name, 0, sizeof(debug_name));
+			ret = strncpy_from_user(debug_name,
 						u64_to_user_ptr(value),
 						DEBUG_NAME_MAX_LEN - 1);
 			if (ret < 0)
 				goto out_unlock;
 
-			vfpriv->explicit_debug_name = true;
+			explicit_debug_name = true;
 			ret = 0;
 			break;
 		default:
@@ -684,17 +697,28 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 		}
 	}
 
-	if (vfpriv->ring_idx_mask) {
+	if (ring_idx_mask) {
 		valid_ring_mask = 0;
-		for (i = 0; i < vfpriv->num_rings; i++)
+		for (i = 0; i < num_rings; i++)
 			valid_ring_mask |= 1ULL << i;
 
-		if (~valid_ring_mask & vfpriv->ring_idx_mask) {
+		if (~valid_ring_mask & ring_idx_mask) {
 			ret = -EINVAL;
 			goto out_unlock;
 		}
 	}
 
+	vfpriv->context_init = context_init;
+	if (num_rings_set && !vfpriv->base_fence_ctx) {
+		vfpriv->base_fence_ctx = dma_fence_context_alloc(num_rings);
+		vfpriv->num_rings = num_rings;
+	}
+	vfpriv->ring_idx_mask = ring_idx_mask;
+	if (explicit_debug_name && !vfpriv->explicit_debug_name) {
+		memcpy(vfpriv->debug_name, debug_name, sizeof(vfpriv->debug_name));
+		vfpriv->explicit_debug_name = true;
+	}
+
 	virtio_gpu_create_context_locked(vgdev, vfpriv);
 	virtio_gpu_notify(vgdev);
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
index 5b4a3ab81cd5..aaeae38afc0e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -248,7 +248,10 @@ void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
 		return;
 
 	mutex_lock(&map_lock);
-	if (!drm_mm_node_allocated(&vram->vram_node))
-		virtio_gpu_vram_map(&vram->base);
+	if (!drm_mm_node_allocated(&vram->vram_node)) {
+		vram->map_state = STATE_INITIALIZING;
+		if (virtio_gpu_vram_map(&vram->base))
+			vram->map_state = STATE_ERR;
+	}
 	mutex_unlock(&map_lock);
 }
