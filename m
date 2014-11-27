From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v4 02/16] virtio: cull virtio_bus_set_vdev_features
Date: Thu, 27 Nov 2014 16:16:35 +0100
Message-ID: <1417101409-29482-3-git-send-email-cornelia.huck__19529.3261007921$1417101448$gmane$org@de.ibm.com>
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

The only user of this function was virtio-ccw, and it should use
virtio_set_features() like everybody else: We need to make sure
that bad features are masked out properly, which this function did
not do.

Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/virtio-ccw.c          |    3 +--
 hw/virtio/virtio-bus.c         |   14 --------------
 include/hw/virtio/virtio-bus.h |    3 ---
 3 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index ea236c9..84f17bc 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -400,8 +400,7 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                                        ccw.cda + sizeof(features.features));
             features.features = ldl_le_phys(&address_space_memory, ccw.cda);
             if (features.index < ARRAY_SIZE(dev->host_features)) {
-                virtio_bus_set_vdev_features(&dev->bus, features.features);
-                vdev->guest_features = features.features;
+                virtio_set_features(vdev, features.features);
             } else {
                 /*
                  * If the guest supports more feature bits, assert that it
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index eb77019..a8ffa07 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -109,20 +109,6 @@ uint32_t virtio_bus_get_vdev_features(VirtioBusState *bus,
     return k->get_features(vdev, requested_features);
 }
 
-/* Set the features of the plugged device. */
-void virtio_bus_set_vdev_features(VirtioBusState *bus,
-                                      uint32_t requested_features)
-{
-    VirtIODevice *vdev = virtio_bus_get_device(bus);
-    VirtioDeviceClass *k;
-
-    assert(vdev != NULL);
-    k = VIRTIO_DEVICE_GET_CLASS(vdev);
-    if (k->set_features != NULL) {
-        k->set_features(vdev, requested_features);
-    }
-}
-
 /* Get bad features of the plugged device. */
 uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus)
 {
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 0756545..0d2e7b4 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -84,9 +84,6 @@ size_t virtio_bus_get_vdev_config_len(VirtioBusState *bus);
 /* Get the features of the plugged device. */
 uint32_t virtio_bus_get_vdev_features(VirtioBusState *bus,
                                     uint32_t requested_features);
-/* Set the features of the plugged device. */
-void virtio_bus_set_vdev_features(VirtioBusState *bus,
-                                  uint32_t requested_features);
 /* Get bad features of the plugged device. */
 uint32_t virtio_bus_get_vdev_bad_features(VirtioBusState *bus);
 /* Get config of the plugged device. */
-- 
1.7.9.5
