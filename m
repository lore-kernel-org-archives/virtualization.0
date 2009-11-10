From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 06/15] virtio_console: Create a buffer pool for sending data
	to host
Date: Tue, 10 Nov 2009 15:11:32 +0530
Message-ID: <1257846101-23258-7-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-3-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-4-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-5-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-6-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-6-git-send-email-amit.shah@redhat.com>
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

The current implementation used to write data to the host
and then wait till the host consumed it.

Also, there was no support to send large chunks of data.

This patch adds support to send big chunks in multiple
buffers of PAGE_SIZE each to the host. It also 'sends
and forgets' the data it sent.

When the host consumes the data and signals to us via
an interrupt, we add the consumed buffer back to our
unconsumed list in a new work handler.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |  147 +++++++++++++++++++++++++++++++++++-----
 1 files changed, 128 insertions(+), 19 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 585ad3c..cc720d3 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -39,11 +39,16 @@ struct virtio_console_struct {
 	 * interrupt
 	 */
 	struct work_struct rx_work;
+	struct work_struct tx_work;
 
 	/* Buffer management */
 	struct list_head unused_read_head;
+	struct list_head unused_write_head;
 	struct list_head readbuf_head;
 
+	/* To protect the list of unused write buffers and the out_vq */
+	spinlock_t write_list_lock;
+
 	/*
 	 * To protect the readbuf_head list. Has to be a spinlock
 	 * because it can be called from interrupt context
@@ -76,34 +81,77 @@ struct virtio_console_port_buffer {
 
 struct virtio_console_struct virtconsole;
 
-/*D:310 The put_chars() callback is pretty straightforward.
+/*D:310
+ * The put_chars() callback is pretty straightforward.
  *
  * We turn the characters into a scatter-gather list, add it to the output
- * queue and then kick the Host.  Then we sit here waiting for it to finish:
- * inefficient in theory, but in practice implementations will do it
- * immediately (lguest's Launcher does). */
-static int put_chars(u32 vtermno, const char *buf, int count)
+ * queue and then kick the Host.
+ *
+ * If the data to be output spans more than a page, it's split into
+ * page-sized buffers and then individual buffers are pushed to the Host.
+ */
+static int put_chars(u32 vtermno, const char *in_buf, int in_count)
 {
 	struct virtqueue *out_vq;
+	struct virtio_console_port_buffer *buf, *buf2;
 	struct scatterlist sg[1];
-	unsigned int len;
+	size_t in_offset, copy_size;
+	ssize_t ret;
 
-	/* This is a convenient routine to initialize a single-elem sg list */
-	sg_init_one(sg, buf, count);
+	if (!in_count)
+		return 0;
 
 	out_vq = virtconsole.out_vq;
-	/* add_buf wants a token to identify this buffer: we hand it any
-	 * non-NULL pointer, since there's only ever one buffer. */
-	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, (void *)1) >= 0) {
-		/* Tell Host to go! */
-		out_vq->vq_ops->kick(out_vq);
-		/* Chill out until it's done with the buffer. */
-		while (!out_vq->vq_ops->get_buf(out_vq, &len))
-			cpu_relax();
+
+	in_offset = 0; /* offset in the user buffer */
+	while (in_count - in_offset) {
+		copy_size = min(in_count - in_offset, PAGE_SIZE);
+
+		spin_lock(&virtconsole.write_list_lock);
+		list_for_each_entry_safe(buf, buf2,
+					 &virtconsole.unused_write_head,
+					 list) {
+			list_del(&buf->list);
+			break;
+		}
+		spin_unlock(&virtconsole.write_list_lock);
+		if (!buf)
+			break;
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
+		spin_lock(&virtconsole.write_list_lock);
+		ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, buf);
+		spin_unlock(&virtconsole.write_list_lock);
+		if (ret < 0) {
+			memset(buf->buf, 0, buf->len);
+			spin_lock(&virtconsole.write_list_lock);
+			list_add_tail(&buf->list,
+				      &virtconsole.unused_write_head);
+			spin_unlock(&virtconsole.write_list_lock);
+			break;
+		}
+		in_offset += buf->len;
+
+		/* No space left in the vq anyway */
+		if (!ret)
+			break;
 	}
