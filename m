From: Yoni Bettan <ybettan@redhat.com>
Subject: [RFC-PATCH] Introducing virtio-example.
Date: Mon, 29 Apr 2019 15:40:03 +0300
Message-ID: <20190429124004.49365-1-ybettan__10702.6309402258$1556541823$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: ehabkost@redhat.com, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

The main goal is to create an example to be used as template or
guideline for contributors when they wish to create a new virtio
device and to document "the right way" to do so.

It consists of several parts:

    1. The device specification
        * it can be found in the device header of the implementation
        * it will hopefully be added to the official virtio specification

    2. The device implementation for Qemu-KVM hypervisor
        * it can be found at https://github.com/ybettan/qemu/blob/virtio\
                /hw/virtio/virtio-example.c

    3. The device driver for linux
        * this patch content

    4. A blog on virtio
        * introducing the virtio concept
        * gives some motivation for virtio-devices to be used
        * bring extra documentation on "how to write":
            - device specification
            - device implementation
            - device driver for linux
        * it can be found at https://howtovms.wordpress.com

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---
 samples/virtio/Makefile                |   1 +
 samples/virtio/virtio_example_driver.c | 239 +++++++++++++++++++++++++
 2 files changed, 240 insertions(+)
 create mode 100644 samples/virtio/Makefile
 create mode 100644 samples/virtio/virtio_example_driver.c

