Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F54439DBC3
	for <virtualization@lists.linux.dev>; Wed, 22 Apr 2026 03:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776827947; cv=none; b=gdD1P5a/cui9VMpkDocUL+V3Zzmsql6QKyclEynenH3YohKUg1DHmqkruBeSSvEPuaG4c6PGFe6KkpdeKSjJyEl8/wS5N5ke94D9WjlPSsgDU0ipLha+jwG1AL9v91smMMWyqJaMQKYc76hCT3TRvhA2ULoGskWT6UOgUsnjD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776827947; c=relaxed/simple;
	bh=+/iimaHO/XPiRa6mbXXOIfJdPCc1fKK+2MHybej5rhg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bmrp16YrzjooF9FRYwoqc516/Wl9hMlixi0rNh6ONa3GPWHFthDUUS2R+ACmwMt7okp7rJCFzvviPfA3HEUTuBjQY0sJ0TeNg0Uv/x5+VTBkA1c5cFj/3RV5KDzVnngdAw1DdzVWKqOh8J5gawE4N4jJQUuQs8a1BmS1V4wVNJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i5R3Dq2B; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="i5R3Dq2B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Oi
	QDuPeM0CiywsGMxhX8g6+bnyymbiQy6vMzxt56jTs=; b=i5R3Dq2BpCHY1WVcJH
	m9+1+ktQWRozJbaUTdP8byvvXqlqpMaDeHAHRpHYbfiSu0ubYC/XI/BgefEbMVtb
	g9Xp2Om98VdlRXuUaxUmrg0bJ2O5H4GXYRKwcSsIajB/WrDDBEwHXcH99Vsr4Fa3
	c8N5uoOVfZQ/04cduwtxRQSQU=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3T+rgPehpC96LAw--.54994S2;
	Wed, 22 Apr 2026 11:18:05 +0800 (CST)
From: liuqiangneo@163.com
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Qiang Liu <liuqiang@kylinos.cn>
Subject: [PATCH v3] drm/qxl: Convert qxl release idr to xarray
Date: Wed, 22 Apr 2026 11:17:39 +0800
Message-ID: <20260422031740.45371-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3T+rgPehpC96LAw--.54994S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr1Dtw1fJFy5Cw18XrWfuFg_yoWxXFWDpF
	W8JFW5ArWUJr4qgFnrAanrXF1Sv3WYgay3GFW7ta43Zw15Jry5Xr15JF4qqrZYyFZ5Aa17
	Xa1UKryUCF1UWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC+w4fgGnoPe6TOQAA3S

From: Qiang Liu <liuqiang@kylinos.cn>

Replace the release_idr + release_idr_lock to an XArray.
IDR internally uses xarray so we can use it directly which simplifies our
code by removing the IDR wrapper.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
v3:
- Change the type of 'handle' to u32.
  'xa_limit_31b' restricts the range of 'handle',
  so an implicit cast to 'int' is safe.
- Keep xa_lock in xa_lock due to concurrent access.

