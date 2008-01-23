From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/2] virtio reset support
Date: Thu, 24 Jan 2008 01:18:08 +1100
Message-ID: <200801240118.09032.rusty__12843.5310129591$1201098413$gmane$org@rustcorp.com.au>
References: <200801240116.26160.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801240116.26160.rusty@rustcorp.com.au>
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: Dor Laor <dor.laor@gmail.com>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

(One big patch, I'll merge it in properly later).

A reset function solves three problems:

1) It allows us to renegotiate features, eg. if we want to upgrade a
   guest driver without rebooting the guest.

2) It gives us a clean way of shutting down virtqueues: after a reset,
   we know that the buffers won't be used by the guest, and

3) It helps the guest recover from messed-up drivers.

So we remove the ->shutdown hook, and the only way we now remove
feature bits is via reset.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/char/hw_random/virtio-rng.c |    1 -
 drivers/lguest/lguest_device.c      |   15 ++++++++++++++-
 drivers/net/virtio_net.c            |    2 --
 drivers/virtio/virtio.c             |   13 ++++++++++---
 drivers/virtio/virtio_pci.c         |   10 ++++++++++
 drivers/virtio/virtio_ring.c        |   11 -----------
 include/linux/virtio.h              |    5 -----
 include/linux/virtio_config.h       |    4 ++++
 8 files changed, 38 insertions(+), 23 deletions(-)

