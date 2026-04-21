Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1667A370D4A
	for <virtualization@lists.linux.dev>; Tue, 21 Apr 2026 06:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776751275; cv=none; b=ZOEWp8IjugWtWAxnA5GFhMfNuhooMSECLoSgmqSr1DZd4WNYA/cTYP10QjDbOiLwk+EbajWY9Rx8RCOwOoPbvXJNDkDPxQbK1FtXh6q5BwEeKEcHPQxAWWLKpq4vM8B1RDLzZJyE6iKOTgvuWMeSsD7Q77lOtntwqSnCQBF00EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776751275; c=relaxed/simple;
	bh=EqD1et+iTwFVX/bpsiFPPpifSVWKpO72WoE7HTLC7nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xlpi0QiQqy/M/H3JF1dEQD4/TpTtwgGMz2Lpp6HrcNdBA0LhNGMO5nyBIjpdNeo8OFL7/Jd6xHtL5gNeO1zYMRYwtrrfIBALJE3ncWdT+GDIWCZRcfN85vXKxA/uOwHRij6hN+pyRN3ir2HcqxHFs/QWx5g5fM77CjSJS9ULrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hKTPJaMu; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hKTPJaMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=VE
	+HeR5jLExkSBGv6vxD6OzE69Sb6c/I3YpoJZsh9c0=; b=hKTPJaMudWjcmNWzBY
	ed4quVP3AoQqy2SYDQRXgWTAKMumh5Lnc9xmocJXaKqyzAxZaCpWuwMo9X4JZ3IV
	JNyGg/awSDY7eb1+5nGl59uJN5v1wo54XHQsKvzvQLjjPfTodU5HyCqti3UJvYwU
	UH3IcyrfuDQRb+Yl2Y5XS3t9o=
Received: from neo-TianYi510Pro-15ICK.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAnnKR9EudpCw9jAw--.47144S2;
	Tue, 21 Apr 2026 14:00:30 +0800 (CST)
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
Subject: [PATCH v2] drm/qxl: Convert qxl release idr to xarray
Date: Tue, 21 Apr 2026 14:00:22 +0800
Message-ID: <20260421060023.96618-1-liuqiangneo@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnnKR9EudpCw9jAw--.47144S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw47ZFy3Gr4kCF17tr43ZFb_yoWxJryxpF
	WrJFW5ArWUJr4qgFnrAanrXF1Sv3WYqayfGFW7ta43Aw15Jry5Xr15Jr4qvrZ5AFZ5Aa17
	Xa1UKryUCF1UW3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnb18UUUUU=
X-CM-SenderInfo: 5olx1xxdqj0vrr6rljoofrz/xtbC4B73WWnnEn6gHwAA3N

From: Qiang Liu <liuqiang@kylinos.cn>

Replace the release_idr + release_idr_lock to an XArray.
IDR internally uses xarray so we can use it directly which simplifies our
code by removing the need to do external locking.

Signed-off-by: Qiang Liu <liuqiang@kylinos.cn>
---
v2:
- Use xa_limit_31b instead of xa_limit_32b to keep IDs within INT_MAX.
- Use GFP_KERNEL instead of GFP_NOWAIT because the context is sleepable.
- Cast to u32 to avoid sign extension when atomic counter wraps above INT_MAX.
---
 drivers/gpu/drm/qxl/qxl_drv.h     |  6 ++---
 drivers/gpu/drm/qxl/qxl_kms.c     |  4 +--
 drivers/gpu/drm/qxl/qxl_release.c | 45 ++++++++++++++-----------------
 3 files changed, 25 insertions(+), 30 deletions(-)

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
index 06979d0e8a9f..929df641b62d 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -90,6 +90,7 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
 	struct qxl_release *release;
 	int handle;
 	size_t size = sizeof(*release);
+	int r;
 
 	release = kmalloc(size, GFP_KERNEL);
 	if (!release) {
@@ -102,16 +103,12 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
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
 	DRM_DEBUG_DRIVER("allocated release %d\n", handle);
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

