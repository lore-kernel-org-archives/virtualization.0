From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Thu, 7 May 2009 17:10:39 +0300
Message-ID: <20090507141039.GA1530__2346.63694068349$1241705579$gmane$org@redhat.com>
References: <cover.1241700929.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1241700929.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: avi@redhat.com, kvm@vger.kernel.org, Anthony Liguori <anthony@codemonkey.ws>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This replaces find_vq/del_vq with find_vqs/del_vqs virtio operations,
and updates all drivers. This is needed for MSI support, because MSI
needs to know the total number of vectors upfront.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c          |   11 +++---
 drivers/char/hw_random/virtio-rng.c |   11 +++---
 drivers/char/virtio_console.c       |   27 ++++++--------
 drivers/lguest/lguest_device.c      |   49 +++++++++++++++++++++++++-
 drivers/net/virtio_net.c            |   47 +++++++++++---------------
 drivers/s390/kvm/kvm_virtio.c       |   64 +++++++++++++++++++++++++++++++++-
 drivers/virtio/virtio_balloon.c     |   31 ++++++++---------
 drivers/virtio/virtio_pci.c         |   43 +++++++++++++++++++----
 include/linux/virtio_config.h       |   29 +++++++++++-----
 9 files changed, 222 insertions(+), 90 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 5d34764..7b7435d 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -197,6 +197,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	u64 cap;
 	u32 v;
 	u32 blk_size, sg_elems;
+	virtqueue_callback *callback[] = { blk_done };
 
 	if (index_to_minor(index) >= 1 << MINORBITS)
 		return -ENOSPC;
@@ -224,11 +225,9 @@ static int virtblk_probe(struct virtio_device *vdev)
 	sg_init_table(vblk->sg, vblk->sg_elems);
 
 	/* We expect one virtqueue, for output. */
-	vblk->vq = vdev->config->find_vq(vdev, 0, blk_done);
-	if (IS_ERR(vblk->vq)) {
-		err = PTR_ERR(vblk->vq);
+	err = vdev->config->find_vqs(vdev, 1, &vblk->vq, callback);
+	if (err)
 		goto out_free_vblk;
-	}
 
 	vblk->pool = mempool_create_kmalloc_pool(1,sizeof(struct virtblk_req));
 	if (!vblk->pool) {
@@ -323,7 +322,7 @@ out_put_disk:
 out_mempool:
 	mempool_destroy(vblk->pool);
 out_free_vq:
-	vdev->config->del_vq(vblk->vq);
+	vdev->config->del_vqs(vdev);
 out_free_vblk:
 	kfree(vblk);
 out:
@@ -344,7 +343,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 	blk_cleanup_queue(vblk->disk->queue);
 	put_disk(vblk->disk);
 	mempool_destroy(vblk->pool);
-	vdev->config->del_vq(vblk->vq);
+	vdev->config->del_vqs(vdev);
 	kfree(vblk);
 }
 
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 86e83f8..18eabe4 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -91,16 +91,17 @@ static struct hwrng virtio_hwrng = {
 
 static int virtrng_probe(struct virtio_device *vdev)
 {
+	virtqueue_callback *callback[] = { random_recv_done };
 	int err;
 
 	/* We expect a single virtqueue. */
-	vq = vdev->config->find_vq(vdev, 0, random_recv_done);
-	if (IS_ERR(vq))
-		return PTR_ERR(vq);
+	err = vdev->config->find_vqs(vdev, 1, &vq, callback);
+	if (err)
+		return err;
 
 	err = hwrng_register(&virtio_hwrng);
 	if (err) {
-		vdev->config->del_vq(vq);
+		vdev->config->del_vqs(vdev);
 		return err;
 	}
 
@@ -112,7 +113,7 @@ static void virtrng_remove(struct virtio_device *vdev)
 {
 	vdev->config->reset(vdev);
 	hwrng_unregister(&virtio_hwrng);
-	vdev->config->del_vq(vq);
+	vdev->config->del_vqs(vdev);
 }
 
 static struct virtio_device_id id_table[] = {
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index ff6f5a4..1fd5376 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -188,6 +188,8 @@ static void hvc_handle_input(struct virtqueue *vq)
  * Finally we put our input buffer in the input queue, ready to receive. */
 static int __devinit virtcons_probe(struct virtio_device *dev)
 {
+	struct virtqueue *vqs[2];
+	virtqueue_callback *callbacks[2];
 	int err;
 
 	vdev = dev;
@@ -199,20 +201,17 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 		goto fail;
 	}
 
-	/* Find the input queue. */
+	/* Find the queues. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
-	in_vq = vdev->config->find_vq(vdev, 0, hvc_handle_input);
-	if (IS_ERR(in_vq)) {
-		err = PTR_ERR(in_vq);
+	callbacks[0] = hvc_handle_input;
+	callbacks[1] = NULL;
+	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks);
+	if (err)
 		goto free;
-	}
 
-	out_vq = vdev->config->find_vq(vdev, 1, NULL);
-	if (IS_ERR(out_vq)) {
-		err = PTR_ERR(out_vq);
-		goto free_in_vq;
-	}
+	in_vq = vqs[0];
+	out_vq = vqs[1];
 
 	/* Start using the new console output. */
 	virtio_cons.get_chars = get_chars;
@@ -233,17 +232,15 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 	hvc = hvc_alloc(0, 0, &virtio_cons, PAGE_SIZE);
 	if (IS_ERR(hvc)) {
 		err = PTR_ERR(hvc);
-		goto free_out_vq;
+		goto free_vqs;
 	}
 
 	/* Register the input buffer the first time. */
 	add_inbuf();
 	return 0;
 
-free_out_vq:
-	vdev->config->del_vq(out_vq);
-free_in_vq:
-	vdev->config->del_vq(in_vq);
+free_vqs:
+	vdev->config->del_vqs(vdev);
 free:
 	kfree(inbuf);
 fail:
diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index df44d96..53699aa 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -37,6 +37,10 @@ static inline void lguest_unmap(void *addr)
 struct lguest_device {
 	struct virtio_device vdev;
 
+	/* Array of virtqueues */
+	struct virtqueue **vqs;
+	int nvqs;
+
 	/* The entry in the lguest_devices page for this device. */
 	struct lguest_device_desc *desc;
 };
@@ -312,6 +316,47 @@ static void lg_del_vq(struct virtqueue *vq)
 	kfree(lvq);
 }
 
+static void lg_del_vqs(struct virtio_device *vdev)
+{
+	struct lguest_device *ldev = to_lgdev(vdev);
+	int i;
+	if (!ldev->vqs)
+		return;
+	for (i = 0; i < ldev->nvqs; ++i)
+		lg_del_vq(ldev->vqs[i]);
+	kfree(ldev->vqs);
+	ldev->vqs = NULL;
+	ldev->nvqs = 0;
+}
+
+static int lg_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+		       struct virtqueue *vqs[]
+		       void (*callbacks)[](struct virtqueue *))
+{
+	struct lguest_device *ldev = to_lgdev(vdev);
+	int i;
+
+	/* We must have this many virtqueues. */
+	if (nvqs > ldev->desc->num_vq)
+		return ERR_PTR(-ENOENT);
+
+	ldev->vqs = kmalloc(GFP_KERNEL, nvqs * sizeof *ldev->vqs);
+	if (!ldev->vqs)
+		return -ENOMEM;
+
+	for (i = 0; i < nvqs; ++i) {
+		ldev->vqs[i] = vqs[i] = lg_find_vq(vdev, i, callbacks[i]);
+		if (IS_ERR(vqs[i]))
+			goto error;
+		ldev->nvqs = i;
+	}
+	return 0;
+
+error:
+	vp_del_vqs(vdev);
+	return PTR_ERR(vqs[i]);
+}
+
 /* The ops structure which hooks everything together. */
 static struct virtio_config_ops lguest_config_ops = {
 	.get_features = lg_get_features,
@@ -321,8 +366,8 @@ static struct virtio_config_ops lguest_config_ops = {
 	.get_status = lg_get_status,
 	.set_status = lg_set_status,
 	.reset = lg_reset,
-	.find_vq = lg_find_vq,
-	.del_vq = lg_del_vq,
+	.find_vqs = lg_find_vqs,
+	.del_vqs = lg_del_vqs,
 };
 
 /* The root device for the lguest virtio devices.  This makes them appear as
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9c82a39..a7cc1c7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -841,6 +841,9 @@ static int virtnet_probe(struct virtio_device *vdev)
 	int err;
 	struct net_device *dev;
 	struct virtnet_info *vi;
+	struct virtqueue *vqs[3];
+	virtqueue_callback *callbacks[3];
+	int nvqs;
 
 	/* Allocate ourselves a network device with room for our info */
 	dev = alloc_etherdev(sizeof(struct virtnet_info));
@@ -901,25 +904,23 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 		vi->mergeable_rx_bufs = true;
 
-	/* We expect two virtqueues, receive then send. */
-	vi->rvq = vdev->config->find_vq(vdev, 0, skb_recv_done);
-	if (IS_ERR(vi->rvq)) {
-		err = PTR_ERR(vi->rvq);
+	/* We expect two virtqueues, receive then send,
+	 * and optionally control. */
+	callbacks[0] = skb_recv_done;
+	callbacks[1] = skb_xmit_done;
+	callbacks[2] = NULL;
+
+	nvqs = virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ) ? 3 : 2;
+
+	err = vdev->config->find_vqs(vdev, nvqs, vqs, callbacks);
+	if (err)
 		goto free;
-	}
 
-	vi->svq = vdev->config->find_vq(vdev, 1, skb_xmit_done);
-	if (IS_ERR(vi->svq)) {
-		err = PTR_ERR(vi->svq);
-		goto free_recv;
-	}
+	vi->rvq = vqs[0];
+	vi->svq = vqs[1];
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ)) {
-		vi->cvq = vdev->config->find_vq(vdev, 2, NULL);
-		if (IS_ERR(vi->cvq)) {
-			err = PTR_ERR(vi->svq);
-			goto free_send;
-		}
+		vi->cvq = vqs[2];
 
 		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VLAN))
 			dev->features |= NETIF_F_HW_VLAN_FILTER;
