From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 22/31] virtio: console: Prepare for writing to / reading from
	userspace buffers
Date: Tue, 22 Dec 2009 20:04:32 +0530
Message-ID: <1261492481-19817-23-git-send-email-amit.shah@redhat.com>
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
	<1261492481-19817-20-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-21-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-22-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-22-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   48 ++++++++++++++++++++++++++++------------
 1 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index bb48345..2f5ef29 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -340,7 +340,8 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 	return 0;
 }
 
-static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
+static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
+			bool from_user)
 {
 	struct scatterlist sg[1];
 	struct virtio_console_header header;
@@ -359,15 +360,21 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
 	while (in_offset < in_count) {
 		copy_size = min(in_count - in_offset + header_len, buf->size);
 		copy_size -= header_len;
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
 
 		if (header_len)
 			memcpy(buf->buf, &header, header_len);
@@ -394,7 +401,8 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count)
  * Give out the data that's requested from the buffers that we have
  * queued up.
  */
-static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
+static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
+			    bool to_user)
 {
 	struct port_buffer *buf;
 	ssize_t out_offset, ret;
@@ -409,9 +417,19 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
 		if (copy_size > buf->len - buf->offset)
 			copy_size = buf->len - buf->offset;
 
-		memcpy(out_buf + out_offset, buf->buf + buf->offset, copy_size);
+		if (to_user) {
+			ret = copy_to_user(out_buf + out_offset,
+					   buf->buf + buf->offset,
+					   copy_size);
+		} else {
+			memcpy(out_buf + out_offset,
+			       buf->buf + buf->offset,
+			       copy_size);
+			ret = 0; /* Emulate copy_to_user behaviour */
+		}
 
-		ret = copy_size;
+		/* Return the number of bytes actually copied */
+		ret = copy_size - ret;
 		buf->offset += ret;
 		out_offset += ret;
 		out_count -= ret;
@@ -447,7 +465,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (unlikely(early_put_chars))
 		return early_put_chars(vtermno, buf, count);
 
-	return send_buf(port, buf, count);
+	return send_buf(port, buf, count, false);
 }
 
 /*
@@ -468,7 +486,7 @@ static int get_chars(u32 vtermno, char *buf, int count)
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
 
-	return fill_readbuf(port, buf, count);
+	return fill_readbuf(port, buf, count, false);
 }
 
 static void resize_console(struct port *port)
-- 
1.6.2.5
