From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 5/7] mdev: introduce virtio device and its device ops
Date: Fri, 11 Oct 2019 16:15:55 +0800
Message-ID: <20191011081557.28302-6-jasowang__42554.6843370952$1570782657$gmane$org@redhat.com>
References: <20191011081557.28302-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191011081557.28302-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com, alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com
Cc: christophe.de.dinechin@gmail.com, sebott@linux.ibm.com, airlied@linux.ie, joonas.lahtinen@linux.intel.com, heiko.carstens@de.ibm.com, virtualization@lists.linux-foundation.org, rob.miller@broadcom.com, lulu@redhat.com, eperezma@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, haotian.wang@sifive.com, zhi.a.wang@intel.com, farman@linux.ibm.com, idos@mellanox.com, gor@linux.ibm.com, zhenyuw@linux.intel.com, rodrigo.vivi@intel.com, xiao.w.wang@intel.com, freude@linux.ibm.com, jani.nikula@linux.intel.com, parav@mellanox.com, zhihong.wang@intel.com, akrowiak@linux.ibm.com, netdev@vger.kernel.org, cohuck@redhat.com, oberpar@linux.ibm.com, maxime.coquelin@redhat.com, daniel@ffwll.ch, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This patch implements basic support for mdev driver that supports
virtio transport for kernel virtio driver.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/mdev.h        |   1 +
 include/linux/virtio_mdev.h | 148 ++++++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 include/linux/virtio_mdev.h

diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index f491308674e5..298581e7ad45 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -124,6 +124,7 @@ struct mdev_device *mdev_from_dev(struct device *dev);
 
 enum {
 	MDEV_ID_VFIO = 1,
+	MDEV_ID_VIRTIO = 2,
 	/* New entries must be added here */
 };
 
