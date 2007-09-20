From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 6/6] virtio ring helper
Date: Thu, 20 Sep 2007 22:27:14 +1000
Message-ID: <1190291234.7262.246.camel__31608.0691562549$1190291394$gmane$org@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<1190290369.7262.231.camel@localhost.localdomain>
	<1190290495.7262.235.camel@localhost.localdomain>
	<1190290606.7262.239.camel@localhost.localdomain>
	<1190290761.7262.242.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1190290761.7262.242.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: lguest <lguest@ozlabs.org>, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

These helper routines supply most of the virtqueue_ops for hypervisors
which want to use a ring for virtio.  Unlike the previous lguest
implementation:

1) The rings are variable sized (2^n-1 elements).
2) They have an unfortunate limit of 65535 bytes per sg element.
3) The page numbers are always 64 bit (PAE anyone?)
4) They no longer place used[] on a separate page, just a separate
   cacheline.
5) We do a modulo on a variable.  We could be tricky if we cared.

Users need only implement the new_vq and free_vq hooks (KVM wants the
guest to allocate the rings, lguest does it sanely).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 arch/i386/lguest/Kconfig     |    1 
 drivers/virtio/Kconfig       |    5 
 drivers/virtio/Makefile      |    1 
 drivers/virtio/virtio_ring.c |  301 ++++++++++++++++++++++++++++++++++++++++++
 drivers/virtio/vring.h       |   50 ++++++
 include/linux/virtio_ring.h  |   96 +++++++++++++
 6 files changed, 454 insertions(+)

===================================================================
--- a/arch/i386/lguest/Kconfig
+++ b/arch/i386/lguest/Kconfig
@@ -2,6 +2,7 @@ config LGUEST_GUEST
 	bool "Lguest guest support"
 	select PARAVIRT
 	depends on !X86_PAE
+	select VIRTIO_RING
 	help
 	  Lguest is a tiny in-kernel hypervisor.  Selecting this will
 	  allow your kernel to boot under lguest.  This option will increase
===================================================================
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -1,3 +1,8 @@
 # Virtio always gets selected by whoever wants it.
 config VIRTIO
 	bool
+
+# Similarly the virtio ring implementation.
+config VIRTIO_RING
+	bool
+	depends on VIRTIO
===================================================================
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,1 +1,2 @@ obj-$(CONFIG_VIRTIO) += virtio.o config.
 obj-$(CONFIG_VIRTIO) += virtio.o config.o
