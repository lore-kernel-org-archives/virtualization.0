From: Amit Shah <amit.shah@redhat.com>
Subject: virtio: console: Return -EFAULT on copy_xx_user errors,
	allow larger writes
Date: Fri, 29 Jan 2010 19:12:37 +0530
Message-ID: <1264772563-25517-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hey Rusty,

These updated patches in the series return -EFAULT on copy_xx_user
errors and also move the copy_from_user into fops_write() instead of it
being in send_buf. This enables send_buf to just read from kernel
buffers, making it simpler.

This also allows write()s to write more to the host in one go,
removingthe 4k limitation. I do limit the writes to 32k at once to not
put too much pressure on the GFP_KERNEL area.

Both of these were pointed out by Marcelo.

I'm including the relative diff between the version that's in linux-next
and the new version below.

Please apply,
Thanks.
		Amit.


diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index b923b5c..2c2de35 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -162,9 +162,6 @@ struct port {
 	 */
 	spinlock_t inbuf_lock;
 
-	/* Buffer that's used to pass data from the guest to the host */
-	struct port_buffer *outbuf;
-
 	/* The IO vqs for this port */
 	struct virtqueue *in_vq, *out_vq;
 
@@ -399,43 +396,23 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 	return 0;
 }
 
-static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
-			bool from_user)
+static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count)
 {
 	struct scatterlist sg[1];
 	struct virtqueue *out_vq;
-	struct port_buffer *buf;
 	ssize_t ret;
-	unsigned int tmplen;
+	unsigned int len;
 
 	out_vq = port->out_vq;
-	buf = port->outbuf;
 
-	if (in_count > buf->size)
-		in_count = buf->size;
-
-	if (from_user) {
-		ret = copy_from_user(buf->buf, in_buf, in_count);
-	} else {
-		/*
-		 * Since we're not sure when the host will actually
-		 * consume the data and tell us about it, we have to
-		 * copy the data here in case the caller frees the
-		 * in_buf.
-		 */
-		memcpy(buf->buf, in_buf, in_count);
-		ret = 0; /* Emulate copy_from_user behaviour */
-	}
-	buf->len = in_count - ret;
-
-	sg_init_one(sg, buf->buf, buf->len);
-	ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, buf);
+	sg_init_one(sg, in_buf, in_count);
+	ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, in_buf);
 
 	/* Tell Host to go! */
 	out_vq->vq_ops->kick(out_vq);
 
 	if (ret < 0) {
-		buf->len = 0;
+		len = 0;
 		goto fail;
 	}
 
@@ -444,13 +421,11 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 	 * sent. Also ensure we return to userspace the number of
 	 * bytes that were successfully consumed by the host.
 	 */
-	while (!out_vq->vq_ops->get_buf(out_vq, &tmplen))
+	while (!out_vq->vq_ops->get_buf(out_vq, &len))
 		cpu_relax();
-
-	buf->len = tmplen;
 fail:
 	/* We're expected to return the amount of data we wrote */
-	return buf->len;
+	return len;
 }
 
 /*
@@ -461,26 +436,25 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 			    bool to_user)
 {
 	struct port_buffer *buf;
-	ssize_t ret;
 	unsigned long flags;
 
 	if (!out_count || !port_has_data(port))
 		return 0;
 
 	buf = port->inbuf;
-	if (out_count > buf->len - buf->offset)
-		out_count = buf->len - buf->offset;
+	out_count = min(out_count, buf->len - buf->offset);
 
 	if (to_user) {
+		ssize_t ret;
+
 		ret = copy_to_user(out_buf, buf->buf + buf->offset, out_count);
+		if (ret)
+			return -EFAULT;
 	} else {
 		memcpy(out_buf, buf->buf + buf->offset, out_count);
-		ret = 0; /* Emulate copy_to_user behaviour */
 	}
 
-	/* Return the number of bytes actually copied */
-	ret = out_count - ret;
-	buf->offset += ret;
+	buf->offset += out_count;
 
 	if (buf->offset == buf->len) {
 		/*
@@ -495,7 +469,8 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 
 		spin_unlock_irqrestore(&port->inbuf_lock, flags);
 	}
-	return ret;
+	/* Return the number of bytes actually copied */
+	return out_count;
 }
 
 /* The condition that must be true for polling to end */
@@ -548,10 +523,27 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 			       size_t count, loff_t *offp)
 {
 	struct port *port;
+	char *buf;
+	ssize_t ret;
 
 	port = filp->private_data;
 
-	return send_buf(port, ubuf, count, true);
+	count = min((size_t)(32 * 1024), count);
+
+	buf = kmalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = copy_from_user(buf, ubuf, count);
+	if (ret) {
+		ret = -EFAULT;
+		goto free_buf;
+	}
+
+	ret = send_buf(port, buf, count);
+free_buf:
+	kfree(buf);
+	return ret;
 }
 
 static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
@@ -657,7 +649,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
 
-	return send_buf(port, buf, count, false);
+	return send_buf(port, (void *)buf, count);
 }
 
 /*
@@ -874,7 +866,6 @@ static int remove_port(struct port *port)
 	cdev_del(&port->cdev);
 
 	discard_port_data(port);
-	free_buf(port->outbuf);
 	kfree(port->name);
 
 	debugfs_remove(port->debugfs_file);
@@ -1143,11 +1134,6 @@ static int add_port(struct ports_device *portdev, u32 id)
 		err = -ENOMEM;
 		goto free_device;
 	}
-	port->outbuf = alloc_buf(PAGE_SIZE);
-	if (!port->outbuf) {
-		err = -ENOMEM;
-		goto free_inbuf;
-	}
 
 	/* Register the input buffer the first time. */
 	add_inbuf(port->in_vq, inbuf);
@@ -1158,7 +1144,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	if (!use_multiport(port->portdev)) {
 		err = init_port_console(port);
 		if (err)
-			goto free_outbuf;
+			goto free_inbuf;
 	}
 
 	spin_lock_irq(&portdev->ports_lock);
@@ -1186,8 +1172,6 @@ static int add_port(struct ports_device *portdev, u32 id)
 	}
 	return 0;
 
-free_outbuf:
-	free_buf(port->outbuf);
 free_inbuf:
 	free_buf(inbuf);
 free_device:
