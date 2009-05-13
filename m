From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv5 1/3] virtio: find_vqs/del_vqs virtio operations
Date: Wed, 13 May 2009 22:08:58 +0300
Message-ID: <20090513190858.GA3990__26185.3500771851$1242242093$gmane$org@redhat.com>
References: <cover.1242241196.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1242241196.git.mst@redhat.com>
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

This replaces find_vq/del_vq with find_vqs/del_vqs virtio operations,
and updates all drivers. This is needed for MSI support, because MSI
needs to know the total number of vectors upfront.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c          |    6 ++--
 drivers/char/hw_random/virtio-rng.c |    6 ++--
 drivers/char/virtio_console.c       |   26 ++++++++-----------
 drivers/lguest/lguest_device.c      |   36 +++++++++++++++++++++++++-
 drivers/net/virtio_net.c            |   45 +++++++++++++--------------------
 drivers/s390/kvm/kvm_virtio.c       |   36 +++++++++++++++++++++++++-
 drivers/virtio/virtio_balloon.c     |   27 ++++++++------------
 drivers/virtio/virtio_pci.c         |   37 ++++++++++++++++++++++-----
 include/linux/virtio_config.h       |   46 ++++++++++++++++++++++++++--------
 net/9p/trans_virtio.c               |    2 +-
 10 files changed, 180 insertions(+), 87 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 8f7c956..c9f5627 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -224,7 +224,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	sg_init_table(vblk->sg, vblk->sg_elems);
 
 	/* We expect one virtqueue, for output. */
-	vblk->vq = vdev->config->find_vq(vdev, 0, blk_done, "requests");
+	vblk->vq = virtio_find_single_vq(vdev, blk_done, "requests");
 	if (IS_ERR(vblk->vq)) {
 		err = PTR_ERR(vblk->vq);
 		goto out_free_vblk;
@@ -323,7 +323,7 @@ out_put_disk:
 out_mempool:
 	mempool_destroy(vblk->pool);
 out_free_vq:
-	vdev->config->del_vq(vblk->vq);
+	vdev->config->del_vqs(vdev);
 out_free_vblk:
 	kfree(vblk);
 out:
@@ -344,7 +344,7 @@ static void virtblk_remove(struct virtio_device *vdev)
 	blk_cleanup_queue(vblk->disk->queue);
 	put_disk(vblk->disk);
 	mempool_destroy(vblk->pool);
-	vdev->config->del_vq(vblk->vq);
+	vdev->config->del_vqs(vdev);
 	kfree(vblk);
 }
 
diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 2aeafce..f2041fe 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -94,13 +94,13 @@ static int virtrng_probe(struct virtio_device *vdev)
 	int err;
 
 	/* We expect a single virtqueue. */
-	vq = vdev->config->find_vq(vdev, 0, random_recv_done, "input");
+	vq = virtio_find_single_vq(vdev, random_recv_done, "input");
 	if (IS_ERR(vq))
 		return PTR_ERR(vq);
 
 	err = hwrng_register(&virtio_hwrng);
 	if (err) {
-		vdev->config->del_vq(vq);
+		vdev->config->del_vqs(vdev);
 		return err;
 	}
 
