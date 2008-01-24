From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH] KVM simplified virtio balloon driver
Date: Thu, 24 Jan 2008 12:58:59 +1100
Message-ID: <200801241258.59441.rusty__17327.717660419$1201140150$gmane$org@rustcorp.com.au>
References: <20080114200357.GA18354@dmt> <20080120002433.GA6880@dmt>
	<47929884.2010908@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <47929884.2010908@codemonkey.ws>
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
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Marcelo Tosatti <marcelo@kvack.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Here's the latest.  Hope this works for everyone (putting in a oom handler or
shrinker requires a lock, but can be done quite easily).

Untested.
===
After discussions with Anthony Liguori, it seems that the virtio
balloon can be made even simpler.  Here's my attempt.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/Kconfig          |   10 +
 drivers/virtio/Makefile         |    1 
 drivers/virtio/virtio_balloon.c |  284 ++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_balloon.h  |   18 ++
 4 files changed, 313 insertions(+)

diff -r e977a88ffefd drivers/virtio/Kconfig
--- a/drivers/virtio/Kconfig	Thu Jan 24 12:34:05 2008 +1100
+++ b/drivers/virtio/Kconfig	Thu Jan 24 12:40:07 2008 +1100
@@ -23,3 +23,13 @@ config VIRTIO_PCI
 
 	  If unsure, say M.
 
+config VIRTIO_BALLOON
+	tristate "Virtio balloon driver (EXPERIMENTAL)"
+	select VIRTIO
+	select VIRTIO_RING
+	---help---
+	 This driver supports increasing and decreasing the amount 
+	 of memory within a KVM guest.
+
+	 If unsure, say M.
+
diff -r e977a88ffefd drivers/virtio/Makefile
--- a/drivers/virtio/Makefile	Thu Jan 24 12:34:05 2008 +1100
+++ b/drivers/virtio/Makefile	Thu Jan 24 12:40:07 2008 +1100
@@ -1,3 +1,4 @@ obj-$(CONFIG_VIRTIO) += virtio.o
 obj-$(CONFIG_VIRTIO) += virtio.o
 obj-$(CONFIG_VIRTIO_RING) += virtio_ring.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
+obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
diff -r e977a88ffefd drivers/virtio/virtio_balloon.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/drivers/virtio/virtio_balloon.c	Thu Jan 24 12:40:07 2008 +1100
@@ -0,0 +1,284 @@
+/* Virtio balloon implementation, inspired by Dor Loar and Marcelo
+ * Tosatti's implementations.
+ *
+ *  Copyright 2008 Rusty Russell IBM Corporation
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
+#define DEBUG
+#include <linux/virtio.h>
+#include <linux/virtio_balloon.h>
+#include <linux/swap.h>
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+
+struct virtio_balloon
+{
+	struct virtio_device *vdev;
+	struct virtqueue *inflate_vq, *deflate_vq;
+
+	/* Where the ballooning thread waits for config to change. */
+	wait_queue_head_t config_change;
+
+	/* The thread servicing the balloon. */
+	struct task_struct *thread;
+
+	/* Waiting for host to ack the pages we released. */
+	struct completion acked;
+
+	/* Do we have to tell Host *before* we reuse pages? */
+	bool tell_host_first;
+
+	/* The pages we've told the Host we're not using. */
+	unsigned int num_pages;
+	struct list_head pages;
+
+	/* The array of pfns we tell the Host about. */
+	unsigned int num_pfns;
+	u32 pfns[256];
+};
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_BALLOON, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static void balloon_ack(struct virtqueue *vq)
+{
+	struct virtio_balloon *vb;
+	unsigned int len;
+
+	vb = vq->vq_ops->get_buf(vq, &len);
+	if (vb)
+		complete(&vb->acked);
+}
+
+static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
+{
+	struct scatterlist sg;
+
+	sg_init_one(&sg, vb->pfns, sizeof(vb->pfns[0]) * vb->num_pfns);
+
+	init_completion(&vb->acked);
+
+	/* We should always be able to add one buffer to an empty queue. */
+	if (vq->vq_ops->add_buf(vq, &sg, 1, 0, vb) != 0)
+		BUG();
+	vq->vq_ops->kick(vq);
+
+	/* When host has read buffer, this completes via balloon_ack */
+	wait_for_completion(&vb->acked);
+}
+
+static void fill_balloon(struct virtio_balloon *vb, unsigned int num)
+{
+	/* We can only do one array worth at a time. */
+	num = min(num, ARRAY_SIZE(vb->pfns));
+
+	for (vb->num_pfns = 0; vb->num_pfns < num; vb->num_pfns++) {
+		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY);
+		if (!page) {
+			if (printk_ratelimit())
+				dev_printk(KERN_INFO, &vb->vdev->dev,
+					   "Out of puff! Can't get %u pages\n",
+					   num);
+			/* Sleep for at least 1/5 of a second before retry. */
+			msleep(200);
+			break;
+		}
+		vb->pfns[vb->num_pfns] = page_to_pfn(page);
+		totalram_pages--;
+		vb->num_pages++;
+		list_add(&page->lru, &vb->pages);
+	}
+
+	/* Didn't get any?  Oh well. */
+	if (vb->num_pfns == 0)
+		return;
+
+	tell_host(vb, vb->inflate_vq);
+}
+
+static void release_pages_by_pfn(const u32 pfns[], unsigned int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++) {
+		__free_page(pfn_to_page(pfns[i]));
+		totalram_pages++;
+	}
+}
+
+static void leak_balloon(struct virtio_balloon *vb, unsigned int num)
+{
+	struct page *page;
+
+	/* We can only do one array worth at a time. */
+	num = min(num, ARRAY_SIZE(vb->pfns));
+
+	for (vb->num_pfns = 0; vb->num_pfns < num; vb->num_pfns++) {
+		page = list_first_entry(&vb->pages, struct page, lru);
+		list_del(&page->lru);
+		vb->pfns[vb->num_pfns] = page_to_pfn(page);
+		vb->num_pages--;
+	}
+
+	if (vb->tell_host_first) {
+		tell_host(vb, vb->deflate_vq);
+		release_pages_by_pfn(vb->pfns, vb->num_pfns);
+	} else {
+		release_pages_by_pfn(vb->pfns, vb->num_pfns);
+		tell_host(vb, vb->deflate_vq);
+	}
+}
+
+static void virtballoon_changed(struct virtio_device *vdev)
+{
+	struct virtio_balloon *vb = vdev->priv;
+
+	wake_up(&vb->config_change);
+}
+
+static inline int towards_target(struct virtio_balloon *vb)
+{
+	u32 v;
+	__virtio_config_val(vb->vdev,
+			    offsetof(struct virtio_balloon_config, num_pages),
+			    &v);
+	return v - vb->num_pages;
+}
+
+static void update_balloon_size(struct virtio_balloon *vb)
+{
+	__le32 actual = cpu_to_le32(vb->num_pages);
+
+	vb->vdev->config->set(vb->vdev,
+			      offsetof(struct virtio_balloon_config, actual),
+			      &actual, sizeof(actual));
+}
+
+static int balloon(void *_vballoon)
+{
+	struct virtio_balloon *vb = _vballoon;
+
+	set_freezable();
+	while (!kthread_should_stop()) {
+		int diff;
+
+		try_to_freeze();
+		wait_event_interruptible(vb->config_change,
+					 (diff = towards_target(vb)) != 0
+					 || kthread_should_stop());
+		if (diff > 0)
+			fill_balloon(vb, diff);
+		else if (diff < 0)
+			leak_balloon(vb, -diff);
+		update_balloon_size(vb);
+	}
+	return 0;
+}
+
+static int virtballoon_probe(struct virtio_device *vdev)
+{
+	struct virtio_balloon *vb;
+	int err;
+
+	vdev->priv = vb = kmalloc(sizeof(*vb), GFP_KERNEL);
+	if (!vb) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&vb->pages);
+	vb->num_pages = 0;
+	init_waitqueue_head(&vb->config_change);
+	vb->vdev = vdev;
+
+	/* We expect two virtqueues. */
+	vb->inflate_vq = vdev->config->find_vq(vdev, 0, balloon_ack);
+	if (IS_ERR(vb->inflate_vq)) {
+		err = PTR_ERR(vb->inflate_vq);
+		goto out_free_vb;
+	}
+
+	vb->deflate_vq = vdev->config->find_vq(vdev, 1, balloon_ack);
+	if (IS_ERR(vb->deflate_vq)) {
+		err = PTR_ERR(vb->deflate_vq);
+		goto out_del_inflate_vq;
+	}
+
+	vb->thread = kthread_run(balloon, vb, "vballoon");
+	if (IS_ERR(vb->thread)) {
+		err = PTR_ERR(vb->thread);
+		goto out_del_deflate_vq;
+	}
+
+	vb->tell_host_first
+		= vdev->config->feature(vdev, VIRTIO_BALLOON_F_MUST_TELL_HOST);
+
+	return 0;
+
+out_del_deflate_vq:
+	vdev->config->del_vq(vb->deflate_vq);
+out_del_inflate_vq:
+	vdev->config->del_vq(vb->inflate_vq);
+out_free_vb:
+	kfree(vb);
+out:
+	return err;
+}
+
+static void virtballoon_remove(struct virtio_device *vdev)
+{
+	struct virtio_balloon *vb = vdev->priv;
+
+	kthread_stop(vb->thread);
+
+	/* There might be pages left in the balloon: free them. */
+	while (vb->num_pages)
+		leak_balloon(vb, vb->num_pages);
+
+	/* Now we reset the device so we can clean up the queues. */
+	vdev->config->reset(vdev);
+
+	vdev->config->del_vq(vb->deflate_vq);
+	vdev->config->del_vq(vb->inflate_vq);
+	kfree(vb);
+}
+
+static struct virtio_driver virtio_balloon = {
+	.driver.name =	KBUILD_MODNAME,
+	.driver.owner =	THIS_MODULE,
+	.id_table =	id_table,
+	.probe =	virtballoon_probe,
+	.remove =	__devexit_p(virtballoon_remove),
+	.config_changed = virtballoon_changed,
+};
+
+static int __init init(void)
+{
+	return register_virtio_driver(&virtio_balloon);
+}
+
+static void __exit fini(void)
+{
+	unregister_virtio_driver(&virtio_balloon);
+}
+module_init(init);
+module_exit(fini);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Virtio balloon driver");
+MODULE_LICENSE("GPL");
diff -r e977a88ffefd include/linux/virtio_balloon.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/linux/virtio_balloon.h	Thu Jan 24 12:40:07 2008 +1100
@@ -0,0 +1,18 @@
+#ifndef _LINUX_VIRTIO_BALLOON_H
+#define _LINUX_VIRTIO_BALLOON_H
+#include <linux/virtio_config.h>
+
+/* The ID for virtio_balloon */
+#define VIRTIO_ID_BALLOON	5
+
+/* The feature bitmap for virtio balloon */
+#define VIRTIO_BALLOON_F_MUST_TELL_HOST	0 /* Tell before reclaiming pages */
+
+struct virtio_balloon_config
+{
+	/* Number of pages host wants Guest to give up. */
+	__le32 num_pages;
+	/* Number of pages we've actually got in balloon. */
+	__le32 actual;
+};
+#endif /* _LINUX_VIRTIO_BALLOON_H */
