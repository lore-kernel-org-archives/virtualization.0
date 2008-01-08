From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Remove unnecessary pr_debug()
Date: Tue,  8 Jan 2008 16:42:05 -0600
Message-ID: <1199832125343-git-send-email-aliguori@us.ibm.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Anthony Liguori <aliguori@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This is not formatted correctly and really not useful, so let's just remove it.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 36b810d..2882490 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -73,7 +73,6 @@ MODULE_DEVICE_TABLE(pci, virtio_pci_id_table);
 
 static void virtio_pci_root_release(struct device *d)
 {
-    pr_debug("%s\n", __FUNCTION__);
 }
 
 /* A PCI device has it's own struct device and so does a virtio device so
