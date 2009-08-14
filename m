From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [Qemu-devel] Re: virtio-serial: An interface for host-guest
	communication
Date: Fri, 14 Aug 2009 13:45:18 +0530
Message-ID: <20090814081518.GA7418__14790.4760357507$1250237889$gmane$org@amit-x200.redhat.com>
References: <20090806173740.GA1178@shareable.org>
	<20090807063800.GA16769@amit-x200.redhat.com>
	<4A7C36D3.3040305@codemonkey.ws>
	<20090810065508.GA4499@amit-x200.redhat.com>
	<4A7FECCA.8080804@redhat.com> <4A801A7B.1020208@codemonkey.ws>
	<4A80287C.7050400@redhat.com> <4A802CA7.9020701@codemonkey.ws>
	<4A803E07.7080407@redhat.com> <4A8051F3.7040400@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4A8051F3.7040400@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) Aug 10 2009 [11:59:31], Anthony Liguori wrote:
>
> However, as I've mentioned repeatedly, the reason I won't merge  
> virtio-serial is that it duplicates functionality with virtio-console.   
> If the two are converged, I'm happy to merge it.  I'm not opposed to  
> having more functionality.

The guest code sort-of ends up looking like this after merging
virtio_console into virtio_serial. Diff is against virtio_serial in my
git tree, but that should be pretty close to the last submission I made
at

http://patchwork.kernel.org/patch/39335/

or the tree at

git://git.kernel.org/pub/scm/linux/kernel/git/amit/vs-kernel.git

I've merged bits from virtio_console.c into virtio_serial.c. If needed,
virtio_serial can be renamed to virtio_console. The VIRITIO_ID also
needs to change to that of virtio_console's.

Similar changes are needed for userspace.

Since there's support for only one console as of now, I've assigned port
#2 as the console port so that we hook into hvc when a port is found at
that location.

One issue that crops up for put_chars: a copy of the buffer to be sent
has to be made as we don't wait for host to ack the buffer before we
move on.

The biggest loss so far is Rusty's excellent comments: they will have to
be reworked and added for the whole of the new file.

Is this approach acceptable?


diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 5e1915b..ab9c914 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -53,7 +53,6 @@ obj-$(CONFIG_HVC_IRQ)		+= hvc_irq.o
 obj-$(CONFIG_HVC_XEN)		+= hvc_xen.o
 obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
 obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
-obj-$(CONFIG_VIRTIO_CONSOLE)	+= virtio_console.o
 obj-$(CONFIG_VIRTIO_SERIAL)	+= virtio_serial.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c74dacf..f82c036 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -43,39 +43,6 @@ static struct virtio_device *vdev;
 static unsigned int in_len;
 static char *in, *inbuf;
 
-/* The operations for our console. */
-static struct hv_ops virtio_cons;
-
-/* The hvc device */
-static struct hvc_struct *hvc;
-
-/*D:310 The put_chars() callback is pretty straightforward.
- *
- * We turn the characters into a scatter-gather list, add it to the output
- * queue and then kick the Host.  Then we sit here waiting for it to finish:
- * inefficient in theory, but in practice implementations will do it
- * immediately (lguest's Launcher does). */
-static int put_chars(u32 vtermno, const char *buf, int count)
-{
-	struct scatterlist sg[1];
-	unsigned int len;
-
-	/* This is a convenient routine to initialize a single-elem sg list */
-	sg_init_one(sg, buf, count);
-
-	/* add_buf wants a token to identify this buffer: we hand it any
-	 * non-NULL pointer, since there's only ever one buffer. */
-	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, (void *)1) == 0) {
-		/* Tell Host to go! */
-		out_vq->vq_ops->kick(out_vq);
-		/* Chill out until it's done with the buffer. */
-		while (!out_vq->vq_ops->get_buf(out_vq, &len))
-			cpu_relax();
-	}
-
-	/* We're expected to return the amount of data we wrote: all of it. */
-	return count;
-}
 
 /* Create a scatter-gather list representing our input buffer and put it in the
  * queue. */
@@ -90,94 +57,7 @@ static void add_inbuf(void)
 	in_vq->vq_ops->kick(in_vq);
 }
 
