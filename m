Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D3F1624C5
	for <virtualization@lists.linux.dev>; Fri,  1 May 2026 00:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777593680; cv=pass; b=MO24YQ3+jyouSkDU1OPRd2tCeMr0PPCkPigLKocq9KIxzAxlbBji+OSD+yG5AcPXAoE0Kt5EH27xZNosOOR+SY1W9k3wIWpxJSl/8tqx7BrpsGuxgcaIg3mJnoDgMWVrindjE5wnbkhywne5E3WZMKC7e6Tx/eafC9/Q5Gx9Kg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777593680; c=relaxed/simple;
	bh=jNx7WM37+RpgdwoBKj7KcAoRNPtqBcCRC8grN0CRelo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PVqBxdESovX0F6aDtHkLYf+J8vgFoDC3xc2C5x/CYfTqLQFaC1z0Ylfk7vGeXHCkjonLpyEouKEhDzO2R65AhxcaYG/6JjKpexPw/PzqGuHuaN/Hi4tPazb7mHjLgSkXfo15wG3Jq4VAKlpJNEelAhI4LnO6ceuqEo2ZnyN2ktY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=YpwLmnGx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="YpwLmnGx"
ARC-Seal: i=1; a=rsa-sha256; t=1777593664; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mBg5rR7hOOaNu2ujoTFwS4iQ5DmZ76VkP2ZEIejuPughBqvIlYExdxqichjYfrINa6EVpYbhJPbuxw9OnD2BDCUqbzd7gIW6ictjLYAQ+wlZaBuMb2q6FXSXStHWf5bW3Ggnwgg+HtP459asFgJV//hOpBUOqv7xb/RdlW3VnSw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777593664; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=38D+j2FFCJtfyIIFhcx+mSM0sBnylQNjunu3hbPRVWU=; 
	b=CNIwwxPma2tJO7wUXct1TOB62vwUuJ7F6hNbc8HJQcuZdJ7tA5cichndsa2ZkQWooLO/Dyss7gJ8y6B4GnZLm6PT6AOqxI/ISiQd4bOZDKuY61iWtj3CUGwsygSV+WOJdVQHhgMNou54YAtLVylNczklk9xm4O9vaI02SxBkMcI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777593664;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=38D+j2FFCJtfyIIFhcx+mSM0sBnylQNjunu3hbPRVWU=;
	b=YpwLmnGx1FV5e5p2GDhRCYG75ahRY/jIy5uAlweQBaEMDnHXuGgPVcdq0V0zJYsz
	orEfN5j5CJI/HpEFXUnwymvomecsatlvem2lFWlsV7Hw8SQoIlfxxZL8Jz7DfCCwmVY
	uDC9TDv/okb2qF2gGkQm+LKBoeR5MdBpt2HJEzrs=
Received: by mx.zohomail.com with SMTPS id 1777593661744215.50532790947523;
	Thu, 30 Apr 2026 17:01:01 -0700 (PDT)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Rob Clark <robdclark@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Nagapuri Ramesh <ram.nagapuri@gmail.com>
Subject: [PATCH v2] drm/virtio: Extend blob UAPI with deferred-mapping hinting
Date: Fri,  1 May 2026 03:00:43 +0300
Message-ID: <20260501000043.2483678-1-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

If userspace never maps GEM object, then BO wastes hostmem space
because VirtIO-GPU driver maps VRAM BO at the BO's creating time.

Make mappings on-demand by adding new RESOURCE_CREATE_BLOB IOCTL/UAPI
hinting flag telling that host mapping should be deferred until first
mapping is made when the flag is set by userspace.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
---

Changelog:

v2: Rebased on recent kernel. Intel i915 native ctx landed to Mesa, lets to
    proceed with merging the mapping hint as a first user of the feature.

 drivers/gpu/drm/virtio/virtgpu_drv.h   |  2 ++
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_vram.c  | 30 +++++++++++++++++++++-----
 include/uapi/drm/virtgpu_drm.h         |  4 ++++
 4 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f17660a71a3e..6f49213e23f8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -84,6 +84,7 @@ struct virtio_gpu_object_params {
 	uint32_t blob_mem;
 	uint32_t blob_flags;
 	uint64_t blob_id;
+	uint32_t blob_hints;
 };
 
 struct virtio_gpu_object {
@@ -507,6 +508,7 @@ struct sg_table *virtio_gpu_vram_map_dma_buf(struct virtio_gpu_object *bo,
 void virtio_gpu_vram_unmap_dma_buf(struct device *dev,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir);
+void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
 
 /* virtgpu_submit.c */
 int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index c33c057365f8..01daa72b1310 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -489,6 +489,7 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 	params->size = rc_blob->size;
 	params->blob = true;
 	params->blob_flags = rc_blob->blob_flags;
+	params->blob_hints = rc_blob->blob_hints;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
index 084e80227433..4ae3cbc35dd3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -3,6 +3,8 @@
 
 #include <linux/dma-mapping.h>
 
+static DEFINE_MUTEX(map_lock);
+
 static void virtio_gpu_vram_free(struct drm_gem_object *obj)
 {
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
@@ -42,6 +44,11 @@ static int virtio_gpu_vram_mmap(struct drm_gem_object *obj,
 	if (!(bo->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
 		return -EINVAL;
 
+	virtio_gpu_vram_map_deferred(vram);
+
+	if (vram->map_state == STATE_INITIALIZING)
+		virtio_gpu_notify(vgdev);
+
 	wait_event(vgdev->resp_wq, vram->map_state != STATE_INITIALIZING);
 	if (vram->map_state != STATE_OK)
 		return -EINVAL;
@@ -218,14 +225,27 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
 
 	virtio_gpu_cmd_resource_create_blob(vgdev, &vram->base, params, NULL,
 					    0);
-	if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {
-		ret = virtio_gpu_vram_map(&vram->base);
-		if (ret) {
-			virtio_gpu_vram_free(obj);
-			return ret;
+	if (!(params->blob_hints & DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING)) {
+		if (params->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) {
+			ret = virtio_gpu_vram_map(&vram->base);
+			if (ret) {
+				virtio_gpu_vram_free(obj);
+				return ret;
+			}
 		}
 	}
 
 	*bo_ptr = &vram->base;
 	return 0;
 }
+
+void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
+{
+	if (!(vram->base.blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
+		return;
+
+	mutex_lock(&map_lock);
+	if (!drm_mm_node_allocated(&vram->vram_node))
+		virtio_gpu_vram_map(&vram->base);
+	mutex_unlock(&map_lock);
+}
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index 9debb320c34b..ba09a4ee3e77 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -200,6 +200,10 @@ struct drm_virtgpu_resource_create_blob {
 	__u32 cmd_size;
 	__u64 cmd;
 	__u64 blob_id;
+
+#define DRM_VIRTGPU_BLOB_FLAG_HINT_DEFER_MAPPING        0x0001
+	__u32 blob_hints;
+	__u32 pad2;
 };
 
 #define VIRTGPU_CONTEXT_PARAM_CAPSET_ID       0x0001
-- 
2.53.0

