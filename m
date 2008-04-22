From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH] virtio: change config to guest endian.
Date: Tue, 22 Apr 2008 13:57:34 +1000
Message-ID: <200804221357.34571.rusty__30355.6049861529$1208836813$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Hollis Blanchard <hollisb@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

[Christian, Hollis, how much is this ABI breakage going to hurt you?]

A recent proposed feature addition to the virtio block driver revealed
some flaws in the API, in particular how easy it is to break big
endian machines.

The virtio config space was originally chosen to be little-endian,
because we thought the config might be part of the PCI config space
for virtio_pci.  It's actually a separate mmio region, so that
argument holds little water; as only x86 is currently using the virtio
mechanism, we can change this (but must do so now, before the
impending s390 and ppc merges).

API changes:
- __virtio_config_val() just becomes a striaght vdev->config_get() call.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/block/virtio_blk.c      |    4 +--
 drivers/virtio/virtio_balloon.c |    6 ++---
 include/linux/virtio_config.h   |   47 +++++++++++++---------------------------
 3 files changed, 21 insertions(+), 36 deletions(-)

diff -r a098f19a6da5 drivers/block/virtio_blk.c
--- a/drivers/block/virtio_blk.c	Sun Apr 20 14:41:02 2008 +1000
+++ b/drivers/block/virtio_blk.c	Sun Apr 20 15:07:45 2008 +1000
@@ -246,8 +246,8 @@ static int virtblk_probe(struct virtio_d
 		blk_queue_ordered(vblk->disk->queue, QUEUE_ORDERED_TAG, NULL);
 
 	/* Host must always specify the capacity. */
-	__virtio_config_val(vdev, offsetof(struct virtio_blk_config, capacity),
-			    &cap);
+	vdev->config->get(vdev, offsetof(struct virtio_blk_config, capacity),
+			  &cap, sizeof(cap));
 
 	/* If capacity is too big, truncate with warning. */
 	if ((sector_t)cap != cap) {
diff -r a098f19a6da5 drivers/virtio/virtio_balloon.c
--- a/drivers/virtio/virtio_balloon.c	Sun Apr 20 14:41:02 2008 +1000
+++ b/drivers/virtio/virtio_balloon.c	Sun Apr 20 15:07:45 2008 +1000
@@ -155,9 +155,9 @@ static inline s64 towards_target(struct 
 static inline s64 towards_target(struct virtio_balloon *vb)
 {
 	u32 v;
-	__virtio_config_val(vb->vdev,
-			    offsetof(struct virtio_balloon_config, num_pages),
-			    &v);
+	vb->vdev->config->get(vb->vdev,
+			      offsetof(struct virtio_balloon_config, num_pages),
+			      &v);
 	return v - vb->num_pages;
 }
 
diff -r a098f19a6da5 include/linux/virtio_config.h
--- a/include/linux/virtio_config.h	Sun Apr 20 14:41:02 2008 +1000
+++ b/include/linux/virtio_config.h	Sun Apr 20 15:07:45 2008 +1000
@@ -16,7 +16,7 @@
 #define VIRTIO_CONFIG_S_FAILED		0x80
 
 #ifdef __KERNEL__
-struct virtio_device;
+#include <linux/virtio.h>
 
 /**
  * virtio_config_ops - operations for configuring a virtio device
@@ -30,13 +30,11 @@ struct virtio_device;
  *	offset: the offset of the configuration field
  *	buf: the buffer to write the field value into.
  *	len: the length of the buffer
- *	Note that contents are conventionally little-endian.
  * @set: write the value of a configuration field
  *	vdev: the virtio_device
  *	offset: the offset of the configuration field
  *	buf: the buffer to read the field value from.
  *	len: the length of the buffer
- *	Note that contents are conventionally little-endian.
  * @get_status: read the status byte
  *	vdev: the virtio_device
  *	Returns the status byte
@@ -70,40 +68,27 @@ struct virtio_config_ops
 };
 
 /**
- * virtio_config_val - look for a feature and get a single virtio config.
+ * virtio_config_val - look for a feature and get a virtio config entry.
  * @vdev: the virtio device
  * @fbit: the feature bit
  * @offset: the type to search for.
  * @val: a pointer to the value to fill in.
  *
  * The return value is -ENOENT if the feature doesn't exist.  Otherwise
- * the value is endian-corrected and returned in v. */
-#define virtio_config_val(vdev, fbit, offset, v) ({			\
-	int _err;							\
-	if ((vdev)->config->feature((vdev), (fbit))) {			\
-		__virtio_config_val((vdev), (offset), (v));		\
-		_err = 0;						\
-	} else								\
-		_err = -ENOENT;						\
-	_err;								\
-})
+ * the config value is copied into whatever is pointed to by v. */
+#define virtio_config_val(vdev, fbit, offset, v) \
+	virtio_config_buf((vdev), (fbit), (offset), (v), sizeof(v))
 
-/**
- * __virtio_config_val - get a single virtio config without feature check.
- * @vdev: the virtio device
- * @offset: the type to search for.
- * @val: a pointer to the value to fill in.
- *
- * The value is endian-corrected and returned in v. */
-#define __virtio_config_val(vdev, offset, v) do {			\
-	BUILD_BUG_ON(sizeof(*(v)) != 1 && sizeof(*(v)) != 2		\
-		     && sizeof(*(v)) != 4 && sizeof(*(v)) != 8);	\
-	(vdev)->config->get((vdev), (offset), (v), sizeof(*(v)));	\
-	switch (sizeof(*(v))) {						\
-	case 2: le16_to_cpus((__u16 *) v); break;			\
-	case 4: le32_to_cpus((__u32 *) v); break;			\
-	case 8: le64_to_cpus((__u64 *) v); break;			\
-	}								\
-} while(0)
+static inline int virtio_config_buf(struct virtio_device *vdev,
+				    unsigned int fbit,
+				    unsigned int offset,
+				    void *buf, unsigned len)
+{
+	if (!vdev->config->feature(vdev, fbit))
+		return -ENOENT;
+
+	vdev->config->get(vdev, offset, buf, len);
+	return 0;
+}
 #endif /* __KERNEL__ */
 #endif /* _LINUX_VIRTIO_CONFIG_H */