-/*D:350 get_chars() is the callback from the hvc_console infrastructure when
- * an interrupt is received.
- *
- * Most of the code deals with the fact that the hvc_console() infrastructure
- * only asks us for 16 bytes at a time.  We keep in_offset and in_used fields
- * for partially-filled buffers. */
-static int get_chars(u32 vtermno, char *buf, int count)
-{
-	/* If we don't have an input queue yet, we can't get input. */
-	BUG_ON(!in_vq);
-
-	/* No buffer?  Try to get one. */
-	if (!in_len) {
-		in = in_vq->vq_ops->get_buf(in_vq, &in_len);
-		if (!in)
-			return 0;
-	}
-
-	/* You want more than we have to give?  Well, try wanting less! */
-	if (in_len < count)
-		count = in_len;
-
-	/* Copy across to their buffer and increment offset. */
-	memcpy(buf, in, count);
-	in += count;
-	in_len -= count;
 
-	/* Finished?  Re-register buffer so Host will use it again. */
-	if (in_len == 0)
-		add_inbuf();
-
-	return count;
-}
-/*:*/
-
-/*D:320 Console drivers are initialized very early so boot messages can go out,
- * so we do things slightly differently from the generic virtio initialization
- * of the net and block drivers.
- *
- * At this stage, the console is output-only.  It's too early to set up a
- * virtqueue, so we let the drivers do some boutique early-output thing. */
-int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
-{
-	virtio_cons.put_chars = put_chars;
-	return hvc_instantiate(0, 0, &virtio_cons);
-}
-
-/*
- * virtio console configuration. This supports:
- * - console resize
- */
-static void virtcons_apply_config(struct virtio_device *dev)
-{
-	struct winsize ws;
-
-	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {
-		dev->config->get(dev,
-				 offsetof(struct virtio_console_config, cols),
-				 &ws.ws_col, sizeof(u16));
-		dev->config->get(dev,
-				 offsetof(struct virtio_console_config, rows),
-				 &ws.ws_row, sizeof(u16));
-		hvc_resize(hvc, ws);
-	}
-}
-
-/*
- * we support only one console, the hvc struct is a global var
- * We set the configuration at this point, since we now have a tty
- */
-static int notifier_add_vio(struct hvc_struct *hp, int data)
-{
-	hp->irq_requested = 1;
-	virtcons_apply_config(vdev);
-
-	return 0;
-}
-
-static void notifier_del_vio(struct hvc_struct *hp, int data)
-{
-	hp->irq_requested = 0;
-}
-
-static void hvc_handle_input(struct virtqueue *vq)
-{
-	if (hvc_poll(hvc))
-		hvc_kick();
-}
 
 /*D:370 Once we're further in boot, we get probed like any other virtio device.
  * At this stage we set up the output virtqueue.
@@ -212,27 +92,7 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 	in_vq = vqs[0];
 	out_vq = vqs[1];
 
-	/* Start using the new console output. */
-	virtio_cons.get_chars = get_chars;
-	virtio_cons.put_chars = put_chars;
-	virtio_cons.notifier_add = notifier_add_vio;
-	virtio_cons.notifier_del = notifier_del_vio;
-	virtio_cons.notifier_hangup = notifier_del_vio;
 
-	/* The first argument of hvc_alloc() is the virtual console number, so
-	 * we use zero.  The second argument is the parameter for the
-	 * notification mechanism (like irq number). We currently leave this
-	 * as zero, virtqueues have implicit notifications.
-	 *
-	 * The third argument is a "struct hv_ops" containing the put_chars()
-	 * get_chars(), notifier_add() and notifier_del() pointers.
-	 * The final argument is the output buffer size: we can do any size,
-	 * so we put PAGE_SIZE here. */
-	hvc = hvc_alloc(0, 0, &virtio_cons, PAGE_SIZE);
-	if (IS_ERR(hvc)) {
-		err = PTR_ERR(hvc);
-		goto free_vqs;
-	}
 
 	/* Register the input buffer the first time. */
 	add_inbuf();
diff --git a/drivers/char/virtio_serial.c b/drivers/char/virtio_serial.c
index ef2d730..ff6ad06 100644
--- a/drivers/char/virtio_serial.c
+++ b/drivers/char/virtio_serial.c
@@ -37,6 +37,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_serial.h>
 #include <linux/workqueue.h>
+#include "hvc_console.h"
 
 struct virtio_serial_struct {
 	struct work_struct rx_work;
@@ -131,27 +132,13 @@ static int send_control_event(struct virtio_serial_control *sercontrol)
 	return ret;
 }
 