@@ -937,7 +938,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	err = register_netdev(dev);
 	if (err) {
 		pr_debug("virtio_net: registering device failed\n");
-		goto free_ctrl;
+		goto free_vqs;
 	}
 
 	/* Last of all, set up some receive buffers. */
@@ -958,13 +959,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
 unregister:
 	unregister_netdev(dev);
-free_ctrl:
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ))
-		vdev->config->del_vq(vi->cvq);
-free_send:
-	vdev->config->del_vq(vi->svq);
-free_recv:
-	vdev->config->del_vq(vi->rvq);
+free_vqs:
+	vdev->config->del_vqs(vdev);
 free:
 	free_netdev(dev);
 	return err;
@@ -990,10 +986,7 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	BUG_ON(vi->num != 0);
 
-	vdev->config->del_vq(vi->svq);
-	vdev->config->del_vq(vi->rvq);
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ))
-		vdev->config->del_vq(vi->cvq);
+	vdev->config->del_vqs(vi->vdev);
 	unregister_netdev(vi->dev);
 
 	while (vi->pages)
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index cbc8566..6787426 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -34,6 +34,11 @@ static void *kvm_devices;
 
 struct kvm_device {
 	struct virtio_device vdev;
+
+	/* Array of virtqueues */
+	struct virtqueue **vqs;
+	int nvqs;
+
 	struct kvm_device_desc *desc;
 };
 
@@ -226,6 +231,61 @@ static void kvm_del_vq(struct virtqueue *vq)
 				       KVM_S390_VIRTIO_RING_ALIGN));
 }
 
