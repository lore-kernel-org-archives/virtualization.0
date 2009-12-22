From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 19/31] virtio: console: Introduce a send_buf function for a
	common path for sending data to host
Date: Tue, 22 Dec 2009 20:04:29 +0530
Message-ID: <1261492481-19817-20-git-send-email-amit.shah@redhat.com>
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
	<1261492481-19817-19-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-19-git-send-email-amit.shah@redhat.com>
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

Adding support for generic ports that will write to userspace will need
some code changes.

Consolidate the write routine into send_buf() and put_chars() now just
calls into the new function.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   70 +++++++++++++++++++++++++++++++----------
 1 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2ab15a5..6509e62 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -107,6 +107,9 @@ struct port {
 	 */
 	spinlock_t inbuf_lock;
 
+	/* Buffer that's used to pass data from the guest to the host */
+	struct port_buffer *outbuf;
+
 	/* The IO vqs for this port */
 	struct virtqueue *in_vq, *out_vq;
 
@@ -240,6 +243,49 @@ out:
 	return ret;
 }
 
+static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
+{
+	struct scatterlist sg[1];
+	struct virtqueue *out_vq;
+	struct port_buffer *buf;
+	size_t in_offset, copy_size;
+	ssize_t ret;
+	unsigned int tmplen;
+
+	out_vq = port->out_vq;
+	buf = port->outbuf;
+
+	in_offset = 0; /* offset in the user buffer */
+	while (in_offset < in_count) {
+		copy_size = min(in_count - in_offset, buf->size);
+		/*
+		 * Since we're not sure when the host will actually
+		 * consume the data and tell us about it, we have
+		 * to copy the data here in case the caller
+		 * frees the in_buf
+		 */
+		memcpy(buf->buf, in_buf + in_offset, copy_size);
+
+		buf->len = copy_size;
+
+		sg_init_one(sg, buf->buf, buf->len);
+		ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, buf);
+
+		/* Tell Host to go! */
+		out_vq->vq_ops->kick(out_vq);
+
+		if (ret < 0)
+			break;
+
+		in_offset += buf->len;
+		while (!out_vq->vq_ops->get_buf(out_vq, &tmplen))
+			cpu_relax();
+	}
+
+	/* We're expected to return the amount of data we wrote */
+	return in_offset;
+}
+
 /*
  * Give out the data that's requested from the buffers that we have
  * queued up.
@@ -288,10 +334,7 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
  */
 static int put_chars(u32 vtermno, const char *buf, int count)
 {
-	struct scatterlist sg[1];
 	struct port *port;
-	struct virtqueue *out_vq;
-	unsigned int len;
 
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
@@ -300,20 +343,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
 
-	out_vq = port->out_vq;
-	/* This is a convenient routine to initialize a single-elem sg list */
-	sg_init_one(sg, buf, count);
-
-	/* This shouldn't fail: if it does, we lose chars. */
-	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, port) >= 0) {
-		/* Tell Host to go! */
-		out_vq->vq_ops->kick(out_vq);
-		while (!out_vq->vq_ops->get_buf(out_vq, &len))
-			cpu_relax();
-	}
-
-	/* We're expected to return the amount of data we wrote: all of it. */
-	return count;
+	return send_buf(port, buf, count);
 }
 
 /*
@@ -501,6 +531,12 @@ static int __devinit add_port(struct ports_device *portdev)
 
 	fill_queue(port->in_vq, &port->inbuf_lock);
 
+	port->outbuf = alloc_buf(PAGE_SIZE);
+	if (!port->outbuf) {
+		err = -ENOMEM;
+		goto free_port;
+	}
+
 	err = init_port_console(port);
 	if (err)
 		goto free_port;
-- 
1.6.2.5
