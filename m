From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/3] virtio_pci: device-specific release callback
Date: Sun, 4 Jan 2015 18:02:18 +0200
Message-ID: <1420386340-7719-2-git-send-email-mst@redhat.com>
References: <1420386340-7719-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1420386340-7719-1-git-send-email-mst@redhat.com>
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
Cc: sasha.levin@oracle.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It turns out we need to add device-specific code
in release callback.
In particular, we need to free memory allocated in probe.

Move it to virtio_pci_legacy.c.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_common.h | 1 -
 drivers/virtio/virtio_pci_common.c | 9 ---------
 drivers/virtio/virtio_pci_legacy.c | 9 +++++++++
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 1584833..24956c5 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -146,7 +146,6 @@ const char *vp_bus_name(struct virtio_device *vdev);
  * - ignore the affinity request if we're using INTX
  */
 int vp_set_vq_affinity(struct virtqueue *vq, int cpu);
-void virtio_pci_release_dev(struct device *);
 
 int virtio_pci_legacy_probe(struct pci_dev *pci_dev,
 			    const struct pci_device_id *id);
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index cb08a68..557cbcb 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -422,15 +422,6 @@ int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
 	return 0;
 }
 
-void virtio_pci_release_dev(struct device *_d)
-{
-	/*
-	 * No need for a release method as we allocate/free
-	 * all devices together with the pci devices.
-	 * Provide an empty one to avoid getting a warning from core.
-	 */
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int virtio_pci_freeze(struct device *dev)
 {
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 6c76f0f..08d1915 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -211,6 +211,15 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.set_vq_affinity = vp_set_vq_affinity,
 };
 
+static void virtio_pci_release_dev(struct device *_d)
+{
+	/*
+	 * No need for a release method as we allocate/free
+	 * all devices together with the pci devices.
+	 * Provide an empty one to avoid getting a warning from core.
+	 */
+}
+
 /* the PCI probing function */
 int virtio_pci_legacy_probe(struct pci_dev *pci_dev,
 			    const struct pci_device_id *id)
-- 
MST
