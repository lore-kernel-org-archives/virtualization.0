From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 12/28] virtio: console: Buffer data that comes in from the host
Date: Sat, 28 Nov 2009 12:20:35 +0530
Message-ID: <1259391051-7752-13-git-send-email-amit.shah@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-12-git-send-email-amit.shah@redhat.com>
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

The console could be flooded with data from the host; handle
this situation by buffering the data.

We move from the per-port inbuf to a per-device queue of buffers,
shared by all the ports for that device, ready to receive host data.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |  219 +++++++++++++++++++++++++++++++----------
 1 files changed, 168 insertions(+), 51 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a80d15c..e8dabae 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -65,6 +65,23 @@ struct ports_device {
 	 * interrupt
 	 */
 	struct work_struct rx_work;
+
+	struct list_head unused_read_head;
+
+	/* To protect the list of unused read buffers and the in_vq */
+	spinlock_t read_list_lock;
+};
+
+/* This struct holds individual buffers received for each port */
+struct port_buffer {
+	struct list_head list;
+
+	char *buf;
+
+	/* length of the buffer */
+	size_t len;
+	/* offset in the buf from which to consume data */
+	size_t offset;
 };
 
 /* This struct holds the per-port data */
@@ -72,9 +89,15 @@ struct port {
 	/* Pointer to the parent virtio_console device */
 	struct ports_device *portdev;
 
-	/* This is our input buffer, and how much data is left in it. */
-	char *inbuf;
-	unsigned int used_len, offset;
+	/* Buffer management */
+	struct list_head readbuf_head;
+
+	/*
+	 * To protect the readbuf_head list.  Has to be a spinlock
+	 * because it can be called from interrupt context
+	 * (get_char())
+	 */
+	spinlock_t readbuf_list_lock;
 
 	/* For console ports, hvc != NULL and these are valid. */
 	/* The hvc device */
@@ -145,67 +168,71 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 }
 
 /*
- * Create a scatter-gather list representing our input buffer and put
- * it in the queue.
+ * Give out the data that's requested from the buffers that we have
+ * queued up.
  */
-static void add_inbuf(struct port *port)
+static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
 {
-	struct virtqueue *in_vq;
-	struct scatterlist sg[1];
-
-	sg_init_one(sg, port->inbuf, PAGE_SIZE);
+	struct port_buffer *buf, *buf2;
+	ssize_t out_offset, ret;
+	unsigned long flags;
 
-	in_vq = port->portdev->in_vq;
-	/* Should always be able to add one buffer to an empty queue. */
-	if (in_vq->vq_ops->add_buf(in_vq, sg, 0, 1, port) < 0)
-		BUG();
-	in_vq->vq_ops->kick(in_vq);
+	out_offset = 0;
+	/*
+	 * Not taking the port->readbuf_list_lock here relying on the
+	 * fact that buffers are taken out from the list only in this
+	 * function so buf2 should be available all the time.
+	 */
+	list_for_each_entry_safe(buf, buf2, &port->readbuf_head, list) {
+		size_t copy_size;
+
+		copy_size = out_count;
+		if (copy_size > buf->len - buf->offset)
+			copy_size = buf->len - buf->offset;
+
+		memcpy(out_buf + out_offset, buf->buf + buf->offset, copy_size);
+
+		/* Return the number of bytes actually copied */
+		ret = copy_size;
+		buf->offset += ret;
+		out_offset += ret;
+		out_count -= ret;
+
+		if (buf->len - buf->offset == 0) {
+			spin_lock_irqsave(&port->readbuf_list_lock, flags);
+			list_del(&buf->list);
+			spin_unlock_irqrestore(&port->readbuf_list_lock, flags);
+			kfree(buf->buf);
+			kfree(buf);
+		}
+		if (!out_count)
+			break;
+	}
+	return out_offset;
 }
 
 /*
  * get_chars() is the callback from the hvc_console infrastructure
  * when an interrupt is received.
  *
- * Most of the code deals with the fact that the hvc_console()
- * infrastructure only asks us for 16 bytes at a time.  We keep
- * in_offset and in_used fields for partially-filled buffers.
+ * We call out to fill_readbuf that gets us the required data from the
+ * buffers that are queued up.
  */
 static int get_chars(u32 vtermno, char *buf, int count)
 {
 	struct port *port;
-	struct virtqueue *in_vq;
 
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
 		return 0;
 
-	in_vq = port->portdev->in_vq;
 	/* If we don't have an input queue yet, we can't get input. */
-	BUG_ON(!in_vq);
-
-	/* No more in buffer?  See if they've (re)used it. */
-	if (port->offset == port->used_len) {
-		unsigned int len;
-
-		if (!in_vq->vq_ops->get_buf(in_vq, &len))
-			return 0;
-		port->used_len = len;
-		port->offset = 0;
-	}
-
-	/* You want more than we have to give?  Well, try wanting less! */
-	if (port->offset + count > port->used_len)
-		count = port->used_len - port->offset;
+	BUG_ON(!port->portdev->in_vq);
 
-	/* Copy across to their buffer and increment offset. */
-	memcpy(buf, port->inbuf + port->offset, count);
-	port->offset += count;
-
-	/* Finished?  Re-register buffer so Host will use it again. */
-	if (port->offset == port->used_len)
-		add_inbuf(port);
+	if (list_empty(&port->readbuf_head))
+		return 0;
 
-	return count;
+	return fill_readbuf(port, buf, count);
 }
 
 static void resize_console(struct port *port)
