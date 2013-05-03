From: Asias He <asias@redhat.com>
Subject: [PATCH 4/4] vhost-net: Cleanup vhost_ubuf adn vhost_zcopy
Date: Fri,  3 May 2013 14:25:18 +0800
Message-ID: <1367562318-11989-5-git-send-email-asias__41440.6574600891$1367562380$gmane$org@redhat.com>
References: <1367562318-11989-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1367562318-11989-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

- Rename vhost_ubuf to vhost_net_ubuf
- Rename vhost_zcopy_mask to vhost_net_zcopy_mask
- Make funcs static

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/net.c | 58 +++++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index eb73217..4548c0b 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -70,7 +70,7 @@ enum {
 	VHOST_NET_VQ_MAX = 2,
 };
 
-struct vhost_ubuf_ref {
+struct vhost_net_ubuf_ref {
 	struct kref kref;
 	wait_queue_head_t wait;
 	struct vhost_virtqueue *vq;
@@ -93,7 +93,7 @@ struct vhost_net_virtqueue {
 	struct ubuf_info *ubuf_info;
 	/* Reference counting for outstanding ubufs.
 	 * Protected by vq mutex. Writers must also take device mutex. */
-	struct vhost_ubuf_ref *ubufs;
+	struct vhost_net_ubuf_ref *ubufs;
 };
 
 struct vhost_net {
@@ -110,24 +110,25 @@ struct vhost_net {
 	bool tx_flush;
 };
 
-static unsigned vhost_zcopy_mask __read_mostly;
+static unsigned vhost_net_zcopy_mask __read_mostly;
 
-void vhost_enable_zcopy(int vq)
+static void vhost_net_enable_zcopy(int vq)
 {
-	vhost_zcopy_mask |= 0x1 << vq;
+	vhost_net_zcopy_mask |= 0x1 << vq;
 }
 
-static void vhost_zerocopy_done_signal(struct kref *kref)
+static void vhost_net_zerocopy_done_signal(struct kref *kref)
 {
-	struct vhost_ubuf_ref *ubufs = container_of(kref, struct vhost_ubuf_ref,
-						    kref);
+	struct vhost_net_ubuf_ref *ubufs;
+
+	ubufs = container_of(kref, struct vhost_net_ubuf_ref, kref);
 	wake_up(&ubufs->wait);
 }
 
-struct vhost_ubuf_ref *vhost_ubuf_alloc(struct vhost_virtqueue *vq,
-					bool zcopy)
+static struct vhost_net_ubuf_ref *
+vhost_net_ubuf_alloc(struct vhost_virtqueue *vq, bool zcopy)
 {
-	struct vhost_ubuf_ref *ubufs;
+	struct vhost_net_ubuf_ref *ubufs;
 	/* No zero copy backend? Nothing to count. */
 	if (!zcopy)
 		return NULL;
@@ -140,14 +141,14 @@ struct vhost_ubuf_ref *vhost_ubuf_alloc(struct vhost_virtqueue *vq,
 	return ubufs;
 }
 
-void vhost_ubuf_put(struct vhost_ubuf_ref *ubufs)
+static void vhost_net_ubuf_put(struct vhost_net_ubuf_ref *ubufs)
 {
-	kref_put(&ubufs->kref, vhost_zerocopy_done_signal);
+	kref_put(&ubufs->kref, vhost_net_zerocopy_done_signal);
 }
 
-void vhost_ubuf_put_and_wait(struct vhost_ubuf_ref *ubufs)
+static void vhost_net_ubuf_put_and_wait(struct vhost_net_ubuf_ref *ubufs)
 {
-	kref_put(&ubufs->kref, vhost_zerocopy_done_signal);
+	kref_put(&ubufs->kref, vhost_net_zerocopy_done_signal);
 	wait_event(ubufs->wait, !atomic_read(&ubufs->kref.refcount));
 	kfree(ubufs);
 }
@@ -159,7 +160,7 @@ static void vhost_net_clear_ubuf_info(struct vhost_net *n)
 	int i;
 
 	for (i = 0; i < n->dev.nvqs; ++i) {
-		zcopy = vhost_zcopy_mask & (0x1 << i);
+		zcopy = vhost_net_zcopy_mask & (0x1 << i);
 		if (zcopy)
 			kfree(n->vqs[i].ubuf_info);
 	}
@@ -171,7 +172,7 @@ int vhost_net_set_ubuf_info(struct vhost_net *n)
 	int i;
 
 	for (i = 0; i < n->dev.nvqs; ++i) {
-		zcopy = vhost_zcopy_mask & (0x1 << i);
+		zcopy = vhost_net_zcopy_mask & (0x1 << i);
 		if (!zcopy)
 			continue;
 		n->vqs[i].ubuf_info = kmalloc(sizeof(*n->vqs[i].ubuf_info) *
@@ -183,7 +184,7 @@ int vhost_net_set_ubuf_info(struct vhost_net *n)
 
 err:
 	while (i--) {
-		zcopy = vhost_zcopy_mask & (0x1 << i);
+		zcopy = vhost_net_zcopy_mask & (0x1 << i);
 		if (!zcopy)
 			continue;
 		kfree(n->vqs[i].ubuf_info);
@@ -305,7 +306,7 @@ static int vhost_zerocopy_signal_used(struct vhost_net *net,
 
 static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
 {
-	struct vhost_ubuf_ref *ubufs = ubuf->ctx;
+	struct vhost_net_ubuf_ref *ubufs = ubuf->ctx;
 	struct vhost_virtqueue *vq = ubufs->vq;
 	int cnt = atomic_read(&ubufs->kref.refcount);
 
@@ -322,7 +323,7 @@ static void vhost_zerocopy_callback(struct ubuf_info *ubuf, bool success)
 	/* set len to mark this desc buffers done DMA */
 	vq->heads[ubuf->desc].len = success ?
 		VHOST_DMA_DONE_LEN : VHOST_DMA_FAILED_LEN;
-	vhost_ubuf_put(ubufs);
+	vhost_net_ubuf_put(ubufs);
 }
 
 /* Expects to be always run from workqueue - which acts as
@@ -345,7 +346,7 @@ static void handle_tx(struct vhost_net *net)
 	int err;
 	size_t hdr_size;
 	struct socket *sock;
-	struct vhost_ubuf_ref *uninitialized_var(ubufs);
+	struct vhost_net_ubuf_ref *uninitialized_var(ubufs);
 	bool zcopy, zcopy_used;
 
 	/* TODO: check that we are running from vhost_worker? */
@@ -441,7 +442,7 @@ static void handle_tx(struct vhost_net *net)
 		if (unlikely(err < 0)) {
 			if (zcopy_used) {
 				if (ubufs)
-					vhost_ubuf_put(ubufs);
+					vhost_net_ubuf_put(ubufs);
 				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
 					% UIO_MAXIOV;
 			}
@@ -795,7 +796,7 @@ static void vhost_net_flush(struct vhost_net *n)
 		n->tx_flush = true;
 		mutex_unlock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		/* Wait for all lower device DMAs done. */
-		vhost_ubuf_put_and_wait(n->vqs[VHOST_NET_VQ_TX].ubufs);
+		vhost_net_ubuf_put_and_wait(n->vqs[VHOST_NET_VQ_TX].ubufs);
 		mutex_lock(&n->vqs[VHOST_NET_VQ_TX].vq.mutex);
 		n->tx_flush = false;
 		kref_init(&n->vqs[VHOST_NET_VQ_TX].ubufs->kref);
@@ -896,7 +897,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	struct socket *sock, *oldsock;
 	struct vhost_virtqueue *vq;
 	struct vhost_net_virtqueue *nvq;
-	struct vhost_ubuf_ref *ubufs, *oldubufs = NULL;
+	struct vhost_net_ubuf_ref *ubufs, *oldubufs = NULL;
 	int r;
 
 	mutex_lock(&n->dev.mutex);
@@ -927,7 +928,8 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	oldsock = rcu_dereference_protected(vq->private_data,
 					    lockdep_is_held(&vq->mutex));
 	if (sock != oldsock) {
-		ubufs = vhost_ubuf_alloc(vq, sock && vhost_sock_zcopy(sock));
+		ubufs = vhost_net_ubuf_alloc(vq,
+					     sock && vhost_sock_zcopy(sock));
 		if (IS_ERR(ubufs)) {
 			r = PTR_ERR(ubufs);
 			goto err_ubufs;
@@ -953,7 +955,7 @@ static long vhost_net_set_backend(struct vhost_net *n, unsigned index, int fd)
 	mutex_unlock(&vq->mutex);
 
 	if (oldubufs) {
-		vhost_ubuf_put_and_wait(oldubufs);
+		vhost_net_ubuf_put_and_wait(oldubufs);
 		mutex_lock(&vq->mutex);
 		vhost_zerocopy_signal_used(n, vq);
 		mutex_unlock(&vq->mutex);
@@ -971,7 +973,7 @@ err_used:
 	rcu_assign_pointer(vq->private_data, oldsock);
 	vhost_net_enable_vq(n, vq);
 	if (ubufs)
-		vhost_ubuf_put_and_wait(ubufs);
+		vhost_net_ubuf_put_and_wait(ubufs);
 err_ubufs:
 	fput(sock->file);
 err_vq:
@@ -1123,7 +1125,7 @@ static struct miscdevice vhost_net_misc = {
 static int vhost_net_init(void)
 {
 	if (experimental_zcopytx)
-		vhost_enable_zcopy(VHOST_NET_VQ_TX);
+		vhost_net_enable_zcopy(VHOST_NET_VQ_TX);
 	return misc_register(&vhost_net_misc);
 }
 module_init(vhost_net_init);
-- 
1.8.1.4
