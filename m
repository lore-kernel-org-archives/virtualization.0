From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/6] virtio_config
Date: Thu, 20 Sep 2007 22:12:49 +1000
Message-ID: <1190290369.7262.231.camel__31216.9291814373$1190290519$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190290140.7262.228.camel@localhost.localdomain>
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
Cc: lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Previous versions of virtio didn't commonalize probing.  For every
driver, every virtio implementation (KVM, lguest, etc) needed an
in-kernel stub to join their bus to the probe code.

To solve this, we introduce a "virtio_config" mechanism, which is
simply a set of [u8 type][u8 len][...data...] fields for each device.
Some convenient wrapper functions make this fairly easy for drivers to
unpack their configuration data themselves.

This configuration data could be PCI config space, or an unrelated bus
(eg. lguest) or manufactured by the kernel itself.  It's designed to
be extensible: fields get marked as the device reads them so a host
supporting some future extension can tell if the guest driver
understood it.  This also applies to bitfields: the guest explicitly
acks the bits it understands.

There's also a simple status bitmask useful for low-level host
analysis of what the guest is doing with the device.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/Kconfig               |    2 
 drivers/Makefile              |    1 
 drivers/virtio/Makefile       |    2 
 drivers/virtio/config.c       |  109 +++++++++++++++++++++++++++++++
 include/linux/virtio_config.h |  141 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 254 insertions(+), 1 deletion(-)

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
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,1 +1,1 @@ obj-$(CONFIG_VIRTIO) += virtio.o
-obj-$(CONFIG_VIRTIO) += virtio.o
+obj-$(CONFIG_VIRTIO) += virtio.o config.o
===================================================================
--- /dev/null
+++ b/drivers/virtio/config.c
@@ -0,0 +1,109 @@
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
+#define HDR_LEN 2
+int virtio_config_find(struct virtio_config_space *config, u8 type,
+		       unsigned int *len)
+{
+	int i;
+
+	for (i = 0; i < config->len; i += HDR_LEN+config->readb(config,i+1)) {
+		if (config->readb(config, i) == type) {
+			/* Mark it used, so host can know we looked at it. */
+			config->writeb(config, i, type | VIRTIO_CONFIG_F_USED);
+			*len = config->readb(config, i+1);
+			return i;
+		}
+	}
+	return -ENOENT;
+}
+
+void virtio_config_get(struct virtio_config_space *config, int off,
+		       unsigned int len, void *buf)
+{
+	unsigned int i;
+
+	BUG_ON(off < 0 || off + HDR_LEN + len > config->len);
+	for (i = 0; i < len; i++)
+		((u8 *)buf)[i] = config->readb(config, off + HDR_LEN + i);
+
+}
+
+void virtio_config_set(struct virtio_config_space *config, int off,
+		       unsigned int len, const void *buf)
+{
+	unsigned int i;
+
+	BUG_ON(off < 0 || off + HDR_LEN + len > config->len);
+	for (i = 0; i < len; i++)
+		config->writeb(config, off + HDR_LEN + i, ((u8 *)buf)[i]);
+}
+
+int __virtio_config_val(struct virtio_config_space *config,
+			u8 type, void *val, size_t size)
+{
+	int off;
+	unsigned int len;
+
+	off = virtio_config_find(config, type, &len);
+	if (off < 0)
+		return off;
+
+	if (len != size)
+		return -EIO;
+
+	virtio_config_get(config, off, size, val);
+	return 0;
+}
+
+int virtio_use_bit(struct virtio_config_space *config,
+		   int off, unsigned int len, unsigned int bitnum)
+{
+	u8 ack, mask = 1 << (bitnum % 8);
+
+	/* This makes it convenient to pass-through virtio_config_find. */
+	if (off < 0)
+		return 0;
+
+	/* bit not in range of this bitfield? */
+	if (bitnum * 8 >= len / 2)
+		return 0;
+
+	/* bit not set? */
+	if (!(config->readb(config, bitnum / 8) & mask))
+		return 0;
+
+	/* Set acknowledge bit. */
+	ack = config->readb(config, bitnum / 8 + len / 2) | mask;
+	config->writeb(config, bitnum / 8 + len / 2, ack);
+	return 1;
+}
+
+struct virtqueue *virtio_config_vq(struct virtio_config_space *config,
+				   struct virtqueue_ops *ops,
+				   struct device *dev,
+				   bool (*callback)(void *), void *cb_data)
+{
+	unsigned int len;
+	int off = virtio_config_find(config, VIRTIO_CONFIG_F_VIRTQUEUE, &len);
+
+	if (off < 0)
+		return ERR_PTR(off);
+
+	return ops->new_vq(config, off, len, dev, callback, cb_data);
+}
+
+void virtio_add_status(struct virtio_config_space *config, u32 mask)
+{
+	config->set_status(config, config->get_status(config) | mask);
+}
===================================================================
--- /dev/null
+++ b/include/linux/virtio_config.h
@@ -0,0 +1,141 @@
+#ifndef _LINUX_VIRTIO_CONFIG_H
+#define _LINUX_VIRTIO_CONFIG_H
+/* Virtio devices use a standardized array of bytes to define their
+ * features and pass configuration information.
+ *
+ * The first byte is the status byte, after that come type/len/data fields.
+ * Each field understood by the guest is acknowledged by setting the USED bit.
+ * Some fields are bitfields: the first half is uses to advertise features to
+ * the guest, and the second half is used by the guest to acknowledge. */
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
+#define VIRTIO_CONFIG_S_FAILED		128
+
+/* Requirements/features of the virtio implementation. */
+#define VIRTIO_CONFIG_F_VIRTIO 1
+/* Requirements/features of the virtqueue (may have more than one). */
+#define VIRTIO_CONFIG_F_VIRTQUEUE 2
+
+/* Used config: guest sets this bit to say it understood the field. */
+#define VIRTIO_CONFIG_F_USED 0x80
+
+#ifdef __KERNEL__
+/* Low level opertions on this virtio device's configuration space. */
+struct virtio_config_space
+{
+	unsigned int len;
+	void (*writeb)(struct virtio_config_space *, unsigned off, u8 b);
+	u8 (*readb)(struct virtio_config_space *, unsigned off);
+	void (*set_status)(struct virtio_config_space *, u32 status);
+	u32 (*get_status)(struct virtio_config_space *);
+};
+
+/**
+ * virtio_config_find - look for a virtio config.
+ * @config: the virtio config space
+ * @type: the type to search for.
+ * @len: the length of the field.
+ *
+ * This returns the offset of the first field of the given type (or -ENOENT).
+ * This offset and length can then be handed to virtio_config_get().
+ *
+ * This function marks the field type with VIRTIO_CONFIG_F_USED, so it can't be
+ * found again, and the host knows we've seen the field. */
+int virtio_config_find(struct virtio_config_space *config, u8 type,
+		       unsigned int *len);
+
+/**
+ * virtio_config_get - get a virtio config field, and mark it used.
+ * @config: the virtio config space
+ * @off: the offset as returned from virtio_config_find.
+ * @len: the length of the field.
+ * @buf: the buffer to copy the field into.
+ *
+ * Note that virtio config entries are conventionally little-endian. */
+void virtio_config_get(struct virtio_config_space *config, int off,
+		       unsigned int len, void *buf);
+
+/**
+ * virtio_config_set - set a virtio config field, and mark it used.
+ * @config: the virtio config space
+ * @off: the offset as returned from virtio_config_find.
+ * @len: the length of the field.
+ * @buf: the buffer to copy into the field.
+ *
+ * Note that virtio config entries are conventionally little-endian. */
+void virtio_config_set(struct virtio_config_space *config, int off,
+		       unsigned int len, const void *buf);
+
+/**
+ * virtio_config_val - get a single virtio config and mark it used.
+ * @config: the virtio config space
+ * @type: the type to search for.
+ * @val: a pointer to the value to fill in.
+ *
+ * Once used, the config type is marked with VIRTIO_CONFIG_F_USED so it can't
+ * be found again.  This version does endian conversion. */
+#define virtio_config_val(config, type, v) ({				\
+	int _err = __virtio_config_val((config),(type),(v),sizeof(*(v))); \
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
+int __virtio_config_val(struct virtio_config_space *config,
+			u8 type, void *val, size_t size);
+
+/**
+ * virtio_use_bit - helper to use a feature bit in a bitfield value.
+ * @config: the virtio config space
+ * @off: the offset as returned from virtio_config_find.
+ * @len: the length of the field.
+ * @bitnum: the bit to test.
+ *
+ * If handed a negative offset, it returns false, otherwise returns bit status.
+ * If it's one, it sets the mirroring acknowledgement bit. */
+int virtio_use_bit(struct virtio_config_space *config,
+		   int off, unsigned int len, unsigned int bitnum);
+
+struct device;
+struct virtqueue_ops;
+
+/**
+ * virtio_config_vq - find a virtqueue in the config and call ops->new_vq.
+ * @config: the virtio config space
+ * @ops: the virtqueue_ops for the queue.
+ * @dev: the struct device this virtqueue is attached to.
+ * @callback: the driver callback when the queue is used.
+ * @cb_data: the pointer for the callback.
+ *
+ * This returns a new virtqueue or ERR_PTR(). */
+struct virtqueue *virtio_config_vq(struct virtio_config_space *config,
+				   struct virtqueue_ops *ops,
+				   struct device *dev,
+				   bool (*callback)(void *), void *cb_data);
+
+/**
+ * virtio_add_status - set a bit in the status field.
+ * @config: the virtio config space
+ * @mask: the mask to set (one bit).
+ *
+ * This is not usually set by the driver itself. */
+void virtio_add_status(struct virtio_config_space *config, u32 mask);
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_VIRTIO_CONFIG_H */
