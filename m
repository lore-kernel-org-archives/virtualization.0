Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C6FEB64D8
	for <virtualization@archiver.kernel.org>; Tue, 20 Jun 2023 10:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 56F6C41681;
	Tue, 20 Jun 2023 10:33:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56F6C41681
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=eozkAryh;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dgZp2ic0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T1k5e2mjEFbk; Tue, 20 Jun 2023 10:33:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5C673415DC;
	Tue, 20 Jun 2023 10:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C673415DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 299FEC007A;
	Tue, 20 Jun 2023 10:33:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 434FFC0029
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 10:33:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09EE540384
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 10:33:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 09EE540384
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=eozkAryh; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dgZp2ic0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8xLjIxFACVWc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 10:33:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E5D9740353
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E5D9740353
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Jun 2023 10:33:47 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E695E218E5;
 Tue, 20 Jun 2023 10:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1687257224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YgOLJgi2fREmyUNpD7QXf421ecux7NS24N20XA+ST9g=;
 b=eozkAryhR8ILRXyn9P9P4RBtfJWBg22C94x1X9/iX88wT00ty70sYrY/0xjRq36L3cyDrt
 s/7QHGFNzWWMLH4VJObdbkcpfEV4dwdGt7WeLxaRi+y7ObTaX04xMIhmY+OqMF+uEmh+sZ
 jxUwPJX+EZhIzssRfrUT81KU0DIkqSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1687257224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YgOLJgi2fREmyUNpD7QXf421ecux7NS24N20XA+ST9g=;
 b=dgZp2ic0WG84p2Ab5p4s0dZSrGkYnIMcYah+xMvkja+gt7HXJ8zKXBpJi0+o2YbcbHGcvt
 Y6o76xpH/dzhwXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0C0B1346D;
 Tue, 20 Jun 2023 10:33:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B14pKoiAkWQzXQAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Tue, 20 Jun 2023 10:33:44 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, kraxel@redhat.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com, daniel@ffwll.ch
Subject: [PATCH] drm/virtgpu: Replace dev_private by helper function
Date: Tue, 20 Jun 2023 12:33:28 +0200
Message-ID: <20230620103343.910-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
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

Dereference struct drm_device.dev_private in the helper function
do_virtio_gpu_device(). The dev_private field is deprecated and
drivers are advised not ot use it. Encapsulating it in a helper
function will help with a later removal. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/virtio/virtgpu_debugfs.c |  6 +++---
 drivers/gpu/drm/virtio/virtgpu_display.c |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_drv.c     |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h     | 12 ++++++++++++
 drivers/gpu/drm/virtio/virtgpu_gem.c     |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_ioctl.c   | 18 +++++++++---------
 drivers/gpu/drm/virtio/virtgpu_kms.c     |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_object.c  |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_plane.c   |  8 ++++----
 drivers/gpu/drm/virtio/virtgpu_prime.c   |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_submit.c  |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_vq.c      |  4 ++--
 drivers/gpu/drm/virtio/virtgpu_vram.c    |  8 ++++----
 13 files changed, 51 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
