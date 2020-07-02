From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 03/22] vhost: Add ops for the VHOST driver to configure VHOST device
Date: Thu, 2 Jul 2020 13:51:24 +0530
Message-ID: <20200702082143.25259-4-kishon@ti.com>
References: <20200702082143.25259-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200702082143.25259-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Add "vhost_config_ops" in *struct vhost_driver* for the VHOST driver to
configure VHOST device and add facility for VHOST device to notify
VHOST driver (whenever VIRTIO sets a new status or finalize features).
This is in preparation to use the same vhost_driver across different
VHOST devices (like PCIe or NTB or platform device).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/vhost/vhost.c | 185 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/vhost.h |  57 +++++++++++++
 2 files changed, 242 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index fa2bc6e68be2..f959abb0b1bb 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2558,6 +2558,190 @@ struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 }
 EXPORT_SYMBOL_GPL(vhost_dequeue_msg);
 
+/**
+ * vhost_create_vqs() - Invoke vhost_config_ops to create virtqueue
+ * @vdev: Vhost device that provides create_vqs() callback to create virtqueue
+ * @nvqs: Number of vhost virtqueues to be created
+ * @num_bufs: The number of buffers that should be supported by the vhost
+ *   virtqueue (number of descriptors in the vhost virtqueue)
+ * @vqs: Pointers to all the created vhost virtqueues
+ * @callback: Callback function associated with the virtqueue
+ * @names: Names associated with each virtqueue
+ *
+ * Wrapper that invokes vhost_config_ops to create virtqueue.
+ */
+int vhost_create_vqs(struct vhost_dev *vdev, unsigned int nvqs,
+		     unsigned int num_bufs, struct vhost_virtqueue *vqs[],
+		     vhost_vq_callback_t *callbacks[],
+		     const char * const names[])
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(vdev))
+		return -EINVAL;
+
+	if (!vdev->ops && !vdev->ops->create_vqs)
+		return -EINVAL;
+
+	mutex_lock(&vdev->mutex);
+	ret = vdev->ops->create_vqs(vdev, nvqs, num_bufs, vqs, callbacks,
+				    names);
+	mutex_unlock(&vdev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vhost_create_vqs);
+
+/* vhost_del_vqs - Invoke vhost_config_ops to delete the created virtqueues
+ * @vdev: Vhost device that provides del_vqs() callback to delete virtqueue
+ *
+ * Wrapper that invokes vhost_config_ops to delete all the virtqueues
+ * associated with the vhost device.
+ */
+void vhost_del_vqs(struct vhost_dev *vdev)
+{
+	if (IS_ERR_OR_NULL(vdev))
+		return;
+
+	if (!vdev->ops && !vdev->ops->del_vqs)
+		return;
+
+	mutex_lock(&vdev->mutex);
+	vdev->ops->del_vqs(vdev);
+	mutex_unlock(&vdev->mutex);
+}
+EXPORT_SYMBOL_GPL(vhost_del_vqs);
+
+/* vhost_write - Invoke vhost_config_ops to write data to buffer provided
+ *   by remote virtio driver
+ * @vdev: Vhost device that provides write() callback to write data
+ * @dst: Buffer address in the remote device provided by the remote virtio
+ *   driver
+ * @src: Buffer address in the local device provided by the vhost client driver
+ * @len: Length of the data to be copied from @src to @dst
+ *
+ * Wrapper that invokes vhost_config_ops to write data to buffer provided by
+ * remote virtio driver from buffer provided by vhost client driver.
+ */
+int vhost_write(struct vhost_dev *vdev, u64 vhost_dst, void *src, int len)
+{
+	if (IS_ERR_OR_NULL(vdev))
+		return -EINVAL;
+
+	if (!vdev->ops && !vdev->ops->write)
+		return -EINVAL;
+
+	return vdev->ops->write(vdev, vhost_dst, src, len);
+}
+EXPORT_SYMBOL_GPL(vhost_write);
+
+/* vhost_read - Invoke vhost_config_ops to read data from buffers provided by
+ *   remote virtio driver
+ * @vdev: Vhost device that provides read() callback to read data
+ * @dst: Buffer address in the local device provided by the vhost client driver
+ * @src: Buffer address in the remote device provided by the remote virtio
+ *   driver
+ * @len: Length of the data to be copied from @src to @dst
+ *
+ * Wrapper that invokes vhost_config_ops to read data from buffers provided by
+ * remote virtio driver to the address provided by vhost client driver.
+ */
+int vhost_read(struct vhost_dev *vdev, void *dst, u64 vhost_src, int len)
+{
+	if (IS_ERR_OR_NULL(vdev))
+		return -EINVAL;
+
+	if (!vdev->ops && !vdev->ops->read)
+		return -EINVAL;
+
+	return vdev->ops->read(vdev, dst, vhost_src, len);
+}
+EXPORT_SYMBOL_GPL(vhost_read);
+
+/* vhost_set_status - Invoke vhost_config_ops to set vhost device status
+ * @vdev: Vhost device that provides set_status() callback to set device status
+ * @status: Vhost device status configured by vhost client driver
+ *
+ * Wrapper that invokes vhost_config_ops to set vhost device status.
+ */
+int vhost_set_status(struct vhost_dev *vdev, u8 status)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(vdev))
+		return -EINVAL;
+
+	if (!vdev->ops && !vdev->ops->set_status)
+		return -EINVAL;
+
+	mutex_lock(&vdev->mutex);
+	ret = vdev->ops->set_status(vdev, status);
+	mutex_unlock(&vdev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vhost_set_status);
+
+/* vhost_get_status - Invoke vhost_config_ops to get vhost device status
+ * @vdev: Vhost device that provides get_status() callback to get device status
+ *
+ * Wrapper that invokes vhost_config_ops to get vhost device status.
+ */
+u8 vhost_get_status(struct vhost_dev *vdev)
+{
+	u8 status;
+
+	if (IS_ERR_OR_NULL(vdev))
+		return -EINVAL;
+
+	if (!vdev->ops && !vdev->ops->get_status)
+		return -EINVAL;
+
+	mutex_lock(&vdev->mutex);
+	status = vdev->ops->get_status(vdev);
+	mutex_unlock(&vdev->mutex);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(vhost_get_status);
+
+/* vhost_set_features - Invoke vhost_config_ops to set vhost device features
+ * @vdev: Vhost device that provides set_features() callback to set device
+ *   features
+ *
+ * Wrapper that invokes vhost_config_ops to set device features.
+ */
+int vhost_set_features(struct vhost_dev *vdev, u64 device_features)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(vdev))
+		return -EINVAL;
+
+	if (!vdev->ops && !vdev->ops->set_features)
+		return -EINVAL;
+
+	mutex_lock(&vdev->mutex);
+	ret = vdev->ops->set_features(vdev, device_features);
+	mutex_unlock(&vdev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vhost_set_features);
+
+/* vhost_register_notifier - Register notifier to receive notification from
+ *   vhost device
+ * @vdev: Vhost device from which notification has to be received.
+ * @nb: Notifier block holding the callback function
+ *
+ * Invoked by vhost client to receive notification from vhost device.
+ */
+int vhost_register_notifier(struct vhost_dev *vdev, struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&vdev->notifier, nb);
+}
+EXPORT_SYMBOL_GPL(vhost_register_notifier);
+
 static inline int vhost_id_match(const struct vhost_dev *vdev,
 				 const struct vhost_device_id *id)
 {
@@ -2669,6 +2853,7 @@ int vhost_register_device(struct vhost_dev *vdev)
 	device_initialize(dev);
 
 	dev_set_name(dev, "vhost%u", ret);
+	BLOCKING_INIT_NOTIFIER_HEAD(&vdev->notifier);
 
 	ret = device_add(dev);
 	if (ret) {
diff --git a/include/linux/vhost.h b/include/linux/vhost.h
index 16c374a8fa12..b22a19c66109 100644
--- a/include/linux/vhost.h
+++ b/include/linux/vhost.h
@@ -135,6 +135,37 @@ struct vhost_msg_node {
   struct list_head node;
 };
 
+enum vhost_notify_event {
+	NOTIFY_SET_STATUS,
+	NOTIFY_FINALIZE_FEATURES,
+	NOTIFY_RESET,
+};
+
+typedef void vhost_vq_callback_t(struct vhost_virtqueue *);
+/**
+ * struct vhost_config_ops - set of function pointers for performing vhost
+ *   device specific operation
+ * @create_vqs: ops to create vhost virtqueue
+ * @del_vqs: ops to delete vhost virtqueue
+ * @write: ops to write data to buffer provided by remote virtio driver
+ * @read: ops to read data from buffer provided by remote virtio driver
+ * @set_features: ops to set vhost device features
+ * @set_status: ops to set vhost device status
+ * @get_status: ops to get vhost device status
+ */
+struct vhost_config_ops {
+	int (*create_vqs)(struct vhost_dev *vdev, unsigned int nvqs,
+			  unsigned int num_bufs, struct vhost_virtqueue *vqs[],
+			  vhost_vq_callback_t *callbacks[],
+			  const char * const names[]);
+	void (*del_vqs)(struct vhost_dev *vdev);
+	int (*write)(struct vhost_dev *vdev, u64 vhost_dst, void *src, int len);
+	int (*read)(struct vhost_dev *vdev, void *dst, u64 vhost_src, int len);
+	int (*set_features)(struct vhost_dev *vdev, u64 device_features);
+	int (*set_status)(struct vhost_dev *vdev, u8 status);
+	u8 (*get_status)(struct vhost_dev *vdev);
+};
+
 struct vhost_driver {
 	struct device_driver driver;
 	struct vhost_device_id *id_table;
@@ -149,6 +180,8 @@ struct vhost_dev {
 	struct vhost_driver *driver;
 	struct vhost_device_id id;
 	int index;
+	const struct vhost_config_ops *ops;
+	struct blocking_notifier_head notifier;
 	struct mm_struct *mm;
 	struct mutex mutex;
 	struct vhost_virtqueue **vqs;
@@ -173,11 +206,35 @@ struct vhost_dev {
 
 #define to_vhost_dev(d) container_of((d), struct vhost_dev, dev)
 
+static inline void vhost_set_drvdata(struct vhost_dev *vdev, void *data)
+{
+	dev_set_drvdata(&vdev->dev, data);
+}
+
+static inline void *vhost_get_drvdata(struct vhost_dev *vdev)
+{
+	return dev_get_drvdata(&vdev->dev);
+}
+
 int vhost_register_driver(struct vhost_driver *driver);
 void vhost_unregister_driver(struct vhost_driver *driver);
 int vhost_register_device(struct vhost_dev *vdev);
 void vhost_unregister_device(struct vhost_dev *vdev);
 
+int vhost_create_vqs(struct vhost_dev *vdev, unsigned int nvqs,
+		     unsigned int num_bufs, struct vhost_virtqueue *vqs[],
+		     vhost_vq_callback_t *callbacks[],
+		     const char * const names[]);
+void vhost_del_vqs(struct vhost_dev *vdev);
+int vhost_write(struct vhost_dev *vdev, u64 vhost_dst, void *src, int len);
+int vhost_read(struct vhost_dev *vdev, void *dst, u64 vhost_src, int len);
+int vhost_set_features(struct vhost_dev *vdev, u64 device_features);
+u64 vhost_get_features(struct vhost_dev *vdev);
+int vhost_set_status(struct vhost_dev *vdev, u8 status);
+u8 vhost_get_status(struct vhost_dev *vdev);
+
+int vhost_register_notifier(struct vhost_dev *vdev, struct notifier_block *nb);
+
 bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts, int total_len);
 void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs,
 		    int nvqs, int iov_limit, int weight, int byte_weight,
-- 
2.17.1
