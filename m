From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 13/28] virtio: console: Create a buffer pool for sending data
	to host
Date: Sat, 28 Nov 2009 12:20:36 +0530
Message-ID: <1259391051-7752-14-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-3-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-4-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-5-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-6-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-9-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-10-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-11-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-12-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-13-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-13-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The old way of sending data to the host was to populate one buffer and
then wait till the host consumed it before sending the next chunk of
data.

Also, there was no support to send large chunks of data.

We now maintain a per-device list of buffers that are ready to be
passed on to the host.

This patch adds support to send big chunks in multiple buffers of
PAGE_SIZE each to the host.

When the host consumes the data and signals to us via an interrupt, we
add the consumed buffer back to our unconsumed list.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |  159 +++++++++++++++++++++++++++++++++-------
 1 files changed, 131 insertions(+), 28 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e8dabae..3111e4c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -67,9 +67,13 @@ struct ports_device {
 	struct work_struct rx_work;
 
 	struct list_head unused_read_head;
+	struct list_head unused_write_head;
 
 	/* To protect the list of unused read buffers and the in_vq */
 	spinlock_t read_list_lock;
+
+	/* To protect the list of unused write buffers and the out_vq */
+	spinlock_t write_list_lock;
 };
 
 /* This struct holds individual buffers received for each port */
@@ -129,42 +133,64 @@ out:
 	return port;
 }
 
-/*
- * The put_chars() callback is pretty straightforward.
- *
- * We turn the characters into a scatter-gather list, add it to the
- * output queue and then kick the Host.  Then we sit here waiting for
- * it to finish: inefficient in theory, but in practice
- * implementations will do it immediately (lguest's Launcher does).
- */
-static int put_chars(u32 vtermno, const char *buf, int count)
+static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
 {
 	struct scatterlist sg[1];
-	struct port *port;
 	struct virtqueue *out_vq;
-	unsigned int len;
+	struct port_buffer *buf;
+	size_t in_offset, copy_size;
+	ssize_t ret;
+	unsigned long irqf;
 
-	port = find_port_by_vtermno(vtermno);
-	if (!port)
+	if (!in_count)
 		return 0;
 
-	if (unlikely(early_put_chars))
-		return early_put_chars(vtermno, buf, count);
-
 	out_vq = port->portdev->out_vq;
-	/* This is a convenient routine to initialize a single-elem sg list */
-	sg_init_one(sg, buf, count);
-
-	/* This shouldn't fail: if it does, we lose chars. */
-	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, port) >= 0) {
-		/* Tell Host to go! */
-		out_vq->vq_ops->kick(out_vq);
-		while (!out_vq->vq_ops->get_buf(out_vq, &len))
-			cpu_relax();
+
+	in_offset = 0; /* offset in the user buffer */
+	spin_lock_irqsave(&port->portdev->write_list_lock, irqf);
+	while (in_count - in_offset) {
+		copy_size = min(in_count - in_offset, PAGE_SIZE);
+
+		if (list_empty(&port->portdev->unused_write_head))
+			break;
+
+		buf = list_first_entry(&port->portdev->unused_write_head,
+				       struct port_buffer, list);
+		list_del(&buf->list);
+		spin_unlock_irqrestore(&port->portdev->write_list_lock, irqf);
+
+		/*
+		 * Since we're not sure when the host will actually
+		 * consume the data and tell us about it, we have
+		 * to copy the data here in case the caller
+		 * frees the in_buf
+		 */
+		memcpy(buf->buf, in_buf + in_offset, copy_size);
+
+		buf->len = copy_size;
+		sg_init_one(sg, buf->buf, buf->len);
+
+		spin_lock_irqsave(&port->portdev->write_list_lock, irqf);
+		ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, buf);
+		if (ret < 0) {
+			memset(buf->buf, 0, buf->len);
+			list_add_tail(&buf->list,
+				      &port->portdev->unused_write_head);
+			break;
+		}
+		in_offset += buf->len;
+
+		/* No space left in the vq anyway */
+		if (!ret)
+			break;
 	}
+	/* Tell Host to go! */
+	out_vq->vq_ops->kick(out_vq);
+	spin_unlock_irqrestore(&port->portdev->write_list_lock, irqf);
 
