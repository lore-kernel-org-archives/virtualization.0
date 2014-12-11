From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 12/20] virtio: disallow late feature changes for
	virtio-1
Date: Thu, 11 Dec 2014 14:25:14 +0100
Message-ID: <1418304322-7546-13-git-send-email-cornelia.huck@de.ibm.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: thuth@linux.vnet.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

For virtio-1 devices, the driver must not attempt to set feature bits
after it set FEATURES_OK in the device status. Simply reject it in
that case.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/virtio/virtio.c         |   16 ++++++++++++++--
 include/hw/virtio/virtio.h |    2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 57190ba..a3dd67b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -978,7 +978,7 @@ void virtio_save(VirtIODevice *vdev, QEMUFile *f)
     vmstate_save_state(f, &vmstate_virtio, vdev);
 }
 
-int virtio_set_features(VirtIODevice *vdev, uint64_t val)
+static int __virtio_set_features(VirtIODevice *vdev, uint64_t val)
 {
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *vbusk = VIRTIO_BUS_GET_CLASS(qbus);
@@ -994,6 +994,18 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
     return bad ? -1 : 0;
 }
 
+int virtio_set_features(VirtIODevice *vdev, uint64_t val)
+{
+   /*
+     * The driver must not attempt to set features after feature negotiation
+     * has finished.
+     */
+    if (vdev->status & VIRTIO_CONFIG_S_FEATURES_OK) {
+        return -EINVAL;
+    }
+    return __virtio_set_features(vdev, val);
+}
+
 int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
 {
     int i, ret;
@@ -1026,7 +1038,7 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     qemu_get_be32s(f, &features);
 
     /* XXX features >= 32 */
-    if (virtio_set_features(vdev, features) < 0) {
+    if (__virtio_set_features(vdev, features) < 0) {
         supported_features = k->get_features(qbus->parent);
         error_report("Features 0x%x unsupported. Allowed features: 0x%lx",
                      features, supported_features);
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b63ced3..a24e403 100644
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