@@ -112,7 +112,7 @@ static void virtrng_remove(struct virtio_device *vdev)
 {
 	vdev->config->reset(vdev);
 	hwrng_unregister(&virtio_hwrng);
-	vdev->config->del_vq(vq);
+	vdev->config->del_vqs(vdev);
 }
 
 static struct virtio_device_id id_table[] = {
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 58684e4..c74dacf 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -188,6 +188,9 @@ static void hvc_handle_input(struct virtqueue *vq)
  * Finally we put our input buffer in the input queue, ready to receive. */
 static int __devinit virtcons_probe(struct virtio_device *dev)
 {
+	vq_callback_t *callbacks[] = { hvc_handle_input, NULL};
+	const char *names[] = { "input", "output" };
+	struct virtqueue *vqs[2];
 	int err;
 
 	vdev = dev;
@@ -199,20 +202,15 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
 		goto fail;
 	}
 
-	/* Find the input queue. */
+	/* Find the queues. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
-	in_vq = vdev->config->find_vq(vdev, 0, hvc_handle_input, "input");
-	if (IS_ERR(in_vq)) {
-		err = PTR_ERR(in_vq);
+	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
+	if (err)
 		goto free;
-	}
 
-	out_vq = vdev->config->find_vq(vdev, 1, NULL, "output");
-	if (IS_ERR(out_vq)) {
-		err = PTR_ERR(out_vq);
-		goto free_in_vq;
-	}
+	in_vq = vqs[0];
+	out_vq = vqs[1];
 
 	/* Start using the new console output. */
 	virtio_cons.get_chars = get_chars;
@@ -233,17 +231,15 @@ static int __devinit virtcons_probe(struct virtio_device *dev)
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
index 4babed8..f8e0c8b 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -313,6 +313,38 @@ static void lg_del_vq(struct virtqueue *vq)
 	kfree(lvq);
 }
 
+static void lg_del_vqs(struct virtio_device *vdev)
+{
+	struct virtqueue *vq, *n;
+
+	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
+		kvm_del_vq(vq);
+}
+
+static int lg_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+		       struct virtqueue *vqs[]
+		       vq_callback_t *callbacks[],
+		       const char *names[])
+{
+	struct lguest_device *ldev = to_lgdev(vdev);
+	int i;
+
+	/* We must have this many virtqueues. */
+	if (nvqs > ldev->desc->num_vq)
+		return ERR_PTR(-ENOENT);
+
+	for (i = 0; i < nvqs; ++i) {
+		vqs[i] = lg_find_vq(vdev, i, callbacks[i], names[i]);
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
 /* The ops structure which hooks everything together. */
 static struct virtio_config_ops lguest_config_ops = {
 	.get_features = lg_get_features,
@@ -322,8 +354,8 @@ static struct virtio_config_ops lguest_config_ops = {
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
index be3b734..7fa620d 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -845,6 +845,10 @@ static int virtnet_probe(struct virtio_device *vdev)
 	int err;
 	struct net_device *dev;
 	struct virtnet_info *vi;
+	struct virtqueue *vqs[3];
+	vq_callback_t *callbacks[] = { skb_recv_done, skb_xmit_done, NULL};
+	const char *names[] = { "input", "output", "control" };
+	int nvqs;
 
 	/* Allocate ourselves a network device with room for our info */
 	dev = alloc_etherdev(sizeof(struct virtnet_info));
@@ -905,25 +909,19 @@ static int virtnet_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF))
 		vi->mergeable_rx_bufs = true;
 
-	/* We expect two virtqueues, receive then send. */
-	vi->rvq = vdev->config->find_vq(vdev, 0, skb_recv_done, "input");
-	if (IS_ERR(vi->rvq)) {
-		err = PTR_ERR(vi->rvq);
+	/* We expect two virtqueues, receive then send,
+	 * and optionally control. */
+	nvqs = virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ) ? 3 : 2;
+
+	err = vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names);
+	if (err)
 		goto free;
-	}
 
-	vi->svq = vdev->config->find_vq(vdev, 1, skb_xmit_done, "output");
-	if (IS_ERR(vi->svq)) {
-		err = PTR_ERR(vi->svq);
-		goto free_recv;
-	}
+	vi->rvq = vqs[0];
+	vi->svq = vqs[1];
 
 	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ)) {
-		vi->cvq = vdev->config->find_vq(vdev, 2, NULL, "control");
-		if (IS_ERR(vi->cvq)) {
-			err = PTR_ERR(vi->svq);
-			goto free_send;
-		}
+		vi->cvq = vqs[2];
 
 		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VLAN))
 			dev->features |= NETIF_F_HW_VLAN_FILTER;
