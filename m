From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 15/17] drm/qxl: switch qxl to drm_gem_object_funcs->mmap
	codepath
Date: Thu,  8 Aug 2019 15:44:15 +0200
Message-ID: <20190808134417.10610-16-kraxel__22847.8922204644$1565271911$gmane$org@redhat.com>
References: <20190808134417.10610-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190808134417.10610-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

... using the use drm_gem_ttm_mmap() helper function.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h    |  1 -
 drivers/gpu/drm/qxl/qxl_drv.c    |  2 +-
 drivers/gpu/drm/qxl/qxl_object.c |  1 +
 drivers/gpu/drm/qxl/qxl_ttm.c    | 16 ----------------
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 82efbe76062a..dc36479a54f2 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -352,7 +352,6 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 /* qxl ttm */
 int qxl_ttm_init(struct qxl_device *qdev);
 void qxl_ttm_fini(struct qxl_device *qdev);
-int qxl_mmap(struct file *filp, struct vm_area_struct *vma);
 
 /* qxl image */
 
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 38467478c7b2..2fb1641c817e 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -139,7 +139,7 @@ static const struct file_operations qxl_fops = {
 	.unlocked_ioctl = drm_ioctl,
 	.poll = drm_poll,
 	.read = drm_read,
-	.mmap = qxl_mmap,
+	.mmap = drm_gem_mmap,
 };
 
 static int qxl_drm_freeze(struct drm_device *dev)
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 29aab7b14513..5c503829c580 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -86,6 +86,7 @@ static const struct drm_gem_object_funcs qxl_object_funcs = {
 	.get_sg_table = qxl_gem_prime_get_sg_table,
 	.vmap = qxl_gem_prime_vmap,
 	.vunmap = qxl_gem_prime_vunmap,
+	.mmap = drm_gem_ttm_mmap,
 };
 
 int qxl_bo_create(struct qxl_device *qdev,
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 41edbde0e37e..dbaed0e67c21 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -48,22 +48,6 @@ static struct qxl_device *qxl_get_qdev(struct ttm_bo_device *bdev)
 	return qdev;
 }
 
-int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	struct drm_file *file_priv = filp->private_data;
-	struct qxl_device *qdev = file_priv->minor->dev->dev_private;
-
-	if (qdev == NULL) {
-		DRM_ERROR(
-		 "filp->private_data->minor->dev->dev_private == NULL\n");
-		return -EINVAL;
-	}
-	DRM_DEBUG_DRIVER("filp->private_data = 0x%p, vma->vm_pgoff = %lx\n",
-		  filp->private_data, vma->vm_pgoff);
-
-	return ttm_bo_mmap(filp, vma, &qdev->mman.bdev);
-}
-
 static int qxl_invalidate_caches(struct ttm_bo_device *bdev, uint32_t flags)
 {
 	return 0;
-- 
2.18.1
