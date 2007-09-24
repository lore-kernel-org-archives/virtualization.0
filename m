From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/3] virtio interface
Date: Mon, 24 Sep 2007 19:14:16 +1000
Message-ID: <1190625256.27805.201.camel__45963.4646228098$1190625587$gmane$org@localhost.localdomain>
References: <1190625194.27805.199.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190625194.27805.199.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This attempts to implement a "virtual I/O" layer which should allow
common drivers to be efficiently used across most virtual I/O
mechanisms.  It will no-doubt need further enhancement.

The virtio drivers add buffers to virtio queues; as the buffers are consumed
the driver "interrupt" callbacks are invoked.

There is also a generic implementation of config space which drivers can query
to get setup information from the host.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/Kconfig                 |    2 
 drivers/Makefile                |    1 
 drivers/virtio/Kconfig          |    3 
 drivers/virtio/Makefile         |    1 
 drivers/virtio/config.c         |   13 ++
 drivers/virtio/virtio.c         |  187 +++++++++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h |    6 +
 include/linux/virtio.h          |  110 ++++++++++++++++++++++
 include/linux/virtio_config.h   |  111 +++++++++++++++++++++++
 9 files changed, 434 insertions(+)

===================================================================
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -87,4 +87,6 @@ source "drivers/kvm/Kconfig"
 source "drivers/kvm/Kconfig"
 
 source "drivers/uio/Kconfig"
+
+source "drivers/virtio/Kconfig"
 endmenu
===================================================================
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_HID)		+= hid/
 obj-$(CONFIG_HID)		+= hid/
 obj-$(CONFIG_PPC_PS3)		+= ps3/
 obj-$(CONFIG_OF)		+= of/