+	/* Tell Host to go! */
+	spin_lock(&virtconsole.write_list_lock);
+	out_vq->vq_ops->kick(out_vq);
+	spin_unlock(&virtconsole.write_list_lock);
 
-	/* We're expected to return the amount of data we wrote: all of it. */
-	return count;
+	/* We're expected to return the amount of data we wrote */
+	return in_offset;
 }
 
 /*
@@ -278,6 +326,23 @@ static void fill_receive_queue(struct virtio_console_struct *vcon)
 	fill_queue(vcon->in_vq, PAGE_SIZE, &vcon->unused_read_head);
 }
 
+/*
+ * This function is only called from the init routine so the spinlock
+ * for the unused_write_head list isn't taken
+ */
+static void alloc_write_bufs(struct virtio_console_struct *vcon)
+{
+	struct virtio_console_port_buffer *buf;
+	int i;
+
+	for (i = 0; i < 128; i++) {
+		buf = get_buf(PAGE_SIZE);
+		if (!buf)
+			break;
+		list_add_tail(&buf->list, &vcon->unused_write_head);
+	}
+}
+
 static void virtio_console_rx_work_handler(struct work_struct *work)
 {
 	struct virtio_console_struct *vcon;
@@ -306,11 +371,50 @@ static void virtio_console_rx_work_handler(struct work_struct *work)
 	fill_receive_queue(&virtconsole);
 }
 
+/*
+ * This is the workhandler for buffers that get received on the output
+ * virtqueue, which is an indication that Host consumed the data we
+ * sent it. Since all our buffers going out are of a fixed size we can
+ * just reuse them instead of freeing them and allocating new ones.
+ *
+ * Zero out the buffer so that we don't leak any information from
+ * other processes. There's a small optimisation here as well: the
+ * buffers are PAGE_SIZE-sized; but instead of zeroing the entire
+ * page, we just zero the length that was most recently used and we
+ * can be sure the rest of the page is already set to 0s.
+ *
+ * So once we zero them out we add them back to the unused buffers
+ * list
+ */
+static void virtio_console_tx_work_handler(struct work_struct *work)
+{
+	struct virtio_console_struct *vcon;
+	struct virtqueue *vq;
+	struct virtio_console_port_buffer *buf;
+	unsigned int tmplen;
+
+	vcon = container_of(work, struct virtio_console_struct, tx_work);
+
+	vq = vcon->out_vq;
+	spin_lock(&vcon->write_list_lock);
+	while ((buf = vq->vq_ops->get_buf(vq, &tmplen))) {
+		/* 0 the buffer to not leak data from other processes */
+		memset(buf->buf, 0, buf->len);
+		list_add_tail(&buf->list, &vcon->unused_write_head);
+	}
+	spin_unlock(&vcon->write_list_lock);
+}
+
 static void rx_intr(struct virtqueue *vq)
 {
 	schedule_work(&virtconsole.rx_work);
 }
 
+static void tx_intr(struct virtqueue *vq)
+{
+	schedule_work(&virtconsole.tx_work);
+}
+
 /*D:370 Once we're further in boot, we get probed like any other virtio device.
  * At this stage we set up the output virtqueue.
  *
@@ -320,7 +424,7 @@ static void rx_intr(struct virtqueue *vq)
  * Finally we put our input buffer in the input queue, ready to receive. */
 static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *callbacks[] = { rx_intr, NULL};
+	vq_callback_t *callbacks[] = { rx_intr, tx_intr };
 	const char *names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
 	int err;
@@ -350,12 +454,17 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	virtio_cons.put_chars = put_chars;
 
 	spin_lock_init(&virtconsole.readbuf_list_lock);
+	spin_lock_init(&virtconsole.write_list_lock);
+
 	INIT_LIST_HEAD(&virtconsole.readbuf_head);
 	INIT_LIST_HEAD(&virtconsole.unused_read_head);
+	INIT_LIST_HEAD(&virtconsole.unused_write_head);
 
 	INIT_WORK(&virtconsole.rx_work, &virtio_console_rx_work_handler);
+	INIT_WORK(&virtconsole.tx_work, &virtio_console_tx_work_handler);
 
 	fill_receive_queue(&virtconsole);
+	alloc_write_bufs(&virtconsole);
 
 	/* The first argument of hvc_alloc() is the virtual console number, so
 	 * we use zero.  The second argument is the parameter for the
-- 
1.6.2.5
