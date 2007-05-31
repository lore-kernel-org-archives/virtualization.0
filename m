From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH RFC 1/3] virtio infrastructure
Date: Thu, 31 May 2007 22:19:07 +1000
Message-ID: <1180613947.11133.58.camel__40434.548413805$1180614049$gmane$org@localhost.localdomain>
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, Xen Mailing List <xen-devel@lists.xensource.com>, virtualization <virtualization@lists.linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, Christian Borntraeger <cborntra@de.ibm.com>, Suzanne McIntosh <skranjac@us.ibm.com>, Anthony Liguori <anthony@codemonkey.ws>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

This attempts to implement a "virtual I/O" layer which should allow
common drivers to be efficiently used across most virtual I/O
mechanisms.  It will no-doubt need further enhancement.

The details of probing the device are left to hypervisor-specific
code: it simple constructs the "struct virtio_device" and hands it to
the probe function (eg. virtnet_probe() or virtblk_probe()).

The virtio drivers add and detach input and output buffers; as the
buffers are used up their associated "used" pointers are filled in.

I have written two virtio device drivers (net and block) and two
virtio implementations (for lguest): a read-write socket-style
implementation, and a more efficient descriptor-based implementation).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/linux/virtio.h |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff -r 2db2135723b0 include/linux/virtio.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/linux/virtio.h	Thu May 31 17:52:19 2007 +1000
@@ -0,0 +1,66 @@
+#ifndef _LINUX_VIRTIO_H
+#define _LINUX_VIRTIO_H
+#include <linux/types.h>
+#include <linux/scatterlist.h>
+
+/**
+ * virtio_device - description and routines to drive a virtual device.
+ * @dev: the underlying struct device.
+ * @ops: the operations for this virtual device.
+ */
+struct virtio_device {
+	struct device *dev;
+	struct virtio_ops *ops;
+};
+
+/**
+ * virtio_ops - virtio abstraction layer
+ * @add_outbuf: prepare to send data to the other end:
+ *	vdev: the virtio_device
+ *	sg: the description of the buffer(s).
+ *	num: the size of the sg array.
+ *	used: the length sent (set once sending is done).
+ *      Returns an identifier or an error.
+ * @add_inbuf: prepare to receive data from the other end:
+ *	vdev: the virtio_device
+ *	sg: the description of the buffer(s).
+ *	num: the size of the sg array.
+ *	used: the length sent (set once data received).
+ *      Returns an identifier or an error (eg. -ENOSPC).
+ * @sync: update after add_inbuf/add_outbuf
+ *	vdev: the virtio_device we're talking about.
+ *	Use the virtio_sync wrapper, to avoid unnecessary calls.
+ * @detach_outbuf: make sure sent sg can no longer be read.
+ *	vdev: the virtio_device we're talking about.
+ *	id: the identifier returned from add_outbuf.
+ * @detach_inbuf: make sure sent sg can no longer be written to.
+ *	vdev: the virtio_device we're talking about.
+ *	id: the identifier returned from add_inbuf.
+ */
+struct virtio_ops {
+	unsigned long (*add_outbuf)(struct virtio_device *vdev,
+				    const struct scatterlist sg[],
+				    unsigned int num,
+				    unsigned long *used);
+
+	unsigned long (*add_inbuf)(struct virtio_device *vdev,
+				   struct scatterlist sg[],
+				   unsigned int num,
+				   unsigned long *used);
+
+	void (*sync)(struct virtio_device *vdev);
+
+	void (*detach_outbuf)(struct virtio_device *vdev, unsigned long id);
+	void (*detach_inbuf)(struct virtio_device *vdev, unsigned long id);
+};
+
+/**
+ * virtio_sync - start sending/receiving data from the other end.
+ * @vdev: the virtio_device we're talking about.
+ */
+static inline void virtio_sync(struct virtio_device *vdev)
+{
+	if (vdev->ops->sync)
+		vdev->ops->sync(vdev);
+}
+#endif /* _LINUX_VIRTIO_H */
