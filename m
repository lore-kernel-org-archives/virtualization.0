From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/6] vhost: use mmgrab() instead of mmget() for non worker device
Date: Fri, 29 May 2020 16:02:59 +0800
Message-ID: <20200529080303.15449-3-jasowang@redhat.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200529080303.15449-1-jasowang@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

For the device that doesn't use vhost worker and use_mm(), mmget() is
too heavy weight and it may brings troubles for implementing mmap()
support for vDPA device.

This is because, an reference to the address space was held via
mm_get() in vhost_dev_set_owner() and an reference to the file was
held in mmap(). This means when process exits, the mm can not be
released thus we can not release the file.

This patch tries to use mmgrab() instead of mmget(), which allows the
address space to be destroy in process exit without releasing the mm
structure itself. This is sufficient for vDPA device which pin user
pages and does not depend on the address space to work.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 70105e045768..9642938a7e7c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -541,6 +541,36 @@ bool vhost_dev_has_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_has_owner);
 
+static void vhost_attach_mm(struct vhost_dev *dev)
+{
+	/* No owner, become one */
+	if (dev->use_worker) {
+		dev->mm = get_task_mm(current);
+	} else {
+		/* vDPA device does not use worker thead, so there's
+		 * no need to hold the address space for mm. This help
+		 * to avoid deadlock in the case of mmap() which may
+		 * held the refcnt of the file and depends on release
+		 * method to remove vma.
+		 */
+		dev->mm = current->mm;
+		mmgrab(dev->mm);
+	}
+}
+
+static void vhost_detach_mm(struct vhost_dev *dev)
+{
+	if (!dev->mm)
+		return;
+
+	if (dev->use_worker)
+		mmput(dev->mm);
+	else
+		mmdrop(dev->mm);
+
+	dev->mm = NULL;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
@@ -553,8 +583,8 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 		goto err_mm;
 	}
 
-	/* No owner, become one */
-	dev->mm = get_task_mm(current);
+	vhost_attach_mm(dev);
+
 	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
 		worker = kthread_create(vhost_worker, dev,
@@ -583,9 +613,7 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 		dev->worker = NULL;
 	}
 err_worker:
-	if (dev->mm)
-		mmput(dev->mm);
-	dev->mm = NULL;
+	vhost_detach_mm(dev);
 	dev->kcov_handle = 0;
 err_mm:
 	return err;
@@ -682,9 +710,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 		dev->worker = NULL;
 		dev->kcov_handle = 0;
 	}
-	if (dev->mm)
-		mmput(dev->mm);
-	dev->mm = NULL;
+	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
 
-- 
2.20.1
