From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [PATCH v2 1/2] virtio_mmio: add cleanup for virtio_mmio_probe
Date: Tue, 5 Dec 2017 19:57:10 +0800
Message-ID: <40b3946d54c4a08b2ce3741f4d27bff99ec2f6c8.1512445595.git.zhangweiping@didichuxing.com>
References: <cover.1512445595.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1512445595.git.zhangweiping@didichuxing.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: cohuck@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

As mentioned at drivers/base/core.c:
/*
 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up the
 * reference initialized in this function instead.
 */

Normal we do cleanup for @vm_dev by contianer_of(@dev), but in this case
we need release @mem resource from @pdev and vm_dev->base. It make
@pdev->vm_dev.dev.release() too complicated, so put_device just put the
reference of register_virtio_device->device_register->device_initialize
and release all resource in virtio_mmio_probe.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/virtio/virtio_mmio.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 74dc717..f984510 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -513,8 +513,10 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		return -EBUSY;
 
 	vm_dev = devm_kzalloc(&pdev->dev, sizeof(*vm_dev), GFP_KERNEL);
-	if (!vm_dev)
-		return  -ENOMEM;
+	if (!vm_dev) {
+		rc = -ENOMEM;
+		goto free_mem;
+	}
 
 	vm_dev->vdev.dev.parent = &pdev->dev;
 	vm_dev->vdev.dev.release = virtio_mmio_release_dev_empty;
@@ -524,14 +526,17 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	spin_lock_init(&vm_dev->lock);
 
 	vm_dev->base = devm_ioremap(&pdev->dev, mem->start, resource_size(mem));
-	if (vm_dev->base == NULL)
-		return -EFAULT;
+	if (vm_dev->base == NULL) {
+		rc = -EFAULT;
+		goto free_vmdev;
+	}
 
 	/* Check magic value */
 	magic = readl(vm_dev->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		dev_warn(&pdev->dev, "Wrong magic value 0x%08lx!\n", magic);
-		return -ENODEV;
+		rc = -ENODEV;
+		goto unmap;
 	}
 
 	/* Check device version */
@@ -539,7 +544,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	if (vm_dev->version < 1 || vm_dev->version > 2) {
 		dev_err(&pdev->dev, "Version %ld not supported!\n",
 				vm_dev->version);
-		return -ENXIO;
+		rc = -ENXIO;
+		goto unmap;
 	}
 
 	vm_dev->vdev.id.device = readl(vm_dev->base + VIRTIO_MMIO_DEVICE_ID);
@@ -548,7 +554,8 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
 		 * with no function. End probing now with no error reported.
 		 */
-		return -ENODEV;
+		rc = -ENODEV;
+		goto unmap;
 	}
 	vm_dev->vdev.id.vendor = readl(vm_dev->base + VIRTIO_MMIO_VENDOR_ID);
 
@@ -573,7 +580,20 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, vm_dev);
 
-	return register_virtio_device(&vm_dev->vdev);
+	rc = register_virtio_device(&vm_dev->vdev);
+	if (rc)
+		goto put_dev;
+	return 0;
+put_dev:
+	put_device(&vm_dev->vdev.dev);
+unmap:
+	iounmap(vm_dev->base);
+free_mem:
+	devm_release_mem_region(&pdev->dev, mem->start,
+			resource_size(mem));
+free_vmdev:
+	devm_kfree(&pdev->dev, vm_dev);
+	return rc;
 }
 
 static int virtio_mmio_remove(struct platform_device *pdev)
-- 
2.9.4
