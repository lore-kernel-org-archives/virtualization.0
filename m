From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 18/31] virtio: console: Buffer data that comes from the host
Date: Tue, 22 Dec 2009 20:04:28 +0530
Message-ID: <1261492481-19817-19-git-send-email-amit.shah@redhat.com>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-2-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-3-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-5-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-6-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-7-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-8-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-9-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-10-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-11-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-12-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-13-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-14-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-15-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-16-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-17-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-18-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-18-git-send-email-amit.shah@redhat.com>
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

The console could be flooded with data from the host; handle this
situation by buffering the data.

We use the virtio queue ring to maintain our buffer. This buffer length
is set by the host while initializing the queue.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |  172 +++++++++++++++++++++++++++++++----------
 1 files changed, 131 insertions(+), 41 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e4b6a37..2ab15a5 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -100,6 +100,13 @@ struct port {
 	/* The current buffer from which data has to be fed to readers */
 	struct port_buffer *inbuf;
 
+	/*
+	 * To protect the operations on the in_vq associated with this
+	 * port.  Has to be a spinlock because it can be called from
+	 * interrupt context (get_char()).
+	 */
+	spinlock_t inbuf_lock;
+
 	/* The IO vqs for this port */
 	struct virtqueue *in_vq, *out_vq;
 
@@ -132,6 +139,25 @@ out:
 	return port;
 }
 
+static struct port *find_port_by_vq(struct ports_device *portdev,
+				    struct virtqueue *vq)
+{
+	struct port *port;
+	struct console *cons;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pdrvdata_lock, flags);
+	list_for_each_entry(cons, &pdrvdata.consoles, list) {
+		port = container_of(cons, struct port, cons);
+		if (port->in_vq == vq || port->out_vq == vq)
+			goto out;
+	}
+	port = NULL;
+out:
+	spin_unlock_irqrestore(&pdrvdata_lock, flags);
+	return port;
+}
+
 static void free_buf(struct port_buffer *buf)
 {
 	kfree(buf->buf);
@@ -181,15 +207,75 @@ static void *get_inbuf(struct port *port)
  *
  * Callers should take appropriate locks.
  */
-static void add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
+static int add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
 {
 	struct scatterlist sg[1];
+	int ret;
 
 	sg_init_one(sg, buf->buf, buf->size);
 
-	if (vq->vq_ops->add_buf(vq, sg, 0, 1, buf) < 0)
-		BUG();
+	ret = vq->vq_ops->add_buf(vq, sg, 0, 1, buf);
 	vq->vq_ops->kick(vq);
+	return ret;
+}
+
+static bool port_has_data(struct port *port)
+{
+	unsigned long flags;
+	bool ret;
+
+	spin_lock_irqsave(&port->inbuf_lock, flags);
+	if (port->inbuf) {
+		ret = true;
+		goto out;
+	}
+	port->inbuf = get_inbuf(port);
+	if (port->inbuf) {
+		ret = true;
+		goto out;
+	}
+	ret = false;
+out:
+	spin_unlock_irqrestore(&port->inbuf_lock, flags);
+	return ret;
+}
+
+/*
+ * Give out the data that's requested from the buffers that we have
+ * queued up.
+ */
+static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
+{
+	struct port_buffer *buf;
+	ssize_t out_offset, ret;
+	unsigned long flags;
+
+	out_offset = 0;
+	while (out_count && port_has_data(port)) {
+		size_t copy_size;
+
+		buf = port->inbuf;
+		copy_size = out_count;
+		if (copy_size > buf->len - buf->offset)
+			copy_size = buf->len - buf->offset;
+
+		memcpy(out_buf + out_offset, buf->buf + buf->offset, copy_size);
+
+		ret = copy_size;
+		buf->offset += ret;
+		out_offset += ret;
+		out_count -= ret;
+
+		if (buf->offset == buf->len) {
+			spin_lock_irqsave(&port->inbuf_lock, flags);
+			port->inbuf = NULL;
+
+			if (add_inbuf(port->in_vq, buf) < 0)
+				free_buf(buf);
+			spin_unlock_irqrestore(&port->inbuf_lock, flags);
+		}
+	}
+	return out_offset;
 }
 
 /*
@@ -234,9 +320,8 @@ static int put_chars(u32 vtermno, const char *buf, int count)
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
@@ -249,25 +334,7 @@ static int get_chars(u32 vtermno, char *buf, int count)
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
 
-	/* No more in buffer?  See if they've (re)used it. */
-	if (port->inbuf->offset == port->inbuf->len) {
-		if (!get_inbuf(port))
-			return 0;
-	}
-
-	/* You want more than we have to give?  Well, try wanting less! */
-	if (port->inbuf->offset + count > port->inbuf->len)
-		count = port->inbuf->len - port->inbuf->offset;
-
-	/* Copy across to their buffer and increment offset. */
-	memcpy(buf, port->inbuf->buf + port->inbuf->offset, count);
-	port->inbuf->offset += count;
-
-	/* Finished?  Re-register buffer so Host will use it again. */
-	if (port->inbuf->offset == port->inbuf->len)
-		add_inbuf(port->in_vq, port->inbuf);
-
-	return count;
+	return fill_readbuf(port, buf, count);
 }
 
 static void resize_console(struct port *port)