@@ -941,7 +939,7 @@ static int virtnet_probe(struct virtio_device *vdev)
 	err = register_netdev(dev);
 	if (err) {
 		pr_debug("virtio_net: registering device failed\n");
-		goto free_ctrl;
+		goto free_vqs;
 	}
 
 	/* Last of all, set up some receive buffers. */
@@ -962,13 +960,8 @@ static int virtnet_probe(struct virtio_device *vdev)
 
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
@@ -994,12 +987,10 @@ static void virtnet_remove(struct virtio_device *vdev)
 
 	BUG_ON(vi->num != 0);
 
-	vdev->config->del_vq(vi->svq);
-	vdev->config->del_vq(vi->rvq);
-	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ))
-		vdev->config->del_vq(vi->cvq);
 	unregister_netdev(vi->dev);
 
+	vdev->config->del_vqs(vi->vdev);
+
 	while (vi->pages)
 		__free_pages(get_a_page(vi, GFP_KERNEL), 0);
 
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index ba8995f..e719188 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -227,6 +227,38 @@ static void kvm_del_vq(struct virtqueue *vq)
 				       KVM_S390_VIRTIO_RING_ALIGN));
 }
 
+static void vp_del_vqs(struct virtio_device *vdev)
+{
+	struct virtqueue *vq, *n;
+
+	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
+		kvm_del_vq(vq);
+}
+
+static int kvm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+			struct virtqueue *vqs[],
+			vq_callback_t *callbacks[],
+			const char *names[])
+{
+	struct kvm_device *kdev = to_kvmdev(vdev);
+	int i;
+
+	/* We must have this many virtqueues. */
+	if (nvqs > kdev->desc->num_vq)
+		return -ENOENT;
+
+	for (i = 0; i < nvqs; ++i) {
+		vqs[i] = kvm_find_vq(vdev, i, callbacks[i], names[i]);
+		if (IS_ERR(vqs[i]))
+			goto error;
+	}
+	return 0;
+
+error:
+	kvm_del_vqs(vdev);
+	return PTR_ERR(vqs[i]);
+}
+
 /*
  * The config ops structure as defined by virtio config
  */
@@ -238,8 +270,8 @@ static struct virtio_config_ops kvm_vq_configspace_ops = {
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
index 0fa73b4..26b2782 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -204,6 +204,9 @@ static int balloon(void *_vballoon)
 static int virtballoon_probe(struct virtio_device *vdev)
 {
 	struct virtio_balloon *vb;
+	struct virtqueue *vqs[2];
+	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack };
+	const char *names[] = { "inflate", "deflate" };
 	int err;
 
 	vdev->priv = vb = kmalloc(sizeof(*vb), GFP_KERNEL);
@@ -218,22 +221,17 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	vb->vdev = vdev;
 
 	/* We expect two virtqueues. */
-	vb->inflate_vq = vdev->config->find_vq(vdev, 0, balloon_ack, "inflate");
-	if (IS_ERR(vb->inflate_vq)) {
-		err = PTR_ERR(vb->inflate_vq);
+	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
+	if (err)
 		goto out_free_vb;
-	}
 
-	vb->deflate_vq = vdev->config->find_vq(vdev, 1, balloon_ack, "deflate");
-	if (IS_ERR(vb->deflate_vq)) {
-		err = PTR_ERR(vb->deflate_vq);
-		goto out_del_inflate_vq;
-	}
+	vb->inflate_vq = vqs[0];
+	vb->deflate_vq = vqs[1];
 
 	vb->thread = kthread_run(balloon, vb, "vballoon");
 	if (IS_ERR(vb->thread)) {
 		err = PTR_ERR(vb->thread);
-		goto out_del_deflate_vq;
+		goto out_del_vqs;
 	}
 
 	vb->tell_host_first
@@ -241,10 +239,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
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
@@ -264,8 +260,7 @@ static void virtballoon_remove(struct virtio_device *vdev)
 	/* Now we reset the device so we can clean up the queues. */
 	vdev->config->reset(vdev);
 
-	vdev->config->del_vq(vb->deflate_vq);
-	vdev->config->del_vq(vb->inflate_vq);
+	vdev->config->del_vqs(vdev);
 	kfree(vb);
 }
 
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index be4047a..027f13f 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -276,11 +276,7 @@ static void vp_del_vq(struct virtqueue *vq)
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
 
