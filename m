From: arnd@arndb.de
Subject: [RFC 1/4] New virtio bus driver
Date: Fri, 06 Jul 2007 14:42:01 +0200
Message-ID: <20070706125717.576683142@arndb.de>
References: <20070706124200.988637662@arndb.de>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=new-io-arnd.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This adds a new bus_type for virtio that is intended to
be completely agnostic of the underlying host transport
and the upper-level protocol.

Device drivers and host drivers register here, and operations
are provided that let a device driver talk to the device
emulation in the hypervisor without knowing the kind of hypervisor.
Module autoloading through udev should also work.

Loosely based on Rusty's Virtio draft III.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--- /dev/null
+++ linux-2.6/include/linux/virtio.h
@@ -0,0 +1,174 @@
+#ifndef _LINUX_VIRTIO_H
+#define _LINUX_VIRTIO_H
+#include <linux/types.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+
+/**
+ * virtio_device_id - match a virtio device to a driver
+ * @device_type: string identifying the virtio interface.
+ * @driver_data: used internally by the driver.
+ */
+struct virtio_device_id {
+	const char *device_type;
+	unsigned long driver_data;
+};
+
+/**
+ * virtio_config - virtual device configuration.
+ * @host: structured data interpreted by the host driver.
+ * @driver: structured data interpreted by the device driver.
+ *
+ * The configuration space is what gets used to tell a driver
+ * about the device, e.g. MAC address or block device size.
+ * All fields in here are read-only in the virtual machine,
+ * they are set up by the host.
+ *
+ * The host part remains opaque to the device driver, it can
+ * contain e.g. lguest device index numbers or part of a PCI
+ * configuration space.
+ *
+ * The 256 bytes total intentionally match the size of the
+ * legacy PCI config registers, but the driver should not
+ * expect the layout to be derived from PCI.
+ *
+ * Every virtio_driver should define a data structure for the
+ * virtio_config->driver data, which becomes part of its ABI.
+ */
+struct virtio_config {
+	const char host[128];
+	const char driver[128];
+};
+
+/**
+ * virtio_device - description and routines to drive a virtual device.
+ * @id: identifier for the device type
+ * @dev: the device itself.
+ * @ops: the operations for this virtual device.
+ * @driver_ops: set by the driver for callbacks.
+ * @config: driver specific configuration data.
+ * @config_size: size of the @config data.
+ */
+struct virtio_device {
+	struct virtio_device_id id;
+	struct device dev;
+	struct virtio_ops *ops;
+	struct virtio_config config;
+};
+
+static inline struct virtio_device *to_virtio_dev(struct device *dev)
+{
+	return container_of(dev, struct virtio_device, dev);
+}
+
+/**
+ * virtio_driver - driver callbacks for a virtual device.
+ * @device_table: identifiers for compatible devices,
+ *  zero-terminated array
+ * @drv: the driver as known to the driver core.
+ * @in: inbufs have been completed.
+ *	Usually called from an interrupt handler.
+ *	Return false to suppress further inbuf callbacks.
+ * @out: outbufs have been completed.
+ *	Usually called from an interrupt handler.
+ *	Return false to suppress further outbuf callbacks.
+ */
+struct virtio_driver {
+	struct virtio_device_id *ids;
+	struct device_driver drv;
+	bool (*in)(struct virtio_device *dev);
+	bool (*out)(struct virtio_device *dev);
+};
+
+static inline struct virtio_driver *to_virtio_drv(struct device_driver *drv)
+{
+	return container_of(drv, struct virtio_driver, drv);
+}
+
+int virtio_device_register(struct virtio_device *vdev);
+void virtio_device_unregister(struct virtio_device *vdev);
+int virtio_driver_register(struct virtio_driver *vdrv);
+void virtio_driver_unregister(struct virtio_driver *vdrv);
+
+enum virtio_dir {
+	VIRTIO_IN = 0x1,
+	VIRTIO_OUT = 0x2,
+};
+
+/**
+ * virtio_ops - virtio abstraction layer
+ * @add_outbuf: prepare to send data to the other end:
+ *	vdev: the virtio_device
+ *	sg: the description of the buffer(s).
+ *	num: the size of the sg array.
+ *	data: the token returned by the get_outbuf function.
+ *      Returns a unique id or an error.
+ * @add_inbuf: prepare to receive data from the other end:
+ *	vdev: the virtio_device
+ *	sg: the description of the buffer(s).
+ *	num: the size of the sg array.
+ *	data: the token returned by the get_inbuf function.
+ *      Returns a unique id or an error (eg. -ENOSPC).
+ * @sync: update after add_inbuf and/or add_outbuf
+ *	vdev: the virtio_device we're talking about.
+ *	inout: VIRTIO_IN and/or VIRTIO_OUT
+ *	After one or more add_inbuf/add_outbuf calls, invoke this to kick
+ *	the virtio layer.
+ * @get_outbuf: get the next used outbuf.
+ *	vdev: the virtio_device we're talking about.
+ *	len: the length written into the outbuf
+ *	Returns NULL or the "data" token handed to add_outbuf (which has been
+ *	detached).
+ * @get_inbuf: get the next used inbuf.
+ *	vdev: the virtio_device we're talking about.
+ *	len: the length read from the inbuf
+ *	Returns NULL or the "data" token handed to add_inbuf (which has been
+ *	detached).
+ * @detach_outbuf: make sure sent sg can no longer be read.
+ *	vdev: the virtio_device we're talking about.
+ *	id: the id returned from add_outbuf.
+ *	This is usually used for shutdown.  Don't try to detach twice.
+ * @detach_inbuf: make sure sent sg can no longer be written to.
+ *	vdev: the virtio_device we're talking about.
+ *	id: the id returned from add_inbuf.
+ *	This is usually used for shutdown.  Don't try to detach twice.
+ * @restart_in: restart calls to driver_ops->in after it returned false.
+ *	vdev: the virtio_device we're talking about.
+ *	This returns "false" (and doesn't re-enable) if there are pending
+ *	inbufs, to avoid a race.
+ * @restart_out: restart calls to driver_ops->out after it returned false.
+ *	vdev: the virtio_device we're talking about.
+ *	This returns "false" (and doesn't re-enable) if there are pending
+ *	outbufs, to avoid a race.
+ *
+ * Locking rules are straightforward: the driver is responsible for
+ * locking.  Outbuf operations can be called in parallel to inbuf
+ * operations, but no two outbuf operations nor two inbuf operations
+ * may be invoked simultaneously.
+ *
+ * All operations can be called in any context.
+ */
+struct virtio_ops {
+	unsigned long (*add_outbuf)(struct virtio_device *vdev,
+				    const struct scatterlist sg[],
+				    unsigned int num,
+				    void *data);
+
+	unsigned long (*add_inbuf)(struct virtio_device *vdev,
+				   struct scatterlist sg[],
+				   unsigned int num,
+				   void *data);
+
+	void (*sync)(struct virtio_device *vdev, enum virtio_dir inout);
+
+	void *(*get_outbuf)(struct virtio_device *vdev, unsigned int *len);
+	void *(*get_inbuf)(struct virtio_device *vdev, unsigned int *len);
+
+	void (*detach_outbuf)(struct virtio_device *vdev, unsigned long id);
+	void (*detach_inbuf)(struct virtio_device *vdev, unsigned long id);
+
+	bool (*restart_in)(struct virtio_device *vdev);
+	bool (*restart_out)(struct virtio_device *vdev);
+};
+#endif /* _LINUX_VIRTIO_H */
Index: linux-2.6/drivers/base/virtio.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/base/virtio.c
@@ -0,0 +1,153 @@
+/* Virtual I/O bus implementation
+ *
+ * Copyright 2007 Arnd Bergmann <arnd@arndb.de> IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/device.h>
+#include <linux/virtio.h>
+
+/**
+ * virtio_match - match a virtio device to its driver by device ID
+ *
+ * Used internally by the bus type implementation. Whenever a new
+ * device or driver is added to the system, the match function gets
+ * called for all possible combinations with existing drivers or
+ * devices.
+ *
+ * When a match is found, we attempt to bind the device to its
+ * driver by calling the driver's probe function.
+ */
+static int virtio_match(struct device *dev, struct device_driver *drv)
+{
+	struct virtio_device *vdev = to_virtio_dev(dev);
+	struct virtio_driver *vdrv = to_virtio_drv(drv);
+	struct virtio_device_id *id;
+
+	/* return true if one id in the driver matches */
+	for (id = vdrv->ids; id->device_type; id++)
+		if (strcmp(id->device_type, vdev->id.device_type) == 0)
+			return 1;
+
+	/* did not match any */
+	return 0;
+}
+
+/**
+ * virtio_uevent - add modalias field to uevent message
+ *
+ * Used internally by the uevent mechanism to add more
+ * information to a virtio device event.
+ */
+static int virtio_uevent(struct device *dev, char **envp, int num_envp,
+				char *buf, int buf_size)
+{
+	struct virtio_device *vdev = to_virtio_dev(dev);
+
+	envp[0] = buf;
+	snprintf(buf, buf_size, "MODALIAS=virtio:%s",
+			vdev->id.device_type);
+	return 0;
+}
+
+static ssize_t modalias_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct virtio_device *vdev = to_virtio_dev(dev);
+	return scnprintf(buf, PAGE_SIZE, "virtio:%s\n", vdev->id.device_type);
+}
+
+static struct device_attribute virtio_dev_attrs[] = {
+	__ATTR_RO(modalias),
+	__ATTR_NULL,
+};
+
+static struct bus_type virtio_bus = {
+	.name = "virtio",
+	.owner = THIS_MODULE,
+	.match = virtio_match,
+	.uevent = virtio_uevent,
+	.dev_attrs = virtio_dev_attrs,
+};
+
+/**
+ * virtio_device_register - add a new virtio device
+ * @vdev: device that will be registered
+ *
+ * A virtio bus driver implementation calls this
+ * function for every device it discovers on its
+ * respective bus implementation.
+ */
+int virtio_device_register(struct virtio_device *vdev)
+{
+	vdev->dev.bus = &virtio_bus;
+	return device_register(&vdev->dev);
+}
+EXPORT_SYMBOL_GPL(virtio_device_register);
+
+/**
+ * virtio_device_unregister - remove a virtio device
+ * @vdev: device that will be unregistered
+ *
+ * If a virtio bus driver supports hot unplugging of
+ * devices, this function will be used at remove
+ * time.
+ */
+void virtio_device_unregister(struct virtio_device *vdev)
+{
+	device_unregister(&vdev->dev);
+}
+EXPORT_SYMBOL_GPL(virtio_device_unregister);
+
+/**
+ * virtio_driver_register - add a new virtio driver
+ * @vdrv: driver that will be registered
+ *
+ * A virtio device driver module needs to call this
+ * function in its module_init handler, and the
+ * respective unregister function for its module_exit
+ * handler.
+ */
+int virtio_driver_register(struct virtio_driver *vdrv)
+{
+	vdrv->drv.bus = &virtio_bus;
+	return driver_register(&vdrv->drv);
+}
+EXPORT_SYMBOL_GPL(virtio_driver_register);
+
+/**
+ * virtio_driver_unregister - remove a virtio driver
+ * @vdrv: driver that will be unregistered
+ */
+void virtio_driver_unregister(struct virtio_driver *vdrv)
+{
+	driver_unregister(&vdrv->drv);
+}
+EXPORT_SYMBOL_GPL(virtio_driver_unregister);
+
+static int __init virtio_bus_init(void)
+{
+	return bus_register(&virtio_bus);
+}
+module_init(virtio_bus_init);
+
+static void __exit virtio_bus_exit(void)
+{
+	bus_unregister(&virtio_bus);
+}
+module_exit(virtio_bus_exit);
+
+MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
+MODULE_LICENSE("GPL");
Index: linux-2.6/drivers/base/Kconfig
===================================================================
--- linux-2.6.orig/drivers/base/Kconfig
+++ linux-2.6/drivers/base/Kconfig
@@ -53,4 +53,7 @@ config SYS_HYPERVISOR
 	bool
 	default n
 
+config VIRTIO
+	tristate "Virtual I/O device bus"
+
 endmenu
Index: linux-2.6/drivers/base/Makefile
===================================================================
--- linux-2.6.orig/drivers/base/Makefile
+++ linux-2.6/drivers/base/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG_SPARSE) += memory.o
 obj-$(CONFIG_SMP)	+= topology.o
 obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
+obj-$(CONFIG_VIRTIO)	+= virtio.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG

--
