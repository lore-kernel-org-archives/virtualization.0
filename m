Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3045C1CEAB6
	for <virtualization@lists.linux.dev>; Thu, 22 Aug 2024 17:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347446; cv=none; b=URKAQundLCxQyfzatxZGkNTReAOB6YILc76gQAdefeVVSiEIYF0CeMkFpTM4uhiT46LkhVri1Q36kiVRjGYkJz4EvoljEfPLT9hBKjzGpAPWqz2bNe3VpaJAIrEtcO1WEvHPrmadIWgTPCApUs28g4pVVGa/RNAZRRUe7kdRaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347446; c=relaxed/simple;
	bh=kmQl/Aot0Lmze8/SBqGNzNTBtp/Cr7/oeHJ1/eeq1Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A3RsDiOSz1jhlBOrcgp1vedccpBhnpnz/7KzSFL9qkiIpez0e1RahurAwmX5pP2DCCdAkq2eU6gNexfgLJAOX2pT09qj8R1SVIMcHsY6QcnAfkFlHIIP4BM+ePcNa/gOB9hR/c405Tx+UYq4A563OQ8okNwarNoMj5A1CgVOjJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c4yqPCEa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c4yqPCEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724347443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eGgGTzAPnTx4/ZuB3xBVYF51gZQj30u1hvWI27T5Mi0=;
	b=c4yqPCEaOfNywehRInkcbiCxYJimN8jbbbMtSHxe+SZ61x25ZU74WLwNdNj0eZGMtb0Zpy
	FXcWyHVRv/hQ85VOcTs+Tw2RDls1SXxeBH3+u0HNui1JAqzKkVVNcKhWGF1env7a0zLqlG
	3YtbkLI5KAsB2SKEIqmj3IfbSzVt1Lo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-TqasFmdIOeChMud3lWd_pg-1; Thu,
 22 Aug 2024 13:23:59 -0400
X-MC-Unique: TqasFmdIOeChMud3lWd_pg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FB7919560B7;
	Thu, 22 Aug 2024 17:23:57 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.88])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F4A419560AA;
	Thu, 22 Aug 2024 17:23:53 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Daniel Vetter <daniel@ffwll.ch>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH 1/2] drm/virtio: Defer the host dumb buffer creation
Date: Thu, 22 Aug 2024 19:22:00 +0200
Message-ID: <20240822172338.698922-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The host dumb buffer command needs a format, but the
DRM_IOCTL_MODE_CREATE_DUMB only provides a buffer size.
So wait for the DRM_IOCTL_MODE_ADDFB(2), to get the format, and create
the host resources at this time.

This will allow virtio-gpu to support multiple pixel formats.

This problem was noticed in commit 42fd9e6c29b39 ("drm/virtio: fix
DRM_FORMAT_* handling")

Suggested-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 26 ++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_drv.h     |  3 +++
 drivers/gpu/drm/virtio/virtgpu_gem.c     |  1 -
 drivers/gpu/drm/virtio/virtgpu_object.c  | 13 +++++++++---
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 64baf2f22d9f0..3f18ee0fd5155 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -290,6 +290,26 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	return 0;
 }
 
+static void virtio_gpu_deferred_create(struct virtio_gpu_object *bo,
+				       struct virtio_gpu_device *vgdev,
+				       const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	struct virtio_gpu_object_params params = { 0 };
+
+	params.format = virtio_gpu_translate_format(mode_cmd->pixel_format);
+	params.width = mode_cmd->width;
+	params.height = mode_cmd->height;
+	params.size = params.height * params.width * 4;
+	params.size = ALIGN(params.size, PAGE_SIZE);
+	params.dumb = true;
+
+	virtio_gpu_cmd_create_resource(vgdev, bo, &params, NULL, NULL);
+	virtio_gpu_object_attach(vgdev, bo, bo->ents, bo->nents);
+
+	bo->deferred = false;
+	bo->ents = NULL;
+}
+
 static struct drm_framebuffer *
 virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 				   struct drm_file *file_priv,
@@ -297,6 +317,8 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 {
 	struct drm_gem_object *obj = NULL;
 	struct virtio_gpu_framebuffer *virtio_gpu_fb;
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_object *bo;
 	int ret;
 
 	if (mode_cmd->pixel_format != DRM_FORMAT_HOST_XRGB8888 &&
@@ -308,6 +330,10 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	if (!obj)
 		return ERR_PTR(-EINVAL);
 
+	bo = gem_to_virtio_gpu_obj(obj);
+	if (bo->deferred)
+		virtio_gpu_deferred_create(bo, vgdev, mode_cmd);
+
 	virtio_gpu_fb = kzalloc(sizeof(*virtio_gpu_fb), GFP_KERNEL);
 	if (virtio_gpu_fb == NULL) {
 		drm_gem_object_put(obj);
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 64c236169db88..8d1e8dcfa8c15 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -93,6 +93,9 @@ struct virtio_gpu_object {
 	bool dumb;
 	bool created;
 	bool host3d_blob, guest_blob;
+	bool deferred;
+	struct virtio_gpu_mem_entry *ents;
+	unsigned int nents;
 	uint32_t blob_mem, blob_flags;
 
 	int uuid_state;
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 7db48d17ee3a8..33ad15fed30f6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -75,7 +75,6 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 	args->size = pitch * args->height;
 	args->size = ALIGN(args->size, PAGE_SIZE);
 
-	params.format = virtio_gpu_translate_format(DRM_FORMAT_HOST_XRGB8888);
 	params.width = args->width;
 	params.height = args->height;
 	params.size = args->size;
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index c7e74cf130221..507a90681a779 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -67,6 +67,8 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 
 	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
 	if (virtio_gpu_is_shmem(bo)) {
+		if (bo->deferred)
+			kvfree(bo->ents);
 		drm_gem_shmem_free(&bo->base);
 	} else if (virtio_gpu_is_vram(bo)) {
 		struct virtio_gpu_object_vram *vram = to_virtio_gpu_vram(bo);
@@ -229,9 +231,14 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 						  objs, fence);
 		virtio_gpu_object_attach(vgdev, bo, ents, nents);
 	} else {
-		virtio_gpu_cmd_create_resource(vgdev, bo, params,
-					       objs, fence);
-		virtio_gpu_object_attach(vgdev, bo, ents, nents);
+		/* Fence is used only with blob or virgl */
+		WARN_ONCE(fence != NULL, "deferred doesn't support fence\n");
+		/* Create the host resource in virtio_gpu_user_framebuffer_create()
+		 * because the pixel format is not specified yet
+		 */
+		bo->ents = ents;
+		bo->nents = nents;
+		bo->deferred = true;
 	}
 
 	*bo_ptr = bo;

base-commit: 04b5b362bc2a36f1dfe5cad52c83b1ea9d25b87c
-- 
2.46.0

