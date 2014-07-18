From: Benoit Taine <benoit.taine@lip6.fr>
Subject: [PATCH 23/25] virtio: Replace DEFINE_PCI_DEVICE_TABLE macro use
Date: Fri, 18 Jul 2014 17:27:10 +0200
Message-ID: <1405697232-11785-24-git-send-email-benoit.taine__16669.0300488428$1405698825$gmane$org@lip6.fr>
References: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1405697232-11785-1-git-send-email-benoit.taine@lip6.fr>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: benoit.taine@lip6.fr, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We should prefer `struct pci_device_id` over `DEFINE_PCI_DEVICE_TABLE` to meet
kernel coding style guidelines. This issue was reported by checkpatch.

Signed-off-by: Benoit Taine <benoit.taine@lip6.fr>

---
Tested by compilation without errors.

 drivers/virtio/virtio_pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 101db3f..3d1463c 100644
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
