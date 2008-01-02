From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH 3/3] Use Qumranet donated PCI vendor/device IDs
Date: Wed,  2 Jan 2008 15:01:34 -0600
Message-ID: <11993076953191-git-send-email-aliguori__5120.77882090143$1199307864$gmane$org@us.ibm.com>
References: <1199307694277-git-send-email-aliguori@us.ibm.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1199307694277-git-send-email-aliguori@us.ibm.com>
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
Cc: kvm-devel@lists.sourceforge.net, Anthony Liguori <aliguori@us.ibm.com>, Dor Laor <dor.laor@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

Qumranet was kind enough to donate a set of vendor/device IDs for virtio
devices.  This patch switches over to using them instead of an unreserved
vendor ID.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index f8df571..36b810d 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -64,7 +64,8 @@ struct virtio_pci_vq_info
 
 /* We have to enumerate here all virtio PCI devices. */
 static struct pci_device_id virtio_pci_id_table[] = {
-	{ 0x5002, 0x2258, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* Dummy entry */
+	{ 0x1af4, 0x1000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* virtio net */
+	{ 0x1af4, 0x1001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 }, /* virtio blk */
 	{ 0 },
 };