v2:
- Use xa_limit_31b instead of xa_limit_32b to keep IDs within INT_MAX.
- Use GFP_KERNEL instead of GFP_NOWAIT because the context is sleepable.
- Cast to u32 to avoid sign extension when atomic counter wraps above INT_MAX.
---
 drivers/gpu/drm/qxl/qxl_drv.h     |  6 ++--
 drivers/gpu/drm/qxl/qxl_kms.c     |  4 +--
 drivers/gpu/drm/qxl/qxl_release.c | 49 ++++++++++++++-----------------
 3 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index cc02b5f10ad9..cf9decf39022 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -35,6 +35,7 @@
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
+#include <linux/xarray.h>
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
@@ -208,11 +209,10 @@ struct qxl_device {
 	struct qxl_memslot surfaces_slot;
 
 	spinlock_t	release_lock;
-	struct idr	release_idr;
-	uint32_t	release_seqno;
+	struct xarray	release_xa;
+	atomic_t	release_seqno;
 	atomic_t	release_count;
 	wait_queue_head_t release_event;
-	spinlock_t release_idr_lock;
 	struct mutex	async_io_mutex;
 	unsigned int last_sent_io_cmd;
 
diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index 461b7ab9ad5c..0cebaf88f407 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -227,8 +227,8 @@ int qxl_device_init(struct qxl_device *qdev,
 		goto cursor_ring_free;
 	}
 
-	idr_init_base(&qdev->release_idr, 1);
-	spin_lock_init(&qdev->release_idr_lock);
+	xa_init_flags(&qdev->release_xa, XA_FLAGS_ALLOC1);
+	atomic_set(&qdev->release_seqno, 0);
 	spin_lock_init(&qdev->release_lock);
 
 	idr_init_base(&qdev->surf_id_idr, 1);
diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 06979d0e8a9f..afed1096cf7b 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -88,8 +88,9 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
 		  struct qxl_release **ret)
 {
 	struct qxl_release *release;
-	int handle;
+	u32 handle;
 	size_t size = sizeof(*release);
+	int r;
 
 	release = kmalloc(size, GFP_KERNEL);
 	if (!release) {
@@ -102,19 +103,15 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
 	release->surface_release_id = 0;
 	INIT_LIST_HEAD(&release->bos);
 
-	idr_preload(GFP_KERNEL);
-	spin_lock(&qdev->release_idr_lock);
-	handle = idr_alloc(&qdev->release_idr, release, 1, 0, GFP_NOWAIT);
-	release->base.seqno = ++qdev->release_seqno;
-	spin_unlock(&qdev->release_idr_lock);
-	idr_preload_end();
-	if (handle < 0) {
+	r = xa_alloc(&qdev->release_xa, &handle, release, xa_limit_31b, GFP_KERNEL);
+	release->base.seqno = (u32)atomic_inc_return(&qdev->release_seqno);
+	if (r < 0) {
 		kfree(release);
 		*ret = NULL;
-		return handle;
+		return r;
 	}
 	*ret = release;
-	DRM_DEBUG_DRIVER("allocated release %d\n", handle);
+	DRM_DEBUG_DRIVER("allocated release %u\n", handle);
 	release->id = handle;
 	return handle;
 }
@@ -143,9 +140,7 @@ qxl_release_free(struct qxl_device *qdev,
 	if (release->surface_release_id)
 		qxl_surface_id_dealloc(qdev, release->surface_release_id);
 
-	spin_lock(&qdev->release_idr_lock);
-	idr_remove(&qdev->release_idr, release->id);
-	spin_unlock(&qdev->release_idr_lock);
+	xa_erase(&qdev->release_xa, release->id);
 
 	if (dma_fence_was_initialized(&release->base)) {
 		WARN_ON(list_empty(&release->bos));
@@ -261,14 +256,14 @@ int qxl_alloc_surface_release_reserved(struct qxl_device *qdev,
 				       struct qxl_release **release)
 {
 	if (surface_cmd_type == QXL_SURFACE_CMD_DESTROY && create_rel) {
-		int idr_ret;
+		int xa_ret;
 		struct qxl_bo *bo;
 		union qxl_release_info *info;
 
 		/* stash the release after the create command */
-		idr_ret = qxl_release_alloc(qdev, QXL_RELEASE_SURFACE_CMD, release);
-		if (idr_ret < 0)
-			return idr_ret;
+		xa_ret = qxl_release_alloc(qdev, QXL_RELEASE_SURFACE_CMD, release);
+		if (xa_ret < 0)
+			return xa_ret;
 		bo = create_rel->release_bo;
 
 		(*release)->release_bo = bo;
@@ -277,7 +272,7 @@ int qxl_alloc_surface_release_reserved(struct qxl_device *qdev,
 		qxl_release_list_add(*release, bo);
 
 		info = qxl_release_map(qdev, *release);
-		info->id = idr_ret;
+		info->id = xa_ret;
 		qxl_release_unmap(qdev, *release, info);
 		return 0;
 	}
@@ -291,7 +286,7 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 				       struct qxl_bo **rbo)
 {
 	struct qxl_bo *bo, *free_bo = NULL;
-	int idr_ret;
+	int xa_ret;
 	int ret = 0;
 	union qxl_release_info *info;
 	int cur_idx;
@@ -312,11 +307,11 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 		return -EINVAL;
 	}
 
-	idr_ret = qxl_release_alloc(qdev, type, release);
-	if (idr_ret < 0) {
+	xa_ret = qxl_release_alloc(qdev, type, release);
+	if (xa_ret < 0) {
 		if (rbo)
 			*rbo = NULL;
-		return idr_ret;
+		return xa_ret;
 	}
 	atomic_inc(&qdev->release_count);
 
@@ -362,7 +357,7 @@ int qxl_alloc_release_reserved(struct qxl_device *qdev, unsigned long size,
 	}
 
 	info = qxl_release_map(qdev, *release);
-	info->id = idr_ret;
+	info->id = xa_ret;
 	qxl_release_unmap(qdev, *release, info);
 
 	return ret;
@@ -373,11 +368,11 @@ struct qxl_release *qxl_release_from_id_locked(struct qxl_device *qdev,
 {
 	struct qxl_release *release;
 
-	spin_lock(&qdev->release_idr_lock);
-	release = idr_find(&qdev->release_idr, id);
-	spin_unlock(&qdev->release_idr_lock);
+	xa_lock(&qdev->release_xa);
+	release = xa_load(&qdev->release_xa, id);
+	xa_unlock(&qdev->release_xa);
 	if (!release) {
-		DRM_ERROR("failed to find id in release_idr\n");
+		DRM_ERROR("failed to find id in release_xa\n");
 		return NULL;
 	}
 
-- 
2.43.0