index 853dd9aa397eb..e768c6253db33 100644
--- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
+++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
@@ -44,7 +44,7 @@ static void virtio_gpu_add_int(struct seq_file *m, const char *name, int value)
 static int virtio_gpu_features(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct virtio_gpu_device *vgdev = node->minor->dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(node->minor->dev);
 
 	virtio_gpu_add_bool(m, "virgl", vgdev->has_virgl_3d);
 	virtio_gpu_add_bool(m, "edid", vgdev->has_edid);
@@ -69,7 +69,7 @@ static int
 virtio_gpu_debugfs_irq_info(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct virtio_gpu_device *vgdev = node->minor->dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(node->minor->dev);
 
 	seq_printf(m, "fence %llu %lld\n",
 		   (u64)atomic64_read(&vgdev->fence_drv.last_fence_id),
@@ -81,7 +81,7 @@ static int
 virtio_gpu_debugfs_host_visible_mm(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
-	struct virtio_gpu_device *vgdev = node->minor->dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(node->minor->dev);
 	struct drm_printer p;
 
 	if (!vgdev->has_host_visible) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index ad924a8502e90..6cf143e06b003 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -86,7 +86,7 @@ virtio_gpu_framebuffer_init(struct drm_device *dev,
 static void virtio_gpu_crtc_mode_set_nofb(struct drm_crtc *crtc)
 {
 	struct drm_device *dev = crtc->dev;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
 
 	virtio_gpu_cmd_set_scanout(vgdev, output->index, 0,
@@ -104,7 +104,7 @@ static void virtio_gpu_crtc_atomic_disable(struct drm_crtc *crtc,
 					   struct drm_atomic_state *state)
 {
 	struct drm_device *dev = crtc->dev;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_output *output = drm_crtc_to_virtio_gpu_output(crtc);
 
 	virtio_gpu_cmd_set_scanout(vgdev, output->index, 0, 0, 0, 0, 0);
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 91ace7a44f2a6..0e251c604049e 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -125,7 +125,7 @@ static void virtio_gpu_remove(struct virtio_device *vdev)
 static void virtio_gpu_config_changed(struct virtio_device *vdev)
 {
 	struct drm_device *dev = vdev->priv;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 
 	schedule_work(&vgdev->config_changed_work);
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 4126c384286bf..d2f9a5862d6b7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -40,6 +40,7 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/virtgpu_drm.h>
 
@@ -266,6 +267,17 @@ struct virtio_gpu_device {
 	spinlock_t host_visible_lock;
 };
 
+static inline struct virtio_gpu_device *to_virtio_gpu_device(struct drm_device *dev)
+{
+	drm_WARN_ON_ONCE(dev, !dev->dev_private);
+
+	/*
+	 * TODO: Embed struct drm_device in struct virtio_gpu_device and
+	 *       upcast with container_of().
+	 */
+	return dev->dev_private;
+}
+
 struct virtio_gpu_fpriv {
 	uint32_t ctx_id;
 	uint32_t context_init;
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 7db48d17ee3a8..6b1663a2c31eb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -34,7 +34,7 @@ static int virtio_gpu_gem_create(struct drm_file *file,
 				 struct drm_gem_object **obj_p,
 				 uint32_t *handle_p)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_object *obj;
 	int ret;
 	u32 handle;
@@ -64,7 +64,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 {
 	struct drm_gem_object *gobj;
 	struct virtio_gpu_object_params params = { 0 };
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	int ret;
 	uint32_t pitch;
 
@@ -117,7 +117,7 @@ int virtio_gpu_mode_dumb_mmap(struct drm_file *file_priv,
 int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 			       struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(obj->dev);
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct virtio_gpu_object_array *objs;
 
@@ -144,7 +144,7 @@ int virtio_gpu_gem_object_open(struct drm_gem_object *obj,
 void virtio_gpu_gem_object_close(struct drm_gem_object *obj,
 				 struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(obj->dev);
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct virtio_gpu_object_array *objs;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index b24b11f25197d..aefcc7fb2e3e7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -54,7 +54,7 @@ static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgdev,
 
 void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 
 	mutex_lock(&vfpriv->context_lock);
@@ -70,7 +70,7 @@ void virtio_gpu_create_context(struct drm_device *dev, struct drm_file *file)
 static int virtio_gpu_map_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct drm_virtgpu_map *virtio_gpu_map = data;
 
 	return virtio_gpu_mode_dumb_mmap(file, vgdev->ddev,
@@ -81,7 +81,7 @@ static int virtio_gpu_map_ioctl(struct drm_device *dev, void *data,
 static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 				     struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct drm_virtgpu_getparam *param = data;
 	int value;
 
@@ -119,7 +119,7 @@ static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 					    struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct drm_virtgpu_resource_create *rc = data;
 	struct virtio_gpu_fence *fence;
 	int ret;
@@ -214,7 +214,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 					       void *data,
 					       struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct drm_virtgpu_3d_transfer_from_host *args = data;
 	struct virtio_gpu_object *bo;
@@ -269,7 +269,7 @@ static int virtio_gpu_transfer_from_host_ioctl(struct drm_device *dev,
 static int virtio_gpu_transfer_to_host_ioctl(struct drm_device *dev, void *data,
 					     struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct drm_virtgpu_3d_transfer_to_host *args = data;
 	struct virtio_gpu_object *bo;
@@ -358,7 +358,7 @@ static int virtio_gpu_wait_ioctl(struct drm_device *dev, void *data,
 static int virtio_gpu_get_caps_ioctl(struct drm_device *dev,
 				void *data, struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct drm_virtgpu_get_caps *args = data;
 	unsigned size, host_caps_size;
 	int i;
@@ -493,7 +493,7 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 	struct drm_gem_object *obj;
 	struct virtio_gpu_object *bo;
 	struct virtio_gpu_object_params params = { 0 };
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct drm_virtgpu_resource_create_blob *rc_blob = data;
 
@@ -569,7 +569,7 @@ static int virtio_gpu_context_init_ioctl(struct drm_device *dev,
 	uint64_t valid_ring_mask;
 	size_t len;
 	struct drm_virtgpu_context_set_param *ctx_set_params = NULL;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct drm_virtgpu_context_init *args = data;
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 5a3b5aaed1f36..ab8c0a6719ac7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -280,7 +280,7 @@ static void virtio_gpu_cleanup_cap_cache(struct virtio_gpu_device *vgdev)
 
 void virtio_gpu_deinit(struct drm_device *dev)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 
 	flush_work(&vgdev->obj_free_work);
 	flush_work(&vgdev->ctrlq.dequeue_work);
@@ -292,7 +292,7 @@ void virtio_gpu_deinit(struct drm_device *dev)
 
 void virtio_gpu_release(struct drm_device *dev)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 
 	if (!vgdev)
 		return;
@@ -307,7 +307,7 @@ void virtio_gpu_release(struct drm_device *dev)
 
 int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_fpriv *vfpriv;
 	int handle;
 
@@ -335,7 +335,7 @@ int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)
 
 void virtio_gpu_driver_postclose(struct drm_device *dev, struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 
 	if (!vgdev->has_virgl_3d)
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index c7e74cf130221..d5613b74b0456 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -63,7 +63,7 @@ static void virtio_gpu_resource_id_put(struct virtio_gpu_device *vgdev, uint32_t
 
 void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 {
-	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(bo->base.base.dev);
 
 	virtio_gpu_resource_id_put(vgdev, bo->hw_res_handle);
 	if (virtio_gpu_is_shmem(bo)) {
@@ -86,7 +86,7 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 static void virtio_gpu_free_object(struct drm_gem_object *obj)
 {
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
-	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(bo->base.base.dev);
 
 	if (bo->created) {
 		virtio_gpu_cmd_unref_resource(vgdev, bo);
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a2e045f3a0004..1f867af2555b1 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -126,7 +126,7 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 				      uint32_t width, uint32_t height)
 {
 	struct drm_device *dev = plane->dev;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_framebuffer *vgfb;
 	struct virtio_gpu_object *bo;
 
@@ -161,7 +161,7 @@ static void virtio_gpu_primary_plane_update(struct drm_plane *plane,
 	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
 									   plane);
 	struct drm_device *dev = plane->dev;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_output *output = NULL;
 	struct virtio_gpu_object *bo;
 	struct drm_rect rect;
@@ -235,7 +235,7 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 				       struct drm_plane_state *new_state)
 {
 	struct drm_device *dev = plane->dev;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_framebuffer *vgfb;
 	struct virtio_gpu_object *bo;
 
@@ -278,7 +278,7 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
 									   plane);
 	struct drm_device *dev = plane->dev;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_output *output = NULL;
 	struct virtio_gpu_framebuffer *vgfb;
 	struct virtio_gpu_object *bo = NULL;
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index 44425f20d91aa..44e761dc4d79f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -32,7 +32,7 @@ static int virtgpu_virtio_get_uuid(struct dma_buf *buf,
 {
 	struct drm_gem_object *obj = buf->priv;
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
-	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(obj->dev);
 
 	wait_event(vgdev->resp_wq, bo->uuid_state != STATE_INITIALIZING);
 	if (bo->uuid_state != STATE_OK)
@@ -106,7 +106,7 @@ struct dma_buf *virtgpu_gem_prime_export(struct drm_gem_object *obj,
 {
 	struct dma_buf *buf;
 	struct drm_device *dev = obj->dev;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
 	int ret = 0;
 	bool blob = bo->host3d_blob || bo->guest_blob;
diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index cf3c04b16a7a8..5a599064aa265 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -162,7 +162,7 @@ static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
 				  u64 fence_ctx, u32 ring_idx)
 {
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_fence *out_fence;
 	int err;
 
@@ -251,7 +251,7 @@ static int virtio_gpu_lock_buflist(struct virtio_gpu_submit *submit)
 int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file)
 {
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	u64 fence_ctx = vgdev->fence_drv.context;
 	struct drm_virtgpu_execbuffer *exbuf = data;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index b1a00c0c25a70..7faa7f1a84005 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -56,7 +56,7 @@ static void convert_to_hw_box(struct virtio_gpu_box *dst,
 void virtio_gpu_ctrl_ack(struct virtqueue *vq)
 {
 	struct drm_device *dev = vq->vdev->priv;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 
 	schedule_work(&vgdev->ctrlq.dequeue_work);
 }
@@ -64,7 +64,7 @@ void virtio_gpu_ctrl_ack(struct virtqueue *vq)
 void virtio_gpu_cursor_ack(struct virtqueue *vq)
 {
 	struct drm_device *dev = vq->vdev->priv;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(dev);
 
 	schedule_work(&vgdev->cursorq.dequeue_work);
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
index 25df81c027837..c4a82f4da5a48 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -6,7 +6,7 @@
 static void virtio_gpu_vram_free(struct drm_gem_object *obj)
 {
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
-	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(obj->dev);
 	struct virtio_gpu_object_vram *vram = to_virtio_gpu_vram(bo);
 	bool unmap;
 
@@ -33,7 +33,7 @@ static int virtio_gpu_vram_mmap(struct drm_gem_object *obj,
 				struct vm_area_struct *vma)
 {
 	int ret;
-	struct virtio_gpu_device *vgdev = obj->dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(obj->dev);
 	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
 	struct virtio_gpu_object_vram *vram = to_virtio_gpu_vram(bo);
 	unsigned long vm_size = vma->vm_end - vma->vm_start;
@@ -70,7 +70,7 @@ struct sg_table *virtio_gpu_vram_map_dma_buf(struct virtio_gpu_object *bo,
 					     struct device *dev,
 					     enum dma_data_direction dir)
 {
-	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(bo->base.base.dev);
 	struct virtio_gpu_object_vram *vram = to_virtio_gpu_vram(bo);
 	struct sg_table *sgt;
 	dma_addr_t addr;
@@ -143,7 +143,7 @@ static int virtio_gpu_vram_map(struct virtio_gpu_object *bo)
 	int ret;
 	uint64_t offset;
 	struct virtio_gpu_object_array *objs;
-	struct virtio_gpu_device *vgdev = bo->base.base.dev->dev_private;
+	struct virtio_gpu_device *vgdev = to_virtio_gpu_device(bo->base.base.dev);
 	struct virtio_gpu_object_vram *vram = to_virtio_gpu_vram(bo);
 
 	if (!vgdev->has_host_visible)
-- 
2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
