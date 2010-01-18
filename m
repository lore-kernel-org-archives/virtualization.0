From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 09/32] virtio: console: introduce a get_inbuf helper to fetch
	bufs from in_vq
Date: Mon, 18 Jan 2010 19:15:03 +0530
Message-ID: <1263822326-24208-10-git-send-email-amit.shah@redhat.com>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-2-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-3-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-4-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-5-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-6-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-7-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-8-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-9-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-9-git-send-email-amit.shah@redhat.com>
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

This makes taking locks around the get_buf vq operation easier, as well
as complements the add_inbuf() operation.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1dbd46c..df45e5e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -77,6 +77,22 @@ fail:
 	return NULL;
 }
 
+/* Callers should take appropriate locks */
+static void *get_inbuf(struct port *port)
+{
+	struct port_buffer *buf;
+	struct virtqueue *vq;
+	unsigned int len;
+
+	vq = port->in_vq;
+	buf = vq->vq_ops->get_buf(vq, &len);
+	if (buf) {
+		buf->len = len;
+		buf->offset = 0;
+	}
+	return buf;
+}
+
 /*
  * Create a scatter-gather list representing our input buffer and put
  * it in the queue.
@@ -138,7 +154,6 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 static int get_chars(u32 vtermno, char *buf, int count)
 {
 	struct port *port;
-	unsigned int len;
 
 	port = &console;
 
@@ -147,10 +162,8 @@ static int get_chars(u32 vtermno, char *buf, int count)
 
 	/* No more in buffer?  See if they've (re)used it. */
 	if (port->inbuf->offset == port->inbuf->len) {
-		if (!port->in_vq->vq_ops->get_buf(port->in_vq, &len))
+		if (!get_inbuf(port))
 			return 0;
-		port->inbuf->offset = 0;
-		port->inbuf->len = len;
 	}
 
 	/* You want more than we have to give?  Well, try wanting less! */
-- 
1.6.2.5
