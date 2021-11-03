Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844E9C433FE
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 11:25:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48F3C61108
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 11:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48F3C61108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E0C440022;
	Wed,  3 Nov 2021 11:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xKuqVbm5pxwR; Wed,  3 Nov 2021 11:25:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4EF8A40364;
	Wed,  3 Nov 2021 11:25:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AAA3C0037;
	Wed,  3 Nov 2021 11:25:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08EECC001F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 11:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D437C40364
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 11:25:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZV0F3ZKzobV0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 11:25:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ABA6C4035D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 11:25:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: mwezdeck) with ESMTPSA id CF5351F45615
From: Maksym Wezdecki <maksym.wezdecki@collabora.com>
To: David Airlie <airlied@linux.ie>,
	Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] drm/virtio: introduce lazy pinning
Date: Wed,  3 Nov 2021 12:25:36 +0100
Message-Id: <20211103112536.126855-3-maksym.wezdecki@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211103112536.126855-1-maksym.wezdecki@collabora.com>
References: <20211103112536.126855-1-maksym.wezdecki@collabora.com>
MIME-Version: 1.0
Cc: mwezdeck <maksym.wezdecki@collabora.co.uk>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: mwezdeck <maksym.wezdecki@collabora.co.uk>

Userspace can opt-in to not pin pages during resource
create ioctl.

In transfer_*_host and map ioctls check if memory is pinned.
If pages are not pinned, pin it. Otherwise, do nothing.

This change is transparent to userspace.
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  |  9 +++++++++
 drivers/gpu/drm/virtio/virtgpu_object.c | 27 ++++++++++++++++---------
 include/uapi/drm/virtgpu_drm.h          |  9 +++++++++
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index f6a3a760c32d..c01c5c15701c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -103,6 +103,8 @@ static int virtio_gpu_map_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct drm_virtgpu_map *virtio_gpu_map = data;
 
+	virtio_gpu_object_pin(file, vgdev, virtio_gpu_map->handle);
+
 	return virtio_gpu_mode_dumb_mmap(file, vgdev->ddev,
 					 virtio_gpu_map->handle,
 					 &virtio_gpu_map->offset);
@@ -292,6 +294,9 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 	case VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs:
 		value = vgdev->capset_id_mask;
 		break;
+	case VIRTGPU_PARAM_PIN_ON_DEMAND:
+		value = 1;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -414,6 +419,8 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 		goto err_put_free;
 	}
 
+	virtio_gpu_object_pin(file, vgdev, args->bo_handle);
+
 	if (!bo->host3d_blob && (args->stride || args->layer_stride)) {
 		ret = -EINVAL;
 		goto err_put_free;
@@ -465,6 +472,8 @@ static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 		goto err_put_free;
 	}
 
+	virtio_gpu_object_pin(file, vgdev, args->bo_handle);
+
 	if (!vgdev->has_virgl_3d) {
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, offset,
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 064c50cb9846..183e57ef10e8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -219,7 +219,7 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	struct virtio_gpu_mem_entry *ents;
 	unsigned int nents;
 	int ret;
-
+	uint32_t backup_flags = params->flags;
 	*bo_ptr = NULL;
 
 	params->size = roundup(params->size, PAGE_SIZE);
@@ -246,13 +246,19 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 			goto err_put_objs;
 	}
 
-	ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
-	if (ret != 0) {
-		virtio_gpu_array_put_free(objs);
-		virtio_gpu_free_object(&shmem_obj->base);
-		return ret;
+	if (!(backup_flags & VIRTGPU_NOT_PIN_FLAG)) {
+		ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
+		if (ret != 0) {
+			virtio_gpu_array_put_free(objs);
+			virtio_gpu_free_object(&shmem_obj->base);
+			return ret;
+		}
 	}
 
+	// turn off these bits, as renderer doesn't support such bits
+	if (params->flags & VIRTGPU_NOT_PIN_FLAG)
+		params->flags &= ~(VIRTGPU_NOT_PIN_FLAG);
+
 	if (params->blob) {
 		if (params->blob_mem == VIRTGPU_BLOB_MEM_GUEST)
 			bo->guest_blob = true;
@@ -262,11 +268,13 @@ int virtio_gpu_object_create(struct virtio_gpu_device *vgdev,
 	} else if (params->virgl) {
 		virtio_gpu_cmd_resource_create_3d(vgdev, bo, params,
 						  objs, fence);
-		virtio_gpu_object_attach(vgdev, bo, ents, nents);
+		if (!(backup_flags & VIRTGPU_NOT_PIN_FLAG))
+			virtio_gpu_object_attach(vgdev, bo, ents, nents);
 	} else {
 		virtio_gpu_cmd_create_resource(vgdev, bo, params,
 					       objs, fence);
-		virtio_gpu_object_attach(vgdev, bo, ents, nents);
+		if (!(backup_flags & VIRTGPU_NOT_PIN_FLAG))
+			virtio_gpu_object_attach(vgdev, bo, ents, nents);
 	}
 
 	*bo_ptr = bo;
@@ -305,9 +313,8 @@ int virtio_gpu_object_pin(struct drm_file *file,
 
 	if (!shmem->pages) {
 		ret = virtio_gpu_object_shmem_init(vgdev, bo, &ents, &nents);
-		if (ret != 0) {
+		if (ret != 0)
 			return -EFAULT;
-		}
 
 		virtio_gpu_object_attach(vgdev, bo, ents, nents);
 	}
diff --git a/include/uapi/drm/virtgpu_drm.h b/include/uapi/drm/virtgpu_drm.h
index bb661d53c0e9..0780234f946f 100644
--- a/include/uapi/drm/virtgpu_drm.h
+++ b/include/uapi/drm/virtgpu_drm.h
@@ -83,12 +83,21 @@ struct drm_virtgpu_execbuffer {
 #define VIRTGPU_PARAM_CROSS_DEVICE 5 /* Cross virtio-device resource sharing  */
 #define VIRTGPU_PARAM_CONTEXT_INIT 6 /* DRM_VIRTGPU_CONTEXT_INIT */
 #define VIRTGPU_PARAM_SUPPORTED_CAPSET_IDs 7 /* Bitmask of supported capability set ids */
+#define VIRTGPU_PARAM_PIN_ON_DEMAND 8 /* is pinning on demand available? */
 
 struct drm_virtgpu_getparam {
 	__u64 param;
 	__u64 value;
 };
 
+/* it is used in resource_create_ioctl as resource
+ * flag.
+ * First 8 bits of uint32_t and 24th bit 
+ * are reserved for user space driver.
+ * Userspace can opt-in to not pin pages.
+ */
+#define VIRTGPU_NOT_PIN_FLAG (1 << 9)
+
 /* NO_BO flags? NO resource flag? */
 /* resource flag for y_0_top */
 struct drm_virtgpu_resource_create {
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
