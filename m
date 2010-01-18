From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 21/32] virtio: console: Prepare for writing to / reading from
	userspace buffers
Date: Mon, 18 Jan 2010 19:15:15 +0530
Message-ID: <1263822326-24208-22-git-send-email-amit.shah@redhat.com>
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
	<1263822326-24208-20-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-21-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-21-git-send-email-amit.shah@redhat.com>
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

When ports get advertised as char devices, the buffers will come from
userspace. Equip the send_buf and fill_readbuf functions with the
ability to write to / read from userspace buffers respectively.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   45 ++++++++++++++++++++++++++--------------
 1 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c0bc146..35bdd41 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -332,7 +332,8 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 	return 0;
 }
 
-static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
+static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
+			bool from_user)
 {
 	struct scatterlist sg[1];
 	struct virtqueue *out_vq;
@@ -357,15 +358,19 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
 	if (in_count > buf->size)
 		in_count = buf->size;
 
-	/*
-	 * Since we're not sure when the host will actually
-	 * consume the data and tell us about it, we have to
-	 * copy the data here in case the caller frees the
-	 * in_buf.
-	 */
-	memcpy(buf->buf, in_buf, in_count);
-
-	buf->len = in_count;
+	if (from_user) {
+		ret = copy_from_user(buf->buf, in_buf, in_count);
+	} else {
+		/*
+		 * Since we're not sure when the host will actually
+		 * consume the data and tell us about it, we have to
+		 * copy the data here in case the caller frees the
+		 * in_buf.
+		 */
+		memcpy(buf->buf, in_buf, in_count);
+		ret = 0; /* Emulate copy_from_user behaviour */
+	}
+	buf->len = in_count - ret;
 
 	sg_init_one(sg, buf->buf, buf->len);
 	ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, buf);
@@ -384,9 +389,11 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
  * Give out the data that's requested from the buffer that we have
  * queued up.
  */
-static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
+static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
+			    bool to_user)
 {
 	struct port_buffer *buf;
+	ssize_t ret;
 	unsigned long flags;
 
 	if (!out_count || !port_has_data(port))
@@ -396,10 +403,16 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
 	if (out_count > buf->len - buf->offset)
 		out_count = buf->len - buf->offset;
 
-	memcpy(out_buf, buf->buf + buf->offset, out_count);
+	if (to_user) {
+		ret = copy_to_user(out_buf, buf->buf + buf->offset, out_count);
+	} else {
+		memcpy(out_buf, buf->buf + buf->offset, out_count);
+		ret = 0; /* Emulate copy_to_user behaviour */
+	}
 
 	/* Return the number of bytes actually copied */
-	buf->offset += out_count;
+	ret = out_count - ret;
+	buf->offset += ret;
 
 	if (buf->offset == buf->len) {
 		/*
@@ -414,7 +427,7 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
 
 		spin_unlock_irqrestore(&port->inbuf_lock, flags);
 	}
-	return out_count;
+	return ret;
 }
 
 /*
@@ -436,7 +449,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
 
-	return send_buf(port, buf, count);
+	return send_buf(port, buf, count, false);
 }
 
 /*
@@ -457,7 +470,7 @@ static int get_chars(u32 vtermno, char *buf, int count)
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
 
-	return fill_readbuf(port, buf, count);
+	return fill_readbuf(port, buf, count, false);
 }
 
 static void resize_console(struct port *port)
-- 
1.6.2.5
