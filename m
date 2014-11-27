From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v4 11/16] virtio: disallow late feature changes for
	virtio-1
Date: Thu, 27 Nov 2014 16:16:44 +0100
Message-ID: <1417101409-29482-12-git-send-email-cornelia.huck__12365.7132535756$1417101542$gmane$org@de.ibm.com>
References: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1417101409-29482-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

For virtio-1 devices, the driver must not attempt to set feature bits
after it set FEATURES_OK in the device status. Simply reject it in
that case.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/virtio/virtio.c         |   17 +++++++++++++++--
 include/hw/virtio/virtio.h |    2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2c6bb91..8cdc0cb 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -982,7 +982,8 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     vmstate_save_state(f, &vmstate_virtio, vdev);
 }
 
-int virtio_set_features(VirtIODevice *vdev, unsigned int index, uint32_t val)
+static int __virtio_set_features(VirtIODevice *vdev, unsigned int index,
+                                 uint32_t val)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *vbusk = VIRTIO_BUS_GET_CLASS(qbus);
@@ -998,6 +999,18 @@ int virtio_set_features(VirtIODevice *vdev, unsigned int index, uint32_t val)
     return bad ? -1 : 0;
 }
 
+int virtio_set_features(VirtIODevice *vdev, unsigned int index, uint32_t val)
+{
+   /*
+     * The driver must not attempt to set features after feature negotiation
+     * has finished.
+     */
+    if (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) {
+        return -EINVAL;
+    }
+    return __virtio_set_features(vdev, index, val);
+}
+
 int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 {
     int i, ret;
@@ -1030,7 +1043,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     qemu_get_be32s(f, &features);
 
     /* XXX features >= 32 */
-    if (virtio_set_features(vdev, 0, features) < 0) {
+    if (__virtio_set_features(vdev, 0, features) < 0) {
         supported_features = k->get_features(qbus->parent, 0);
         error_report("Features 0x%x unsupported. Allowed features: 0x%x",
                      features, supported_features);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index f840320..ec1be3b 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -32,6 +32,8 @@
 #define VIRTIO_CONFIG_S_DRIVER          2
 /* Driver has used its parts of the config, and is happy */
 #define VIRTIO_CONFIG_S_DRIVER_OK       4
+/* Driver has finished configuring features */
+#define VIRTIO_CONFIG_S_FEATURES_OK     8
 /* We've given up on this device. */
 #define VIRTIO_CONFIG_S_FAILED          0x80
 
-- 
1.7.9.5
