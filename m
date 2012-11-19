From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 392/493] block: remove use of __devexit
Date: Mon, 19 Nov 2012 13:25:41 -0500
Message-ID: <1353349642-3677-392-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@linuxfoundation.org
Cc: iss_storagedev@hp.com, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Grant Likely <grant.likely@secretlab.ca>, Chirag Kantharia <chirag.kantharia@hp.com>
List-Id: virtualization@lists.linuxfoundation.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Chirag Kantharia <chirag.kantharia@hp.com> 
Cc: Rusty Russell <rusty@rustcorp.com.au> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: Grant Likely <grant.likely@secretlab.ca> 
Cc: iss_storagedev@hp.com 
Cc: virtualization@lists.linux-foundation.org 
---
 drivers/block/cciss.c      | 2 +-
 drivers/block/cpqarray.c   | 6 +++---
 drivers/block/nvme.c       | 2 +-
 drivers/block/swim.c       | 2 +-
 drivers/block/virtio_blk.c | 4 ++--
 drivers/block/xsysace.c    | 6 +++---
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 3096c79..d5b415c97 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -5229,7 +5229,7 @@ static int cciss_enter_simple_mode(struct ctlr_info *h)
 }
 
 
-static void __devexit cciss_remove_one(struct pci_dev *pdev)
+static void cciss_remove_one(struct pci_dev *pdev)
 {
 	ctlr_info_t *h;
 	int i, j;
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index 34973bc..6c2aa76 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -320,7 +320,7 @@ static void release_io_mem(ctlr_info_t *c)
 	c->io_mem_length = 0;
 }
 
-static void __devexit cpqarray_remove_one(int i)
+static void cpqarray_remove_one(int i)
 {
 	int j;
 	char buff[4];
@@ -352,7 +352,7 @@ static void __devexit cpqarray_remove_one(int i)
 	free_hba(i);
 }
 
-static void __devexit cpqarray_remove_one_pci (struct pci_dev *pdev)
+static void cpqarray_remove_one_pci (struct pci_dev *pdev)
 {
 	int i;
 	ctlr_info_t *tmp_ptr;
@@ -377,7 +377,7 @@ static void __devexit cpqarray_remove_one_pci (struct pci_dev *pdev)
 /* removing an instance that was not removed automatically..
  * must be an eisa card.
  */
-static void __devexit cpqarray_remove_one_eisa (int i)
+static void cpqarray_remove_one_eisa (int i)
 {
 	if (hba[i] == NULL) {
 		printk(KERN_ERR "cpqarray: controller %d appears to have"
diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 8a7dc4c..7f40623 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1702,7 +1702,7 @@ static int nvme_probe(struct pci_dev *pdev,
 	return result;
 }
 
-static void __devexit nvme_remove(struct pci_dev *pdev)
+static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 	nvme_dev_remove(dev);
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 989f5bd..a8e09b8 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -936,7 +936,7 @@ out:
 	return ret;
 }
 
-static int __devexit swim_remove(struct platform_device *dev)
+static int swim_remove(struct platform_device *dev)
 {
 	struct swim_priv *swd = platform_get_drvdata(dev);
 	int drive;
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9f64e5cb..6c6df0c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -885,7 +885,7 @@ out:
 	return err;
 }
 
-static void __devexit virtblk_remove(struct virtio_device *vdev)
+static void virtblk_remove(struct virtio_device *vdev)
 {
 	struct virtio_blk *vblk = vdev->priv;
 	int index = vblk->index;
@@ -963,7 +963,7 @@ static unsigned int features[] = {
 
 /*
  * virtio_blk causes spurious section mismatch warning by
- * simultaneously referring to a and a __devexit function.
+ * simultaneously referring to a and a function.
  * Use __refdata to avoid this warning.
  */
 static struct virtio_driver __refdata virtio_blk = {
diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 1700b20..a784b176 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1074,7 +1074,7 @@ err_ioremap:
 	return -ENOMEM;
 }
 
-static void __devexit ace_teardown(struct ace_device *ace)
+static void ace_teardown(struct ace_device *ace)
 {
 	if (ace->gd) {
 		del_gendisk(ace->gd);
@@ -1135,7 +1135,7 @@ err_noreg:
 	return rc;
 }
 
-static void __devexit ace_free(struct device *dev)
+static void ace_free(struct device *dev)
 {
 	struct ace_device *ace = dev_get_drvdata(dev);
 	dev_dbg(dev, "ace_free(%p)\n", dev);
@@ -1182,7 +1182,7 @@ static int ace_probe(struct platform_device *dev)
 /*
  * Platform bus remove() method
  */
-static int __devexit ace_remove(struct platform_device *dev)
+static int ace_remove(struct platform_device *dev)
 {
 	ace_free(&dev->dev);
 	return 0;
-- 
1.8.0
