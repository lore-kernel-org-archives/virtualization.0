From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_console: fix sparse warnings
Date: Mon, 1 Dec 2014 13:35:57 +0200
Message-ID: <1417433749-17408-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

CHECK drivers/char/virtio_console.c
drivers/char/virtio_console.c:687:36: warning: incorrect type in
	argument 1 (different address spaces)
drivers/char/virtio_console.c:687:36:    expected void [noderef]
	<asn:1>*to
drivers/char/virtio_console.c:687:36:    got char *out_buf
drivers/char/virtio_console.c:790:35: warning: incorrect type in
	argument 2 (different address spaces)
drivers/char/virtio_console.c:790:35:    expected char *out_buf
drivers/char/virtio_console.c:790:35:    got char [noderef]
	<asn:1>*ubuf

fill_readbuf is reused with both kernel and userspace pointers,
depending on value of to_user flag.

Tag address parameter as __user, and cast to/from regular pointer type
when we know it's safe.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 775c898..ccb5357 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -669,8 +669,8 @@ done:
  * Give out the data that's requested from the buffer that we have
  * queued up.
  */
-static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
-			    bool to_user)
+static ssize_t fill_readbuf(struct port *port, char __user *out_buf,
+			    size_t out_count, bool to_user)
 {
 	struct port_buffer *buf;
 	unsigned long flags;
@@ -688,7 +688,8 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 		if (ret)
 			return -EFAULT;
 	} else {
-		memcpy(out_buf, buf->buf + buf->offset, out_count);
+		memcpy((__force char *)out_buf, buf->buf + buf->offset,
+		       out_count);
 	}
 
 	buf->offset += out_count;
@@ -1162,7 +1163,7 @@ static int get_chars(u32 vtermno, char *buf, int count)
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!port->in_vq);
 
-	return fill_readbuf(port, buf, count, false);
+	return fill_readbuf(port, (__force char __user *)buf, count, false);
 }
 
 static void resize_console(struct port *port)
-- 
MST
