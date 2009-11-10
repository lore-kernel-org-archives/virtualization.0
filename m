From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 03/15] virtio_console: Club all globals into one struct
Date: Tue, 10 Nov 2009 15:11:29 +0530
Message-ID: <1257846101-23258-4-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-3-git-send-email-amit.shah@redhat.com>
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

Club all the globals -- the virtio_device struct, virtqueues,
hvc_console struct, inbuf, len, etc. into one virtioconsole
struct.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   83 ++++++++++++++++++++++++-----------------
 1 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 21039b8..ed4d9a4 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -34,17 +34,23 @@
 #include <linux/virtio_console.h>
 #include "hvc_console.h"
 
-/*D:340 These represent our input and output console queues, and the virtio
- * operations for them. */
-static struct virtqueue *in_vq, *out_vq;
-static struct virtio_device *vdev;
+struct virtio_console_struct {
+	/*D:340
+	 * These represent our input and output console queues,
+	 * and the virtio operations for them.
+	 */
+	struct virtqueue *in_vq, *out_vq;
+	struct virtio_device *vdev;
+
+	/* This is our input buffer, and how much data is left in it. */
+	unsigned int in_len;
+	char *in, *inbuf;
 
-/* This is our input buffer, and how much data is left in it. */
-static unsigned int in_len;
-static char *in, *inbuf;
+	/* The hvc device */
+	struct hvc_struct *hvc;
+};
 
-/* The hvc device */
-static struct hvc_struct *hvc;
+struct virtio_console_struct virtconsole;
 
 /*D:310 The put_chars() callback is pretty straightforward.
  *
@@ -54,12 +60,14 @@ static struct hvc_struct *hvc;
  * immediately (lguest's Launcher does). */
 static int put_chars(u32 vtermno, const char *buf, int count)
 {
+	struct virtqueue *out_vq;
 	struct scatterlist sg[1];
 	unsigned int len;
 
 	/* This is a convenient routine to initialize a single-elem sg list */
 	sg_init_one(sg, buf, count);
 
+	out_vq = virtconsole.out_vq;
 	/* add_buf wants a token to identify this buffer: we hand it any
 	 * non-NULL pointer, since there's only ever one buffer. */
 	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, (void *)1) >= 0) {
@@ -78,11 +86,14 @@ static int put_chars(u32 vtermno, const char *buf, int count)
  * queue. */
 static void add_inbuf(void)
 {
+	struct virtqueue *in_vq;
 	struct scatterlist sg[1];
-	sg_init_one(sg, inbuf, PAGE_SIZE);
 
+	sg_init_one(sg, virtconsole.inbuf, PAGE_SIZE);
+
+	in_vq = virtconsole.in_vq;
 	/* We should always be able to add one buffer to an empty queue. */
-	if (in_vq->vq_ops->add_buf(in_vq, sg, 0, 1, inbuf) < 0)
+	if (in_vq->vq_ops->add_buf(in_vq, sg, 0, 1, virtconsole.inbuf) < 0)
 		BUG();
 	in_vq->vq_ops->kick(in_vq);
 }
@@ -95,27 +106,31 @@ static void add_inbuf(void)
  * for partially-filled buffers. */
 static int get_chars(u32 vtermno, char *buf, int count)
 {
+	struct virtqueue *in_vq;
+
+	in_vq = virtconsole.in_vq;
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!in_vq);
 
 	/* No buffer?  Try to get one. */
-	if (!in_len) {
-		in = in_vq->vq_ops->get_buf(in_vq, &in_len);
-		if (!in)
+	if (!virtconsole.in_len) {
+		virtconsole.in = in_vq->vq_ops->get_buf(in_vq,
+							&virtconsole.in_len);
+		if (!virtconsole.in)
 			return 0;
 	}
 
 	/* You want more than we have to give?  Well, try wanting less! */
-	if (in_len < count)
-		count = in_len;
+	if (virtconsole.in_len < count)
+		count = virtconsole.in_len;
 
 	/* Copy across to their buffer and increment offset. */
-	memcpy(buf, in, count);
-	in += count;
-	in_len -= count;
+	memcpy(buf, virtconsole.in, count);
+	virtconsole.in += count;
+	virtconsole.in_len -= count;
 
 	/* Finished?  Re-register buffer so Host will use it again. */
-	if (in_len == 0)
+	if (virtconsole.in_len == 0)
 		add_inbuf();
 
 	return count;
@@ -137,7 +152,7 @@ static void virtcons_apply_config(struct virtio_device *dev)
 		dev->config->get(dev,
 				 offsetof(struct virtio_console_config, rows),
 				 &ws.ws_row, sizeof(u16));
-		hvc_resize(hvc, ws);
+		hvc_resize(virtconsole.hvc, ws);
 	}
 }
 
@@ -148,7 +163,7 @@ static void virtcons_apply_config(struct virtio_device *dev)
 static int notifier_add_vio(struct hvc_struct *hp, int data)
 {
 	hp->irq_requested = 1;
-	virtcons_apply_config(vdev);
+	virtcons_apply_config(virtconsole.vdev);
 
 	return 0;
 }
@@ -184,7 +199,7 @@ int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
 
 static void hvc_handle_input(struct virtqueue *vq)
 {
-	if (hvc_poll(hvc))
+	if (hvc_poll(virtconsole.hvc))
 		hvc_kick();
 }
 
@@ -195,22 +210,22 @@ static void hvc_handle_input(struct virtqueue *vq)
  * never remove the console device we never need this pointer again.
  *
  * Finally we put our input buffer in the input queue, ready to receive. */
-static int __devinit virtcons_probe(struct virtio_device *dev)
+static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
 	vq_callback_t *callbacks[] = { hvc_handle_input, NULL};
 	const char *names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
 	int err;
 
-	if (vdev) {
+	if (virtconsole.vdev) {
 		pr_err("Multiple virtio-console devices not supported yet\n");
 		return -EEXIST;
 	}
-	vdev = dev;
+	virtconsole.vdev = vdev;
 
 	/* This is the scratch page we use to receive console input */
-	inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!inbuf) {
+	virtconsole.inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!virtconsole.inbuf) {
 		err = -ENOMEM;
 		goto fail;
 	}
@@ -222,8 +237,8 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 	if (err)
 		goto free;
 
-	in_vq = vqs[0];
-	out_vq = vqs[1];
+	virtconsole.in_vq = vqs[0];
+	virtconsole.out_vq = vqs[1];
 
 	/*
 	 * We had set the virtio_cons ->put_chars implementation to an
@@ -242,9 +257,9 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 	 * get_chars(), notifier_add() and notifier_del() pointers.
 	 * The final argument is the output buffer size: we can do any size,
 	 * so we put PAGE_SIZE here. */
-	hvc = hvc_alloc(0, 0, &virtio_cons, PAGE_SIZE);
-	if (IS_ERR(hvc)) {
-		err = PTR_ERR(hvc);
+	virtconsole.hvc = hvc_alloc(0, 0, &virtio_cons, PAGE_SIZE);
+	if (IS_ERR(virtconsole.hvc)) {
+		err = PTR_ERR(virtconsole.hvc);
 		goto free_vqs;
 	}
 
@@ -255,7 +270,7 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 free_vqs:
 	vdev->config->del_vqs(vdev);
 free:
-	kfree(inbuf);
+	kfree(virtconsole.inbuf);
 fail:
 	return err;
 }
-- 
1.6.2.5
