From: Asias He <asias@redhat.com>
Subject: [PATCH] vhost: Move vhost-net zerocopy support fields to net.c
Date: Sat, 27 Apr 2013 15:07:46 +0800
Message-ID: <1367046466-9843-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On top of 'vhost: Allow device specific fields per vq', we can move device
specific fields to device virt queue from vhost virt queue.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/net.c   | 164 +++++++++++++++++++++++++++++++++++++++++++-------
 drivers/vhost/vhost.c |  57 +-----------------
 drivers/vhost/vhost.h |  22 -------
 3 files changed, 142 insertions(+), 101 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 683d9a1..c194045 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -70,8 +70,24 @@ enum vhost_net_poll_state {
 	VHOST_NET_POLL_STOPPED = 2,
 };
 
+struct vhost_ubuf_ref {
+	struct kref kref;
+	wait_queue_head_t wait;
+	struct vhost_virtqueue *vq;
+};
+
 struct vhost_net_virtqueue {
 	struct vhost_virtqueue vq;
+	/* vhost zerocopy support fields below: */
+	/* last used idx for outstanding DMA zerocopy buffers */
+	int upend_idx;
+	/* first used idx for DMA done zerocopy buffers */
+	int done_idx;
+	/* an array of userspace buffers info */
+	struct ubuf_info *ubuf_info;
+	/* Reference counting for outstanding ubufs.
+	 * Protected by vq mutex. Writers must also take device mutex. */
+	struct vhost_ubuf_ref *ubufs;
 };
 
 struct vhost_net {
@@ -92,6 +108,88 @@ struct vhost_net {
 	bool tx_flush;
 };
 
+static unsigned vhost_zcopy_mask __read_mostly;
+
+void vhost_enable_zcopy(int vq)
+{
+	vhost_zcopy_mask |= 0x1 << vq;
+}
+
+static void vhost_zerocopy_done_signal(struct kref *kref)
+{
+	struct vhost_ubuf_ref *ubufs = container_of(kref, struct vhost_ubuf_ref,
+						    kref);
+	wake_up(&ubufs->wait);
+}
+
+struct vhost_ubuf_ref *vhost_ubuf_alloc(struct vhost_virtqueue *vq,
+					bool zcopy)
+{
+	struct vhost_ubuf_ref *ubufs;
+	/* No zero copy backend? Nothing to count. */
+	if (!zcopy)
+		return NULL;
+	ubufs = kmalloc(sizeof(*ubufs), GFP_KERNEL);
+	if (!ubufs)
+		return ERR_PTR(-ENOMEM);
+	kref_init(&ubufs->kref);
+	init_waitqueue_head(&ubufs->wait);
+	ubufs->vq = vq;
+	return ubufs;
+}
+
+void vhost_ubuf_put(struct vhost_ubuf_ref *ubufs)
+{
+	kref_put(&ubufs->kref, vhost_zerocopy_done_signal);
+}
+
+void vhost_ubuf_put_and_wait(struct vhost_ubuf_ref *ubufs)
+{
+	kref_put(&ubufs->kref, vhost_zerocopy_done_signal);
+	wait_event(ubufs->wait, !atomic_read(&ubufs->kref.refcount));
+	kfree(ubufs);
+}
+
+int vhost_net_set_ubuf_info(struct vhost_net *n)
+{
+	bool zcopy;
+	int i;
+
+	for (i = 0; i < n->dev.nvqs; ++i) {
+		zcopy = vhost_zcopy_mask & (0x1 << i);
+		if (!zcopy)
+			continue;
+		n->vqs[i].ubuf_info = kmalloc(sizeof(*n->vqs[i].ubuf_info) *
+					      UIO_MAXIOV, GFP_KERNEL);
+		if  (!n->vqs[i].ubuf_info)
+			goto err;
+	}
+	return 0;
+
+err:
+	while (i--) {
+		zcopy = vhost_zcopy_mask & (0x1 << i);
+		if (!zcopy)
+			continue;
+		kfree(n->vqs[i].ubuf_info);
+	}
+	return -ENOMEM;
+}
+
+void vhost_net_reset_ubuf_info(struct vhost_net *n)
+{
+	int i;
+
+	for (i = 0; i < VHOST_NET_VQ_MAX; i++) {
+		n->vqs[i].done_idx = 0;
+		n->vqs[i].upend_idx = 0;
+		n->vqs[i].ubufs = NULL;
+		kfree(n->vqs[i].ubuf_info);
+		n->vqs[i].ubuf_info = NULL;
+	}
+
+}
+
 static void vhost_net_tx_packet(struct vhost_net *net)
 {
 	++net->tx_packets;
@@ -189,10 +287,12 @@ static int tx_poll_start(struct vhost_net *net, struct socket *sock)
 static int vhost_zerocopy_signal_used(struct vhost_net *net,
 				      struct vhost_virtqueue *vq)
 {
+	struct vhost_net_virtqueue *nvq =
+		container_of(vq, struct vhost_net_virtqueue, vq);
 	int i;
 	int j = 0;
 
-	for (i = vq->done_idx; i != vq->upend_idx; i = (i + 1) % UIO_MAXIOV) {
+	for (i = nvq->done_idx; i != nvq->upend_idx; i = (i + 1) % UIO_MAXIOV) {
 		if (vq->heads[i].len == VHOST_DMA_FAILED_LEN)
 			vhost_net_tx_err(net);
 		if (VHOST_DMA_IS_DONE(vq->heads[i].len)) {
@@ -204,7 +304,7 @@ static int vhost_zerocopy_signal_used(struct vhost_net *net,
 			break;
 	}
 	if (j)
-		vq->done_idx = i;
+		nvq->done_idx = i;
 	return j;
 }
 
@@ -235,6 +335,7 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
 static void handle_tx(struct vhost_net *net)
 {
 	struct vhost_virtqueue *vq = &net->vqs[VHOST_NET_VQ_TX].vq;
+	struct vhost_net_virtqueue *nvq = &net->vqs[VHOST_NET_VQ_TX];
 	unsigned out, in, s;
 	int head;
 	struct msghdr msg = {
@@ -271,7 +372,7 @@ static void handle_tx(struct vhost_net *net)
 	if (wmem < sock->sk->sk_sndbuf / 2)
 		tx_poll_stop(net);
 	hdr_size = vq->vhost_hlen;
-	zcopy = vq->ubufs;
+	zcopy = nvq->ubufs;
 
 	for (;;) {
 		/* Release DMAs done buffers first */
@@ -298,9 +399,10 @@ static void handle_tx(struct vhost_net *net)
 			/* If more outstanding DMAs, queue the work.
 			 * Handle upend_idx wrap around
 			 */
-			num_pends = likely(vq->upend_idx >= vq->done_idx) ?
-				    (vq->upend_idx - vq->done_idx) :
-				    (vq->upend_idx + UIO_MAXIOV - vq->done_idx);
+			num_pends = likely(nvq->upend_idx >= nvq->done_idx) ?
+				    (nvq->upend_idx - nvq->done_idx) :
+				    (nvq->upend_idx + UIO_MAXIOV -
+				     nvq->done_idx);
 			if (unlikely(num_pends > VHOST_MAX_PEND)) {
 				tx_poll_start(net, sock);
 				set_bit(SOCK_ASYNC_NOSPACE, &sock->flags);
@@ -329,34 +431,34 @@ static void handle_tx(struct vhost_net *net)
 			break;
 		}
 		zcopy_used = zcopy && (len >= VHOST_GOODCOPY_LEN ||
-				       vq->upend_idx != vq->done_idx);
+				       nvq->upend_idx != nvq->done_idx);
 
 		/* use msg_control to pass vhost zerocopy ubuf info to skb */
 		if (zcopy_used) {
-			vq->heads[vq->upend_idx].id = head;
+			vq->heads[nvq->upend_idx].id = head;
 			if (!vhost_net_tx_select_zcopy(net) ||
 			    len < VHOST_GOODCOPY_LEN) {
 				/* copy don't need to wait for DMA done */
-				vq->heads[vq->upend_idx].len =
+				vq->heads[nvq->upend_idx].len =
 							VHOST_DMA_DONE_LEN;
 				msg.msg_control = NULL;
 				msg.msg_controllen = 0;
 				ubufs = NULL;
 			} else {
 				struct ubuf_info *ubuf;
-				ubuf = vq->ubuf_info + vq->upend_idx;
+				ubuf = nvq->ubuf_info + nvq->upend_idx;
 
-				vq->heads[vq->upend_idx].len =
+				vq->heads[nvq->upend_idx].len =
 					VHOST_DMA_IN_PROGRESS;
 				ubuf->callback = vhost_zerocopy_callback;
-				ubuf->ctx = vq->ubufs;
-				ubuf->desc = vq->upend_idx;
+				ubuf->ctx = nvq->ubufs;
+				ubuf->desc = nvq->upend_idx;
 				msg.msg_control = ubuf;
 				msg.msg_controllen = sizeof(ubuf);
-				ubufs = vq->ubufs;
+				ubufs = nvq->ubufs;
 				kref_get(&ubufs->kref);
 			}
-			vq->upend_idx = (vq->upend_idx + 1) % UIO_MAXIOV;
+			nvq->upend_idx = (nvq->upend_idx + 1) % UIO_MAXIOV;
 		}
 		/* TODO: Check specific error and bomb out unless ENOBUFS? */
 		err = sock->ops->sendmsg(NULL, sock, &msg, len);
@@ -364,8 +466,8 @@ static void handle_tx(struct vhost_net *net)
 			if (zcopy_used) {
 				if (ubufs)
 					vhost_ubuf_put(ubufs);
-				vq->upend_idx = ((unsigned)vq->upend_idx - 1) %
-					UIO_MAXIOV;
+				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
+					% UIO_MAXIOV;
 			}
 			vhost_discard_vq_desc(vq, 1);
 			if (err == -EAGAIN || err == -ENOBUFS)
@@ -617,7 +719,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	struct vhost_net *n = kmalloc(sizeof *n, GFP_KERNEL);
 	struct vhost_dev *dev;
 	struct vhost_virtqueue **vqs;
-	int r;
+	int r, i;
 
 	if (!n)
 		return -ENOMEM;
@@ -632,6 +734,12 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	vqs[VHOST_NET_VQ_RX] = &n->vqs[VHOST_NET_VQ_RX].vq;
 	n->vqs[VHOST_NET_VQ_TX].vq.handle_kick = handle_tx_kick;
 	n->vqs[VHOST_NET_VQ_RX].vq.handle_kick = handle_rx_kick;
+	for (i = 0; i < VHOST_NET_VQ_MAX; i++) {
+		n->vqs[i].ubufs = NULL;
+		n->vqs[i].ubuf_info = NULL;
+		n->vqs[i].upend_idx = 0;
+		n->vqs[i].done_idx = 0;
+	}
 	r = vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX);
 	if (r < 0) {
 		kfree(n);
@@ -710,15 +818,15 @@ static void vhost_net_flush(struct vhost_net *n)
 {
 	vhost_net_flush_vq(n, VHOST_NET_VQ_TX);
 	vhost_net_flush_vq(n, VHOST_NET_VQ_RX);
-	if (n->vqs[VHOST_NET_VQ_TX].vq.ubufs) {
+	if (n->vqs[VHOST_NET_VQ_TX].ubufs) {
 		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		n->tx_flush = true;
 		mutex_unlock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		/* Wait for all lower device DMAs done. */
-		vhost_ubuf_put_and_wait(n->vqs[VHOST_NET_VQ_TX].vq.ubufs);
+		vhost_ubuf_put_and_wait(n->vqs[VHOST_NET_VQ_TX].ubufs);
 		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		n->tx_flush = false;
-		kref_init(&n->vqs[VHOST_NET_VQ_TX].vq.ubufs->kref);
+		kref_init(&n->vqs[VHOST_NET_VQ_TX].ubufs->kref);
 		mutex_unlock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 	}
 }
@@ -733,6 +841,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	vhost_net_flush(n);
 	vhost_dev_stop(&n->dev);
 	vhost_dev_cleanup(&n->dev, false);
+	vhost_net_reset_ubuf_info(n);
 	if (tx_sock)
 		fput(tx_sock->file);
 	if (rx_sock)
@@ -814,6 +923,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 {
 	struct socket *sock, *oldsock;
 	struct vhost_virtqueue *vq;
+	struct vhost_net_virtqueue *nvq;
 	struct vhost_ubuf_ref *ubufs, *oldubufs = NULL;
 	int r;
 
@@ -827,6 +937,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		goto err;
 	}
 	vq = &n->vqs[index].vq;
+	nvq = &n->vqs[index];
 	mutex_lock(&vq->mutex);
 
 	/* Verify that ring has been setup correctly. */
@@ -859,8 +970,8 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 		if (r)
 			goto err_used;
 
-		oldubufs = vq->ubufs;
-		vq->ubufs = ubufs;
+		oldubufs = nvq->ubufs;
+		nvq->ubufs = ubufs;
 
 		n->tx_packets = 0;
 		n->tx_zcopy_err = 0;
@@ -911,6 +1022,7 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	vhost_net_stop(n, &tx_sock, &rx_sock);
 	vhost_net_flush(n);
 	err = vhost_dev_reset_owner(&n->dev);
+	vhost_net_reset_ubuf_info(n);
 done:
 	mutex_unlock(&n->dev.mutex);
 	if (tx_sock)
@@ -986,11 +1098,17 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 		return vhost_net_reset_owner(n);
 	default:
 		mutex_lock(&n->dev.mutex);
+		if (ioctl == VHOST_SET_OWNER) {
+			r = vhost_net_set_ubuf_info(n);
+			if (r)
+				goto out;
+		}
 		r = vhost_dev_ioctl(&n->dev, ioctl, argp);
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vring_ioctl(&n->dev, ioctl, argp);
 		else
 			vhost_net_flush(n);
+out:
 		mutex_unlock(&n->dev.mutex);
 		return r;
 	}
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 3f80286..40e0540 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -33,8 +33,6 @@ enum {
 	VHOST_MEMORY_F_LOG = 0x1,
 };
 
-static unsigned vhost_zcopy_mask __read_mostly;
-
 #define vhost_used_event(vq) ((u16 __user *)&vq->avail->ring[vq->num])
 #define vhost_avail_event(vq) ((u16 __user *)&vq->used->ring[vq->num])
 
@@ -188,9 +186,6 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 	vq->call_ctx = NULL;
 	vq->call = NULL;
 	vq->log_ctx = NULL;
-	vq->upend_idx = 0;
-	vq->done_idx = 0;
-	vq->ubufs = NULL;
 }
 
 static int vhost_worker(void *data)
@@ -250,20 +245,12 @@ static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
 	vq->log = NULL;
 	kfree(vq->heads);
 	vq->heads = NULL;
-	kfree(vq->ubuf_info);
-	vq->ubuf_info = NULL;
-}
-
-void vhost_enable_zcopy(int vq)
-{
-	vhost_zcopy_mask |= 0x1 << vq;
 }
 
 /* Helper to allocate iovec buffers for all vqs. */
 static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
 {
 	int i;
-	bool zcopy;
 
 	for (i = 0; i < dev->nvqs; ++i) {
 		dev->vqs[i]->indirect = kmalloc(sizeof *dev->vqs[i]->indirect *
@@ -272,14 +259,8 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
 					  GFP_KERNEL);
 		dev->vqs[i]->heads = kmalloc(sizeof *dev->vqs[i]->heads *
 					    UIO_MAXIOV, GFP_KERNEL);
-		zcopy = vhost_zcopy_mask & (0x1 << i);
-		if (zcopy)
-			dev->vqs[i]->ubuf_info =
-				kmalloc(sizeof *dev->vqs[i]->ubuf_info *
-					UIO_MAXIOV, GFP_KERNEL);
 		if (!dev->vqs[i]->indirect || !dev->vqs[i]->log ||
-			!dev->vqs[i]->heads ||
-			(zcopy && !dev->vqs[i]->ubuf_info))
+			!dev->vqs[i]->heads)
 			goto err_nomem;
 	}
 	return 0;
@@ -318,7 +299,6 @@ long vhost_dev_init(struct vhost_dev *dev,
 		dev->vqs[i]->log = NULL;
 		dev->vqs[i]->indirect = NULL;
 		dev->vqs[i]->heads = NULL;
-		dev->vqs[i]->ubuf_info = NULL;
 		dev->vqs[i]->dev = dev;
 		mutex_init(&dev->vqs[i]->mutex);
 		vhost_vq_reset(dev, dev->vqs[i]);
@@ -1548,38 +1528,3 @@ void vhost_disable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 			       &vq->used->flags, r);
 	}
 }
-
-static void vhost_zerocopy_done_signal(struct kref *kref)
-{
-	struct vhost_ubuf_ref *ubufs = container_of(kref, struct vhost_ubuf_ref,
-						    kref);
-	wake_up(&ubufs->wait);
-}
-
-struct vhost_ubuf_ref *vhost_ubuf_alloc(struct vhost_virtqueue *vq,
-					bool zcopy)
-{
-	struct vhost_ubuf_ref *ubufs;
-	/* No zero copy backend? Nothing to count. */
-	if (!zcopy)
-		return NULL;
-	ubufs = kmalloc(sizeof *ubufs, GFP_KERNEL);
-	if (!ubufs)
-		return ERR_PTR(-ENOMEM);
-	kref_init(&ubufs->kref);
-	init_waitqueue_head(&ubufs->wait);
-	ubufs->vq = vq;
-	return ubufs;
-}
-
-void vhost_ubuf_put(struct vhost_ubuf_ref *ubufs)
-{
-	kref_put(&ubufs->kref, vhost_zerocopy_done_signal);
-}
-
-void vhost_ubuf_put_and_wait(struct vhost_ubuf_ref *ubufs)
-{
-	kref_put(&ubufs->kref, vhost_zerocopy_done_signal);
-	wait_event(ubufs->wait, !atomic_read(&ubufs->kref.refcount));
-	kfree(ubufs);
-}
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index f3afa8a..3a36712 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -54,18 +54,6 @@ struct vhost_log {
 
 struct vhost_virtqueue;
 
-struct vhost_ubuf_ref {
-	struct kref kref;
-	wait_queue_head_t wait;
-	struct vhost_virtqueue *vq;
-};
-
-struct vhost_ubuf_ref *vhost_ubuf_alloc(struct vhost_virtqueue *, bool zcopy);
-void vhost_ubuf_put(struct vhost_ubuf_ref *);
-void vhost_ubuf_put_and_wait(struct vhost_ubuf_ref *);
-
-struct ubuf_info;
-
 /* The virtqueue structure describes a queue attached to a device. */
 struct vhost_virtqueue {
 	struct vhost_dev *dev;
@@ -130,16 +118,6 @@ struct vhost_virtqueue {
 	/* Log write descriptors */
 	void __user *log_base;
 	struct vhost_log *log;
-	/* vhost zerocopy support fields below: */
-	/* last used idx for outstanding DMA zerocopy buffers */
-	int upend_idx;
-	/* first used idx for DMA done zerocopy buffers */
-	int done_idx;
-	/* an array of userspace buffers info */
-	struct ubuf_info *ubuf_info;
-	/* Reference counting for outstanding ubufs.
-	 * Protected by vq mutex. Writers must also take device mutex. */
-	struct vhost_ubuf_ref *ubufs;
 };
 
 struct vhost_dev {
-- 
1.8.1.4
