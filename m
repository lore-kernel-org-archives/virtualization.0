From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 08/31] virtio: console: ensure add_inbuf can work for multiple
	ports as well
Date: Tue, 22 Dec 2009 20:04:18 +0530
Message-ID: <1261492481-19817-9-git-send-email-amit.shah@redhat.com>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-2-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-3-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-5-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-6-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-7-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-8-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-8-git-send-email-amit.shah@redhat.com>
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

add_inbuf() assumed one port and one inbuf per port. Remove that
assumption.

Also move the function so that put_chars and get_chars are together.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 699fc98..1dbd46c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -78,6 +78,22 @@ fail:
 }
 
 /*
+ * Create a scatter-gather list representing our input buffer and put
+ * it in the queue.
+ *
+ * Callers should take appropriate locks.
+ */
+static void add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
+{
+	struct scatterlist sg[1];
+	sg_init_one(sg, buf->buf, buf->size);
+
+	if (vq->vq_ops->add_buf(vq, sg, 0, 1, buf) < 0)
+		BUG();
+	vq->vq_ops->kick(vq);
+}
+
+/*
  * The put_chars() callback is pretty straightforward.
  *
  * We turn the characters into a scatter-gather list, add it to the
@@ -112,21 +128,6 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 }
 
 /*
- * Create a scatter-gather list representing our input buffer and put
- * it in the queue.
- */
-static void add_inbuf(struct port *port)
-{
-	struct scatterlist sg[1];
-	sg_init_one(sg, port->inbuf->buf, PAGE_SIZE);
-
-	/* Should always be able to add one buffer to an empty queue. */
-	if (port->in_vq->vq_ops->add_buf(port->in_vq, sg, 0, 1, port) < 0)
-		BUG();
-	port->in_vq->vq_ops->kick(port->in_vq);
-}
-
-/*
  * get_chars() is the callback from the hvc_console infrastructure
  * when an interrupt is received.
  *
@@ -162,7 +163,7 @@ static int get_chars(u32 vtermno, char *buf, int count)
 
 	/* Finished?  Re-register buffer so Host will use it again. */
 	if (port->inbuf->offset == port->inbuf->len)
-		add_inbuf(port);
+		add_inbuf(port->in_vq, port->inbuf);
 
 	return count;
 }
@@ -294,7 +295,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	}
 
 	/* Register the input buffer the first time. */
-	add_inbuf(port);
+	add_inbuf(port->in_vq, port->inbuf);
 
 	/* Start using the new console output. */
 	early_put_chars = NULL;
-- 
1.6.2.5
