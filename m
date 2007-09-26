From: rusty@rustcorp.com.au
Subject: [patch 35/43] lguest: Virtio console driver
Date: Wed, 26 Sep 2007 16:36:53 +1000
Message-ID: <20070926063651.423573144@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=new-io-console.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This is an hvc-based virtio console driver.  It's suboptimal becuase
hvc expects to have raw access to interrupts and virtio doesn't assume
that, so it currently polls.

There are two solutions: expose hvc's "kick" interface, or wean off hvc.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/Kconfig           |    4 
 drivers/char/Makefile          |    1 
 drivers/char/virtio_console.c  |  225 ++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_console.h |   12 ++
 4 files changed, 242 insertions(+)

===================================================================
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -613,6 +613,10 @@ config HVC_XEN
 	help
 	  Xen virtual console device driver
 
+config VIRTIO_CONSOLE
+	bool
+	select HVC_DRIVER
+
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
 	depends on PPC_PSERIES
===================================================================
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_HVC_BEAT)		+= hvc_beat.o
 obj-$(CONFIG_HVC_BEAT)		+= hvc_beat.o
 obj-$(CONFIG_HVC_DRIVER)	+= hvc_console.o
 obj-$(CONFIG_HVC_XEN)		+= hvc_xen.o
+obj-$(CONFIG_VIRTIO_CONSOLE)	+= virtio_console.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MSPEC)		+= mspec.o
===================================================================
--- /dev/null
+++ b/drivers/char/virtio_console.c
@@ -0,0 +1,225 @@
+/*D:300
+ * The Guest console driver
+ *
+ * Writing console drivers is one of the few remaining Dark Arts in Linux.
+ * Fortunately for us, the path of virtual consoles has been well-trodden by
+ * the PowerPC folks, who wrote "hvc_console.c" to generically support any
+ * virtual console.  We use that infrastructure which only requires us to write
+ * the basic put_chars and get_chars functions and call the right register
+ * functions.
+ :*/
+
+/*M:002 The console can be flooded: while the Guest is processing input the
+ * Host can send more.  Buffering in the Host could alleviate this, but it is a
+ * difficult problem in general. :*/
+/* Copyright (C) 2006, 2007 Rusty Russell, IBM Corporation
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
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/virtio.h>
+#include <linux/virtio_console.h>
+#include "hvc_console.h"
+
+/*D:340 These represent our input and output console queues, and the virtio
+ * operations for them. */
+static struct virtqueue *in_vq, *out_vq;
+static struct virtio_device *vdev;
+
+/* This is our input buffer, and how much data is left in it. */
+static unsigned int in_len;
+static char *in, *inbuf;
+
+/* The operations for our console. */
+static struct hv_ops virtio_cons;
+
+/*D:310 The put_chars() callback is pretty straightforward.
+ *
+ * We turn the characters into a scatter-gather list, add it to the output
+ * queue and then kick the Host.  Then we sit here waiting for it to finish:
+ * inefficient in theory, but in practice implementations will do it
+ * immediately (lguest's Launcher does). */
+static int put_chars(u32 vtermno, const char *buf, int count)
+{
+	struct scatterlist sg[1];
+	unsigned int len;
+
+	/* This is a convenient routine to initialize a single-elem sg list */
+	sg_init_one(sg, buf, count);
+
+	/* add_buf wants a token to identify this buffer: we hand it any
+	 * non-NULL pointer, since there's only ever one buffer. */
+	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, (void *)1) == 0) {
+		/* Tell Host to go! */
+		out_vq->vq_ops->kick(out_vq);
+		/* Chill out until it's done with the buffer. */
+		while (!out_vq->vq_ops->get_buf(out_vq, &len))
+			cpu_relax();
+	}
+
+	/* We're expected to return the amount of data we wrote: all of it. */
+	return count;
+}
+
+/* Create a scatter-gather list representing our input buffer and put it in the
+ * queue. */
+static void add_inbuf(void)
+{
+	struct scatterlist sg[1];
+	sg_init_one(sg, inbuf, PAGE_SIZE);
+
+	/* We should always be able to add one buffer to an empty queue. */
+	if (in_vq->vq_ops->add_buf(in_vq, sg, 0, 1, inbuf) != 0)
+		BUG();
+	in_vq->vq_ops->kick(in_vq);
+}
+
+/*D:350 get_chars() is the callback from the hvc_console infrastructure when
+ * an interrupt is received.
+ *
+ * Most of the code deals with the fact that the hvc_console() infrastructure
+ * only asks us for 16 bytes at a time.  We keep in_offset and in_used fields
+ * for partially-filled buffers. */
+static int get_chars(u32 vtermno, char *buf, int count)
+{
+	/* If we don't have an input queue yet, we can't get input. */
+	BUG_ON(!in_vq);
+
+	/* No buffer?  Try to get one. */
+	if (!in_len) {
+		in = in_vq->vq_ops->get_buf(in_vq, &in_len);
+		if (!in)
+			return 0;
+	}
+
+	/* You want more than we have to give?  Well, try wanting less! */
+	if (in_len < count)
+		count = in_len;
+
+	/* Copy across to their buffer and increment offset. */
+	memcpy(buf, in, count);
+	in += count;
+	in_len -= count;
+
+	/* Finished?  Re-register buffer so Host will use it again. */
+	if (in_len == 0)
+		add_inbuf();
+
+	return count;
+}
+/*:*/
+
+/*D:320 Console drivers are initialized very early so boot messages can go out,
+ * so we do things slightly differently from the generic virtio initialization
+ * of the net and block drivers.
+ *
+ * At this stage, the console is output-only.  It's too early to set up a
+ * virtqueue, so we let the drivers do some boutique early-output thing. */
+int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
+{
+	virtio_cons.put_chars = put_chars;
+	return hvc_instantiate(0, 0, &virtio_cons);
+}
+
+/*D:370 Once we're further in boot, we get probed like any other virtio device.
+ * At this stage we set up the output virtqueue.
+ *
+ * To set up and manage our virtual console, we call hvc_alloc().  Since we
+ * never remove the console device we never need this pointer again.
+ *
+ * Finally we put our input buffer in the input queue, ready to receive. */
+static int virtcons_probe(struct virtio_device *dev)
+{
+	int err;
+	struct hvc_struct *hvc;
+
+	vdev = dev;
+
+	/* This is the scratch page we use to receive console input */
+	inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!inbuf) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	/* Find the input queue. */
+	/* FIXME: This is why we want to wean off hvc: we do nothing
+	 * when input comes in. */
+	in_vq = vdev->config->find_vq(vdev, NULL);
+	if (IS_ERR(in_vq)) {
+		err = PTR_ERR(in_vq);
+		goto free;
+	}
+
+	out_vq = vdev->config->find_vq(vdev, NULL);
+	if (IS_ERR(out_vq)) {
+		err = PTR_ERR(out_vq);
+		goto free_in_vq;
+	}
+
+	/* Start using the new console output. */
+	virtio_cons.get_chars = get_chars;
+	virtio_cons.put_chars = put_chars;
+
+	/* The first argument of hvc_alloc() is the virtual console number, so
+	 * we use zero.  The second argument is the interrupt number; we
+	 * currently leave this as zero: it would be better not to use the
+	 * hvc mechanism and fix this (FIXME!).
+	 *
+	 * The third argument is a "struct hv_ops" containing the put_chars()
+	 * and get_chars() pointers.  The final argument is the output buffer
+	 * size: we can do any size, so we put PAGE_SIZE here. */
+	hvc = hvc_alloc(0, 0, &virtio_cons, PAGE_SIZE);
+	if (IS_ERR(hvc)) {
+		err = PTR_ERR(hvc);
+		goto free_out_vq;
+	}
+
+	/* Register the input buffer the first time. */
+	add_inbuf();
+	return 0;
+
+free_out_vq:
+	vdev->config->del_vq(out_vq);
+free_in_vq:
+	vdev->config->del_vq(in_vq);
+free:
+	kfree(inbuf);
+fail:
+	return err;
+}
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_CONSOLE, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_console = {
+	.driver.name =	KBUILD_MODNAME,
+	.driver.owner =	THIS_MODULE,
+	.id_table =	id_table,
+	.probe =	virtcons_probe,
+};
+
+static int __init init(void)
+{
+	return register_virtio_driver(&virtio_console);
+}
+module_init(init);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Virtio console driver");
+MODULE_LICENSE("GPL");
===================================================================
--- /dev/null
+++ b/include/linux/virtio_console.h
@@ -0,0 +1,12 @@
+#ifndef _LINUX_VIRTIO_CONSOLE_H
+#define _LINUX_VIRTIO_CONSOLE_H
+#include <linux/virtio_config.h>
+
+/* The ID for virtio console */
+#define VIRTIO_ID_CONSOLE	3
+
+#ifdef __KERNEL__
+int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_VIRTIO_CONSOLE_H */

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