+obj-$(CONFIG_VIRTIO)		+= virtio/
===================================================================
--- /dev/null
+++ b/drivers/virtio/Kconfig
@@ -0,0 +1,3 @@
+# Virtio always gets selected by whoever wants it.
+config VIRTIO
+	bool
===================================================================
--- /dev/null
+++ b/drivers/virtio/Makefile
@@ -0,0 +1,1 @@
+obj-$(CONFIG_VIRTIO) += virtio.o
===================================================================
--- /dev/null
+++ b/drivers/virtio/config.c
@@ -0,0 +1,13 @@
+/* Configuration space parsing helpers for virtio.
+ *
+ * The configuration is [type][len][... len bytes ...] fields.
+ *
+ * Copyright 2007 Rusty Russell, IBM Corporation.
+ * GPL v2 or later.
+ */
+#include <linux/err.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/bug.h>
+#include <asm/system.h>
+
===================================================================
--- /dev/null
+++ b/drivers/virtio/virtio.c
@@ -0,0 +1,187 @@
+#include <linux/virtio.h>
+#include <linux/spinlock.h>
+#include <linux/virtio_config.h>
+
+static ssize_t device_show(struct device *_d,
+			   struct device_attribute *attr, char *buf)
+{
+	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+	return sprintf(buf, "%hu", dev->id.device);
+}
+static ssize_t vendor_show(struct device *_d,
+			   struct device_attribute *attr, char *buf)
+{
+	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+	return sprintf(buf, "%hu", dev->id.vendor);
+}
+static ssize_t status_show(struct device *_d,
+			   struct device_attribute *attr, char *buf)
+{
+	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+	return sprintf(buf, "0x%08x", dev->config->get_status(dev));
+}
+static struct device_attribute virtio_dev_attrs[] = {
+	__ATTR_RO(device),
+	__ATTR_RO(vendor),
+	__ATTR_RO(status),
+	__ATTR_NULL
+};
+
+static inline int virtio_id_match(const struct virtio_device *dev,
+				  const struct virtio_device_id *id)
+{
+	if (id->device != dev->id.device)
+		return 0;
+
+	return id->vendor == VIRTIO_DEV_ANY_ID || id->vendor != dev->id.vendor;
+}
+
+/* This looks through all the IDs a driver claims to support.  If any of them
+ * match, we return 1 and the kernel will call virtio_dev_probe(). */
+static int virtio_dev_match(struct device *_dv, struct device_driver *_dr)
+{
+	unsigned int i;
+	struct virtio_device *dev = container_of(_dv,struct virtio_device,dev);
+	const struct virtio_device_id *ids;
+
+	ids = container_of(_dr, struct virtio_driver, driver)->id_table;
+	for (i = 0; ids[i].device; i++)
+		if (virtio_id_match(dev, &ids[i]))
+			return 1;
+	return 0;
+}
+
+struct virtio_bus {
+	struct bus_type bus;
+	struct device dev;
+};
+
+static struct virtio_bus virtio_bus = {
+	.bus = {
+		.name  = "virtio",
+		.match = virtio_dev_match,
+		.dev_attrs = virtio_dev_attrs,
+	},
+	.dev = {
+		/* Can override this if you have a real bus behind it. */
+		.parent = NULL,
+		.bus_id = "virtio",
+	}
+};
+
+static void add_status(struct virtio_device *dev, unsigned status)
+{
+	dev->config->set_status(dev, dev->config->get_status(dev) | status);
+}
+
+static int virtio_dev_probe(struct device *_d)
+{
+	int err;
+	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
+	struct virtio_driver *drv = container_of(dev->dev.driver,
+						 struct virtio_driver, driver);
+
+	add_status(dev, VIRTIO_CONFIG_S_DRIVER);
+	err = drv->probe(dev);
+	if (err)
+		add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	else
+		add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
+	return err;
+}
+
+int register_virtio_driver(struct virtio_driver *driver)
+{
+	driver->driver.bus = &virtio_bus.bus;
+	driver->driver.probe = virtio_dev_probe;
+	return driver_register(&driver->driver);
+}
+EXPORT_SYMBOL_GPL(register_virtio_driver);
+
+void unregister_virtio_driver(struct virtio_driver *driver)
+{
+	driver_unregister(&driver->driver);
+}
+EXPORT_SYMBOL_GPL(unregister_virtio_driver);
+
+int register_virtio_device(struct virtio_device *dev)
+{
+	int err;
+
+	/* If the device hasn't already been given a parent, our bus is it. */
+	if (!dev->dev.parent)
+		dev->dev.parent = &virtio_bus.dev;
+	dev->dev.bus = &virtio_bus.bus;
+	sprintf(dev->dev.bus_id, "%u", dev->index);
+
+	/* Acknowledge that we've seen the device. */
+	add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
+
+	/* device_register() causes the bus infrastructure to look for a
+	 * matching driver. */
+	err = device_register(&dev->dev);
+	if (err)
+		add_status(dev, VIRTIO_CONFIG_S_FAILED);
+	return err;
+}
+EXPORT_SYMBOL_GPL(register_virtio_device);
+
+void unregister_virtio_device(struct virtio_device *dev)
+{
+	device_unregister(&dev->dev);
+}
+EXPORT_SYMBOL_GPL(unregister_virtio_device);
+
+int __virtio_config_val(struct virtio_device *vdev,
+			u8 type, void *val, size_t size)
+{
+	void *token;
+	unsigned int len;
+
+	token = vdev->config->find(vdev, type, &len);
+	if (!token)
+		return -ENOENT;
+
+	if (len != size)
+		return -EIO;
+
+	vdev->config->get(vdev, token, val, size);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(__virtio_config_val);
+
+int virtio_use_bit(struct virtio_device *vdev,
+		   void *token, unsigned int len, unsigned int bitnum)
+{
+	unsigned long bits[16];
+
+	/* This makes it convenient to pass-through find() results. */
+	if (!token)
+		return 0;
+
+	/* bit not in range of this bitfield? */
+	if (bitnum * 8 >= len / 2)
+		return 0;
+
+	/* Giant feature bitfields are silly. */
+	BUG_ON(len > sizeof(bits));
+	vdev->config->get(vdev, token, bits, len);
+
+	if (!test_bit(bitnum, bits))
+		return 0;
+
+	/* Set acknowledge bit, and write it back. */
+	set_bit(bitnum + len * 8 / 2, bits);
+	vdev->config->set(vdev, token, bits, len);
+	return 1;
+}
+EXPORT_SYMBOL_GPL(virtio_use_bit);
+
+static int virtio_init(void)
+{
+	if (bus_register(&virtio_bus.bus) != 0
+	    || device_register(&virtio_bus.dev) != 0)
+		panic("virtio bus registration failed");
+	return 0;
+}
+core_initcall(virtio_init);
===================================================================
--- a/include/linux/mod_devicetable.h
+++ b/include/linux/mod_devicetable.h
@@ -340,4 +340,10 @@ struct parisc_device_id {
 #define PA_HVERSION_ANY_ID	0xffff
 #define PA_SVERSION_ANY_ID	0xffffffff
 
+struct virtio_device_id {
+	__u32 device;
+	__u32 vendor;
+};
+#define VIRTIO_DEV_ANY_ID	0xffffffff
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
===================================================================
--- /dev/null
+++ b/include/linux/virtio.h
@@ -0,0 +1,110 @@
+#ifndef _LINUX_VIRTIO_H
+#define _LINUX_VIRTIO_H
+/* Everything a virtio driver needs to work with any particular virtio
+ * implementation. */
+#include <linux/types.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+
+/**
+ * virtqueue - a queue to register buffers for sending or receiving.
+ * @callback: the function to call when buffers are consumed (can be NULL).
+ *    If this returns false, callbacks are suppressed until vq_ops->restart
+ *    is called.
+ * @vdev: the virtio device this queue was created for.
+ * @vq_ops: the operations for this virtqueue (see below).
+ * @priv: a pointer for the virtqueue implementation to use.
+ */
+struct virtqueue
+{
+	bool (*callback)(struct virtqueue *vq);
+	struct virtio_device *vdev;
+	struct virtqueue_ops *vq_ops;
+	void *priv;
+};
+
+/**
+ * virtqueue_ops - operations for virtqueue abstraction layer
+ * @add_buf: expose buffer to other end
+ *	vq: the struct virtqueue we're talking about.
+ *	sg: the description of the buffer(s).
+ *	out_num: the number of sg readable by other side
+ *	in_num: the number of sg which are writable (after readable ones)
+ *	data: the token identifying the buffer.
+ *      Returns 0 or an error.
+ * @kick: update after add_buf
+ *	vq: the struct virtqueue
+ *	After one or more add_buf calls, invoke this to kick the other side.
+ * @get_buf: get the next used buffer
+ *	vq: the struct virtqueue we're talking about.
+ *	len: the length written into the buffer
+ *	Returns NULL or the "data" token handed to add_buf.
+ * @restart: restart callbacks ater callback returned false.
+ *	vq: the struct virtqueue we're talking about.
+ *	This returns "false" (and doesn't re-enable) if there are pending
+ *	buffers in the queue, to avoid a race.
+ * @shutdown: "unadd" all buffers.
+ *	vq: the struct virtqueue we're talking about.
+ *	Remove everything from the queue.
+ *
+ * Locking rules are straightforward: the driver is responsible for
+ * locking.  No two operations may be invoked simultaneously.
+ *
+ * All operations can be called in any context.
+ */
+struct virtqueue_ops {
+	int (*add_buf)(struct virtqueue *vq,
+		       struct scatterlist sg[],
+		       unsigned int out_num,
+		       unsigned int in_num,
+		       void *data);
+
+	void (*kick)(struct virtqueue *vq);
+
+	void *(*get_buf)(struct virtqueue *vq, unsigned int *len);
+
+	bool (*restart)(struct virtqueue *vq);
+
+	void (*shutdown)(struct virtqueue *vq);
+};
+
+/**
+ * virtio_device - representation of a device using virtio
+ * @index: unique position on the virtio bus
+ * @dev: underlying device.
+ * @id: the device type identification (used to match it with a driver).
+ * @config: the configuration ops for this device.
+ * @priv: private pointer for the driver's use.
+ */
+struct virtio_device
+{
+	int index;
+	struct device dev;
+	struct virtio_device_id id;
+	struct virtio_config_ops *config;
+	void *priv;
+};
+
+int register_virtio_device(struct virtio_device *dev);
+void unregister_virtio_device(struct virtio_device *dev);
+
+/**
+ * virtio_driver - operations for a virtio I/O driver
+ * @driver: underlying device driver (populate name and owner).
+ * @id_table: the ids serviced by this driver.
+ * @probe: the function to call when a device is found.  Returns a token for
+ *    remove, or PTR_ERR().
+ * @remove: the function when a device is removed.
+ */
+struct virtio_driver {
+	struct device_driver driver;
+	const struct virtio_device_id *id_table;
+	int (*probe)(struct virtio_device *dev);
+	void (*remove)(struct virtio_device *dev);
+};
+
+int register_virtio_driver(struct virtio_driver *drv);
+void unregister_virtio_driver(struct virtio_driver *drv);
+#endif /* _LINUX_VIRTIO_H */
===================================================================
--- /dev/null
+++ b/include/linux/virtio_config.h
@@ -0,0 +1,111 @@
+#ifndef _LINUX_VIRTIO_CONFIG_H
+#define _LINUX_VIRTIO_CONFIG_H
+/* Virtio devices use a standardized configuration space to define their
+ * features and pass configuration information, but each implementation can
+ * store and access that space differently. */
+#include <linux/types.h>
+
+/* Status byte for guest to report progress, and synchronize config. */
+/* We have seen device and processed generic fields (VIRTIO_CONFIG_F_VIRTIO) */
+#define VIRTIO_CONFIG_S_ACKNOWLEDGE	1
+/* We have found a driver for the device. */
+#define VIRTIO_CONFIG_S_DRIVER		2
+/* Driver has used its parts of the config, and is happy */
+#define VIRTIO_CONFIG_S_DRIVER_OK	4
+/* We've given up on this device. */
+#define VIRTIO_CONFIG_S_FAILED		0x80
+
+/* Feature byte (actually 7 bits availabe): */
+/* Requirements/features of the virtio implementation. */
+#define VIRTIO_CONFIG_F_VIRTIO 1
+/* Requirements/features of the virtqueue (may have more than one). */
+#define VIRTIO_CONFIG_F_VIRTQUEUE 2
+
+#ifdef __KERNEL__
+struct virtio_device;
+
+/**
+ * virtio_config_ops - operations for configuring a virtio device
+ * @find: search for the next configuration field of the given type.
+ *	vdev: the virtio_device
+ *	type: the feature type
+ *	len: the (returned) length of the field if found.
+ *	Returns a token if found, or NULL.  Never returnes the same field twice
+ *	(ie. it's used up).
+ * @get: read the value of a configuration field after find().
+ *	vdev: the virtio_device
+ *	token: the token returned from find().
+ *	buf: the buffer to write the field value into.
+ *	len: the length of the buffer (given by find()).
+ *	Note that contents are conventionally little-endian.
+ * @set: write the value of a configuration field after find().
+ *	vdev: the virtio_device
+ *	token: the token returned from find().
+ *	buf: the buffer to read the field value from.
+ *	len: the length of the buffer (given by find()).
+ *	Note that contents are conventionally little-endian.
+ * @get_status: read the status byte
+ *	vdev: the virtio_device
+ *	Returns the status byte
+ * @set_status: write the status byte
+ *	vdev: the virtio_device
+ *	status: the new status byte
+ * @find_vq: find the first VIRTIO_CONFIG_F_VIRTQUEUE and create a virtqueue.
+ *	vdev: the virtio_device
+ *	callback: the virqtueue callback
+ *	Returns the new virtqueue or ERR_PTR().
+ * @del_vq: free a virtqueue found by find_vq().
+ */
+struct virtio_config_ops
+{
+	void *(*find)(struct virtio_device *vdev, u8 type, unsigned *len);
+	void (*get)(struct virtio_device *vdev, void *token,
+		    void *buf, unsigned len);
+	void (*set)(struct virtio_device *vdev, void *token,
+		    const void *buf, unsigned len);
+	u8 (*get_status)(struct virtio_device *vdev);
+	void (*set_status)(struct virtio_device *vdev, u8 status);
+	struct virtqueue *(*find_vq)(struct virtio_device *vdev,
+				     bool (*callback)(struct virtqueue *));
+	void (*del_vq)(struct virtqueue *vq);
+};
+
+/**
+ * virtio_config_val - get a single virtio config and mark it used.
+ * @config: the virtio config space
+ * @type: the type to search for.
+ * @val: a pointer to the value to fill in.
+ *
+ * Once used, the config type is marked with VIRTIO_CONFIG_F_USED so it can't
+ * be found again.  This version does endian conversion. */
+#define virtio_config_val(vdev, type, v) ({				\
+	int _err = __virtio_config_val((vdev),(type),(v),sizeof(*(v))); \
+									\
+	BUILD_BUG_ON(sizeof(*(v)) != 1 && sizeof(*(v)) != 2		\
+		     && sizeof(*(v)) != 4 && sizeof(*(v)) != 8);	\
+	if (!_err) {							\
+		switch (sizeof(*(v))) {					\
+		case 2: le16_to_cpus(v); break;				\
+		case 4: le32_to_cpus(v); break;				\
+		case 8: le64_to_cpus(v); break;				\
+		}							\
+	}								\
+	_err;								\
+})
+
+int __virtio_config_val(struct virtio_device *dev,
+			u8 type, void *val, size_t size);
+
+/**
+ * virtio_use_bit - helper to use a feature bit in a bitfield value.
+ * @dev: the virtio device
+ * @token: the token as returned from vdev->config->find().
+ * @len: the length of the field.
+ * @bitnum: the bit to test.
+ *
+ * If handed a NULL token, it returns false, otherwise returns bit status.
+ * If it's one, it sets the mirroring acknowledgement bit. */
+int virtio_use_bit(struct virtio_device *vdev,
+		   void *token, unsigned int len, unsigned int bitnum);
+#endif /* __KERNEL__ */
+#endif /* _LINUX_VIRTIO_CONFIG_H */
