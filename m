From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 12/22] virtio: Add ops to allocate and free buffer
Date: Thu, 2 Jul 2020 13:51:33 +0530
Message-ID: <20200702082143.25259-13-kishon@ti.com>
References: <20200702082143.25259-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200702082143.25259-1-kishon@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add ops to allocate and free buffer in struct virtio_config_ops.
Certain vhost devices can have restriction on the range of memory
it can access on the virtio. The virtio drivers attached to
such vhost devices reserves memory that can be accessed by
vhost. This function allocates buffer for such reserved region.

For instance when virtio-vhost is used by two hosts connected to
NTB, the vhost can access only memory exposed by memory windows
and the size of the memory window can be limited. Here the NTB
virtio driver can reserve a small region (few MBs) and provide
buffer address from this pool whenever requested by virtio client
driver.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/virtio_config.h | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bb4cc4910750..419f733017c2 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -65,6 +65,9 @@ struct irq_affinity;
  *      the caller can then copy.
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
+ * @alloc_buffer: Allocate and provide buffer addresses that can be
+ *      accessed by both virtio and vhost
+ * @free_buffer: Free the allocated buffer address
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -88,6 +91,9 @@ struct virtio_config_ops {
 			       const struct cpumask *cpu_mask);
 	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
 			int index);
+	void * (*alloc_buffer)(struct virtio_device *vdev, size_t size);
+	void (*free_buffer)(struct virtio_device *vdev, void *addr,
+			    size_t size);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
@@ -232,6 +238,42 @@ const char *virtio_bus_name(struct virtio_device *vdev)
 	return vdev->config->bus_name(vdev);
 }
 
+/**
+ * virtio_alloc_buffer - Allocate buffer from the reserved memory
+ * @vdev: Virtio device which manages the reserved memory
+ * @size: Size of the buffer to be allocated
+ *
+ * Certain vhost devices can have restriction on the range of memory
+ * it can access on the virtio. The virtio drivers attached to
+ * such vhost devices reserves memory that can be accessed by
+ * vhost. This function allocates buffer for such reserved region.
+ */
+static inline void *
+virtio_alloc_buffer(struct virtio_device *vdev, size_t size)
+{
+	if (!vdev->config->alloc_buffer)
+		return NULL;
+
+	return vdev->config->alloc_buffer(vdev, size);
+}
+
+/**
+ * virtio_free_buffer - Free the allocated buffer
+ * @vdev: Virtio device which manages the reserved memory
+ * @addr: Address returned by virtio_alloc_buffer()
+ * @size: Size of the buffer that has to be freed
+ *
+ * Free the allocated buffer address given by virtio_alloc_buffer().
+ */
+static inline void
+virtio_free_buffer(struct virtio_device *vdev, void *addr, size_t size)
+{
+	if (!vdev->config->free_buffer)
+		return;
+
+	return vdev->config->free_buffer(vdev, addr, size);
+}
+
 /**
  * virtqueue_set_affinity - setting affinity for a virtqueue
  * @vq: the virtqueue
-- 
2.17.1
