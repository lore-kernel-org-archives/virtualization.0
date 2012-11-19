From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 122/493] virtio: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:21:11 -0500
Message-ID: <1353349642-3677-122-git-send-email-wfp5p@virginia.edu>
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
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: virtualization@lists.linux-foundation.org 
---
 drivers/virtio/virtio_balloon.c | 2 +-
 drivers/virtio/virtio_mmio.c    | 2 +-
 drivers/virtio/virtio_pci.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 2a4f1e3..c61cce9 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -545,7 +545,7 @@ static struct virtio_driver virtio_balloon_driver = {
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtballoon_probe,
-	.remove =	__devexit_p(virtballoon_remove),
+	.remove =	virtballoon_remove,
 	.config_changed = virtballoon_changed,
 #ifdef CONFIG_PM
 	.freeze	=	virtballoon_freeze,
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 5a0e1d3..5584f48 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -630,7 +630,7 @@ MODULE_DEVICE_TABLE(of, virtio_mmio_match);
 
 static struct platform_driver virtio_mmio_driver = {
 	.probe		= virtio_mmio_probe,
-	.remove		= __devexit_p(virtio_mmio_remove),
+	.remove		= virtio_mmio_remove,
 	.driver		= {
 		.name	= "virtio-mmio",
 		.owner	= THIS_MODULE,
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index e3ecc94..9bd7fb2 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -822,7 +822,7 @@ static struct pci_driver virtio_pci_driver = {
 	.name		= "virtio-pci",
 	.id_table	= virtio_pci_id_table,
 	.probe		= virtio_pci_probe,
-	.remove		= __devexit_p(virtio_pci_remove),
+	.remove		= virtio_pci_remove,
 #ifdef CONFIG_PM
 	.driver.pm	= &virtio_pci_pm_ops,
 #endif
-- 
1.8.0
