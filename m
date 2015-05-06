From: Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH RFC 3/7] virtio: introduce virtio_legacy_is_cross_endian()
Date: Wed, 06 May 2015 14:07:53 +0200
Message-ID: <20150506120753.8607.17240.stgit@bahia.huguette.org>
References: <20150506120729.8607.23404.stgit@bahia.huguette.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150506120729.8607.23404.stgit@bahia.huguette.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This helper will be used by vhost and tap to detect cross-endianness in
the legacy virtio case.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---
 include/hw/virtio/virtio-access.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 46456fd..caf0940 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -28,6 +28,19 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 #endif
 }
 
+static inline bool virtio_legacy_is_cross_endian(VirtIODevice *vdev)
+{
+#ifdef TARGET_IS_BIENDIAN
+#ifdef HOST_WORDS_BIGENDIAN
+    return !virtio_is_big_endian(vdev);
+#else
+    return virtio_is_big_endian(vdev);
+#endif
+#else
+    return false;
+#endif
+}
+
 static inline uint16_t virtio_lduw_phys(VirtIODevice *vdev, hwaddr pa)
 {
     if (virtio_access_is_big_endian(vdev)) {
