From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 19/31] virtio: console: Introduce a send_buf function for a
	common path for sending data to host
Date: Fri, 29 Jan 2010 19:12:38 +0530
Message-ID: <1264772563-25517-2-git-send-email-amit.shah@redhat.com>
References: <1264772563-25517-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1264772563-25517-1-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   50 +++++++++++++++++++++++++++--------------
 1 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 5096d92..d010510 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -233,6 +233,38 @@ static bool port_has_data(struct port *port)
 	return ret;
 }
 
+static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count)
+{
+	struct scatterlist sg[1];
+	struct virtqueue *out_vq;
+	ssize_t ret;
+	unsigned int len;
+
+	out_vq = port->out_vq;
+
+	sg_init_one(sg, in_buf, in_count);
+	ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, in_buf);
+
+	/* Tell Host to go! */
+	out_vq->vq_ops->kick(out_vq);
+
+	if (ret < 0) {
+		len = 0;
+		goto fail;
+	}
+
+	/*
+	 * Wait till the host acknowledges it pushed out the data we
+	 * sent. Also ensure we return to userspace the number of
+	 * bytes that were successfully consumed by the host.
+	 */
+	while (!out_vq->vq_ops->get_buf(out_vq, &len))
+		cpu_relax();
+fail:
+	/* We're expected to return the amount of data we wrote */
+	return len;
+}
+
 /*
  * Give out the data that's requested from the buffer that we have
  * queued up.
@@ -280,10 +312,7 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count)
  */
 static int put_chars(u32 vtermno, const char *buf, int count)
 {
-	struct scatterlist sg[1];
 	struct port *port;
-	struct virtqueue *out_vq;
-	unsigned int len;
 
 	port = find_port_by_vtermno(vtermno);
 	if (!port)
@@ -292,20 +321,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
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
+	return send_buf(port, (void *)buf, count);
 }
 
 /*
-- 
1.6.2.5
