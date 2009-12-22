From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 07/31] virtio: console: encapsulate buffer information in a
	struct
Date: Tue, 22 Dec 2009 20:04:17 +0530
Message-ID: <1261492481-19817-8-git-send-email-amit.shah@redhat.com>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-2-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-3-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-5-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-6-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-7-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-7-git-send-email-amit.shah@redhat.com>
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

Collect port buffer, used_len, offset fields into a single structure.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   70 ++++++++++++++++++++++++++++++++---------
 1 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 9ea9223..699fc98 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -21,12 +21,24 @@
 #include <linux/virtio_console.h>
 #include "hvc_console.h"
 
+struct port_buffer {
+	char *buf;
+
+	/* size of the buffer in *buf above */
+	size_t size;
+
+	/* used length of the buffer */
+	size_t len;
+	/* offset in the buf from which to consume data */
+	size_t offset;
+};
+
 struct port {
 	struct virtqueue *in_vq, *out_vq;
 	struct virtio_device *vdev;
-	/* This is our input buffer, and how much data is left in it. */
-	char *inbuf;
-	unsigned int used_len, offset;
+
+	/* The current buffer from which data has to be fed to readers */
+	struct port_buffer *inbuf;
 
 	/* The hvc device */
 	struct hvc_struct *hvc;
@@ -38,6 +50,33 @@ static struct port console;
 /* This is the very early arch-specified put chars function. */
 static int (*early_put_chars)(u32, const char *, int);
 
+static void free_buf(struct port_buffer *buf)
+{
+	kfree(buf->buf);
+	kfree(buf);
+}
+
+static struct port_buffer *alloc_buf(size_t buf_size)
+{
+	struct port_buffer *buf;
+
+	buf = kmalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		goto fail;
+	buf->buf = kzalloc(buf_size, GFP_KERNEL);
+	if (!buf->buf)
+		goto free_buf;
+	buf->len = 0;
+	buf->offset = 0;
+	buf->size = buf_size;
+	return buf;
+
+free_buf:
+	kfree(buf);
+fail:
+	return NULL;
+}
+
 /*
  * The put_chars() callback is pretty straightforward.
  *
@@ -79,7 +118,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 static void add_inbuf(struct port *port)
 {
 	struct scatterlist sg[1];
-	sg_init_one(sg, port->inbuf, PAGE_SIZE);
+	sg_init_one(sg, port->inbuf->buf, PAGE_SIZE);
 
 	/* Should always be able to add one buffer to an empty queue. */
 	if (port->in_vq->vq_ops->add_buf(port->in_vq, sg, 0, 1, port) < 0)
@@ -98,6 +137,7 @@ static void add_inbuf(struct port *port)
 static int get_chars(u32 vtermno, char *buf, int count)
 {
 	struct port *port;
+	unsigned int len;
 
 	port = &console;
 
@@ -105,22 +145,23 @@ static int get_chars(u32 vtermno, char *buf, int count)
 	BUG_ON(!port->in_vq);
 
 	/* No more in buffer?  See if they've (re)used it. */
-	if (port->offset == port->used_len) {
-		if (!port->in_vq->vq_ops->get_buf(port->in_vq, &port->used_len))
+	if (port->inbuf->offset == port->inbuf->len) {
+		if (!port->in_vq->vq_ops->get_buf(port->in_vq, &len))
 			return 0;
-		port->offset = 0;
+		port->inbuf->offset = 0;
+		port->inbuf->len = len;
 	}
 
 	/* You want more than we have to give?  Well, try wanting less! */
-	if (port->offset + count > port->used_len)
-		count = port->used_len - port->offset;
+	if (port->inbuf->offset + count > port->inbuf->len)
+		count = port->inbuf->len - port->inbuf->offset;
 
 	/* Copy across to their buffer and increment offset. */
-	memcpy(buf, port->inbuf + port->offset, count);
-	port->offset += count;
+	memcpy(buf, port->inbuf->buf + port->inbuf->offset, count);
+	port->inbuf->offset += count;
 
 	/* Finished?  Re-register buffer so Host will use it again. */
-	if (port->offset == port->used_len)
+	if (port->inbuf->offset == port->inbuf->len)
 		add_inbuf(port);
 
 	return count;
@@ -220,8 +261,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	port->vdev = vdev;
 
 	/* This is the scratch page we use to receive console input */
-	port->used_len = 0;
-	port->inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	port->inbuf = alloc_buf(PAGE_SIZE);
 	if (!port->inbuf) {
 		err = -ENOMEM;
 		goto fail;
@@ -263,7 +303,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 free_vqs:
 	vdev->config->del_vqs(vdev);
 free:
-	kfree(port->inbuf);
+	free_buf(port->inbuf);
 fail:
 	return err;
 }
-- 
1.6.2.5
