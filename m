From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/3] Virtio draft IV
Date: Wed, 04 Jul 2007 14:12:28 +1000
Message-ID: <1183522348.6110.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization <virtualization@lists.linux-foundation.org>
Cc: Carsten Otte <cotte@de.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: virtualization@lists.linuxfoundation.org

In response to Avi's excellent analysis, I've updated virtio as promised
(apologies for the delay, travel got in the way).
===
This attempts to implement a "virtual I/O" layer which should allow
common drivers to be efficiently used across most virtual I/O
mechanisms.  It will no-doubt need further enhancement.

The details of probing the device are left to hypervisor-specific
code: it simple constructs the "struct virtio_device" and hands it to
the probe function (eg. virtnet_probe() or virtblk_probe()).

The virtio drivers add and get I/O buffers; as the buffers are consumed
the driver "interrupt" callbacks are invoked.

I have written two virtio device drivers (net and block) and two
virtio implementations (for lguest): a read-write socket-style
implementation, and a more efficient descriptor-based implementation.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/linux/virtio.h |   64 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

===================================================================
--- /dev/null
+++ b/include/linux/virtio.h
@@ -0,0 +1,64 @@
+#ifndef _LINUX_VIRTIO_H
+#define _LINUX_VIRTIO_H
+#include <linux/types.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+
+/**
+ * virtqueue - queue for virtual I/O
+ * @ops: the operations for this virtqueue.
+ * @cb: set by the driver for callbacks.
+ * @priv: private pointer for the driver to use.
+ */
+struct virtqueue {
+	struct virtqueue_ops *ops;
+	bool (*cb)(struct virtqueue *vq);
+	void *priv;
+};
+
+/**
+ * virtqueue_ops - operations for virtqueue abstraction layer
+ * @add_buf: expose buffer to other end
+ *	vq: the struct virtqueue we're talking about.
+ *	sg: the description of the buffer(s).
+ *	out_num: the number of sg readable by other side
+ *	in_num: the number of sg which are writable (after readable ones)
+ *	data: the token identifying the buffer.
+ *      Returns 0 or an error.
+ * @sync: update after add_buf
+ *	vq: the struct virtqueue
+ *	After one or more add_buf calls, invoke this to kick the virtio layer.
+ * @get_buf: get the next used buffer
+ *	vq: the struct virtqueue we're talking about.
+ *	len: the length written into the buffer
+ *	Returns NULL or the "data" token handed to add_buf.
+ * @detach_buf: "unadd" an unused buffer.
+ *	vq: the struct virtqueue we're talking about.
+ *	data: the buffer identifier.
+ *	This is usually used for shutdown, returnes 0 or -ENOENT.
+ * @restart: restart callbacks ater callback returned false.
+ *	vq: the struct virtqueue we're talking about.
+ *	This returns "false" (and doesn't re-enable) if there are pending
+ *	buffers in thq queue, to avoid a race.
+ *
+ * Locking rules are straightforward: the driver is responsible for
+ * locking.  No two operations may be invoked simultaneously.
+ *
+ * All operations can be called in any context.
+ */
+struct virtqueue_ops {
+	int (*add_buf)(struct virtqueue *vq,
+		       struct scatterlist sg[],
+		       unsigned int out_num,
+		       unsigned int in_num,
+		       void *data);
+
+	void (*sync)(struct virtqueue *vq);
+
+	void *(*get_buf)(struct virtqueue *vq, unsigned int *len);
+
+	int (*detach_buf)(struct virtqueue *vq, void *data);
+
+	bool (*restart)(struct virtqueue *vq);
+};
+#endif /* _LINUX_VIRTIO_H */