+static void kvm_del_vqs(struct virtio_device *vdev)
+{
+	struct kvm_device *kdev = to_kvmdev(vdev);
+	int i;
+	if (!kdev->vqs)
+		return;
+	for (i = 0; i < ldev->nvqs; ++i)
+		kvm_del_vq(kdev->vqs[i]);
+	kfree(ldev->vqs);
+	ldev->vqs = NULL;
+	ldev->nvqs = 0;
+}
+
+static int kvm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+			struct virtqueue *vqs[]
+			void (*callbacks)[](struct virtqueue *))
+{
+	struct kvm_device *kdev = to_kvmdev(vdev);
+	int i;
+
+	/* We must have this many virtqueues. */
+	if (nvqs > kdev->desc->num_vq)
+		return ERR_PTR(-ENOENT);
+
+	kdev->vqs = kmalloc(GFP_KERNEL, nvqs * sizeof *kdev->vqs);
+	if (!kdev->vqs)
+		return -ENOMEM;
+
+	for (i = 0; i < nvqs; ++i) {
+		kdev->vqs[i] = vqs[i] = kvm_find_vq(vdev, i, callbacks[i]);
+		if (IS_ERR(vqs[i]))
+			goto error;
+		kdev->nvqs = i;
+	}
+	return 0;
+
+error:
+	kvm_del_vqs(vdev);
+	return PTR_ERR(vqs[i]);
+}
+
+static void kvm_del_vqs(struct virtio_device *vdev)
+{
+	struct lguest_device *ldev = to_lgdev(vdev);
+	int i;
+
+	if (!ldev->vqs)
+		return;
+	for (i = 0; i < ldev->nvqs; ++i)
+		lg_del_vq(ldev->vqs[i]);
+	kfree(ldev->vqs);
+	ldev->vqs = NULL;
+	ldev->nvqs = 0;
+}
+
 /*
  * The config ops structure as defined by virtio config
  */
@@ -237,8 +297,8 @@ static struct virtio_config_ops kvm_vq_configspace_ops = {
 	.get_status = kvm_get_status,
 	.set_status = kvm_set_status,
 	.reset = kvm_reset,
-	.find_vq = kvm_find_vq,
-	.del_vq = kvm_del_vq,
+	.find_vqs = kvm_find_vqs,
+	.del_vqs = kvm_del_vqs,
 };
 
 /*
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 9c76a06..549073b 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -204,6 +204,8 @@ static int balloon(void *_vballoon)
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
+	struct virtqueue *vqs[2];
+	virtqueue_callback *callbacks[2];
 	int err;
 
 	vdev->priv = vb = kmalloc(sizeof(*vb), GFP_KERNEL);
@@ -218,22 +220,20 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	vb->vdev = vdev;
 
 	/* We expect two virtqueues. */
-	vb->inflate_vq = vdev->config->find_vq(vdev, 0, balloon_ack);
-	if (IS_ERR(vb->inflate_vq)) {
-		err = PTR_ERR(vb->inflate_vq);
-		goto out_free_vb;
-	}
+	callbacks[0] = balloon_ack;
+	callbacks[1] = balloon_ack;
 
-	vb->deflate_vq = vdev->config->find_vq(vdev, 1, balloon_ack);
-	if (IS_ERR(vb->deflate_vq)) {
-		err = PTR_ERR(vb->deflate_vq);
-		goto out_del_inflate_vq;
-	}
+	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks);
+	if (err)
+		goto out_free_vb;
+	
+	vb->inflate_vq = vqs[0];
+	vb->deflate_vq = vqs[1];
 
 	vb->thread = kthread_run(balloon, vb, "vballoon");
 	if (IS_ERR(vb->thread)) {
 		err = PTR_ERR(vb->thread);
-		goto out_del_deflate_vq;
+		goto out_del_vqs;
 	}
 
 	vb->tell_host_first
@@ -241,10 +241,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	return 0;
 
-out_del_deflate_vq:
-	vdev->config->del_vq(vb->deflate_vq);
-out_del_inflate_vq:
-	vdev->config->del_vq(vb->inflate_vq);
+out_del_vqs:
+	vdev->config->del_vqs(vdev);
 out_free_vb:
 	kfree(vb);
 out:
@@ -264,8 +262,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	/* Now we reset the device so we can clean up the queues. */
 	vdev->config->reset(vdev);
 
