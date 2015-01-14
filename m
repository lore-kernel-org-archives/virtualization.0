From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 16/16] virtio_pci_modern: support devices with no config
Date: Wed, 14 Jan 2015 19:28:21 +0200
Message-ID: <1421256142-11512-17-git-send-email-mst__39798.5969590538$1421256642$gmane$org@redhat.com>
References: <1421256142-11512-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421256142-11512-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Virtio 1.0 spec lists device config as optional.
Set get/set callbacks to NULL. Drivers can check that
and fail gracefully.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 9c000e9a..b877705 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -425,6 +425,21 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	free_pages_exact(info->queue, vring_pci_size(info->num));
 }
 
+static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
+	.get		= NULL,
+	.set		= NULL,
+	.generation	= vp_generation,
+	.get_status	= vp_get_status,
+	.set_status	= vp_set_status,
+	.reset		= vp_reset,
+	.find_vqs	= vp_modern_find_vqs,
+	.del_vqs	= vp_del_vqs,
+	.get_features	= vp_get_features,
+	.finalize_features = vp_finalize_features,
+	.bus_name	= vp_bus_name,
+	.set_vq_affinity = vp_set_vq_affinity,
+};
+
 static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get		= vp_get,
 	.set		= vp_set,
@@ -655,9 +670,11 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 						&vp_dev->device_len);
 		if (!vp_dev->device)
 			goto err_map_device;
-	}
 
-	vp_dev->vdev.config = &virtio_pci_config_ops;
+		vp_dev->vdev.config = &virtio_pci_config_ops;
+	} else {
+		vp_dev->vdev.config = &virtio_pci_config_nodev_ops;
+	}
 
 	vp_dev->config_vector = vp_config_vector;
 	vp_dev->setup_vq = setup_vq;
-- 
MST