-static ssize_t virtserial_read(struct file *filp, char __user *ubuf,
-			       size_t count, loff_t *offp)
+static ssize_t fill_readbuf(struct virtio_serial_port *port, char *out_buf,
+			    size_t count, bool to_user)
 {
-	struct virtio_serial_port *port;
 	struct virtio_serial_port_buffer *buf, *buf2;
-	ssize_t ubuf_offset, ret;
-
-	port = filp->private_data;
-
-	ret = 0;
-	if (list_empty(&port->readbuf_head)) {
-		if (filp->f_flags & O_NONBLOCK)
-			return -EAGAIN;
+	ssize_t out_offset, ret;
 
-		ret = wait_event_interruptible(port->waitqueue,
-					       !list_empty(&port->readbuf_head));
-	}
-	if (ret < 0)
-		return ret;
-
-	ubuf_offset = 0;
+	out_offset = 0;
 	list_for_each_entry_safe(buf, buf2, &port->readbuf_head, next) {
 		size_t copy_size;
 
@@ -159,16 +146,24 @@ static ssize_t virtserial_read(struct file *filp, char __user *ubuf,
 		if (copy_size > buf->len - buf->offset)
 			copy_size = buf->len - buf->offset;
 
-		ret = copy_to_user(ubuf + ubuf_offset, buf->buf + buf->offset,
-				   copy_size);
+		if (to_user) {
+			ret = copy_to_user(out_buf + out_offset,
+					   buf->buf + buf->offset,
+					   copy_size);
+			/* FIXME: Deal with ret != 0 */
+		} else {
+			memcpy(out_buf + out_offset,
+			       buf->buf + buf->offset,
+			       copy_size);
+			ret = 0; /* Emulate copy_to_user behaviour */
+		}
 
-		/* FIXME: Deal with ret != 0 */
 		/* Return the number of bytes actually copied */
 		ret = copy_size - ret;
 		buf->offset += ret;
-		ubuf_offset += ret;
+		out_offset += ret;
 		count -= ret;
-		ret = ubuf_offset;
+		ret = out_offset;
 
 		if (buf->len - buf->offset == 0) {
 			list_del(&buf->next);
@@ -178,6 +173,30 @@ static ssize_t virtserial_read(struct file *filp, char __user *ubuf,
 		if (!count)
 			break;
 	}
+	return out_offset;
+}
+
+static ssize_t virtserial_read(struct file *filp, char __user *ubuf,
+			       size_t count, loff_t *offp)
+{
+	struct virtio_serial_port *port;
+	ssize_t ret;
+
+	port = filp->private_data;
+
+	ret = 0;
+	if (list_empty(&port->readbuf_head)) {
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(port->waitqueue,
+					       !list_empty(&port->readbuf_head));
+	}
+	if (ret < 0)
+		return ret;
+
+	ret = fill_readbuf(port, ubuf, count, 1);
+
 	return ret;
 }
 
@@ -196,21 +215,19 @@ struct vbuf {
 	unsigned int nent;
 };
 
-static ssize_t virtserial_write(struct file *filp, const char __user *ubuf,
-				size_t count, loff_t *offp)
+static ssize_t send_writebuf(struct virtio_serial_port *port,
+			     const char *in_buf, size_t count, bool from_user)
 {
 	struct virtqueue *out_vq;
-	struct virtio_serial_port *port;
 	struct virtio_serial_id id;
 	struct vbuf *vbuf;
-	size_t offset, size;
+	size_t in_offset, copy_size;
 	ssize_t ret;
 	unsigned int i, id_len;
 
 	if (!count)
 		return 0;
 
-	port = filp->private_data;
 	id.id = get_id_from_port(port);
 	out_vq = virtserial.out_vq;
 
@@ -234,10 +251,10 @@ static ssize_t virtserial_write(struct file *filp, const char __user *ubuf,
 	sg_init_table(vbuf->sg, vbuf->nent);
 
 	i = 0; /* vbuf->bufs[i] */
-	offset = 0; /* offset in the user buffer */
-	while (count - offset) {
-		size = min(count - offset + id_len, PAGE_SIZE);
-		vbuf->bufs[i] = kzalloc(size, GFP_KERNEL);
+	in_offset = 0; /* offset in the source buffer */
+	while (count - in_offset) {
+		copy_size = min(count - in_offset + id_len, PAGE_SIZE);
+		vbuf->bufs[i] = kzalloc(copy_size, GFP_KERNEL);
 		if (!vbuf->bufs[i]) {
 			ret = -ENOMEM;
 			if (!i)
@@ -246,12 +263,25 @@ static ssize_t virtserial_write(struct file *filp, const char __user *ubuf,
 		}
 		if (id_len) {
 			memcpy(vbuf->bufs[i], &id, id_len);
-			size -= id_len;
+			copy_size -= id_len;
 		}
-		ret = copy_from_user(vbuf->bufs[i] + id_len, ubuf + offset, size);
-		offset += size - ret;
+		if (from_user)
+			ret = copy_from_user(vbuf->bufs[i] + id_len,
+					     in_buf + in_offset, copy_size);
+		else {
+			/* Since we're not sure when the host will actually
+			 * consume the data and tell us about it, we have
+			 * to copy the data here in case the caller
+			 * frees the string
+			 */
+			memcpy(vbuf->bufs[i] + id_len,
+			       in_buf + in_offset, copy_size);
+			ret = 0; /* Emulate copy_from_user */
+		}
+		in_offset += copy_size - ret;
 
-		sg_set_buf(&vbuf->sg[i], vbuf->bufs[i], size - ret + id_len);
+		sg_set_buf(&vbuf->sg[i], vbuf->bufs[i],
+			   copy_size - ret + id_len);
 		id_len = 0; /* Pass the port id only in the first buffer */
 		i++;
 	}
@@ -263,7 +293,7 @@ static ssize_t virtserial_write(struct file *filp, const char __user *ubuf,
 	out_vq->vq_ops->kick(out_vq);
 
 	/* We're expected to return the amount of data we wrote */
-	return offset;
+	return in_offset;
 free_buffers:
 	while (--i >= 0)
 		kfree(vbuf->bufs[i]);
@@ -276,6 +306,16 @@ free_vbuf:
 	return ret;
 }
 
+static ssize_t virtserial_write(struct file *filp, const char __user *ubuf,
+				size_t count, loff_t *offp)
+{
+	struct virtio_serial_port *port;
+
+	port = filp->private_data;
+
+	return send_writebuf(port, ubuf, count, 1);
+}
+
 static int virtserial_release(struct inode *inode, struct file *filp)
 {
 	struct virtio_serial_control *sercontrol;
@@ -343,6 +383,104 @@ static const struct file_operations virtserial_fops = {
 	.release = virtserial_release,
 };
 
+/* Some routines for supporting virtio console */
+
+/* The operations for our console. */
+static struct hv_ops virtio_cons;
+
+/* The hvc device */
+static struct hvc_struct *hvc;
+
+/*D:310 The console_put_chars() callback is pretty straightforward.
+ *
+ * We turn the characters into a scatter-gather list, add it to the output
+ * queue and then kick the Host.  Then we sit here waiting for it to finish:
+ * inefficient in theory, but in practice implementations will do it
+ * immediately (lguest's Launcher does). */
+static int console_put_chars(u32 vtermno, const char *buf, int count)
+{
+	struct virtio_serial_port *port;
+
+	port = get_port_from_id(VIRTIO_SERIAL_CONSOLE_PORT);
+	if (!port)
+		return 0;
+
+	return send_writebuf(port, buf, count, 0);
+}
+
+/*D:350 console_get_chars() is the callback from the hvc_console
+ * infrastructure when an interrupt is received.
+ *
+ * Most of the code deals with the fact that the hvc_console() infrastructure
+ * only asks us for 16 bytes at a time.  We keep in_offset and in_used fields
+ * for partially-filled buffers. */
+static int console_get_chars(u32 vtermno, char *out_buf, int count)
+{
+	struct virtio_serial_port *port;
+
+	/* If we don't have an input queue yet, we can't get input. */
+	BUG_ON(!virtserial.in_vq);
+
+	port = get_port_from_id(VIRTIO_SERIAL_CONSOLE_PORT);
+	if (!port)
+		return 0;
+
+	if (list_empty(&port->readbuf_head))
+		return 0;
+
+	return fill_readbuf(port, out_buf, count, 0);
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
+/*
+ * virtio console configuration. This supports:
+ * - console resize
+ */
+static void virtcons_apply_config(struct virtio_device *dev)
+{
+	struct winsize ws;
+
+	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {
+		dev->config->get(dev,
+				 offsetof(struct virtio_serial_config, cols),
+				 &ws.ws_col, sizeof(u16));
+		dev->config->get(dev,
+				 offsetof(struct virtio_serial_config, rows),
+				 &ws.ws_row, sizeof(u16));
+		hvc_resize(hvc, ws);
+	}
+}
+
+/*
+ * we support only one console, the hvc struct is a global var
+ * We set the configuration at this point, since we now have a tty
+ */
+static int console_notifier_add_vio(struct hvc_struct *hp, int data)
+{
+	hp->irq_requested = 1;
+	virtcons_apply_config(virtserial.vdev);
+
+	return 0;
+}
+
+static void console_notifier_del_vio(struct hvc_struct *hp, int data)
+{
+	hp->irq_requested = 0;
+}
+
+
 static void virtio_serial_queue_work_handler(struct work_struct *work)
 {
 	struct scatterlist sg[1];
@@ -410,6 +548,10 @@ static void virtio_serial_rx_work_handler(struct work_struct *work)
 
 		wake_up_interruptible(&port->waitqueue);
 	}
+
+	if (get_id_from_port(port) == VIRTIO_SERIAL_CONSOLE_PORT && hvc_poll(hvc))
+		hvc_kick();
+
 	/* Allocate buffers for all the ones that got used up */
 	schedule_work(&virtserial.queue_work);
 }
@@ -555,6 +697,33 @@ static int virtserial_add_port(u32 port_nr)
 
 	list_add_tail(&port->next, &virtserial.port_head);
 
+	if (port_nr == VIRTIO_SERIAL_CONSOLE_PORT) {
+		/* Start using the new console output. */
+		virtio_cons.get_chars = console_get_chars;
+		virtio_cons.put_chars = console_put_chars;
+		virtio_cons.notifier_add = console_notifier_add_vio;
+		virtio_cons.notifier_del = console_notifier_del_vio;
+		virtio_cons.notifier_hangup = console_notifier_del_vio;
+
+		/* The first argument of hvc_alloc() is the virtual
+		 * console number, so we use zero.  The second
+		 * argument is the parameter for the notification
+		 * mechanism (like irq number). We currently leave
+		 * this as zero, virtqueues have implicit
+		 * notifications.
+		 *
+		 * The third argument is a "struct hv_ops" containing
+		 * the put_chars() get_chars(), notifier_add() and
+		 * notifier_del() pointers.  The final argument is the
+		 * output buffer size: we can do any size, so we put
+		 * PAGE_SIZE here. */
+		hvc = hvc_alloc(0, 0, &virtio_cons, PAGE_SIZE);
+		if (IS_ERR(hvc)) {
+			ret = PTR_ERR(hvc);
+			goto free_cdev;
+		}
+	}
+
 	pr_info("virtio-serial port found at id %u\n", port_nr);
 
 	return 0;
@@ -721,9 +890,13 @@ static struct virtio_device_id id_table[] = {
 	{ 0 },
 };
 
+static unsigned int features[] = {
+	VIRTIO_CONSOLE_F_SIZE,
+};
+
 static struct virtio_driver virtio_serial = {
-  //	.feature_table = virtserial_features,
-  //	.feature_table_size = ARRAY_SIZE(virtserial_features),
+	.feature_table = features,
+	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name =	KBUILD_MODNAME,
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
diff --git a/include/linux/virtio_serial.h b/include/linux/virtio_serial.h
index 26ccd83..1c9f853 100644
--- a/include/linux/virtio_serial.h
+++ b/include/linux/virtio_serial.h
@@ -10,7 +10,16 @@
 
 #define VIRTIO_SERIAL_BAD_ID		(~(u32)0)
 
+/* Feature bits */
+#define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
+
 struct virtio_serial_config {
+	/* first two values come from virtio_console */
+	/* colums of the screens */
+	__u16 cols;
+	/* rows of the screens */
+	__u16 rows;
+
 	__u32 max_nr_ports;
 	__u32 nr_active_ports;
 	__u32 ports_map[0 /* (max_nr_ports + 31) / 32 */];
@@ -22,6 +31,9 @@ struct virtio_serial_control {
 	__u16 value;
 };
 
+/* Predefined ports */
+#define VIRTIO_SERIAL_CONSOLE_PORT 2
+
 /* Some events for the control channel */
 /*   Guest -> Host  range 1..256 */
 #define VIRTIO_SERIAL_GUEST_PORT_OPEN	1
@@ -31,7 +43,7 @@ struct virtio_serial_control {
 
 #ifdef __KERNEL__
 
-/* Guest kernel - Guest userspace interface */
+int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
 
 #endif /* __KERNEL__ */
 #endif /* _LINUX_VIRTIO_SERIAL_H */

		Amit
