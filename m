From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 1/3] Virtio draft III: virtio.h
Date: Sat, 16 Jun 2007 23:14:29 +1000
Message-ID: <1181999669.6237.257.camel__43844.9351968758$1181999744$gmane$org@localhost.localdomain>
References: <1181217762.14054.192.camel@localhost.localdomain>
	<1181999552.6237.255.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1181999552.6237.255.camel@localhost.localdomain>
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

Draft III of virtio interface

This attempts to implement a "virtual I/O" layer which should allow
common drivers to be efficiently used across most virtual I/O
mechanisms.  It will no-doubt need further enhancement.

The details of probing the device are left to hypervisor-specific
code: it simple constructs the "struct virtio_device" and hands it to
the probe function (eg. virtnet_probe() or virtblk_probe()).

The virtio drivers add and get input and output buffers; as the
buffers are used up the driver "interrupt" callbacks are invoked.

I have written two virtio device drivers (net and block) and two
virtio implementations (for lguest): a read-write socket-style
implementation, and a more efficient descriptor-based implementation.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/linux/virtio.h |  115 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

===================================================================
--- /dev/null
+++ b/include/linux/virtio.h
@@ -0,0 +1,115 @@
+#ifndef _LINUX_VIRTIO_H
+#define _LINUX_VIRTIO_H
+#include <linux/types.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+
+/**
+ * virtio_device - description and routines to drive a virtual device.
+ * @dev: the underlying struct device.
+ * @ops: the operations for this virtual device.
+ * @driver_ops: set by the driver for callbacks.
+ * @priv: private pointer for the driver to use.
+ */
+struct virtio_device {
+	struct device *dev;
+	struct virtio_ops *ops;
+	struct virtio_driver_ops *driver_ops;
+	void *priv;
+};
+
+/**
+ * virtio_driver_ops - driver callbacks for a virtual device.
+ * @in: inbufs have been completed.
+ *	Usually called from an interrupt handler.
+ *	Return false to suppress further inbuf callbacks.
+ * @out: outbufs have been completed.
+ *	Usually called from an interrupt handler.
+ *	Return false to suppress further outbuf callbacks.
+ */
+struct virtio_driver_ops {
+	bool (*in)(struct virtio_device *dev);
+	bool (*out)(struct virtio_device *dev);
+};
+
+enum virtio_dir {
+	VIRTIO_IN = 0x1,
+	VIRTIO_OUT = 0x2,
+};
+
+/**
+ * virtio_ops - virtio abstraction layer
+ * @add_outbuf: prepare to send data to the other end:
+ *	vdev: the virtio_device
+ *	sg: the description of the buffer(s).
+ *	num: the size of the sg array.
+ *	data: the token returned by the get_outbuf function.
+ *      Returns a unique id or an error.
+ * @add_inbuf: prepare to receive data from the other end:
+ *	vdev: the virtio_device
+ *	sg: the description of the buffer(s).
+ *	num: the size of the sg array.
+ *	data: the token returned by the get_inbuf function.
+ *      Returns a unique id or an error (eg. -ENOSPC).
+ * @sync: update after add_inbuf and/or add_outbuf
+ *	vdev: the virtio_device we're talking about.
+ *	inout: VIRTIO_IN and/or VIRTIO_OUT
+ *	After one or more add_inbuf/add_outbuf calls, invoke this to kick
+ *	the virtio layer.
+ * @get_outbuf: get the next used outbuf.
+ *	vdev: the virtio_device we're talking about.
+ *	len: the length written into the outbuf
+ *	Returns NULL or the "data" token handed to add_outbuf (which has been
+ *	detached).
+ * @get_inbuf: get the next used inbuf.
+ *	vdev: the virtio_device we're talking about.
+ *	len: the length read from the inbuf
+ *	Returns NULL or the "data" token handed to add_inbuf (which has been
+ *	detached).
+ * @detach_outbuf: make sure sent sg can no longer be read.
+ *	vdev: the virtio_device we're talking about.
+ *	id: the id returned from add_outbuf.
+ *	This is usually used for shutdown.  Don't try to detach twice.
+ * @detach_inbuf: make sure sent sg can no longer be written to.
+ *	vdev: the virtio_device we're talking about.
+ *	id: the id returned from add_inbuf.
+ *	This is usually used for shutdown.  Don't try to detach twice.
+ * @restart_in: restart calls to driver_ops->in after it returned false.
+ *	vdev: the virtio_device we're talking about.
+ *	This returns "false" (and doesn't re-enable) if there are pending
+ *	inbufs, to avoid a race.
+ * @restart_out: restart calls to driver_ops->out after it returned false.
+ *	vdev: the virtio_device we're talking about.
+ *	This returns "false" (and doesn't re-enable) if there are pending
+ *	outbufs, to avoid a race.
+ *
+ * Locking rules are straightforward: the driver is responsible for
+ * locking.  Outbuf operations can be called in parallel to inbuf
+ * operations, but no two outbuf operations nor two inbuf operations
+ * may be invoked simultaneously.
+ *
+ * All operations can be called in any context.
+ */
+struct virtio_ops {
+	unsigned long (*add_outbuf)(struct virtio_device *vdev,
+				    const struct scatterlist sg[],
+				    unsigned int num,
+				    void *data);
+
+	unsigned long (*add_inbuf)(struct virtio_device *vdev,
+				   struct scatterlist sg[],
+				   unsigned int num,
+				   void *data);
+
+	void (*sync)(struct virtio_device *vdev, enum virtio_dir inout);
+
+	void *(*get_outbuf)(struct virtio_device *vdev, unsigned int *len);
+	void *(*get_inbuf)(struct virtio_device *vdev, unsigned int *len);
+
+	void (*detach_outbuf)(struct virtio_device *vdev, unsigned long id);
+	void (*detach_inbuf)(struct virtio_device *vdev, unsigned long id);
+
+	bool (*restart_in)(struct virtio_device *vdev);
+	bool (*restart_out)(struct virtio_device *vdev);
+};
+#endif /* _LINUX_VIRTIO_H */