-	/* We're expected to return the amount of data we wrote: all of it. */
-	return count;
+	/* We're expected to return the amount of data we wrote */
+	return in_offset;
 }
 
 /*
@@ -212,6 +238,29 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
 }
 
 /*
+ * The put_chars() callback is pretty straightforward.
+ *
+ * We turn the characters into a scatter-gather list, add it to the output
+ * queue and then kick the Host.
+ *
+ * If the data to be output spans more than a page, it's split into
+ * page-sized buffers and then individual buffers are pushed to the Host.
+ */
+static int put_chars(u32 vtermno, const char *buf, int count)
+{
+	struct port *port;
+
+	port = find_port_by_vtermno(vtermno);
+	if (!port)
+		return 0;
+
+	if (unlikely(early_put_chars))
+		return early_put_chars(vtermno, buf, count);
+
+	return send_buf(port, buf, count);
+}
+
+/*
  * get_chars() is the callback from the hvc_console infrastructure
  * when an interrupt is received.
  *
@@ -318,6 +367,23 @@ out:
 	return buf;
 }
 
+/*
+ * This function is only called from the init routine so the spinlock
+ * for the unused_write_head list isn't taken
+ */
+static void alloc_write_bufs(struct ports_device *portdev)
+{
+	struct port_buffer *buf;
+	int i;
+
+	for (i = 0; i < 30; i++) {
+		buf = get_buf(PAGE_SIZE);
+		if (!buf)
+			break;
+		list_add_tail(&buf->list, &portdev->unused_write_head);
+	}
+}
+
 static void fill_receive_queue(struct ports_device *portdev)
 {
 	struct scatterlist sg[1];
@@ -408,6 +474,40 @@ static void rx_intr(struct virtqueue *vq)
 	schedule_work(&portdev->rx_work);
 }
 
+/*
+ * This is the interrupt handler for buffers that get received on the
+ * output virtqueue, which is an indication that Host consumed the
+ * data we sent it.  Since all our buffers going out are of a fixed
+ * size we can just reuse them instead of freeing them and allocating
+ * new ones.
+ *
+ * Zero out the buffer so that we don't leak any information from
+ * other processes.  There's a small optimisation here as well: the
+ * buffers are PAGE_SIZE-sized; but instead of zeroing the entire
+ * page, we just zero the length that was most recently used and we
+ * can be sure the rest of the page is already set to 0s.
+ *
+ * So once we zero them out we add them back to the unused buffers
+ * list.
+ */
+static void tx_intr(struct virtqueue *vq)
+{
+	struct ports_device *portdev;
+	struct port_buffer *buf;
+	unsigned long flags;
+	unsigned int tmplen;
+
+	portdev = vq->vdev->priv;
+
+	spin_lock_irqsave(&portdev->write_list_lock, flags);
+	while ((buf = vq->vq_ops->get_buf(vq, &tmplen))) {
+		/* 0 the buffer to not leak data from other processes */
+		memset(buf->buf, 0, buf->len);
+		list_add_tail(&buf->list, &portdev->unused_write_head);
+	}
+	spin_unlock_irqrestore(&portdev->write_list_lock, flags);
+}
+
 static int __devinit add_port(struct ports_device *portdev)
 {
 	struct port *port;
@@ -460,7 +560,7 @@ fail:
  */
 static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *callbacks[] = { rx_intr, NULL};
+	vq_callback_t *callbacks[] = { rx_intr, tx_intr };
 	const char *names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
 	struct ports_device *portdev;
@@ -484,12 +584,15 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	portdev->out_vq = vqs[1];
 
 	spin_lock_init(&portdev->read_list_lock);
+	spin_lock_init(&portdev->write_list_lock);
 
 	INIT_LIST_HEAD(&portdev->unused_read_head);
+	INIT_LIST_HEAD(&portdev->unused_write_head);
 
 	INIT_WORK(&portdev->rx_work, &rx_work_handler);
 
 	fill_receive_queue(portdev);
+	alloc_write_bufs(portdev);
 
 	/* We only have one port. */
 	err = add_port(portdev);
-- 
1.6.2.5