diff --git a/include/linux/virtio_mdev.h b/include/linux/virtio_mdev.h
new file mode 100644
index 000000000000..b39c62534acc
--- /dev/null
+++ b/include/linux/virtio_mdev.h
@@ -0,0 +1,148 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Virtio mediated device driver
+ *
+ * Copyright 2019, Red Hat Corp.
+ *     Author: Jason Wang <jasowang@redhat.com>
+ */
+#ifndef _LINUX_VIRTIO_MDEV_H
+#define _LINUX_VIRTIO_MDEV_H
+
+#include <linux/interrupt.h>
+#include <linux/mdev.h>
+#include <uapi/linux/vhost.h>
+
+#define VIRTIO_MDEV_DEVICE_API_STRING		"virtio-mdev"
+#define VIRTIO_MDEV_F_VERSION_1 0x1
+
+struct virtio_mdev_callback {
+	irqreturn_t (*callback)(void *data);
+	void *private;
+};
+
+/**
+ * struct vfio_mdev_device_ops - Structure to be registered for each
+ * mdev device to register the device to virtio-mdev module.
+ *
+ * @set_vq_address:		Set the address of virtqueue
+ *				@mdev: mediated device
+ *				@idx: virtqueue index
+ *				@desc_area: address of desc area
+ *				@driver_area: address of driver area
+ *				@device_area: address of device area
+ *				Returns integer: success (0) or error (< 0)
+ * @set_vq_num:		Set the size of virtqueue
+ *				@mdev: mediated device
+ *				@idx: virtqueue index
+ *				@num: the size of virtqueue
+ * @kick_vq:			Kick the virtqueue
+ *				@mdev: mediated device
+ *				@idx: virtqueue index
+ * @set_vq_cb:			Set the interrut calback function for
+ *				a virtqueue
+ *				@mdev: mediated device
+ *				@idx: virtqueue index
+ *				@cb: virtio-mdev interrupt callback structure
+ * @set_vq_ready:		Set ready status for a virtqueue
+ *				@mdev: mediated device
+ *				@idx: virtqueue index
+ *				@ready: ready (true) not ready(false)
+ * @get_vq_ready:		Get ready status for a virtqueue
+ *				@mdev: mediated device
+ *				@idx: virtqueue index
+ *				Returns boolean: ready (true) or not (false)
+ * @set_vq_state:		Set the state for a virtqueue
+ *				@mdev: mediated device
+ *				@idx: virtqueue index
+ *				@state: virtqueue state (last_avail_idx)
+ *				Returns integer: success (0) or error (< 0)
+ * @get_vq_state:		Get the state for a virtqueue
+ *				@mdev: mediated device
+ *				@idx: virtqueue index
+ *				Returns virtqueue state (last_avail_idx)
+ * @get_vq_align:		Get the virtqueue align requirement
+ *				for the device
+ *				@mdev: mediated device
+ *				Returns virtqueue algin requirement
+ * @get_features:		Get virtio features supported by the device
+ *				@mdev: mediated device
+ *				Returns the virtio features support by the
+ *				device
+ * @get_features:		Set virtio features supported by the driver
+ *				@mdev: mediated device
+ *				@features: feature support by the driver
+ *				Returns integer: success (0) or error (< 0)
+ * @set_config_cb:		Set the config interrupt callback
+ *				@mdev: mediated device
+ *				@cb: virtio-mdev interrupt callback structure
+ * @get_vq_num_max:		Get the max size of virtqueue
+ *				@mdev: mediated device
+ *				Returns u16: max size of virtqueue
+ * @get_device_id:		Get virtio device id
+ *				@mdev: mediated device
+ *				Returns u32: virtio device id
+ * @get_vendor_id:		Get virtio vendor id
+ *				@mdev: mediated device
+ *				Returns u32: virtio vendor id
+ * @get_status: 		Get the device status
+ *				@mdev: mediated device
+ *				Returns u8: virtio device status
+ * @set_status: 		Set the device status
+ *				@mdev: mediated device
+ *				@status: virtio device status
+ * @get_config: 		Read from device specific configuration space
+ *				@mdev: mediated device
+ *				@offset: offset from the beginning of
+ *				configuration space
+ *				@buf: buffer used to read to
+ *				@len: the length to read from
+ *				configration space
+ * @set_config: 		Write to device specific configuration space
+ *				@mdev: mediated device
+ *				@offset: offset from the beginning of
+ *				configuration space
+ *				@buf: buffer used to write from
+ *				@len: the length to write to
+ *				configration space
+ * @get_mdev_features:		Get the feature of virtio mdev device
+ *				@mdev: mediated device
+ *				Returns the mdev features (API) support by
+ *				the device.
+ * @get_generation:		Get device generaton
+ *				@mdev: mediated device
+ *				Returns u32: device generation
+ */
+struct virtio_mdev_device_ops {
+	/* Virtqueue ops */
+	int (*set_vq_address)(struct mdev_device *mdev,
+			      u16 idx, u64 desc_area, u64 driver_area,
+			      u64 device_area);
+	void (*set_vq_num)(struct mdev_device *mdev, u16 idx, u32 num);
+	void (*kick_vq)(struct mdev_device *mdev, u16 idx);
+	void (*set_vq_cb)(struct mdev_device *mdev, u16 idx,
+			  struct virtio_mdev_callback *cb);
+	void (*set_vq_ready)(struct mdev_device *mdev, u16 idx, bool ready);
+	bool (*get_vq_ready)(struct mdev_device *mdev, u16 idx);
+	int (*set_vq_state)(struct mdev_device *mdev, u16 idx, u64 state);
+	u64 (*get_vq_state)(struct mdev_device *mdev, u16 idx);
+
+	/* Device ops */
+	u16 (*get_vq_align)(struct mdev_device *mdev);
+	u64 (*get_features)(struct mdev_device *mdev);
+	int (*set_features)(struct mdev_device *mdev, u64 features);
+	void (*set_config_cb)(struct mdev_device *mdev,
+			      struct virtio_mdev_callback *cb);
+	u16 (*get_vq_num_max)(struct mdev_device *mdev);
+	u32 (*get_device_id)(struct mdev_device *mdev);
+	u32 (*get_vendor_id)(struct mdev_device *mdev);
+	u8 (*get_status)(struct mdev_device *mdev);
+	void (*set_status)(struct mdev_device *mdev, u8 status);
+	void (*get_config)(struct mdev_device *mdev, unsigned int offset,
+			   void *buf, unsigned int len);
+	void (*set_config)(struct mdev_device *mdev, unsigned int offset,
+			   const void *buf, unsigned int len);
+	u64 (*get_mdev_features)(struct mdev_device *mdev);
+	u32 (*get_generation)(struct mdev_device *mdev);
+};
+
+#endif
-- 
2.19.1