+obj-$(CONFIG_VIRTIO_RING) += virtio_ring.o
===================================================================
--- /dev/null
+++ b/drivers/virtio/virtio_ring.c
@@ -0,0 +1,301 @@
+/* Virtio ring implementation.
+ *
+ *  Copyright 2007 Rusty Russell IBM Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/virtio.h>
+#include <linux/virtio_ring.h>
+#include <linux/device.h>
+#include "vring.h"
+
+#ifdef DEBUG
+/* For development, we want to crash whenever the ring is screwed. */
+#define BAD_RING(vvq, fmt...)			\
+	do { dev_err(vvq->dev, fmt); BUG(); } while(0)
+#define START_USE(vvq) \
+	do { if ((vvq)->in_use) panic("in_use = %i\n", (vvq)->in_use); (vvq)->in_use = __LINE__; mb(); } while(0)
+#define END_USE(vvq) \
+	do { BUG_ON(!(vvq)->in_use); (vvq)->in_use = 0; mb(); } while(0)
+#else
+#define BAD_RING(vvq, fmt...)			\
+	do { dev_err(vvq->dev, fmt); (vvq)->broken = true; } while(0)
+#define START_USE(vvq)
+#define END_USE(vvq)
+#endif
+
+struct virtqueue
+{
+	/* Callback for driver when data is consumed. */
+	bool (*callback)(void *);
+	void *cb_data;
+
+	/* Who to blame this on. */
+	struct device *dev;
+
+	/* Actual memory layout for this queue */
+	struct vring vring;
+
+	/* Other side has made a mess, don't try any more. */
+	bool broken;
+
+	/* Number of free buffers */
+	unsigned int num_free;
+	/* Head of free buffer list. */
+	unsigned int free_head;
+	/* Number we've added since last sync. */
+	unsigned int num_added;
+
+	/* Last used index we've seen. */
+	unsigned int last_used_idx;
+
+	/* How to notify other side. FIXME: commonalize hcalls! */
+	void (*notify)(void *priv);
+	void *priv;
+
+	/* Unless they told us to stop */
+	bool running;
+
+#ifdef DEBUG
+	/* They're supposed to lock for us. */
+	unsigned int in_use;
+#endif
+
+	/* Tokens for callbacks. */
+	void *data[];
+};
+
+void *vring_priv(struct virtqueue *vq)
+{
+	return vq->priv;
+}
+
+int vring_add_buf(struct virtqueue *vq,
+		  struct scatterlist sg[],
+		  unsigned int out,
+		  unsigned int in,
+		  void *data)
+{
+	unsigned int i, avail, head, uninitialized_var(prev);
+
+	BUG_ON(data == NULL);
+	BUG_ON(out + in > vq->vring.num);
+	BUG_ON(out + in == 0);
+
+	START_USE(vq);
+
+	if (vq->num_free < out + in) {
+		pr_debug("Can't add buf len %i - avail = %i\n",
+			 out + in, vq->num_free);
+		END_USE(vq);
+		return -ENOSPC;
+	}
+
+	/* We're about to use some buffers from the free list. */
+	vq->num_free -= out + in;
+
+	head = vq->free_head;
+	for (i = vq->free_head; out; i = vq->vring.desc[i].next, out--) {
+		vq->vring.desc[i].flags = VRING_DESC_F_NEXT;
+		vq->vring.desc[i].pfn = page_to_pfn(sg[0].page);
+		BUG_ON(sg[0].offset > 65535);
+		BUG_ON(sg[0].length > 65535);
+		vq->vring.desc[i].offset = sg[0].offset;
+		vq->vring.desc[i].len = sg[0].length;
+		prev = i;
+		sg++;
+	}
+	for (; in; i = vq->vring.desc[i].next, in--) {
+		vq->vring.desc[i].flags=VRING_DESC_F_NEXT|VRING_DESC_F_WRITE;
+		vq->vring.desc[i].pfn = page_to_pfn(sg[0].page);
+		BUG_ON(sg[0].offset > 65535);
+		BUG_ON(sg[0].length > 65535);
+		vq->vring.desc[i].offset = sg[0].offset;
+		vq->vring.desc[i].len = sg[0].length;
+		prev = i;
+		sg++;
+	}
+	/* Last one doesn't continue. */
+	vq->vring.desc[prev].flags &= ~VRING_DESC_F_NEXT;
+
+	/* Update free pointer */
+	vq->free_head = i;
+
+	/* Set token. */
+	vq->data[head] = data;
+
+	/* Put entry in available array (but don't update avail->idx until they
+	 * do sync).  FIXME: avoid modulus here? */
+	avail = (vq->vring.avail->idx + vq->num_added++) % vq->vring.num;
+	vq->vring.avail->ring[avail] = head;
+
+	pr_debug("Added buffer head %i to %p\n", head, vq);
+	END_USE(vq);
+	return 0;
+}
+
+void vring_kick(struct virtqueue *vq)
+{
+	START_USE(vq);
+	/* Descriptors and available array need to be set before we expose the
+	 * new available array entries. */
+	wmb();
+
+	vq->vring.avail->idx += vq->num_added;
+	vq->num_added = 0;
+
+	/* Prod other side to tell it about changes. */
+	vq->notify(vq->priv);
+	END_USE(vq);
+}
+
+static void detach_buf(struct virtqueue *vq, unsigned int head)
+{
+	unsigned int i;
+
+	/* Clear data ptr. */
+	vq->data[head] = NULL;
+
+	/* Put back on free list: find end */
+	i = head;
+	while (vq->vring.desc[i].flags & VRING_DESC_F_NEXT) {
+		i = vq->vring.desc[i].next;
+		vq->num_free++;
+	}
+
+	vq->vring.desc[i].next = vq->free_head;
+	vq->free_head = head;
+	/* Plus final descriptor */
+	vq->num_free++;
+}
+
+/* FIXME: We need to tell other side about removal, to synchronize. */
+void vring_shutdown(struct virtqueue *vq)
+{
+	unsigned int i;
+
+	for (i = 0; i < vq->vring.num; i++)
+		detach_buf(vq, i);
+}
+
+static bool more_used(const struct virtqueue *vq)
+{
+	return vq->last_used_idx != vq->vring.used->idx;
+}
+
+void *vring_get_buf(struct virtqueue *vq, unsigned int *len)
+{
+	void *ret;
+	unsigned int i;
+
+	START_USE(vq);
+
+	if (!more_used(vq)) {
+		pr_debug("No more buffers in queue\n");
+		END_USE(vq);
+		return NULL;
+	}
+
+	i = vq->vring.used->ring[vq->last_used_idx%vq->vring.num].id;
+	*len = vq->vring.used->ring[vq->last_used_idx%vq->vring.num].len;
+
+	if (unlikely(i >= vq->vring.num)) {
+		BAD_RING(vq, "id %u out of range\n", i);
+		return NULL;
+	}
+	if (unlikely(!vq->data[i])) {
+		BAD_RING(vq, "id %u is not a head!\n", i);
+		return NULL;
+	}
+
+	/* detach_buf clears data, so grab it now. */
+	ret = vq->data[i];
+	detach_buf(vq, i);
+	vq->last_used_idx++;
+	END_USE(vq);
+	return ret;
+}
+
+/* FIXME: Put running in shmem */
+bool vring_restart(struct virtqueue *vq)
+{
+	START_USE(vq);
+	BUG_ON(vq->running);
+
+	if (likely(!more_used(vq)) || unlikely(vq->broken))
+		vq->running = true;
+
+	END_USE(vq);
+	return vq->running;
+}
+
+irqreturn_t vring_interrupt(int irq, void *_vq)
+{
+	struct virtqueue *vq = _vq;
+
+	pr_debug("virtqueue interrupt for %p\n", vq);
+
+	if (unlikely(vq->broken))
+		return IRQ_HANDLED;
+
+	if (vq->running && more_used(vq)) {
+		pr_debug("virtqueue callback for %p (%p)\n", vq, vq->callback);
+		vq->running = vq->callback(vq->cb_data);
+	} else
+		pr_debug("virtqueue %p no more used\n", vq);
+
+	return IRQ_HANDLED;
+}
+
+struct virtqueue *vring_new_virtqueue(unsigned int num,
+				      struct device *dev,
+				      void *pages,
+				      void (*notify)(void *priv), void *priv,
+				      bool (*callback)(void *), void *cb_data)
+{
+	struct virtqueue *vq;
+	unsigned int i;
+
+	vq = kmalloc(sizeof(*vq) + sizeof(void *)*num, GFP_KERNEL);
+	if (!vq)
+		return NULL;
+
+	vring_init(&vq->vring, num, pages);
+	vq->callback = callback;
+	vq->cb_data = cb_data;
+	vq->dev = dev;
+	vq->notify = notify;
+	vq->priv = priv;
+	vq->broken = false;
+	vq->last_used_idx = 0;
+	vq->num_added = 0;
+	vq->running = true;
+#ifdef DEBUG
+	vq->in_use = false;
+#endif
+
+	/* Put everything in free lists. */
+	vq->num_free = num;
+	vq->free_head = 0;
+	for (i = 0; i < num-1; i++)
+		vq->vring.desc[i].next = i+1;
+
+	return vq;
+}
+
+void vring_destroy_virtqueue(struct virtqueue *vq)
+{
+	kfree(vq);
+}
===================================================================
--- /dev/null
+++ b/drivers/virtio/vring.h
@@ -0,0 +1,50 @@
+#ifndef _VRING_VRING_H
+#define _VRING_VRING_H
+#include <linux/virtio.h>
+#include <linux/irqreturn.h>
+
+/* A vring consists of a continuous chunk of memory which looks like so:
+ * (use num == 2^n-1 to make it nicely cacheline aligned).
+ *
+ * struct vring
+ * {
+ *	// The actual descriptors.
+ *	struct vring_desc desc[num];
+ *
+ *	// A ring of available descriptor heads with free-running index.
+ *	__u16 avail_idx;
+ *	__u16 available[num];
+ *
+ *	// Padding so a correctly-chosen num value will cache-align used_idx.
+ *	char pad[sizeof(struct vring_desc) - sizeof(__u16)];
+ *
+ *	// A ring of used descriptor heads with free-running index.
+ *	__u16 used_idx;
+ *	struct vring_used_elem used[num];
+ * };
+ */
+struct virtqueue *vring_new_virtqueue(unsigned int num,
+				      struct device *dev,
+				      void *pages,
+				      void (*notify)(void *priv), void *priv,
+				      bool (*callback)(void *), void *cb_data);
+void vring_destroy_virtqueue(struct virtqueue *vq);
+
+irqreturn_t vring_interrupt(int irq, void *_vq);
+
+void *vring_priv(struct virtqueue *vq);
+
+int vring_add_buf(struct virtqueue *vq,
+		  struct scatterlist sg[],
+		  unsigned int out,
+		  unsigned int in,
+		  void *data);
+
+void vring_kick(struct virtqueue *vq);
+
+void *vring_get_buf(struct virtqueue *vq, unsigned int *len);
+
+bool vring_restart(struct virtqueue *vq);
+
+void vring_shutdown(struct virtqueue *vq);
+#endif /* _VRING_VRING_H */
===================================================================
--- /dev/null
+++ b/include/linux/virtio_ring.h
@@ -0,0 +1,96 @@
+#ifndef _LINUX_VIRTIO_RING_H
+#define _LINUX_VIRTIO_RING_H
+/* An interface for efficient virtio implementation, currently for use by KVM
+ * and lguest, but hopefully others soon.  Do NOT change this since it will
+ * break existing servers and clients.
+ *
+ * This header is BSD licensed so anyone can use the definitions to implement
+ * compatible drivers/servers.
+ *
+ * Copyright Rusty Russell IBM Corporation 2007. */
+#include <linux/types.h>
+
+/* This marks a buffer as continuing via the next field. */
+#define VRING_DESC_F_NEXT	1
+/* This marks a buffer as write-only (otherwise read-only). */
+#define VRING_DESC_F_WRITE	2
+
+/* Virtio ring descriptors: 16 bytes.  These can chain together via "next". */
+struct vring_desc
+{
+	/* Page number. */
+	__u64 pfn;
+	/* Length and offset. */
+	__u16 len;
+	__u16 offset;
+	/* The flags as indicated above. */
+	__u16 flags;
+	/* We chain unused descriptors via this, too */
+	__u16 next;
+};
+
+struct vring_avail
+{
+	__u16 idx;
+	__u16 ring[];
+};
+
+/* u32 is used here for ids for padding reasons. */
+struct vring_used_elem
+{
+	/* Index of start of used descriptor chain. */
+	__u32 id;
+	/* Total length of the descriptor chain which was used (written to) */
+	__u32 len;
+};
+
+struct vring_used
+{
+	__u32 idx;
+	struct vring_used_elem ring[];
+};
+
+struct vring {
+	unsigned int num;
+
+	struct vring_desc *desc;
+
+	struct vring_avail *avail;
+
+	struct vring_used *used;
+};
+
+/* The standard layout for the ring is a continuous chunk of memory which looks
+ * like this.  The used fields will be aligned to a "num+1" boundary.
+ *
+ * struct vring
+ * {
+ *	// The actual descriptors (16 bytes each)
+ *	struct vring_desc desc[num];
+ *
+ *	// A ring of available descriptor heads with free-running index.
+ *	__u16 avail_idx;
+ *	__u16 available[num];
+ *
+ *	// Padding so a correctly-chosen num value will cache-align used_idx.
+ *	char pad[sizeof(struct vring_desc)];
+ *
+ *	// A ring of used descriptor heads with free-running index.
+ *	__u32 used_idx;
+ *	struct vring_used_elem used[num];
+ * };
+ */
+static inline void vring_init(struct vring *vr, unsigned int num, void *p)
+{
+	vr->num = num;
+	vr->desc = p;
+	vr->avail = p + num*sizeof(struct vring);
+	vr->used = p + (num+1)*(sizeof(struct vring) + sizeof(__u16));
+}
+
+static inline unsigned vring_size(unsigned int num)
+{
+	return (num + 1) * (sizeof(struct vring_desc) + sizeof(__u16))
+		+ sizeof(__u32) + num * sizeof(struct vring_used_elem);
+}
+#endif /* _LINUX_VIRTIO_RING_H */