@@ -293,14 +289,41 @@ static void vp_del_vq(struct virtqueue *vq)
 	kfree(info);
 }
 
+static void vp_del_vqs(struct virtio_device *vdev)
+{
+	struct virtqueue *vq, *n;
+
+	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
+		vp_del_vq(vq);
+}
+
+static int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
+		       struct virtqueue *vqs[],
+		       vq_callback_t *callbacks[],
+		       const char *names[])
+{
+	int i;
+
+	for (i = 0; i < nvqs; ++i) {
+		vqs[i] = vp_find_vq(vdev, i, callbacks[i], names[i]);
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
index 9fae274..4938050 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -49,16 +49,26 @@
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
- *	callback: the virtqueue callback
- *	name: the virtqueue name (mainly for debugging)
- *	Returns the new virtqueue or ERR_PTR() (eg. -ENOENT).
- * @del_vq: free a virtqueue found by find_vq().
+ *	nvqs: the number of virtqueues to find
+ *	vqs: on success, includes new virtqueues
+ *	callbacks: array of callbacks, for each virtqueue
+ *	names: array of virtqueue names (mainly for debugging)
+ *	Returns 0 on success or error status
+ * @del_vqs: free virtqueues found by find_vqs().
  * @get_features: get the array of feature bits for this device.
  *	vdev: the virtio_device
  *	Returns the first 32 feature bits (all we currently need).
@@ -67,6 +77,7 @@
  *	This gives the final feature bits for the device: it can change
  *	the dev->feature bits if it wants.
  */
+typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops
 {
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -76,11 +87,11 @@ struct virtio_config_ops
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
-	struct virtqueue *(*find_vq)(struct virtio_device *vdev,
-				     unsigned index,
-				     void (*callback)(struct virtqueue *),
-				     const char *name);
-	void (*del_vq)(struct virtqueue *vq);
+	int (*find_vqs)(struct virtio_device *, unsigned nvqs,
+			struct virtqueue *vqs[],
+			vq_callback_t *callbacks[],
+			const char *names[]);
+	void (*del_vqs)(struct virtio_device *);
 	u32 (*get_features)(struct virtio_device *vdev);
 	void (*finalize_features)(struct virtio_device *vdev);
 };
@@ -128,5 +139,18 @@ static inline int virtio_config_buf(struct virtio_device *vdev,
 	vdev->config->get(vdev, offset, buf, len);
 	return 0;
 }
+
+static inline
+struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
+					vq_callback_t *c, const char *n)
+{
+	vq_callback_t *callbacks[] = { c };
+	const char *names[] = { n };
+	struct virtqueue *vq;
+	int err = vdev->config->find_vqs(vdev, 1, &vq, callbacks, names);
+	if (err < 0)
+		return ERR_PTR(err);
+	return vq;
+}
 #endif /* __KERNEL__ */
 #endif /* _LINUX_VIRTIO_CONFIG_H */
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index ab8791f..977a8c3 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -246,7 +246,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 	chan->vdev = vdev;
 
 	/* We expect one virtqueue, for requests. */
-	chan->vq = vdev->config->find_vq(vdev, 0, req_done, "requests");
+	chan->vq = virtio_find_single_vq(vdev, req_done, "requests");
 	if (IS_ERR(chan->vq)) {
 		err = PTR_ERR(chan->vq);
 		goto out_free_vq;
-- 
1.6.3.rc3.1.g830204
