From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 05/15] virtio_console: Buffer data that comes in from the host
Date: Tue, 10 Nov 2009 15:11:31 +0530
Message-ID: <1257846101-23258-6-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-3-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-4-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-5-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-5-git-send-email-amit.shah@redhat.com>
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

The console could be flooded with data from the host; handle
this situation by buffering the data.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |  210 +++++++++++++++++++++++++++++------------
 1 files changed, 149 insertions(+), 61 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 19c9729..585ad3c 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -9,9 +9,6 @@
  * functions.
  :*/
 
-/*M:002 The console can be flooded: while the Guest is processing input the
- * Host can send more.  Buffering in the Host could alleviate this, but it is a
- * difficult problem in general. :*/
 /* Copyright (C) 2006, 2007 Rusty Russell, IBM Corporation
  *
  * This program is free software; you can redistribute it and/or modify
@@ -30,6 +27,8 @@
  */
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_console.h>
 #include "hvc_console.h"
@@ -41,6 +40,17 @@ struct virtio_console_struct {
 	 */
 	struct work_struct rx_work;
 
+	/* Buffer management */
+	struct list_head unused_read_head;
+	struct list_head readbuf_head;
+
+	/*
+	 * To protect the readbuf_head list. Has to be a spinlock
+	 * because it can be called from interrupt context
+	 * (get_char())
+	 */
+	spinlock_t readbuf_list_lock;
+
 	/*D:340
 	 * These represent our input and output console queues,
 	 * and the virtio operations for them.
@@ -48,14 +58,22 @@ struct virtio_console_struct {
 	struct virtqueue *in_vq, *out_vq;
 	struct virtio_device *vdev;
 
-	/* This is our input buffer, and how much data is left in it. */
-	unsigned int in_len;
-	char *in, *inbuf;
-
 	/* The hvc device */
 	struct hvc_struct *hvc;
 };
 
+/* This struct holds individual buffers received from the host */
+struct virtio_console_port_buffer {
+	struct list_head list;
+
+	char *buf;
+
+	/* length of the buffer */
+	size_t len;
+	/* offset in the buf from which to consume data */
+	size_t offset;
+};
+
 struct virtio_console_struct virtconsole;
 
 /*D:310 The put_chars() callback is pretty straightforward.
@@ -88,58 +106,65 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	return count;
 }
 
-/* Create a scatter-gather list representing our input buffer and put it in the
- * queue. */
-static void add_inbuf(void)
+/*
+ * Give out the data that's requested from the buffers that we have
+ * queued up.
+ */
+static ssize_t fill_readbuf(char *out_buf, size_t out_count)
 {
-	struct virtqueue *in_vq;
-	struct scatterlist sg[1];
-
-	sg_init_one(sg, virtconsole.inbuf, PAGE_SIZE);
+	struct virtio_console_port_buffer *buf, *buf2;
+	ssize_t out_offset, ret;
 
-	in_vq = virtconsole.in_vq;
-	/* We should always be able to add one buffer to an empty queue. */
-	if (in_vq->vq_ops->add_buf(in_vq, sg, 0, 1, virtconsole.inbuf) < 0)
-		BUG();
-	in_vq->vq_ops->kick(in_vq);
+	out_offset = 0;
+	/*
+	 * Not taking the port->readbuf_list_lock here relying on the
+	 * fact that buffers are taken out from the list only in this
+	 * function so buf2 should be available all the time.
+	 */
+	list_for_each_entry_safe(buf, buf2, &virtconsole.readbuf_head, list) {
+		size_t copy_size;
+
+		copy_size = out_count;
+		if (copy_size > buf->len - buf->offset)
+			copy_size = buf->len - buf->offset;
+
+		memcpy(out_buf + out_offset, buf->buf + buf->offset, copy_size);
+
+		/* Return the number of bytes actually copied */
+		ret = copy_size;
+		buf->offset += ret;
+		out_offset += ret;
+		out_count -= ret;
+
+		if (buf->len - buf->offset == 0) {
+			spin_lock(&virtconsole.readbuf_list_lock);
+			list_del(&buf->list);
+			spin_unlock(&virtconsole.readbuf_list_lock);
+			kfree(buf->buf);
+			kfree(buf);
+		}
+		if (!out_count)
+			break;
+	}
+	return out_offset;
 }
 
