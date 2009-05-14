From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv6 1/4] virtio: add names to virtqueue struct, mapping from
	devices to queues.
Date: Thu, 14 May 2009 13:55:08 +0300
Message-ID: <20090514105508.GB3120__18289.1766228297$1242298970$gmane$org@redhat.com>
References: <cover.1242297977.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1242297977.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemonkey.ws>, kvm@vger.kernel.org, avi@redha
List-Id: virtualization@lists.linuxfoundation.org

From: Rusty Russell <rusty@rustcorp.com.au>

Add a linked list of all virtqueues for a virtio device: this helps for
debugging and is also needed for upcoming interface change.

Also, add a "name" field for clearer debug messages.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---

including this Rusty's patch here for completeness.

 drivers/block/virtio_blk.c          |    2 +-
 drivers/char/hw_random/virtio-rng.c |    2 +-
 drivers/char/virtio_console.c       |    4 ++--
 drivers/lguest/lguest_device.c      |    5 +++--
 drivers/net/virtio_net.c            |    6 +++---
 drivers/s390/kvm/kvm_virtio.c       |    7 ++++---
 drivers/virtio/virtio.c             |    2 ++
 drivers/virtio/virtio_balloon.c     |    4 ++--
 drivers/virtio/virtio_pci.c         |    5 +++--
 drivers/virtio/virtio_ring.c        |   25 +++++++++++++++++++------
 include/linux/virtio.h              |   12 ++++++++----
 include/linux/virtio_config.h       |    6 ++++--
 include/linux/virtio_ring.h         |    3 ++-
 net/9p/trans_virtio.c               |    2 +-
 14 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5d34764..8f7c956 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -224,7 +224,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	sg_init_table(vblk->sg, vblk->sg_elems);
 
 	/* We expect one virtqueue, for output. */