diff -r f9464b21ed9c drivers/char/hw_random/virtio-rng.c
--- a/drivers/char/hw_random/virtio-rng.c	Wed Jan 23 23:52:47 2008 +1100
+++ b/drivers/char/hw_random/virtio-rng.c	Thu Jan 24 00:47:05 2008 +1100
@@ -92,7 +92,6 @@ static void virtrng_remove(struct virtio
 static void virtrng_remove(struct virtio_device *vdev)
 {
 	hwrng_unregister(&virtio_hwrng);
-	vq->vq_ops->shutdown(vq);
 	vdev->config->del_vq(vq);
 }
 
diff -r f9464b21ed9c drivers/lguest/lguest_device.c
--- a/drivers/lguest/lguest_device.c	Wed Jan 23 23:52:47 2008 +1100
+++ b/drivers/lguest/lguest_device.c	Thu Jan 24 00:47:05 2008 +1100
@@ -54,7 +54,7 @@ struct lguest_device {
  *
  * The configuration information for a device consists of one or more
  * virtqueues, a feature bitmaks, and some configuration bytes.  The
- * configuration bytes don't really matter to us: the Launcher set them up, and
+ * configuration bytes don't really matter to us: the Launcher sets them up, and
  * the driver will look at them during setup.
  *
  * A convenient routine to return the device's virtqueue config array:
@@ -139,7 +139,19 @@ static u8 lg_get_status(struct virtio_de
 
 static void lg_set_status(struct virtio_device *vdev, u8 status)
 {
+	BUG_ON(!status);
 	to_lgdev(vdev)->desc->status = status;
+}
+
+/* To reset the device, we (ab)use the NOTIFY hypercall, with the descriptor
+ * address of the device.  The Host will zero the status and all the
+ * features. */
+static void lg_reset(struct virtio_device *vdev)
+{
+	unsigned long offset = (void *)to_lgdev(vdev)->desc - lguest_devices;
+
+	printk("Resetting %i\n", vdev->index);
+	hcall(LHCALL_NOTIFY, (max_pfn<<PAGE_SHIFT) + offset, 0, 0);
 }
 
 /*
@@ -279,6 +291,7 @@ static struct virtio_config_ops lguest_c
 	.set = lg_set,
 	.get_status = lg_get_status,
 	.set_status = lg_set_status,
+	.reset = lg_reset,
 	.find_vq = lg_find_vq,
 	.del_vq = lg_del_vq,
 };
diff -r f9464b21ed9c drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c	Wed Jan 23 23:52:47 2008 +1100
+++ b/drivers/net/virtio_net.c	Thu Jan 24 00:47:05 2008 +1100
@@ -415,12 +415,10 @@ static void virtnet_remove(struct virtio
 	struct sk_buff *skb;
 
 	/* Free our skbs in send and recv queues, if any. */
-	vi->rvq->vq_ops->shutdown(vi->rvq);
 	while ((skb = __skb_dequeue(&vi->recv)) != NULL) {
 		kfree_skb(skb);
 		vi->num--;
 	}
-	vi->svq->vq_ops->shutdown(vi->svq);
 	while ((skb = __skb_dequeue(&vi->send)) != NULL)
 		kfree_skb(skb);
 
diff -r f9464b21ed9c drivers/virtio/virtio.c
--- a/drivers/virtio/virtio.c	Wed Jan 23 23:52:47 2008 +1100
+++ b/drivers/virtio/virtio.c	Thu Jan 24 00:47:05 2008 +1100
@@ -104,10 +104,13 @@ static int virtio_dev_remove(struct devi
 	struct virtio_driver *drv = container_of(dev->dev.driver,
 						 struct virtio_driver, driver);
 
-	dev->config->set_status(dev, dev->config->get_status(dev)
-				& ~(VIRTIO_CONFIG_S_DRIVER
-				    | VIRTIO_CONFIG_S_DRIVER_OK));
+	/* This shuts down all the virtqueues, so their buffers won't
+	 * be used. */
+	dev->config->reset(dev);
 	drv->remove(dev);
+
+	/* Acknowledge the device's existence again, after reset. */
+	add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 	return 0;
 }
 
@@ -139,6 +142,10 @@ int register_virtio_device(struct virtio
 	dev->dev.release = virtio_device_release;
 	sprintf(dev->dev.bus_id, "%u", dev->index);
 
+	/* We always start by resetting the device, in case a previous
+	 * driver messed it up.  This also tests that code path a little. */
+	dev->config->reset(dev);
+
 	/* Acknowledge that we've seen the device. */
 	add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
diff -r f9464b21ed9c drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c	Wed Jan 23 23:52:47 2008 +1100
+++ b/drivers/virtio/virtio_pci.c	Thu Jan 24 00:47:05 2008 +1100
@@ -148,7 +148,16 @@ static void vp_set_status(struct virtio_
 static void vp_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	/* We should never be setting status to 0. */
+	BUG_ON(status == 0);
 	return iowrite8(status, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
+}
+
+static void vp_reset(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	/* 0 status means a reset. */
+	return iowrite8(0, vp_dev->ioaddr + VIRTIO_PCI_STATUS);
 }
 
 /* the notify function used when creating a virt queue */
@@ -291,6 +300,7 @@ static struct virtio_config_ops virtio_p
 	.set		= vp_set,
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
+	.reset		= vp_reset,
 	.find_vq	= vp_find_vq,
 	.del_vq		= vp_del_vq,
 };
diff -r f9464b21ed9c drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c	Wed Jan 23 23:52:47 2008 +1100
+++ b/drivers/virtio/virtio_ring.c	Thu Jan 24 00:47:05 2008 +1100
@@ -173,16 +173,6 @@ static void detach_buf(struct vring_virt
 	vq->num_free++;
 }
 
-/* FIXME: We need to tell other side about removal, to synchronize. */
-static void vring_shutdown(struct virtqueue *_vq)
-{
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	unsigned int i;
-
-	for (i = 0; i < vq->vring.num; i++)
-		detach_buf(vq, i);
-}
-
 static inline bool more_used(const struct vring_virtqueue *vq)
 {
 	return vq->last_used_idx != vq->vring.used->idx;
@@ -287,7 +277,6 @@ static struct virtqueue_ops vring_vq_ops
 	.kick = vring_kick,
 	.disable_cb = vring_disable_cb,
 	.enable_cb = vring_enable_cb,
-	.shutdown = vring_shutdown,
 };
 
 struct virtqueue *vring_new_virtqueue(unsigned int num,
diff -r f9464b21ed9c include/linux/virtio.h
--- a/include/linux/virtio.h	Wed Jan 23 23:52:47 2008 +1100
+++ b/include/linux/virtio.h	Thu Jan 24 00:47:05 2008 +1100
@@ -45,9 +45,6 @@ struct virtqueue
  *	vq: the struct virtqueue we're talking about.
  *	This returns "false" (and doesn't re-enable) if there are pending
  *	buffers in the queue, to avoid a race.
- * @shutdown: "unadd" all buffers.
- *	vq: the struct virtqueue we're talking about.
- *	Remove everything from the queue.
  *
  * Locking rules are straightforward: the driver is responsible for
  * locking.  No two operations may be invoked simultaneously.
@@ -67,8 +64,6 @@ struct virtqueue_ops {
 
 	void (*disable_cb)(struct virtqueue *vq);
 	bool (*enable_cb)(struct virtqueue *vq);
-
-	void (*shutdown)(struct virtqueue *vq);
 };
 
 /**
diff -r f9464b21ed9c include/linux/virtio_config.h
--- a/include/linux/virtio_config.h	Wed Jan 23 23:52:47 2008 +1100
+++ b/include/linux/virtio_config.h	Thu Jan 24 00:47:05 2008 +1100
@@ -43,6 +43,9 @@ struct virtio_device;
  * @set_status: write the status byte
  *	vdev: the virtio_device
  *	status: the new status byte
+ * @reset: reset the device
+ *	vdev: the virtio device
+ *	After this, status and feature negotiation must be done again
  * @find_vq: find a virtqueue and instantiate it.
  *	vdev: the virtio_device
  *	index: the 0-based virtqueue number in case there's more than one.
@@ -59,6 +62,7 @@ struct virtio_config_ops
 		    const void *buf, unsigned len);
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
+	void (*reset)(struct virtio_device *vdev);
 	struct virtqueue *(*find_vq)(struct virtio_device *vdev,
 				     unsigned index,
 				     void (*callback)(struct virtqueue *));
