From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/6] tools/virtio: more stubs
Date: Mon, 15 Dec 2014 00:04:17 +0200
Message-ID: <1418594542-22623-2-git-send-email-mst@redhat.com>
References: <1418594542-22623-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418594542-22623-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

As usual, add more stubs to fix test build after main
codebase changes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/virtio.h            |  1 +
 tools/virtio/linux/virtio_byteorder.h  |  8 ++++++++
 tools/virtio/linux/virtio_config.h     | 25 +++++++++++++++++++++++--
 tools/virtio/uapi/linux/virtio_types.h |  1 +
 4 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 tools/virtio/linux/virtio_byteorder.h
 create mode 100644 tools/virtio/uapi/linux/virtio_types.h

diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 8eb6421..a3e0701 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -6,6 +6,7 @@
 /* TODO: empty stubs for now. Broken but enough for virtio_ring.c */
 #define list_add_tail(a, b) do {} while (0)
 #define list_del(a) do {} while (0)
+#define list_for_each_entry(a, b, c) while (0)
 /* end of stubs */
 
 struct virtio_device {
diff --git a/tools/virtio/linux/virtio_byteorder.h b/tools/virtio/linux/virtio_byteorder.h
new file mode 100644
index 0000000..9de9e6a
--- /dev/null
+++ b/tools/virtio/linux/virtio_byteorder.h
@@ -0,0 +1,8 @@
+#ifndef _LINUX_VIRTIO_BYTEORDER_STUB_H
+#define _LINUX_VIRTIO_BYTEORDER_STUB_H
+
+#include <asm/byteorder.h>
+#include "../../include/linux/byteorder/generic.h"
+#include "../../include/linux/virtio_byteorder.h"
+
+#endif
diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virtio_config.h
index dafe1c9..806d683 100644
--- a/tools/virtio/linux/virtio_config.h
+++ b/tools/virtio/linux/virtio_config.h
@@ -1,8 +1,7 @@
 #include <linux/virtio_byteorder.h>
 #include <linux/virtio.h>
+#include <uapi/linux/virtio_config.h>
 
-#define VIRTIO_TRANSPORT_F_START	28
-#define VIRTIO_TRANSPORT_F_END		32
 /*
  * __virtio_test_bit - helper to test feature bits. For use by transports.
  *                     Devices should normally use virtio_has_feature,
@@ -16,6 +15,28 @@ static inline bool __virtio_test_bit(const struct virtio_device *vdev,
 	return vdev->features & (1ULL << fbit);
 }
 
+/**
+ * __virtio_set_bit - helper to set feature bits. For use by transports.
+ * @vdev: the device
+ * @fbit: the feature bit
+ */
+static inline void __virtio_set_bit(struct virtio_device *vdev,
+				    unsigned int fbit)
+{
+	vdev->features |= (1ULL << fbit);
+}
+
+/**
+ * __virtio_clear_bit - helper to clear feature bits. For use by transports.
+ * @vdev: the device
+ * @fbit: the feature bit
+ */
+static inline void __virtio_clear_bit(struct virtio_device *vdev,
+				      unsigned int fbit)
+{
+	vdev->features &= ~(1ULL << fbit);
+}
+
 #define virtio_has_feature(dev, feature) \
 	(__virtio_test_bit((dev), feature))
 
diff --git a/tools/virtio/uapi/linux/virtio_types.h b/tools/virtio/uapi/linux/virtio_types.h
new file mode 100644
index 0000000..e7a1096
--- /dev/null
+++ b/tools/virtio/uapi/linux/virtio_types.h
@@ -0,0 +1 @@
+#include "../../include/uapi/linux/virtio_types.h"
-- 
MST