-	vblk->vq = vdev->config->find_vq(vdev, 0, blk_done);
+	vblk->vq = vdev->config->find_vq(vdev, 0, blk_done, "requests");
 	if (IS_ERR(vblk->vq)) {
 		err = PTR_ERR(vblk->vq);
 		goto out_free_vblk;
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 86e83f8..2aeafce 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -94,7 +94,7 @@ static int virtrng_probe(struct virtio_device *vdev)
 	int err;
 
 	/* We expect a single virtqueue. */
-	vq = vdev->config->find_vq(vdev, 0, random_recv_done);
+	vq = vdev->config->find_vq(vdev, 0, random_recv_done, "input");
 	if (IS_ERR(vq))
 		return PTR_ERR(vq);
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index ff6f5a4..58684e4 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -202,13 +202,13 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 	/* Find the input queue. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
-	in_vq = vdev->config->find_vq(vdev, 0, hvc_handle_input);
+	in_vq = vdev->config->find_vq(vdev, 0, hvc_handle_input, "input");
 	if (IS_ERR(in_vq)) {
 		err = PTR_ERR(in_vq);
 		goto free;
 	}
 
-	out_vq = vdev->config->find_vq(vdev, 1, NULL);
+	out_vq = vdev->config->find_vq(vdev, 1, NULL, "output");
 	if (IS_ERR(out_vq)) {
 		err = PTR_ERR(out_vq);
 		goto free_in_vq;
diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index df44d96..4babed8 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -228,7 +228,8 @@ extern void lguest_setup_irq(unsigned int irq);
  * function. */
 static struct virtqueue *lg_find_vq(struct virtio_device *vdev,
 				    unsigned index,
-				    void (*callback)(struct virtqueue *vq))
+				    void (*callback)(struct virtqueue *vq),
+				    const char *name)
 {
 	struct lguest_device *ldev = to_lgdev(vdev);
 	struct lguest_vq_info *lvq;
@@ -263,7 +264,7 @@ static struct virtqueue *lg_find_vq(struct virtio_device *vdev,
 	/* OK, tell virtio_ring.c to set up a virtqueue now we know its size
 	 * and we've got a pointer to its pages. */
 	vq = vring_new_virtqueue(lvq->config.num, LGUEST_VRING_ALIGN,
-				 vdev, lvq->pages, lg_notify, callback);
+				 vdev, lvq->pages, lg_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto unmap;
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 4d1d479..be3b734 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -906,20 +906,20 @@ static int virtnet_probe(struct virtio_device *vdev)
 		vi->mergeable_rx_bufs = true;
 
 	/* We expect two virtqueues, receive then send. */
-	vi->rvq = vdev->config->find_vq(vdev, 0, skb_recv_done);
+	vi->rvq = vdev->config->find_vq(vdev, 0, skb_recv_done, "input");
 	if (IS_ERR(vi->rvq)) {
 		err = PTR_ERR(vi->rvq);
 		goto free;
 	}
 
-	vi->svq = vdev->config->find_vq(vdev, 1, skb_xmit_done);
+	vi->svq = vdev->config->find_vq(vdev, 1, skb_xmit_done, "output");
 	if (IS_ERR(vi->svq)) {
 		err = PTR_ERR(vi->svq);
 		goto free_recv;
 	}
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ)) {
-		vi->cvq = vdev->config->find_vq(vdev, 2, NULL);
+		vi->cvq = vdev->config->find_vq(vdev, 2, NULL, "control");
 		if (IS_ERR(vi->cvq)) {
 			err = PTR_ERR(vi->svq);
 			goto free_send;
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index cbc8566..ba8995f 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -173,8 +173,9 @@ static void kvm_notify(struct virtqueue *vq)
  * this device and sets it up.
  */
 static struct virtqueue *kvm_find_vq(struct virtio_device *vdev,
-				    unsigned index,
-				    void (*callback)(struct virtqueue *vq))
+				     unsigned index,
+				     void (*callback)(struct virtqueue *vq),
+				     const char *name)
 {
 	struct kvm_device *kdev = to_kvmdev(vdev);
 	struct kvm_vqconfig *config;
@@ -194,7 +195,7 @@ static struct virtqueue *kvm_find_vq(struct virtio_device *vdev,
 
 	vq = vring_new_virtqueue(config->num, KVM_S390_VIRTIO_RING_ALIGN,
 				 vdev, (void *) config->address,
-				 kvm_notify, callback);
+				 kvm_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto unmap;
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 018c070..f72e936 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -185,6 +185,8 @@ int register_virtio_device(struct virtio_device *dev)
 	/* Acknowledge that we've seen the device. */
 	add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
+	INIT_LIST_HEAD(&dev->vqs);
+
 	/* device_register() causes the bus infrastructure to look for a
 	 * matching driver. */
 	err = device_register(&dev->dev);
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 9c76a06..0fa73b4 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -218,13 +218,13 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	vb->vdev = vdev;
 
 	/* We expect two virtqueues. */
-	vb->inflate_vq = vdev->config->find_vq(vdev, 0, balloon_ack);
+	vb->inflate_vq = vdev->config->find_vq(vdev, 0, balloon_ack, "inflate");
 	if (IS_ERR(vb->inflate_vq)) {
 		err = PTR_ERR(vb->inflate_vq);
 		goto out_free_vb;
 	}
 
-	vb->deflate_vq = vdev->config->find_vq(vdev, 1, balloon_ack);
+	vb->deflate_vq = vdev->config->find_vq(vdev, 1, balloon_ack, "deflate");
 	if (IS_ERR(vb->deflate_vq)) {
 		err = PTR_ERR(vb->deflate_vq);
 		goto out_del_inflate_vq;
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 330aacb..be4047a 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -208,7 +208,8 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 
 /* the config->find_vq() implementation */
 static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
-				    void (*callback)(struct virtqueue *vq))
+				    void (*callback)(struct virtqueue *vq),
+				    const char *name)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
@@ -247,7 +248,7 @@ static struct virtqueue *vp_find_vq(struct virtio_device *vdev, unsigned index,
 
 	/* create the vring */
 	vq = vring_new_virtqueue(info->num, VIRTIO_PCI_VRING_ALIGN,
-				 vdev, info->queue, vp_notify, callback);
+				 vdev, info->queue, vp_notify, callback, name);
 	if (!vq) {
 		err = -ENOMEM;
 		goto out_activate_queue;
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5c52369..8cf39d4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -23,21 +23,30 @@
 
 #ifdef DEBUG
 /* For development, we want to crash whenever the ring is screwed. */
-#define BAD_RING(_vq, fmt...)			\
-	do { dev_err(&(_vq)->vq.vdev->dev, fmt); BUG(); } while(0)
+#define BAD_RING(_vq, fmt, args...)				\
+	do {							\
+		dev_err(&(_vq)->vq.vdev->dev,			\
+			"%s:"fmt, (_vq)->vq.name, ##args);	\
+		BUG();						\
+	} while (0)
 /* Caller is supposed to guarantee no reentry. */
 #define START_USE(_vq)						\
 	do {							\
 		if ((_vq)->in_use)				\
-			panic("in_use = %i\n", (_vq)->in_use);	\
+			panic("%s:in_use = %i\n",		\
+			      (_vq)->vq.name, (_vq)->in_use);	\
 		(_vq)->in_use = __LINE__;			\
 		mb();						\
 	} while(0)
 #define END_USE(_vq) \
 	do { BUG_ON(!(_vq)->in_use); (_vq)->in_use = 0; mb(); } while(0)
 #else
-#define BAD_RING(_vq, fmt...)			\
-	do { dev_err(&_vq->vq.vdev->dev, fmt); (_vq)->broken = true; } while(0)
+#define BAD_RING(_vq, fmt, args...)				\
+	do {							\
+		dev_err(&_vq->vq.vdev->dev,			\
+			"%s:"fmt, (_vq)->vq.name, ##args);	\
+		(_vq)->broken = true;				\
+	} while(0)
 #define START_USE(vq)
 #define END_USE(vq)
 #endif
@@ -284,7 +293,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
 				      struct virtio_device *vdev,
 				      void *pages,
 				      void (*notify)(struct virtqueue *),
-				      void (*callback)(struct virtqueue *))
+				      void (*callback)(struct virtqueue *),
+				      const char *name)
 {
 	struct vring_virtqueue *vq;
 	unsigned int i;
@@ -303,10 +313,12 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.vq_ops = &vring_vq_ops;
+	vq->vq.name = name;
 	vq->notify = notify;
 	vq->broken = false;
 	vq->last_used_idx = 0;
 	vq->num_added = 0;
+	list_add_tail(&vq->vq.list, &vdev->vqs);
 #ifdef DEBUG
 	vq->in_use = false;
 #endif
@@ -327,6 +339,7 @@ EXPORT_SYMBOL_GPL(vring_new_virtqueue);
 
 void vring_del_virtqueue(struct virtqueue *vq)
 {
+	list_del(&vq->list);
 	kfree(to_vvq(vq));
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 06005fa..4dc1c0e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -10,14 +10,17 @@
 
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
+ * @list: the chain of virtqueues for this device
  * @callback: the function to call when buffers are consumed (can be NULL).
+ * @name: the name of this virtqueue (mainly for debugging)
  * @vdev: the virtio device this queue was created for.
  * @vq_ops: the operations for this virtqueue (see below).
  * @priv: a pointer for the virtqueue implementation to use.
  */
-struct virtqueue
-{
+struct virtqueue {
+	struct list_head list;
 	void (*callback)(struct virtqueue *vq);
+	const char *name;
 	struct virtio_device *vdev;
 	struct virtqueue_ops *vq_ops;
 	void *priv;
@@ -76,15 +79,16 @@ struct virtqueue_ops {
  * @dev: underlying device.
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
+ * @vqs: the list of virtqueues for this device.
  * @features: the features supported by both driver and device.
  * @priv: private pointer for the driver's use.
  */
-struct virtio_device
-{
+struct virtio_device {
 	int index;
 	struct device dev;
 	struct virtio_device_id id;
 	struct virtio_config_ops *config;
+	struct list_head vqs;
 	/* Note that this is a Linux set_bit-style bitmap. */
 	unsigned long features[1];
 	void *priv;
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bf8ec28..9fae274 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -55,7 +55,8 @@
  * @find_vq: find a virtqueue and instantiate it.
  *	vdev: the virtio_device
  *	index: the 0-based virtqueue number in case there's more than one.
- *	callback: the virqtueue callback
+ *	callback: the virtqueue callback
+ *	name: the virtqueue name (mainly for debugging)
  *	Returns the new virtqueue or ERR_PTR() (eg. -ENOENT).
  * @del_vq: free a virtqueue found by find_vq().
  * @get_features: get the array of feature bits for this device.
@@ -77,7 +78,8 @@ struct virtio_config_ops
 	void (*reset)(struct virtio_device *vdev);
 	struct virtqueue *(*find_vq)(struct virtio_device *vdev,
 				     unsigned index,
-				     void (*callback)(struct virtqueue *));
+				     void (*callback)(struct virtqueue *),
+				     const char *name);
 	void (*del_vq)(struct virtqueue *vq);
 	u32 (*get_features)(struct virtio_device *vdev);
 	void (*finalize_features)(struct virtio_device *vdev);
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index 71e0372..166c519 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -119,7 +119,8 @@ struct virtqueue *vring_new_virtqueue(unsigned int num,
 				      struct virtio_device *vdev,
 				      void *pages,
 				      void (*notify)(struct virtqueue *vq),
-				      void (*callback)(struct virtqueue *vq));
+				      void (*callback)(struct virtqueue *vq),
+				      const char *name);
 void vring_del_virtqueue(struct virtqueue *vq);
 /* Filter out transport-specific feature bits. */
 void vring_transport_features(struct virtio_device *vdev);
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index bb8579a..ab8791f 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -246,7 +246,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 	chan->vdev = vdev;
 
 	/* We expect one virtqueue, for requests. */
-	chan->vq = vdev->config->find_vq(vdev, 0, req_done);
+	chan->vq = vdev->config->find_vq(vdev, 0, req_done, "requests");
 	if (IS_ERR(chan->vq)) {
 		err = PTR_ERR(chan->vq);
 		goto out_free_vq;
-- 
1.6.3.rc3.1.g830204
