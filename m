From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 33/39] virtio: pci: remove DEFINE_PCI_DEVICE_TABLE macro
Date: Tue, 03 Dec 2013 08:29:12 +0900
Message-ID: <003601ceefb6$4ef0e6e0$ecd2b4a0$%han@samsung.com>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-to: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
Content-language: ko
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: 'Jingoo Han' <jg1.han@samsung.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
is not preferred.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/virtio/virtio_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index a37c699..a4a1f7c 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -91,7 +91,7 @@ struct virtio_pci_vq_info
 };
 
 /* Qumranet donated their vendor ID for devices 0x1000 thru 0x10FF. */
-static DEFINE_PCI_DEVICE_TABLE(virtio_pci_id_table) = {
+static const struct pci_device_id virtio_pci_id_table[] = {
 	{ PCI_DEVICE(0x1af4, PCI_ANY_ID) },
 	{ 0 }
 };
-- 
1.7.10.4
