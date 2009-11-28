From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 19/28] virtio: console: Prepare for writing to / reading from
	userspace buffers
Date: Sat, 28 Nov 2009 12:20:42 +0530
Message-ID: <1259391051-7752-20-git-send-email-amit.shah@redhat.com>
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
	<1259391051-7752-14-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-15-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-16-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-17-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-18-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-19-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-19-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   51 ++++++++++++++++++++++++++++-------------
 1 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 56b7cfa..4d55f0f 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -221,7 +221,7 @@ static inline bool is_control(u32 flags)
 }
 
 static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
-			u32 flags)
+			u32 flags, bool from_user)
 {
 	struct scatterlist sg[1];
 	struct virtio_console_header header;
@@ -265,15 +265,21 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 			memcpy(buf->buf, &header, header_len);
 			copy_size -= header_len;
 		}
-		/*
-		 * Since we're not sure when the host will actually
-		 * consume the data and tell us about it, we have
-		 * to copy the data here in case the caller
-		 * frees the in_buf
-		 */
-		memcpy(buf->buf + header_len, in_buf + in_offset, copy_size);
-
-		buf->len = header_len + copy_size;
+		if (from_user) {
+			ret = copy_from_user(buf->buf + header_len,
+					     in_buf + in_offset, copy_size);
+		} else {
+			/*
+			 * Since we're not sure when the host will actually
+			 * consume the data and tell us about it, we have
+			 * to copy the data here in case the caller
+			 * frees the in_buf
+			 */
+			memcpy(buf->buf + header_len,
+			       in_buf + in_offset, copy_size);
+			ret = 0; /* Emulate copy_from_user behaviour */
+		}
+		buf->len = header_len + copy_size - ret;
 		sg_init_one(sg, buf->buf, buf->len);
 
 		spin_lock_irqsave(&port->portdev->write_list_lock, irqf);
@@ -306,14 +312,15 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 	cpkt.event = event;
 	cpkt.value = value;
 	return send_buf(port, (char *)&cpkt, sizeof(cpkt),
-			VIRTIO_CONSOLE_HDR_CONTROL);
+			VIRTIO_CONSOLE_HDR_CONTROL, false);
 }
 
 /*
  * Give out the data that's requested from the buffers that we have
  * queued up.
  */
-static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
+static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
+			    bool to_user)
 {
 	struct port_buffer *buf, *buf2;
 	ssize_t out_offset, ret;
@@ -324,6 +331,8 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
 	 * Not taking the port->readbuf_list_lock here relying on the
 	 * fact that buffers are taken out from the list only in this
 	 * function so buf2 should be available all the time.
+	 *
+	 * Also, copy_to_user() might sleep.
 	 */
 	list_for_each_entry_safe(buf, buf2, &port->readbuf_head, list) {
 		size_t copy_size;
@@ -332,10 +341,20 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
 		if (copy_size > buf->len - buf->offset)
 			copy_size = buf->len - buf->offset;
 
-		memcpy(out_buf + out_offset, buf->buf + buf->offset, copy_size);
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
 
 		/* Return the number of bytes actually copied */
-		ret = copy_size;
+		ret = copy_size - ret;
 		buf->offset += ret;
 		out_offset += ret;
 		out_count -= ret;
@@ -373,7 +392,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
 
-	return send_buf(port, buf, count, 0);
+	return send_buf(port, buf, count, 0, false);
 }
 
 /*
@@ -397,7 +416,7 @@ static int get_chars(u32 vtermno, char *buf, int count)
 	if (list_empty(&port->readbuf_head))
 		return 0;
 
-	return fill_readbuf(port, buf, count);
+	return fill_readbuf(port, buf, count, false);
 }
 
 static void resize_console(struct port *port)
-- 
1.6.2.5
