From: Matthew Wilcox <willy@infradead.org>
Subject: [RFC] Rewrite page fault interception in TTM drivers
Date: Sat, 14 Apr 2018 20:31:13 -0700
Message-ID: <20180415033113.GB6297@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Three^W Two of the TTM drivers intercept the pagefault handler in a rather
un-Linuxy and racy way.  If they really must intercept the fault call
(and it's not clear to me that they need to), I'd rather see them do it
like this.

The QXL driver seems least likely to need it; as the virtio driver has
exactly the same code in it, only commented out.  The radeon driver takes
its own lock ... maybe there's a way to avoid that since no other driver
needs to take its own lock at this point?

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index ee2340e31f06..d2c76a3d6816 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -102,21 +102,23 @@ static void qxl_ttm_global_fini(struct qxl_device *qdev)
 	}
 }
 
-static struct vm_operations_struct qxl_ttm_vm_ops;
-static const struct vm_operations_struct *ttm_vm_ops;
-
 static int qxl_ttm_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo;
-	int r;
 
 	bo = (struct ttm_buffer_object *)vmf->vma->vm_private_data;
 	if (bo == NULL)
 		return VM_FAULT_NOPAGE;
-	r = ttm_vm_ops->fault(vmf);
-	return r;
+	return ttm_bo_vm_fault(vmf);
 }
 
+static const struct vm_operations_struct qxl_ttm_vm_ops = {
+	.fault = qxl_ttm_fault,
+	.open = ttm_bo_vm_open,
+	.close = ttm_bo_vm_close,
+	.access = ttm_bo_vm_access,
+};
+
 int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct drm_file *file_priv;
@@ -139,11 +141,6 @@ int qxl_mmap(struct file *filp, struct vm_area_struct *vma)
 	r = ttm_bo_mmap(filp, vma, &qdev->mman.bdev);
 	if (unlikely(r != 0))
 		return r;
-	if (unlikely(ttm_vm_ops == NULL)) {
-		ttm_vm_ops = vma->vm_ops;
-		qxl_ttm_vm_ops = *ttm_vm_ops;
-		qxl_ttm_vm_ops.fault = &qxl_ttm_fault;
-	}
 	vma->vm_ops = &qxl_ttm_vm_ops;
 	return 0;
 }
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 8689fcca051c..08cc0c5b9e94 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -944,9 +944,6 @@ void radeon_ttm_set_active_vram_size(struct radeon_device *rdev, u64 size)
 	man->size = size >> PAGE_SHIFT;
 }
 
-static struct vm_operations_struct radeon_ttm_vm_ops;
-static const struct vm_operations_struct *ttm_vm_ops = NULL;
-
 static int radeon_ttm_fault(struct vm_fault *vmf)
 {
 	struct ttm_buffer_object *bo;
@@ -959,11 +956,18 @@ static int radeon_ttm_fault(struct vm_fault *vmf)
 	}
 	rdev = radeon_get_rdev(bo->bdev);
 	down_read(&rdev->pm.mclk_lock);
-	r = ttm_vm_ops->fault(vmf);
+	r = ttm_bo_vm_fault(vmf);
 	up_read(&rdev->pm.mclk_lock);
 	return r;
 }
 
+static const struct vm_operations_struct radeon_ttm_vm_ops = {
+	.fault = radeon_ttm_fault,
+	.open = ttm_bo_vm_open,
+	.close = ttm_bo_vm_close,
+	.access = ttm_bo_vm_access,
+};
+
 int radeon_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct drm_file *file_priv;
@@ -983,11 +987,6 @@ int radeon_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (unlikely(r != 0)) {
 		return r;
 	}
-	if (unlikely(ttm_vm_ops == NULL)) {
-		ttm_vm_ops = vma->vm_ops;
-		radeon_ttm_vm_ops = *ttm_vm_ops;
-		radeon_ttm_vm_ops.fault = &radeon_ttm_fault;
-	}
 	vma->vm_ops = &radeon_ttm_vm_ops;
 	return 0;
 }
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 8eba95b3c737..f59a8f41aae0 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -104,7 +104,7 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
 		+ page_offset;
 }
 
-static int ttm_bo_vm_fault(struct vm_fault *vmf)
+int ttm_bo_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
@@ -294,8 +294,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
 	ttm_bo_unreserve(bo);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ttm_bo_vm_fault);
 
-static void ttm_bo_vm_open(struct vm_area_struct *vma)
+void ttm_bo_vm_open(struct vm_area_struct *vma)
 {
 	struct ttm_buffer_object *bo =
 	    (struct ttm_buffer_object *)vma->vm_private_data;
@@ -304,14 +305,16 @@ static void ttm_bo_vm_open(struct vm_area_struct *vma)
 
 	(void)ttm_bo_reference(bo);
 }
+EXPORT_SYMBOL_GPL(ttm_bo_vm_open);
 
-static void ttm_bo_vm_close(struct vm_area_struct *vma)
+void ttm_bo_vm_close(struct vm_area_struct *vma)
 {
 	struct ttm_buffer_object *bo = (struct ttm_buffer_object *)vma->vm_private_data;
 
 	ttm_bo_unref(&bo);
 	vma->vm_private_data = NULL;
 }
+EXPORT_SYMBOL_GPL(ttm_bo_vm_close);
 
 static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
 				 unsigned long offset,
@@ -352,7 +355,7 @@ static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
 	return len;
 }
 
-static int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
+int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
 			    void *buf, int len, int write)
 {
 	unsigned long offset = (addr) - vma->vm_start;
@@ -389,6 +392,7 @@ static int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(ttm_bo_vm_access);
 
 static const struct vm_operations_struct ttm_bo_vm_ops = {
 	.fault = ttm_bo_vm_fault,
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index c67977aa1a0e..5935fbfc07f5 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -713,6 +713,12 @@ void *ttm_kmap_atomic_prot(struct page *page, pgprot_t prot);
 
 void ttm_kunmap_atomic_prot(void *addr, pgprot_t prot);
 
+int ttm_bo_vm_fault(struct vm_fault *vmf);
+void ttm_bo_vm_open(struct vm_area_struct *vma);
+void ttm_bo_vm_close(struct vm_area_struct *vma);
+int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned long addr,
+		void *buf, int len, int write);
+
 /**
  * ttm_bo_io
  *