@@ -274,16 +301,103 @@ int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
 	return hvc_instantiate(0, 0, &hv_ops);
 }
 
+static struct port_buffer *get_buf(size_t buf_size)
+{
+	struct port_buffer *buf;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		goto out;
+	buf->buf = kzalloc(buf_size, GFP_KERNEL);
+	if (!buf->buf) {
+		kfree(buf);
+		goto out;
+	}
+	buf->len = buf_size;
+out:
+	return buf;
+}
+
+static void fill_receive_queue(struct ports_device *portdev)
+{
+	struct scatterlist sg[1];
+	struct port_buffer *buf;
+	struct virtqueue *vq;
+	int buf_size, ret;
+
+	vq = portdev->in_vq;
+	buf_size = PAGE_SIZE;
+	do {
+		buf = get_buf(buf_size);
+		if (!buf)
+			break;
+		sg_init_one(sg, buf->buf, buf_size);
+
+		spin_lock(&portdev->read_list_lock);
+		ret = vq->vq_ops->add_buf(vq, sg, 0, 1, buf);
+		if (ret < 0) {
+			spin_unlock(&portdev->read_list_lock);
+			kfree(buf->buf);
+			kfree(buf);
+			break;
+		}
+		/*
+		 * We have to keep track of the unused buffers so that
+		 * they can be freed when the module is being removed
+		 */
+		list_add_tail(&buf->list, &portdev->unused_read_head);
+		spin_unlock(&portdev->read_list_lock);
+	} while (ret > 0);
+
+	spin_lock(&portdev->read_list_lock);
+	vq->vq_ops->kick(vq);
+	spin_unlock(&portdev->read_list_lock);
+}
+
+static void *get_incoming_buf(struct ports_device *portdev,
+			      unsigned int *len)
+{
+	struct port_buffer *buf;
+	struct virtqueue *vq;
+
+	vq = portdev->in_vq;
+
+	spin_lock(&portdev->read_list_lock);
+	buf = vq->vq_ops->get_buf(vq, len);
+	if (buf) {
+		/* The buffer is no longer unused */
+		list_del(&buf->list);
+	}
+	spin_unlock(&portdev->read_list_lock);
+	return buf;
+}
+
 static void rx_work_handler(struct work_struct *work)
 {
+	struct ports_device *portdev;
 	struct port *port;
+	struct port_buffer *buf;
+	unsigned int tmplen;
 	bool activity = false;
 
-	list_for_each_entry(port, &pdrvdata.consoles, list)
-		activity |= hvc_poll(port->hvc);
+	portdev = container_of(work, struct ports_device, rx_work);
+
+	/* We currently have only one port */
+	port = find_port_by_vtermno(0);
+	while ((buf = get_incoming_buf(portdev, &tmplen))) {
+		buf->len = tmplen;
+		buf->offset = 0;
+
+		spin_lock_irq(&port->readbuf_list_lock);
+		list_add_tail(&buf->list, &port->readbuf_head);
+		spin_unlock_irq(&port->readbuf_list_lock);
 
+		activity |= hvc_poll(port->hvc);
+	}
 	if (activity)
 		hvc_kick();
+
+	fill_receive_queue(portdev);
 }
 
 static void rx_intr(struct virtqueue *vq)
@@ -305,9 +419,6 @@ static int __devinit add_port(struct ports_device *portdev)
 		goto fail;
 
 	port->portdev = portdev;
-	port->inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!port->inbuf)
-		goto free;
 
 	/*
 	 * The first argument of hvc_alloc() is the virtual console
@@ -327,15 +438,15 @@ static int __devinit add_port(struct ports_device *portdev)
 		goto free;
 	}
 
+	spin_lock_init(&port->readbuf_list_lock);
+	INIT_LIST_HEAD(&port->readbuf_head);
+
 	/* Add to vtermno list. */
 	spin_lock_irq(&pdrvdata_lock);
 	pdrvdata.next_vtermno++;
 	list_add(&port->list, &pdrvdata.consoles);
 	spin_unlock_irq(&pdrvdata_lock);
 
-	/* Register the input buffer the first time. */
-	add_inbuf(port);
-
 	return 0;
 free:
 	kfree(port);
@@ -372,8 +483,14 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	portdev->in_vq = vqs[0];
 	portdev->out_vq = vqs[1];
 
+	spin_lock_init(&portdev->read_list_lock);
+
+	INIT_LIST_HEAD(&portdev->unused_read_head);
+
 	INIT_WORK(&portdev->rx_work, &rx_work_handler);
 
+	fill_receive_queue(portdev);
+
 	/* We only have one port. */
 	err = add_port(portdev);
 	if (err)
-- 
1.6.2.5
