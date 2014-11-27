From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v6 01/46] virtio: add low-level APIs for feature bits
Date: Thu, 27 Nov 2014 22:07:36 +0200
Message-ID: <1417118789-18231-2-git-send-email-mst@redhat.com>
References: <1417118789-18231-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417118789-18231-1-git-send-email-mst@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, rusty@au1.ibm.com, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Add low level APIs to test/set/clear feature bits.
For use by transports, to make it easier to
write code independent of feature bit array format.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h | 53 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 7f4ef66..249fcd6 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -77,11 +77,47 @@ void virtio_check_driver_offered_feature(const struct virtio_device *vdev,
 					 unsigned int fbit);
 
 /**
- * virtio_has_feature - helper to determine if this device has this feature.
+ * __virtio_test_bit - helper to test feature bits. For use by transports.
+ *                     Devices should normally use virtio_has_feature,
+ *                     which includes more checks.
  * @vdev: the device
  * @fbit: the feature bit
  */
-static inline bool virtio_has_feature(const struct virtio_device *vdev,
+static inline bool __virtio_test_bit(const struct virtio_device *vdev,
+				     unsigned int fbit)
+{
+	/* Did you forget to fix assumptions on max features? */
+	if (__builtin_constant_p(fbit))
+		BUILD_BUG_ON(fbit >= 32);
+	else
+		BUG_ON(fbit >= 32);
+
+	return test_bit(fbit, vdev->features);
+}
+
+/**
+ * __virtio_set_bit - helper to set feature bits. For use by transports.
+ * @vdev: the device
+ * @fbit: the feature bit
+ */
+static inline void __virtio_set_bit(struct virtio_device *vdev,
+				    unsigned int fbit)
+{
+	/* Did you forget to fix assumptions on max features? */
+	if (__builtin_constant_p(fbit))
+		BUILD_BUG_ON(fbit >= 32);
+	else
+		BUG_ON(fbit >= 32);
+
+	set_bit(fbit, vdev->features);
+}
+
+/**
+ * __virtio_clear_bit - helper to set feature bits. For use by transports.
+ * @vdev: the device
+ * @fbit: the feature bit
+ */
+static inline void __virtio_clear_bit(struct virtio_device *vdev,
 				      unsigned int fbit)
 {
 	/* Did you forget to fix assumptions on max features? */
@@ -90,10 +126,21 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 	else
 		BUG_ON(fbit >= 32);
 
+	clear_bit(fbit, vdev->features);
+}
+
+/**
+ * virtio_has_feature - helper to determine if this device has this feature.
+ * @vdev: the device
+ * @fbit: the feature bit
+ */
+static inline bool virtio_has_feature(const struct virtio_device *vdev,
+				      unsigned int fbit)
+{
 	if (fbit < VIRTIO_TRANSPORT_F_START)
 		virtio_check_driver_offered_feature(vdev, fbit);
 
-	return test_bit(fbit, vdev->features);
+	return __virtio_test_bit(vdev, fbit);
 }
 
 static inline
-- 
MST
