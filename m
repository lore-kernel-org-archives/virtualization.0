From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 1/3] Virtio draft II: virtio.h
Date: Thu, 07 Jun 2007 22:04:27 +1000
Message-ID: <1181217867.14054.195.camel__32337.9698595547$1181217972$gmane$org@localhost.localdomain>
References: <1181217762.14054.192.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181217762.14054.192.camel@localhost.localdomain>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <cborntra@de.ibm.com>, Latchesar Ionkov <lionkov@lanl.gov>, Suzanne McIntosh <skranjac@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This attempts to implement a "virtual I/O" layer which should allow
common drivers to be efficiently used across most virtual I/O
mechanisms.  It will no-doubt need further enhancement.

The details of probing the device are left to hypervisor-specific
code: it simple constructs the "struct virtio_device" and hands it to
the probe function (eg. virtnet_probe() or virtblk_probe()).

The virtio drivers add and detach input and output buffers; as the
buffers are used up their associated callbacks are filled in.

I have written two virtio device drivers (net and block) and two
virtio implementations (for lguest): a read-write socket-style
implementation, and a more efficient descriptor-based implementation.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/linux/virtio.h |   75 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

===================================================================
--- /dev/null
+++ b/include/linux/virtio.h
@@ -0,0 +1,75 @@
+#ifndef _LINUX_VIRTIO_H
+#define _LINUX_VIRTIO_H
+#include <linux/types.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+
+/**
+ * virtio_device - description and routines to drive a virtual device.
+ * @lock: the lock to hold before calling any functions.
+ * @dev: the underlying struct device.
+ * @ops: the operations for this virtual device.
+ * @priv: private pointer for the driver to use.
+ */
+struct virtio_device {
+	spinlock_t lock;
+	struct device *dev;
+	struct virtio_ops *ops;
+	void *priv;
+};
+
+/**
+ * virtio_ops - virtio abstraction layer
+ * @add_outbuf: prepare to send data to the other end:
+ *	vdev: the virtio_device
+ *	sg: the description of the buffer(s).
+ *	num: the size of the sg array.
+ *	cb: the function to call once the outbuf is finished & detached.
+ *	data: the token to hand to the cb function.
+ *      Returns a unique id or an error.  Note that the callback will be
+ *	called with the lock held, and possibly in an interrupt handler.
+ * @add_inbuf: prepare to receive data from the other end:
+ *	vdev: the virtio_device
+ *	sg: the description of the buffer(s).
+ *	num: the size of the sg array.
+ *	cb: the function to call once the inbuf is finished & detached.
+ *	data: the token to hand to the cb function.
+ *      Returns a unique id or an error (eg. -ENOSPC).  Note that the
+ *	callback will be called with the lock held, and possibly in an
+ *	interrupt handler.
+ * @sync: update after add_inbuf/add_outbuf
+ *	vdev: the virtio_device we're talking about.
+ *	After one or more add_inbuf/add_outbuf calls, invoke this to kick
+ *	the virtio layer.
+ * @detach_outbuf: make sure sent sg can no longer be read.
+ *	vdev: the virtio_device we're talking about.
+ *	id: the id returned from add_outbuf.
+ *	This is not necessary (or valid!) if the outbuf callback has
+ *	already fired.
+ * @detach_inbuf: make sure sent sg can no longer be written to.
+ *	vdev: the virtio_device we're talking about.
+ *	id: the id returned from add_inbuf.
+ *	This is not necessary (or valid!) if the outbuf callback has
+ *	already fired.
+ */
+struct virtio_ops {
+	unsigned long (*add_outbuf)(struct virtio_device *vdev,
+				    const struct scatterlist sg[],
+				    unsigned int num,
+				    void (*cb)(struct virtio_device *vdev,
+					       void *data, unsigned len),
+				    void *data);
+
+	unsigned long (*add_inbuf)(struct virtio_device *vdev,
+				   struct scatterlist sg[],
+				   unsigned int num,
+				   void (*cb)(struct virtio_device *vdev,
+					      void *data, unsigned len),
+				   void *data);
+
+	void (*sync)(struct virtio_device *vdev);
+
+	void (*detach_outbuf)(struct virtio_device *vdev, unsigned long id);
+	void (*detach_inbuf)(struct virtio_device *vdev, unsigned long id);
+};
+#endif /* _LINUX_VIRTIO_H */
