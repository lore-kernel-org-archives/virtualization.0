From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC v6 06/20] virtio: endianness checks for virtio 1.0 devices
Date: Thu, 11 Dec 2014 14:25:08 +0100
Message-ID: <1418304322-7546-7-git-send-email-cornelia.huck@de.ibm.com>
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

Add code that checks for the VERSION_1 feature bit in order to make
decisions about the device's endianness. This allows us to support
transitional devices.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/virtio/virtio.c                |    6 +++++-
 include/hw/virtio/virtio-access.h |    4 ++++
 include/hw/virtio/virtio.h        |    8 ++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 7f74ae5..8f69ffa 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -881,7 +881,11 @@ static bool virtio_device_endian_needed(void *opaque)
     VirtIODevice *vdev = opaque;
 
     assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-    return vdev->device_endian != virtio_default_endian();
+    if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        return vdev->device_endian != virtio_default_endian();
+    }
+    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+    return vdev->device_endian != VIRTIO_DEVICE_ENDIAN_LITTLE;
 }
 
 static const VMStateDescription vmstate_virtio_device_endian = {
diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 46456fd..ee28c21 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -19,6 +19,10 @@
 
 static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 {
+    if (virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+        return false;
+    }
 #if defined(TARGET_IS_BIENDIAN)
     return virtio_is_big_endian(vdev);
 #elif defined(TARGET_WORDS_BIGENDIAN)
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 08141c7..68c40db 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -297,7 +297,11 @@ static inline bool virtio_has_feature(VirtIODevice *vdev, unsigned int fbit)
 
 static inline bool virtio_is_big_endian(VirtIODevice *vdev)
 {
-    assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-    return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
+    if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
+        return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
+    }
+    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+    return false;
 }
 #endif
-- 
1.7.9.5