diff --git a/samples/virtio/Makefile b/samples/virtio/Makefile
new file mode 100644
index 000000000000..6f3cc811ca89
--- /dev/null
+++ b/samples/virtio/Makefile
@@ -0,0 +1 @@
+obj-m := virtio_example_driver.o
diff --git a/samples/virtio/virtio_example_driver.c b/samples/virtio/virtio_example_driver.c
new file mode 100644
index 000000000000..2f5a354009a1
--- /dev/null
+++ b/samples/virtio/virtio_example_driver.c
@@ -0,0 +1,239 @@
+/*
+ * Virtio example implementation.
+ *
+ *  Copyright 2019 Yoni Bettan Red Hat Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ */
+
+#include <linux/virtio.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>               /* io map */
+#include <linux/dma-mapping.h>      /* DMA */
+#include <linux/kernel.h>           /* kstrtoint() func */
+#include <linux/virtio_config.h>    /* find_single_vq() func */
+
+
+#define VIRTIO_ID_EXAMPLE 21
+/* big enough to contain a string representing an integer */
+#define MAX_DATA_SIZE 20
+
+struct virtexample_info {
+	struct virtqueue *vq;
+    /*
+     * in - the data we get from the device
+     * out - the data we send to the device
+     */
+    int in, out;
+};
+
+
+
+//-----------------------------------------------------------------------------
+//                  sysfs - give user access to driver
+//-----------------------------------------------------------------------------
+
+static ssize_t
+virtio_buf_store(struct device *dev, struct device_attribute *attr,
+                    const char *buf, size_t count)
+{
+    char tmp_buf[MAX_DATA_SIZE];
+    int retval;
+	struct scatterlist sg_in, sg_out;
+	struct scatterlist *request[2];
+    /* cast dev into a virtio_device */
+    struct virtio_device *vdev = dev_to_virtio(dev);
+	struct virtexample_info *vi = vdev->priv;
+
+    /* copy the user buffer since it is a const buffer */
+    sprintf(tmp_buf, "%s", buf);
+
+    /* convert the data into an integer */
+    retval = kstrtoint(tmp_buf, 10, &vi->out);
+    if (retval) {
+        pr_alert("string converstion failed with error: %d\n", retval);
+    }
+
+    /* initialize a single entry sg lists, one for input and one for output */
+    sg_init_one(&sg_out, &vi->out, sizeof(int));
+    sg_init_one(&sg_in, &vi->in, sizeof(int));
+
+    /* build the request */
+    request[0] = &sg_out;
+    request[1] = &sg_in;
+
+	/* add the request to the queue, in_buf is sent as the buffer idetifier */
+    virtqueue_add_sgs(vi->vq, request, 1, 1, &vi->in, GFP_KERNEL);
+
+    /* notify the device */
+	virtqueue_kick(vi->vq);
+
+    return count;
+}
+
+static ssize_t
+virtio_buf_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+    /* cast dev into a virtio_device */
+    struct virtio_device *vdev = dev_to_virtio(dev);
+	struct virtexample_info *vi = vdev->priv;
+
+    return sprintf(buf, "%d\n", vi->in);
+}
+
+/*
+ * struct device_attribute dev_attr_virtio_buf = {
+ *     .attr = {
+ *         .name = "virtio_buf",
+ *         .mode = 0644
+ *     },
+ *     .show = virtio_buf_show,
+ *     .store = virtio_buf_store
+ * }
+ */
+static DEVICE_ATTR_RW(virtio_buf);
+
+
+/*
+ * The example_attr defined above is then grouped in the struct attribute group
+ * as follows:
+ */
+struct attribute *example_attrs[] = {
+    &dev_attr_virtio_buf.attr,
+    NULL,
+};
+
+static const struct attribute_group example_attr_group = {
+    .name = "example", /* directory's name */
+    .attrs = example_attrs,
+};
+
+
+
+//-----------------------------------------------------------------------------
+//                              IRQ functions
+//-----------------------------------------------------------------------------
+
+static void example_irq_handler(struct virtqueue *vq)
+{
+
+	struct virtexample_info *vi = vq->vdev->priv;
+    unsigned int len;
+    int *res = NULL;
+
+    /* get the buffer from virtqueue */
+    res = virtqueue_get_buf(vi->vq, &len);
+
+    vi->in = *res;
+}
+
+
+//-----------------------------------------------------------------------------
+//                             driver functions
+//-----------------------------------------------------------------------------
+
+
+static int example_probe(struct virtio_device *vdev)
+{
+    int retval;
+    struct virtexample_info *vi = NULL;
+
+    /* create sysfiles for UI */
+    retval = sysfs_create_group(&vdev->dev.kobj, &example_attr_group);
+    if (retval) {
+        pr_alert("failed to create group in /sys/bus/virtio/devices/.../\n");
+    }
+
+    /* initialize driver data */
+	vi = kzalloc(sizeof(struct virtexample_info), GFP_KERNEL);
+	if (!vi)
+		return -ENOMEM;
+
+	/* We expect a single virtqueue. */
+	vi->vq = virtio_find_single_vq(vdev, example_irq_handler, "input");
+	if (IS_ERR(vi->vq)) {
+        pr_alert("failed to connect to the device virtqueue\n");
+	}
+
+    /* initialize the data to 0 */
+    vi->in = 0;
+    vi->out = 0;
+
+    /* store driver data inside the device to be accessed for all functions */
+    vdev->priv = vi;
+
+    return 0;
+}
+
+static void example_remove(struct virtio_device *vdev)
+{
+	struct virtexample_info *vi = vdev->priv;
+
+    /* remove the directory from sysfs */
+    sysfs_remove_group(&vdev->dev.kobj, &example_attr_group);
+
+    /* disable interrupts for vqs */
+    vdev->config->reset(vdev);
+
+    /* remove virtqueues */
+	vdev->config->del_vqs(vdev);
+
+    /* free memory */
+	kfree(vi);
+}
+
+
+/*
+ * vendor and device (+ subdevice and subvendor)
+ * identifies a device we support
+ */
+static struct virtio_device_id example_ids[] = {
+    {
+        .device = VIRTIO_ID_EXAMPLE,
+        .vendor = VIRTIO_DEV_ANY_ID,
+    },
+    { 0, },
+};
+
+/*
+ * id_table describe the device this driver support
+ * probe is called when a device we support exist and
+ * when we are chosen to drive it.
+ * remove is called when the driver is unloaded or
+ * when the device disappears
+ */
+static struct virtio_driver example = {
+	.driver.name =	"example",
+	.driver.owner =	THIS_MODULE,
+	.id_table =	example_ids,
+	.probe =	example_probe,
+	.remove =	example_remove,
+};
+
+
+
+//-----------------------------------------------------------------------------
+//                          overhead - must have
+//-----------------------------------------------------------------------------
+
+
+
+/* register driver in kernel pci framework */
+module_virtio_driver(example);
+MODULE_DEVICE_TABLE(virtio, example_ids);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Example virtio");
+MODULE_AUTHOR("Yoni Bettan");
+
-- 
2.17.2
