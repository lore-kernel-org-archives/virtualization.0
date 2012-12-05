From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [PATCH 1/3] virtio: change to_vp_device to an inlined definition
Date: Wed, 5 Dec 2012 15:03:27 +0800
Message-ID: <1354691009-25966-1-git-send-email-gaowanlong@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

to_vp_device is worth changing to inlined definition.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/virtio/virtio_pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index e3ecc94..7681fe3 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -98,11 +98,7 @@ static struct pci_device_id virtio_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, virtio_pci_id_table);
 
-/* Convert a generic virtio device to our structure */
-static struct virtio_pci_device *to_vp_device(struct virtio_device *vdev)
-{
-	return container_of(vdev, struct virtio_pci_device, vdev);
-}
+#define to_vp_device(_vdev) container_of(_vdev, struct virtio_pci_device, vdev)
 
 /* virtio config->get_features() implementation */
 static u32 vp_get_features(struct virtio_device *vdev)
-- 
1.8.0
