From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 19/32] virtio: console: Introduce a send_buf function for a
	common path for sending data to host
Date: Mon, 18 Jan 2010 19:15:13 +0530
Message-ID: <1263822326-24208-20-git-send-email-amit.shah@redhat.com>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-2-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-3-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-4-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-5-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-6-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-7-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-8-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-9-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-10-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-11-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-12-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-13-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-14-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-15-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-16-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-17-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-18-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-19-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-19-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   78 +++++++++++++++++++++++++++++++---------
 1 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 5096d92..fff47cf 100644
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
 
@@ -233,6 +236,54 @@ static bool port_has_data(struct port *port)
 	return ret;
 }
 
+static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
+{
+	struct scatterlist sg[1];
+	struct virtqueue *out_vq;
+	struct port_buffer *buf;
+	ssize_t ret;
+	unsigned int tmplen;
+
+	out_vq = port->out_vq;
+	buf = port->outbuf;
+
+	if (buf->len) {
+		/*
+		 * Nonzero buf->len means we had queued a buffer
+		 * earlier to the Host to be consumed.  Get the buffer
+		 * back for this write request; wait while the Host
+		 * consumes it.
+		 */
+		while (!out_vq->vq_ops->get_buf(out_vq, &tmplen))
+			cpu_relax();
+	}
+
+	if (in_count > buf->size)
+		in_count = buf->size;
+
+	/*
+	 * Since we're not sure when the host will actually
+	 * consume the data and tell us about it, we have to
+	 * copy the data here in case the caller frees the
+	 * in_buf.
+	 */
+	memcpy(buf->buf, in_buf, in_count);
+
+	buf->len = in_count;
+
+	sg_init_one(sg, buf->buf, buf->len);
+	ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, buf);
+
+	/* Tell Host to go! */
+	out_vq->vq_ops->kick(out_vq);
+
+	if (ret < 0)
+		buf->len = 0;
+
+	/* We're expected to return the amount of data we wrote */
+	return buf->len;
+}
+
 /*
  * Give out the data that's requested from the buffer that we have
  * queued up.
@@ -280,10 +331,7 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
  */
 static int put_chars(u32 vtermno, const char *buf, int count)
 {
-	struct scatterlist sg[1];
 	struct port *port;
-	struct virtqueue *out_vq;
-	unsigned int len;
 
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
@@ -292,20 +340,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
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
@@ -475,16 +510,23 @@ static int __devinit add_port(struct ports_device *portdev)
 		err = -ENOMEM;
 		goto free_port;
 	}
+	port->outbuf = alloc_buf(PAGE_SIZE);
+	if (!port->outbuf) {
+		err = -ENOMEM;
+		goto free_inbuf;
+	}
 
 	/* Register the input buffer the first time. */
 	add_inbuf(port->in_vq, inbuf);
 
 	err = init_port_console(port);
 	if (err)
-		goto free_inbuf;
+		goto free_outbuf;
 
 	return 0;
 
+free_outbuf:
+	free_buf(port->outbuf);
 free_inbuf:
 	free_buf(inbuf);
 free_port:
-- 
1.6.2.5