-/*D:350 get_chars() is the callback from the hvc_console infrastructure when
+/*D:350
+ * get_chars() is the callback from the hvc_console infrastructure when
  * an interrupt is received.
  *
- * Most of the code deals with the fact that the hvc_console() infrastructure
- * only asks us for 16 bytes at a time.  We keep in_offset and in_used fields
- * for partially-filled buffers. */
+ * We call out to fill_readbuf that gets us the required data from the
+ * buffers that are queued up.
+ */
 static int get_chars(u32 vtermno, char *buf, int count)
 {
-	struct virtqueue *in_vq;
-
-	in_vq = virtconsole.in_vq;
 	/* If we don't have an input queue yet, we can't get input. */
-	BUG_ON(!in_vq);
-
-	/* No buffer?  Try to get one. */
-	if (!virtconsole.in_len) {
-		virtconsole.in = in_vq->vq_ops->get_buf(in_vq,
-							&virtconsole.in_len);
-		if (!virtconsole.in)
-			return 0;
-	}
-
-	/* You want more than we have to give?  Well, try wanting less! */
-	if (virtconsole.in_len < count)
-		count = virtconsole.in_len;
+	BUG_ON(!virtconsole.in_vq);
 
-	/* Copy across to their buffer and increment offset. */
-	memcpy(buf, virtconsole.in, count);
-	virtconsole.in += count;
-	virtconsole.in_len -= count;
+	if (list_empty(&virtconsole.readbuf_head))
+		return 0;
 
-	/* Finished?  Re-register buffer so Host will use it again. */
-	if (virtconsole.in_len == 0)
-		add_inbuf();
-
-	return count;
+	return fill_readbuf(buf, count);
 }
 /*:*/
 
@@ -203,14 +228,82 @@ int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
 	return hvc_instantiate(0, 0, &virtio_cons);
 }
 
+static struct virtio_console_port_buffer *get_buf(size_t buf_size)
+{
+	struct virtio_console_port_buffer *buf;
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf)
+		goto out;
+	buf->buf = kzalloc(buf_size, GFP_KERNEL);
+	if (!buf->buf) {
+		kfree(buf);
+		goto out;
+	}
+	buf->len = buf_size;
+out:
+	return buf;
+}
+
+static void fill_queue(struct virtqueue *vq, size_t buf_size,
+		       struct list_head *unused_head)
+{
+	struct scatterlist sg[1];
+	struct virtio_console_port_buffer *buf;
+	int ret;
+
+	do {
+		buf = get_buf(buf_size);
+		if (!buf)
+			break;
+		sg_init_one(sg, buf->buf, buf_size);
+
+		ret = vq->vq_ops->add_buf(vq, sg, 0, 1, buf);
+		if (ret < 0) {
+			kfree(buf->buf);
+			kfree(buf);
+			break;
+		}
+		/*
+		 * We have to keep track of the unused buffers so that
+		 * they can be freed when the module is being removed
+		 */
+		list_add_tail(&buf->list, unused_head);
+	} while (ret > 0);
+	vq->vq_ops->kick(vq);
+}
+
+static void fill_receive_queue(struct virtio_console_struct *vcon)
+{
+	fill_queue(vcon->in_vq, PAGE_SIZE, &vcon->unused_read_head);
+}
+
 static void virtio_console_rx_work_handler(struct work_struct *work)
 {
 	struct virtio_console_struct *vcon;
+	struct virtio_console_port_buffer *buf;
+	struct virtqueue *vq;
+	unsigned int tmplen;
 
 	vcon = container_of(work, struct virtio_console_struct, rx_work);
 
-	if (hvc_poll(vcon->hvc))
+	vq = vcon->in_vq;
+	while ((buf = vq->vq_ops->get_buf(vq, &tmplen))) {
+		/* The buffer is no longer unused */
+		list_del(&buf->list);
+
+		buf->len = tmplen;
+		buf->offset = 0;
+
+		spin_lock(&virtconsole.readbuf_list_lock);
+		list_add_tail(&buf->list, &virtconsole.readbuf_head);
+		spin_unlock(&virtconsole.readbuf_list_lock);
+	}
+	if (hvc_poll(virtconsole.hvc))
 		hvc_kick();
+
+	/* Allocate buffers for all the ones that got used up */
+	fill_receive_queue(&virtconsole);
 }
 
 static void rx_intr(struct virtqueue *vq)
@@ -238,19 +331,12 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	}
 	virtconsole.vdev = vdev;
 
-	/* This is the scratch page we use to receive console input */
-	virtconsole.inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!virtconsole.inbuf) {
-		err = -ENOMEM;
-		goto fail;
-	}
-
 	/* Find the queues. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
 	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
 	if (err)
-		goto free;
+		goto fail;
 
 	virtconsole.in_vq = vqs[0];
 	virtconsole.out_vq = vqs[1];
@@ -263,8 +349,14 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	 */
 	virtio_cons.put_chars = put_chars;
 
+	spin_lock_init(&virtconsole.readbuf_list_lock);
+	INIT_LIST_HEAD(&virtconsole.readbuf_head);
+	INIT_LIST_HEAD(&virtconsole.unused_read_head);
+
 	INIT_WORK(&virtconsole.rx_work, &virtio_console_rx_work_handler);
 
+	fill_receive_queue(&virtconsole);
+
 	/* The first argument of hvc_alloc() is the virtual console number, so
 	 * we use zero.  The second argument is the parameter for the
 	 * notification mechanism (like irq number). We currently leave this
@@ -280,14 +372,10 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 		goto free_vqs;
 	}
 
-	/* Register the input buffer the first time. */
-	add_inbuf();
 	return 0;
 
 free_vqs:
 	vdev->config->del_vqs(vdev);
-free:
-	kfree(virtconsole.inbuf);
 fail:
 	return err;
 }
-- 
1.6.2.5
