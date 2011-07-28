From: Amit Shah <amit.shah@redhat.com>
Subject: [RFC PATCH 3/8] virtio-pci: save/restore config space across S4
Date: Thu, 28 Jul 2011 20:05:08 +0530
Message-ID: <124c8fbc2974d0353cac204d5d9ff35a6a6a0e13.1311863438.git.amit.shah@redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
In-Reply-To: <cover.1311863438.git.amit.shah@redhat.com>
References: <cover.1311863438.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The virtio config space doesn't get saved across hibernation; we save it
locally and update it after restore.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/virtio/virtio_pci.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 579681f..9c37561 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -56,6 +56,10 @@ struct virtio_pci_device
 	unsigned msix_vectors;
 	/* Vectors allocated, excluding per-vq vectors if any */
 	unsigned msix_used_vectors;
+
+	/* Status saved during hibernate/restore */
+	u8 saved_status;
+
 	/* Whether we have vector per vq */
 	bool per_vq_vectors;
 };
@@ -713,6 +717,7 @@ static int virtio_pci_freeze(struct device *dev)
 	drv = container_of(vp_dev->vdev.dev.driver,
 			   struct virtio_driver, driver);
 
+	vp_dev->saved_status = vp_get_status(&vp_dev->vdev);
 	if (drv && drv->freeze)
 		return drv->freeze(&vp_dev->vdev);
 
@@ -728,6 +733,7 @@ static int virtio_pci_restore(struct device *dev)
 	drv = container_of(vp_dev->vdev.dev.driver,
 			   struct virtio_driver, driver);
 
+	vp_set_status(&vp_dev->vdev, vp_dev->saved_status);
 	if (drv && drv->restore)
 		return drv->restore(&vp_dev->vdev);
 
-- 
1.7.6
