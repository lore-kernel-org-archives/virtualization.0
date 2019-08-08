From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 14/17] drm/qxl: drop qxl_ttm_fault
Date: Thu,  8 Aug 2019 15:44:14 +0200
Message-ID: <20190808134417.10610-15-kraxel__41605.3194248647$1565271934$gmane$org@redhat.com>
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

Not sure what this hook is supposed to do.  vmf->vma->vm_private_data
should never be NULL, so the extra check in qxl_ttm_fault should have no
effect.

Drop it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 3a24145dd516..41edbde0e37e 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -48,24 +48,8 @@ static struct qxl_device *qxl_get_qdev(struct ttm_bo_device *bdev)
 	return qdev;
 }
 
-static struct vm_operations_struct qxl_ttm_vm_ops;
-static const struct vm_operations_struct *ttm_vm_ops;
-
-static vm_fault_t qxl_ttm_fault(struct vm_fault *vmf)
-{
-	struct ttm_buffer_object *bo;
-	vm_fault_t ret;
-
-	bo = (struct ttm_buffer_object *)vmf->vma->vm_private_data;
-	if (bo == NULL)
-		return VM_FAULT_NOPAGE;
-	ret = ttm_vm_ops->fault(vmf);
-	return ret;
-}
-
 int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-	int r;
 	struct drm_file *file_priv = filp->private_data;
 	struct qxl_device *qdev = file_priv->minor->dev->dev_private;
 
@@ -77,16 +61,7 @@ int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
 	DRM_DEBUG_DRIVER("filp->private_data = 0x%p, vma->vm_pgoff = %lx\n",
 		  filp->private_data, vma->vm_pgoff);
 
-	r = ttm_bo_mmap(filp, vma, &qdev->mman.bdev);
-	if (unlikely(r != 0))
-		return r;
-	if (unlikely(ttm_vm_ops == NULL)) {
-		ttm_vm_ops = vma->vm_ops;
-		qxl_ttm_vm_ops = *ttm_vm_ops;
-		qxl_ttm_vm_ops.fault = &qxl_ttm_fault;
-	}
-	vma->vm_ops = &qxl_ttm_vm_ops;
-	return 0;
+	return ttm_bo_mmap(filp, vma, &qdev->mman.bdev);
 }
 
 static int qxl_invalidate_caches(struct ttm_bo_device *bdev, uint32_t flags)
-- 
2.18.1
