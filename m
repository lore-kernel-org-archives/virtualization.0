From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 21/31] virtio: console: Prepare for writing to userspace
	buffers
Date: Fri, 29 Jan 2010 19:12:40 +0530
Message-ID: <1264772563-25517-4-git-send-email-amit.shah@redhat.com>
References: <1264772563-25517-1-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-2-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1264772563-25517-3-git-send-email-amit.shah@redhat.com>
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
userspace. Equip the fill_readbuf function with the ability to write
to userspace buffers.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9d33239..5f61021 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -365,7 +365,8 @@ fail:
  * Give out the data that's requested from the buffer that we have
  * queued up.
  */
-static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
+static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
+			    bool to_user)
 {
 	struct port_buffer *buf;
 	unsigned long flags;
@@ -374,12 +375,18 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
 		return 0;
 
 	buf = port->inbuf;
-	if (out_count > buf->len - buf->offset)
-		out_count = buf->len - buf->offset;
+	out_count = min(out_count, buf->len - buf->offset);
 
-	memcpy(out_buf, buf->buf + buf->offset, out_count);
+	if (to_user) {
+		ssize_t ret;
+
+		ret = copy_to_user(out_buf, buf->buf + buf->offset, out_count);
+		if (ret)
+			return -EFAULT;
+	} else {
+		memcpy(out_buf, buf->buf + buf->offset, out_count);
+	}
 
-	/* Return the number of bytes actually copied */
 	buf->offset += out_count;
 
 	if (buf->offset == buf->len) {
@@ -395,6 +402,7 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
 
 		spin_unlock_irqrestore(&port->inbuf_lock, flags);
 	}
+	/* Return the number of bytes actually copied */
 	return out_count;
 }
 
@@ -438,7 +446,7 @@ static int get_chars(u32 vtermno, char *buf, int count)
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
 
-	return fill_readbuf(port, buf, count);
+	return fill_readbuf(port, buf, count, false);
 }
 
 static void resize_console(struct port *port)
-- 
1.6.2.5
