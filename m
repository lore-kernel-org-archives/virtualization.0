From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/8] virtio: add request_vqs/free_vqs operations
Date: Mon, 27 Apr 2009 15:31:53 +0300
Message-ID: <20090427123153.GA1156__14056.5775255256$1240855719$gmane$org@redhat.com>
References: <cover.1240832196.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1240832196.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

This adds 2 new optional virtio operations: request_vqs/free_vqs. They will be
used for MSI support, because MSI needs to know the total number of vectors
upfront.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/virtio_config.h |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bf8ec28..e935670 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -49,6 +49,15 @@
  * @set_status: write the status byte
  *	vdev: the virtio_device
  *	status: the new status byte
+ * @request_vqs: request the specified number of virtqueues
+ *	vdev: the virtio_device
+ *	max_vqs: the max number of virtqueues we want
+ *      If supplied, must call before any virtqueues are instantiated.
+ *      To modify the max number of virtqueues after request_vqs has been
+ *      called, call free_vqs and then request_vqs with a new value.
+ * @free_vqs: cleanup resources allocated by request_vqs
+ *	vdev: the virtio_device
+ *      If supplied, must call after all virtqueues have been deleted.
  * @reset: reset the device
  *	vdev: the virtio device
  *	After this, status and feature negotiation must be done again
@@ -75,6 +84,8 @@ struct virtio_config_ops
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
+	int (*request_vqs)(struct virtio_device *vdev, unsigned max_vqs);
+	void (*free_vqs)(struct virtio_device *vdev);
 	struct virtqueue *(*find_vq)(struct virtio_device *vdev,
 				     unsigned index,
 				     void (*callback)(struct virtqueue *));
@@ -126,5 +137,29 @@ static inline int virtio_config_buf(struct virtio_device *vdev,
 	vdev->config->get(vdev, offset, buf, len);
 	return 0;
 }
+
+/**
+ * virtio_request_vqs: request the specified number of virtqueues
+ * @vdev: the virtio_device
+ * @max_vqs: the max number of virtqueues we want
+ *
+ * For details, see documentation for request_vqs above. */
+static inline int virtio_request_vqs(struct virtio_device *vdev,
+				     unsigned max_vqs)
+{
+	return vdev->config->request_vqs ?
+		vdev->config->request_vqs(vdev, max_vqs) : 0;
+}
+
+/**
+ * free_vqs: cleanup resources allocated by virtio_request_vqs
+ * @vdev: the virtio_device
+ *
+ * For details, see documentation for free_vqs above. */
+static inline void virtio_free_vqs(struct virtio_device *vdev)
+{
+	if (vdev->config->free_vqs)
+		vdev->config->free_vqs(vdev);
+}
 #endif /* __KERNEL__ */
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
1.6.0.6