-	vdev->config->del_vq(vb->deflate_vq);
-	vdev->config->del_vq(vb->inflate_vq);
+	vdev->config->del_vqs(vdev);
 	kfree(vb);
 }
 
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 330aacb..3671c42 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -275,11 +275,7 @@ static void vp_del_vq(struct virtqueue *vq)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_vq_info *info = vq->priv;
-	unsigned long flags, size;
-
-	spin_lock_irqsave(&vp_dev->lock, flags);
-	list_del(&info->node);
-	spin_unlock_irqrestore(&vp_dev->lock, flags);
+	unsigned long size;
 
 	vring_del_virtqueue(vq);
 
@@ -292,14 +288,47 @@ static void vp_del_vq(struct virtqueue *vq)
 	kfree(info);
 }
 
+static void vp_del_vqs(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_vq_info *info;
+	struct list_head virtqueues;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vp_dev->lock, flags);
+	list_replace_init(&virtqueues, &vp_dev->virtqueues);
+	spin_unlock_irqrestore(&vp_dev->lock, flags);
+
+	list_for_each_entry(info, &virtqueues, node)
+		vp_del_vq(info->vq);
+}
+
+static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+		       struct virtqueue *vqs[]
+		       void (*callbacks)[](struct virtqueue *))
+{
+	int i;
+
+	for (i = 0; i < nvqs; ++i) {
+		vqs[i] = vp_find_vq(vdev, i, callbacks[i]);
+		if (IS_ERR(vqs[i]))
+			goto error;
+	}
+	return 0;
+
+error:
+	vp_del_vqs(vdev);
+	return PTR_ERR(vqs[i]);
+}
+
 static struct virtio_config_ops virtio_pci_config_ops = {
 	.get		= vp_get,
 	.set		= vp_set,
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
-	.find_vq	= vp_find_vq,
-	.del_vq		= vp_del_vq,
+	.find_vqs	= vp_find_vqs,
+	.del_vqs	= vp_del_vqs,
 	.get_features	= vp_get_features,
 	.finalize_features = vp_finalize_features,
 };
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index bf8ec28..ef8aec4 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -49,15 +49,25 @@
  * @set_status: write the status byte
  *	vdev: the virtio_device
  *	status: the new status byte
+ * @request_vqs: request the specified number of virtqueues
+ *	vdev: the virtio_device
+ *	max_vqs: the max number of virtqueues we want
+ *      If supplied, must call before any virtqueues are instantiated.
+ *      To modify the max number of virtqueues after request_vqs has been
+ *      called, call free_vqs and then request_vqs with a new value.
+ * @free_vqs: cleanup resources allocated by request_vqs
+ *	vdev: the virtio_device
+ *      If supplied, must call after all virtqueues have been deleted.
  * @reset: reset the device
  *	vdev: the virtio device
  *	After this, status and feature negotiation must be done again
- * @find_vq: find a virtqueue and instantiate it.
+ * @find_vqs: find virtqueues and instantiate them.
  *	vdev: the virtio_device
- *	index: the 0-based virtqueue number in case there's more than one.
- *	callback: the virqtueue callback
- *	Returns the new virtqueue or ERR_PTR() (eg. -ENOENT).
- * @del_vq: free a virtqueue found by find_vq().
+ *	nvqs: the number of virtqueues to find
+ *	vqs: on success, includes new virtqueues
+ *	callbacks: array of callbacks, for each virtqueue
+ *	Returns 0 on success or error status
+ * @del_vqs: free virtqueues found by find_vqs().
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
  *	Returns the first 32 feature bits (all we currently need).
@@ -66,6 +76,7 @@
  *	This gives the final feature bits for the device: it can change
  *	the dev->feature bits if it wants.
  */
+typedef void virtqueue_callback(struct virtqueue *);
 struct virtio_config_ops
 {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -75,10 +86,10 @@ struct virtio_config_ops
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
-	struct virtqueue *(*find_vq)(struct virtio_device *vdev,
-				     unsigned index,
-				     void (*callback)(struct virtqueue *));
-	void (*del_vq)(struct virtqueue *vq);
+	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
+			struct virtqueue *vqs[],
+			virtqueue_callback *callbacks[]);
+	void (*del_vqs)(struct virtio_device *);
 	u32 (*get_features)(struct virtio_device *vdev);
 	void (*finalize_features)(struct virtio_device *vdev);
 };
-- 
1.6.3.rc3.1.g830204
