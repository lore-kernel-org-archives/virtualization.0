From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 042/493] drivers/block: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:19:51 -0500
Message-ID: <1353349642-3677-42-git-send-email-wfp5p@virginia.edu>
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

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Chirag Kantharia <chirag.kantharia@hp.com> 
Cc: Rusty Russell <rusty@rustcorp.com.au> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: Grant Likely <grant.likely@secretlab.ca> 
Cc: iss_storagedev@hp.com 
Cc: virtualization@lists.linux-foundation.org 
---
 drivers/block/cciss.c      | 2 +-
 drivers/block/cpqarray.c   | 2 +-
 drivers/block/nvme.c       | 2 +-
 drivers/block/swim.c       | 2 +-
 drivers/block/virtio_blk.c | 2 +-
 drivers/block/xsysace.c    | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/cciss.c b/drivers/block/cciss.c
index 6526157..b40068f 100644
--- a/drivers/block/cciss.c
+++ b/drivers/block/cciss.c
@@ -5308,7 +5308,7 @@ static void __devexit cciss_remove_one(struct pci_dev *pdev)
 static struct pci_driver cciss_pci_driver = {
 	.name = "cciss",
 	.probe = cciss_init_one,
-	.remove = __devexit_p(cciss_remove_one),
+	.remove = cciss_remove_one,
 	.id_table = cciss_pci_device_id,	/* id_table */
 	.shutdown = cciss_shutdown,
 };
diff --git a/drivers/block/cpqarray.c b/drivers/block/cpqarray.c
index 9125bbe..389e314 100644
--- a/drivers/block/cpqarray.c
+++ b/drivers/block/cpqarray.c
@@ -536,7 +536,7 @@ static int __devinit cpqarray_init_one( struct pci_dev *pdev,
 static struct pci_driver cpqarray_pci_driver = {
 	.name = "cpqarray",
 	.probe = cpqarray_init_one,
-	.remove = __devexit_p(cpqarray_remove_one_pci),
+	.remove = cpqarray_remove_one_pci,
 	.id_table = cpqarray_pci_device_id,
 };
 
diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 931769e..1f7acff 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1747,7 +1747,7 @@ static struct pci_driver nvme_driver = {
 	.name		= "nvme",
 	.id_table	= nvme_id_table,
 	.probe		= nvme_probe,
-	.remove		= __devexit_p(nvme_remove),
+	.remove		= nvme_remove,
 	.suspend	= nvme_suspend,
 	.resume		= nvme_resume,
 	.err_handler	= &nvme_err_handler,
diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 6d5a914..314f0b4 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -972,7 +972,7 @@ static int __devexit swim_remove(struct platform_device *dev)
 
 static struct platform_driver swim_driver = {
 	.probe  = swim_probe,
-	.remove = __devexit_p(swim_remove),
+	.remove = swim_remove,
 	.driver   = {
 		.name	= CARDNAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0bdde8f..dbba5cf 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -973,7 +973,7 @@ static struct virtio_driver __refdata virtio_blk = {
 	.driver.owner		= THIS_MODULE,
 	.id_table		= id_table,
 	.probe			= virtblk_probe,
-	.remove			= __devexit_p(virtblk_remove),
+	.remove			= virtblk_remove,
 	.config_changed		= virtblk_config_changed,
 #ifdef CONFIG_PM
 	.freeze			= virtblk_freeze,
diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 1a17e33..d925121 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -1204,7 +1204,7 @@ MODULE_DEVICE_TABLE(of, ace_of_match);
 
 static struct platform_driver ace_platform_driver = {
 	.probe = ace_probe,
-	.remove = __devexit_p(ace_remove),
+	.remove = ace_remove,
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "xsysace",
-- 
1.8.0