@@ -314,13 +381,19 @@ static void notifier_del_vio(struct hvc_struct *hp, int data)
 
 static void hvc_handle_input(struct virtqueue *vq)
 {
-	struct console *cons;
-	bool activity = false;
+	struct port *port;
+	unsigned long flags;
 
-	list_for_each_entry(cons, &pdrvdata.consoles, list)
-		activity |= hvc_poll(cons->hvc);
+	port = find_port_by_vq(vq->vdev->priv, vq);
+	if (!port)
+		return;
+
+	spin_lock_irqsave(&port->inbuf_lock, flags);
+	if (!port->inbuf)
+		port->inbuf = get_inbuf(port);
+	spin_unlock_irqrestore(&port->inbuf_lock, flags);
 
-	if (activity)
+	if (hvc_poll(port->cons.hvc))
 		hvc_kick();
 }
 
@@ -385,6 +458,27 @@ int __devinit init_port_console(struct port *port)
 	return 0;
 }
 
+static void fill_queue(struct virtqueue *vq, spinlock_t *lock)
+{
+	struct port_buffer *buf;
+	int ret;
+
+	do {
+		buf = alloc_buf(PAGE_SIZE);
+		if (!buf)
+			break;
+
+		spin_lock_irq(lock);
+		ret = add_inbuf(vq, buf);
+		if (ret < 0) {
+			spin_unlock_irq(lock);
+			free_buf(buf);
+			break;
+		}
+		spin_unlock_irq(lock);
+	} while (ret > 0);
+}
+
 static int __devinit add_port(struct ports_device *portdev)
 {
 	struct port *port;
@@ -397,26 +491,22 @@ static int __devinit add_port(struct ports_device *portdev)
 	}
 
 	port->portdev = portdev;
+
+	port->inbuf = NULL;
+
 	port->in_vq = portdev->in_vqs[0];
 	port->out_vq = portdev->out_vqs[0];
 
-	port->inbuf = alloc_buf(PAGE_SIZE);
-	if (!port->inbuf) {
-		err = -ENOMEM;
-		goto free_port;
-	}
+	spin_lock_init(&port->inbuf_lock);
+
+	fill_queue(port->in_vq, &port->inbuf_lock);
 
 	err = init_port_console(port);
 	if (err)
-		goto free_inbuf;
-
-	/* Register the input buffer the first time. */
-	add_inbuf(port->in_vq, port->inbuf);
+		goto free_port;
 
 	return 0;
 
-free_inbuf:
-	free_buf(port->inbuf);
 free_port:
 	kfree(port);
 fail:
-- 
1.6.2.5
