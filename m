From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH untested] vhost: allow device specific fields per vq
Date: Thu, 25 Apr 2013 12:32:48 +0300
Message-ID: <20130425093248.GA15876__31107.1381009699$1366882389$gmane$org@redhat.com>
References: <1366875323-17639-1-git-send-email-asias@redhat.com>
	<1366875323-17639-5-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1366875323-17639-5-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Off-list, Asias asked about adding scsi specific fields per vq.
Something like the following would be helpful: untested, just to give
you the idea.

On top of this we can add patches to move things like ubufs
from vhost.h out to net.c

Warning: completely untested.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index ec6fb3f..e8fa9b6 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -70,9 +70,13 @@ enum vhost_net_poll_state {
 	VHOST_NET_POLL_STOPPED = 2,
 };
 
+struct vhost_net_virtqueue {
+	struct vhost_virtqueue vq;
+};
+
 struct vhost_net {
 	struct vhost_dev dev;
-	struct vhost_virtqueue vqs[VHOST_NET_VQ_MAX];
+	struct vhost_net_virtqueue vqs[VHOST_NET_VQ_MAX];
 	struct vhost_poll poll[VHOST_NET_VQ_MAX];
 	/* Tells us whether we are polling a socket for TX.
 	 * We only do this when socket buffer fills up.
@@ -612,17 +616,26 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 {
 	struct vhost_net *n = kmalloc(sizeof *n, GFP_KERNEL);
 	struct vhost_dev *dev;
+	struct vhost_virtqueue **vqs;
 	int r;
 
 	if (!n)
 		return -ENOMEM;
+	vqs = kmalloc(VHOST_NET_VQ_MAX, sizeof *vqs);
+	if (!vqs) {
+		kfree(n);
+		return -ENOMEM;
+	}
 
 	dev = &n->dev;
-	n->vqs[VHOST_NET_VQ_TX].handle_kick = handle_tx_kick;
-	n->vqs[VHOST_NET_VQ_RX].handle_kick = handle_rx_kick;
-	r = vhost_dev_init(dev, n->vqs, VHOST_NET_VQ_MAX);
+	vqs[VHOST_NET_VQ_TX] = &n->vqs[VHOST_NET_VQ_TX].vq;
+	vqs[VHOST_NET_VQ_RX] = &n->vqs[VHOST_NET_VQ_RX].vq;
+	n->vqs[VHOST_NET_VQ_TX].vq.handle_kick = handle_tx_kick;
+	n->vqs[VHOST_NET_VQ_RX].vq.handle_kick = handle_rx_kick;
+	r = vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX);
 	if (r < 0) {
 		kfree(n);
+		kfree(vqs);
 		return r;
 	}
 
@@ -727,6 +740,7 @@ static int vhost_net_release(struct inode *inode, struct file *f)
 	/* We do an extra flush before freeing memory,
 	 * since jobs can re-queue themselves. */
 	vhost_net_flush(n);
+	kfree(n->dev->vqs);
 	kfree(n);
 	return 0;
 }
diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 2968b49..ba54b3c 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -72,6 +72,10 @@ enum {
 #define VHOST_SCSI_MAX_TARGET	256
 #define VHOST_SCSI_MAX_VQ	128
 
+struct vhost_scsi_virtqueue {
+	struct vhost_virtqueue vq;
+};
+
 struct vhost_scsi {
 	/* Protected by vhost_scsi->dev.mutex */
 	struct tcm_vhost_tpg *vs_tpg[VHOST_SCSI_MAX_TARGET];
@@ -79,7 +83,7 @@ struct vhost_scsi {
 	bool vs_endpoint;
 
 	struct vhost_dev dev;
-	struct vhost_virtqueue vqs[VHOST_SCSI_MAX_VQ];
+	struct vhost_scsi_virtqueue vqs[VHOST_SCSI_MAX_VQ];
 
 	struct vhost_work vs_completion_work; /* cmd completion work item */
 	struct llist_head vs_completion_list; /* cmd completion queue */
@@ -902,20 +906,32 @@ err_dev:
 static int vhost_scsi_open(struct inode *inode, struct file *f)
 {
 	struct vhost_scsi *s;
+	struct vhost_scsi_virtqueue *vqs;
 	int r, i;
 
 	s = kzalloc(sizeof(*s), GFP_KERNEL);
 	if (!s)
 		return -ENOMEM;
 
+	vqs = kmalloc(VHOST_SCSI_MAX_VQ, sizeof *vqs);
+	if (!vqs) {
+		kfree(s);
+		return -ENOMEM;
+	}
+
 	vhost_work_init(&s->vs_completion_work, vhost_scsi_complete_cmd_work);
 
-	s->vqs[VHOST_SCSI_VQ_CTL].handle_kick = vhost_scsi_ctl_handle_kick;
-	s->vqs[VHOST_SCSI_VQ_EVT].handle_kick = vhost_scsi_evt_handle_kick;
-	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++)
-		s->vqs[i].handle_kick = vhost_scsi_handle_kick;
-	r = vhost_dev_init(&s->dev, s->vqs, VHOST_SCSI_MAX_VQ);
+	vqs[VHOST_SCSI_VQ_CTL] = &n->vqs[VHOST_SCSI_VQ_CTL].vq;
+	vqs[VHOST_SCSI_VQ_EVT] = &n->vqs[VHOST_SCSI_VQ_EVT].vq;
+	s->vqs[VHOST_SCSI_VQ_CTL].vq.handle_kick = vhost_scsi_ctl_handle_kick;
+	s->vqs[VHOST_SCSI_VQ_EVT].vq.handle_kick = vhost_scsi_evt_handle_kick;
+	for (i = VHOST_SCSI_VQ_IO; i < VHOST_SCSI_MAX_VQ; i++) {
+		vqs[i] = &s->vqs[i].vq;
+		s->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
+	}
+	r = vhost_dev_init(&s->dev, vqs, VHOST_SCSI_MAX_VQ);
 	if (r < 0) {
+		kfree(vqs);
 		kfree(s);
 		return r;
 	}
@@ -935,6 +951,7 @@ static int vhost_scsi_release(struct inode *inode, struct file *f)
 	vhost_scsi_clear_endpoint(s, &t);
 	vhost_dev_stop(&s->dev);
 	vhost_dev_cleanup(&s->dev, false);
+	kfree(s->dev->vqs);
 	kfree(s);
 	return 0;
 }
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9759249..666ed34 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -266,20 +266,20 @@ static long vhost_dev_alloc_iovecs(struct vhost_dev *dev)
 	bool zcopy;
 
 	for (i = 0; i < dev->nvqs; ++i) {
-		dev->vqs[i].indirect = kmalloc(sizeof *dev->vqs[i].indirect *
+		dev->vqs[i]->indirect = kmalloc(sizeof *dev->vqs[i]->indirect *
 					       UIO_MAXIOV, GFP_KERNEL);
-		dev->vqs[i].log = kmalloc(sizeof *dev->vqs[i].log * UIO_MAXIOV,
+		dev->vqs[i]->log = kmalloc(sizeof *dev->vqs[i]->log * UIO_MAXIOV,
 					  GFP_KERNEL);
-		dev->vqs[i].heads = kmalloc(sizeof *dev->vqs[i].heads *
+		dev->vqs[i]->heads = kmalloc(sizeof *dev->vqs[i]->heads *
 					    UIO_MAXIOV, GFP_KERNEL);
 		zcopy = vhost_zcopy_mask & (0x1 << i);
 		if (zcopy)
-			dev->vqs[i].ubuf_info =
-				kmalloc(sizeof *dev->vqs[i].ubuf_info *
+			dev->vqs[i]->ubuf_info =
+				kmalloc(sizeof *dev->vqs[i]->ubuf_info *
 					UIO_MAXIOV, GFP_KERNEL);
-		if (!dev->vqs[i].indirect || !dev->vqs[i].log ||
-			!dev->vqs[i].heads ||
-			(zcopy && !dev->vqs[i].ubuf_info))
+		if (!dev->vqs[i]->indirect || !dev->vqs[i]->log ||
+			!dev->vqs[i]->heads ||
+			(zcopy && !dev->vqs[i]->ubuf_info))
 			goto err_nomem;
 	}
 	return 0;
@@ -315,16 +315,16 @@ long vhost_dev_init(struct vhost_dev *dev,
 	dev->worker = NULL;
 
 	for (i = 0; i < dev->nvqs; ++i) {
-		dev->vqs[i].log = NULL;
-		dev->vqs[i].indirect = NULL;
-		dev->vqs[i].heads = NULL;
-		dev->vqs[i].ubuf_info = NULL;
-		dev->vqs[i].dev = dev;
-		mutex_init(&dev->vqs[i].mutex);
+		dev->vqs[i]->log = NULL;
+		dev->vqs[i]->indirect = NULL;
+		dev->vqs[i]->heads = NULL;
+		dev->vqs[i]->ubuf_info = NULL;
+		dev->vqs[i]->dev = dev;
+		mutex_init(&dev->vqs[i]->mutex);
 		vhost_vq_reset(dev, dev->vqs + i);
-		if (dev->vqs[i].handle_kick)
-			vhost_poll_init(&dev->vqs[i].poll,
-					dev->vqs[i].handle_kick, POLLIN, dev);
+		if (dev->vqs[i]->handle_kick)
+			vhost_poll_init(&dev->vqs[i]->poll,
+					dev->vqs[i]->handle_kick, POLLIN, dev);
 	}
 
 	return 0;
@@ -427,9 +427,9 @@ void vhost_dev_stop(struct vhost_dev *dev)
 	int i;
 
 	for (i = 0; i < dev->nvqs; ++i) {
-		if (dev->vqs[i].kick && dev->vqs[i].handle_kick) {
-			vhost_poll_stop(&dev->vqs[i].poll);
-			vhost_poll_flush(&dev->vqs[i].poll);
+		if (dev->vqs[i]->kick && dev->vqs[i]->handle_kick) {
+			vhost_poll_stop(&dev->vqs[i]->poll);
+			vhost_poll_flush(&dev->vqs[i]->poll);
 		}
 	}
 }
@@ -440,16 +440,16 @@ void vhost_dev_cleanup(struct vhost_dev *dev, bool locked)
 	int i;
 
 	for (i = 0; i < dev->nvqs; ++i) {
-		if (dev->vqs[i].error_ctx)
-			eventfd_ctx_put(dev->vqs[i].error_ctx);
-		if (dev->vqs[i].error)
-			fput(dev->vqs[i].error);
-		if (dev->vqs[i].kick)
-			fput(dev->vqs[i].kick);
-		if (dev->vqs[i].call_ctx)
-			eventfd_ctx_put(dev->vqs[i].call_ctx);
-		if (dev->vqs[i].call)
-			fput(dev->vqs[i].call);
+		if (dev->vqs[i]->error_ctx)
+			eventfd_ctx_put(dev->vqs[i]->error_ctx);
+		if (dev->vqs[i]->error)
+			fput(dev->vqs[i]->error);
+		if (dev->vqs[i]->kick)
+			fput(dev->vqs[i]->kick);
+		if (dev->vqs[i]->call_ctx)
+			eventfd_ctx_put(dev->vqs[i]->call_ctx);
+		if (dev->vqs[i]->call)
+			fput(dev->vqs[i]->call);
 		vhost_vq_reset(dev, dev->vqs + i);
 	}
 	vhost_dev_free_iovecs(dev);
@@ -521,14 +521,14 @@ static int memory_access_ok(struct vhost_dev *d, struct vhost_memory *mem,
 
 	for (i = 0; i < d->nvqs; ++i) {
 		int ok;
-		mutex_lock(&d->vqs[i].mutex);
+		mutex_lock(&d->vqs[i]->mutex);
 		/* If ring is inactive, will check when it's enabled. */
-		if (d->vqs[i].private_data)
-			ok = vq_memory_access_ok(d->vqs[i].log_base, mem,
+		if (d->vqs[i]->private_data)
+			ok = vq_memory_access_ok(d->vqs[i]->log_base, mem,
 						 log_all);
 		else
 			ok = 1;
-		mutex_unlock(&d->vqs[i].mutex);
+		mutex_unlock(&d->vqs[i]->mutex);
 		if (!ok)
 			return 0;
 	}
@@ -876,9 +876,9 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 		} else
 			filep = eventfp;
 		for (i = 0; i < d->nvqs; ++i) {
-			mutex_lock(&d->vqs[i].mutex);
-			d->vqs[i].log_ctx = d->log_ctx;
-			mutex_unlock(&d->vqs[i].mutex);
+			mutex_lock(&d->vqs[i]->mutex);
+			d->vqs[i]->log_ctx = d->log_ctx;
+			mutex_unlock(&d->vqs[i]->mutex);
 		}
 		if (ctx)
 			eventfd_ctx_put(ctx);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 17261e2..eeb3433 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -150,7 +150,7 @@ struct vhost_dev {
 	struct mm_struct *mm;
 	struct mutex mutex;
 	unsigned acked_features;
-	struct vhost_virtqueue *vqs;
+	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct file *log_file;
 	struct eventfd_ctx *log_ctx;
