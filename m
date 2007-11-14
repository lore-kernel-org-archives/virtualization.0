From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH] Remove pagesize parameter from vring_init/vring_size
Date: Wed, 14 Nov 2007 10:06:43 -0600
Message-ID: <11950564033349-git-send-email-aliguori@us.ibm.com>
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
To: Rusty Russell <rusty@rustcorp.com.au>Rusty Russell <rusty@rustcorp.com.au>
Cc: Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The PAGE_SIZE constant should be used instead of taking an extra parameter.
Moreover, once we use PAGE_SIZE, we can use PAGE_ALIGN() instead of having it
open coded.

I've only compile tested the lguest launcher as I'm on a 64-bit system but I've
tested the virtio-pci device with KVM.

Signed-off-by: Anthony Liguori <aliguori@us.ibm.com>

diff --git a/Documentation/lguest/lguest.c b/Documentation/lguest/lguest.c
index 4200839..171dead 100644
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -34,6 +34,11 @@
 #include <zlib.h>
 #include <assert.h>
 #include <sched.h>
+
+/* these are needed for virtio_ring.h */
+#define PAGE_SIZE (getpagesize())
+#define PAGE_ALIGN(addr) (((addr) + PAGE_SIZE - 1) & ~(PAGE_SIZE - 1))
+
 #include "linux/lguest_launcher.h"
 #include "linux/virtio_config.h"
 #include "linux/virtio_net.h"
@@ -1036,7 +1041,7 @@ static void add_virtqueue(struct device *dev, unsigned int num_descs,
 	void *p;
 
 	/* First we need some pages for this virtqueue. */
-	pages = (vring_size(num_descs, getpagesize()) + getpagesize() - 1)
+	pages = (vring_size(num_descs) + getpagesize() - 1)
 		/ getpagesize();
 	p = get_pages(pages);
 
@@ -1046,7 +1051,7 @@ static void add_virtqueue(struct device *dev, unsigned int num_descs,
 	vq->config.pfn = to_guest_phys(p) / getpagesize();
 
 	/* Initialize the vring. */
-	vring_init(&vq->vring, num_descs, p, getpagesize());
+	vring_init(&vq->vring, num_descs, p);
 
 	/* Add the configuration information to this device's descriptor. */
 	add_desc_field(dev, VIRTIO_CONFIG_F_VIRTQUEUE,
diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index e2eec38..cbf90fc 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -200,8 +200,7 @@ static struct virtqueue *lg_find_vq(struct virtio_device *vdev,
 
 	/* Figure out how many pages the ring will take, and map that memory */
 	lvq->pages = lguest_map((unsigned long)lvq->config.pfn << PAGE_SHIFT,
-				DIV_ROUND_UP(vring_size(lvq->config.num,
-							PAGE_SIZE),
+				DIV_ROUND_UP(vring_size(lvq->config.num),
 					     PAGE_SIZE));
 	if (!lvq->pages) {
 		err = -ENOMEM;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1dc04b6..8438303 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -287,7 +287,7 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
 	if (!vq)
 		return NULL;
 
-	vring_init(&vq->vring, num, pages, PAGE_SIZE);
+	vring_init(&vq->vring, num, pages);
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.vq_ops = &vring_vq_ops;
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 1a4ed49..f786170 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -9,6 +9,7 @@
  *
  * Copyright Rusty Russell IBM Corporation 2007. */
 #include <linux/types.h>
+#include <linux/mm.h>
 
 /* This marks a buffer as continuing via the next field. */
 #define VRING_DESC_F_NEXT	1
@@ -88,21 +89,18 @@ struct vring {
  *	struct vring_used_elem used[num];
  * };
  */
-static inline void vring_init(struct vring *vr, unsigned int num, void *p,
-			      unsigned int pagesize)
+static inline void vring_init(struct vring *vr, unsigned int num, void *p)
 {
 	vr->num = num;
 	vr->desc = p;
 	vr->avail = p + num*sizeof(struct vring_desc);
-	vr->used = (void *)(((unsigned long)&vr->avail->ring[num] + pagesize-1)
-			    & ~(pagesize - 1));
+	vr->used = (void *)PAGE_ALIGN((unsigned long)&vr->avail->ring[num]);
 }
 
-static inline unsigned vring_size(unsigned int num, unsigned int pagesize)
+static inline unsigned vring_size(unsigned int num)
 {
-	return ((sizeof(struct vring_desc) * num + sizeof(__u16) * (2 + num)
-		 + pagesize - 1) & ~(pagesize - 1))
-		+ sizeof(__u16) * 2 + sizeof(struct vring_used_elem) * num;
+	return PAGE_ALIGN(sizeof(struct vring_desc)*num+sizeof(__u16)*(2+num))
+		+ sizeof(struct vring_used_elem) * num + sizeof(__u16) * 2;
 }
 
 #ifdef __KERNEL__
