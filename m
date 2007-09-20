From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/6] virtio interace
Date: Thu, 20 Sep 2007 22:09:00 +1000
Message-ID: <1190290140.7262.228.camel__26029.1319377304$1190290308$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190289808.7262.223.camel@localhost.localdomain>
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

(Changes: 
 - renamed sync to kick as Dor suggested
 - added new_vq and free_vq hooks to create virtqueues
 - define a simple virtio driver, which uses PCI ids
 - provide register/unregister_virtio_driver hooks)

This attempts to implement a "virtual I/O" layer which should allow
common drivers to be efficiently used across most virtual I/O
mechanisms.  It will no-doubt need further enhancement.

The virtio drivers add and get I/O buffers; as the buffers are consumed
the driver "interrupt" callbacks are invoked.

It also provides driver register and unregister hooks, which are
simply overridden at run time (eg. for a guest kernel which supports
KVM paravirt and lguest).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/Kconfig  |    3 +
 drivers/virtio/Makefile |    1 
 drivers/virtio/virtio.c |   20 ++++++++
 include/linux/virtio.h  |  114 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)

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
+++ b/drivers/virtio/virtio.c
@@ -0,0 +1,20 @@
+#include <linux/virtio.h>
+
+struct virtio_backend_ops virtio_backend_ops;
+EXPORT_SYMBOL_GPL(virtio_backend_ops);
+
+/* register and unregister simply punt through to the specific backend. */
+int register_virtio_driver(struct virtio_driver *drv)
+{
+	if (!virtio_backend_ops.register_driver)
+		return -ENOSYS;
+
+	return virtio_backend_ops.register_driver(drv);
+}
+EXPORT_SYMBOL_GPL(register_virtio_driver);
+
+void unregister_virtio_driver(struct virtio_driver *drv)
+{
+	virtio_backend_ops.unregister_driver(drv);
+}
+EXPORT_SYMBOL_GPL(unregister_virtio_driver);
===================================================================
--- /dev/null
+++ b/include/linux/virtio.h
@@ -0,0 +1,114 @@
+#ifndef _LINUX_VIRTIO_H
+#define _LINUX_VIRTIO_H
+/* Everything a virtio driver needs to work with any particular virtio
+ * implementation. */
+#include <linux/types.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/pci.h>
+
+struct device;
+struct virtio_config_space;
+
+/**
+ * virtqueue_ops - operations for virtqueue abstraction layer
+ * @new_vq: create a new virtqueue
+ *	config: the virtio_config_space field describing the queue
+ *	off: the offset in the config space of the queue configuration
+ *	len: the length of the virtio_config_space field
+ *	callback: the driver callback when the queue is used.
+ *	cb_data: the pointer for the callback.
+ *	Returns a new virtqueue or an ERR_PTR.
+ * @free_vq: free a virtqueue
+ *	vq: the struct virtqueue to free (must be unused or empty).
+ * @add_buf: expose buffer to other end
+ *	vq: the struct virtqueue we're talking about.
+ *	sg: the description of the buffer(s).
+ *	out_num: the number of sg readable by other side
+ *	in_num: the number of sg which are writable (after readable ones)
+ *	data: the token identifying the buffer.
+ *      Returns 0 or an error.
+ * @kick: update after add_buf
+ *	vq: the struct virtqueue
+ *	After one or more add_buf calls, invoke this to kick the virtio layer.
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
+	struct virtqueue *(*new_vq)(struct device *dev,
+				    struct virtio_config_space *config,
+				    int off, unsigned len,
+				    bool (*callback)(void *),
+				    void *cb_data);
+
+	void (*free_vq)(struct virtqueue *vq);
+
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
+/* FIXME: Get a real PCI vendor ID. */
+#define PCI_VENDOR_ID_VIRTIO 0x5000
+
+#define VIRTIO_DEV_ID(_devid, _class) {		\
+	.vendor = PCI_VENDOR_ID_VIRTIO,		\
+	.device = (_devid),			\
+	.subvendor = PCI_ANY_ID,		\
+	.subdevice = PCI_ANY_ID,		\
+	.class = (_class)<<8,			\
+	.class_mask = 0xFFFF00 }
+
+/**
+ * virtio_driver - operations for a virtio I/O driver
+ * @name: the name of the driver (KBUILD_MODNAME).
+ * @owner: the module which contains these routines (ie. THIS_MODULE).
+ * @id_table: the ids (we re-use PCI ids) serviced by this driver.
+ * @probe: the function to call when a device is found.  Returns a token for
+ *    remove, or PTR_ERR().
+ * @remove: the function when a device is removed.
+ */
+struct virtio_driver {
+	const char *name;
+	struct module *owner;
+	struct pci_device_id *id_table;
+	void *(*probe)(struct device *device,
+		       struct virtio_config_space *config,
+		       struct virtqueue_ops *vqops);
+	void (*remove)(void *dev);
+};
+
+int register_virtio_driver(struct virtio_driver *drv);
+void unregister_virtio_driver(struct virtio_driver *drv);
+
+/* The particular virtio backend supplies these. */
+struct virtio_backend_ops {
+	int (*register_driver)(struct virtio_driver *drv);
+	void (*unregister_driver)(struct virtio_driver *drv);
+};
+extern struct virtio_backend_ops virtio_backend_ops;
+#endif /* _LINUX_VIRTIO_H */
