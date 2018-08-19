From: xiangxia.m.yue@gmail.com
Subject: [PATCH net-next v8 5/7] net: vhost: introduce bitmap for vhost_poll
Date: Sun, 19 Aug 2018 05:11:24 -0700
Message-ID: <1534680686-3108-6-git-send-email-xiangxia.m.yue__42855.8940337554$1534680899$gmane$org@gmail.com>
References: <1534680686-3108-1-git-send-email-xiangxia.m.yue@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1534680686-3108-1-git-send-email-xiangxia.m.yue@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com, mst@redhat.com, makita.toshiaki@lab.ntt.co.jp
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

The bitmap of vhost_dev can help us to check if the
specified poll is scheduled. This patch will be used
for next two patches.

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
---
 drivers/vhost/net.c   | 11 +++++++++--
 drivers/vhost/vhost.c | 17 +++++++++++++++--
 drivers/vhost/vhost.h |  7 ++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 1eff72d..23d7ffc 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1135,8 +1135,15 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	}
 	vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX);
 
-	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
-	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
+	vhost_poll_init(n->poll + VHOST_NET_VQ_TX,
+			handle_tx_net,
+			VHOST_NET_VQ_TX,
+			EPOLLOUT, dev);
+
+	vhost_poll_init(n->poll + VHOST_NET_VQ_RX,
+			handle_rx_net,
+			VHOST_NET_VQ_RX,
+			EPOLLIN, dev);
 
 	f->private_data = n;
 
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index a1c06e7..dc88a60 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -186,7 +186,7 @@ void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn)
 
 /* Init poll structure */
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     __poll_t mask, struct vhost_dev *dev)
+		     __u8 poll_id, __poll_t mask, struct vhost_dev *dev)
 {
 	init_waitqueue_func_entry(&poll->wait, vhost_poll_wakeup);
 	init_poll_funcptr(&poll->table, vhost_poll_func);
@@ -194,6 +194,7 @@ void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
 	poll->dev = dev;
 	poll->wqh = NULL;
 
+	poll->poll_id = poll_id;
 	vhost_work_init(&poll->work, fn);
 }
 EXPORT_SYMBOL_GPL(vhost_poll_init);
@@ -276,8 +277,16 @@ bool vhost_has_work(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
+bool vhost_has_work_pending(struct vhost_dev *dev, int poll_id)
+{
+	return !llist_empty(&dev->work_list) &&
+		test_bit(poll_id, dev->work_pending);
+}
+EXPORT_SYMBOL_GPL(vhost_has_work_pending);
+
 void vhost_poll_queue(struct vhost_poll *poll)
 {
+	set_bit(poll->poll_id, poll->dev->work_pending);
 	vhost_work_queue(poll->dev, &poll->work);
 }
 EXPORT_SYMBOL_GPL(vhost_poll_queue);
@@ -354,6 +363,7 @@ static int vhost_worker(void *data)
 		if (!node)
 			schedule();
 
+		bitmap_zero(dev->work_pending, VHOST_DEV_MAX_VQ);
 		node = llist_reverse_order(node);
 		/* make sure flag is seen after deletion */
 		smp_wmb();
@@ -420,6 +430,8 @@ void vhost_dev_init(struct vhost_dev *dev,
 	struct vhost_virtqueue *vq;
 	int i;
 
+	BUG_ON(nvqs > VHOST_DEV_MAX_VQ);
+
 	dev->vqs = vqs;
 	dev->nvqs = nvqs;
 	mutex_init(&dev->mutex);
@@ -428,6 +440,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->iotlb = NULL;
 	dev->mm = NULL;
 	dev->worker = NULL;
+	bitmap_zero(dev->work_pending, VHOST_DEV_MAX_VQ);
 	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
@@ -445,7 +458,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 		vhost_vq_reset(dev, vq);
 		if (vq->handle_kick)
 			vhost_poll_init(&vq->poll, vq->handle_kick,
-					EPOLLIN, dev);
+					i, EPOLLIN, dev);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_dev_init);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 6c844b9..60b6f6d 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -30,6 +30,7 @@ struct vhost_poll {
 	wait_queue_head_t        *wqh;
 	wait_queue_entry_t              wait;
 	struct vhost_work	  work;
+	__u8			  poll_id;
 	__poll_t		  mask;
 	struct vhost_dev	 *dev;
 };
@@ -37,9 +38,10 @@ struct vhost_poll {
 void vhost_work_init(struct vhost_work *work, vhost_work_fn_t fn);
 void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work);
 bool vhost_has_work(struct vhost_dev *dev);
+bool vhost_has_work_pending(struct vhost_dev *dev, int poll_id);
 
 void vhost_poll_init(struct vhost_poll *poll, vhost_work_fn_t fn,
-		     __poll_t mask, struct vhost_dev *dev);
+		     __u8 id, __poll_t mask, struct vhost_dev *dev);
 int vhost_poll_start(struct vhost_poll *poll, struct file *file);
 void vhost_poll_stop(struct vhost_poll *poll);
 void vhost_poll_flush(struct vhost_poll *poll);
@@ -152,6 +154,8 @@ struct vhost_msg_node {
   struct list_head node;
 };
 
+#define VHOST_DEV_MAX_VQ	128
+
 struct vhost_dev {
 	struct mm_struct *mm;
 	struct mutex mutex;
@@ -159,6 +163,7 @@ struct vhost_dev {
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
 	struct llist_head work_list;
+	DECLARE_BITMAP(work_pending, VHOST_DEV_MAX_VQ);
 	struct task_struct *worker;
 	struct vhost_umem *umem;
 	struct vhost_umem *iotlb;
-- 
1.8.3.1
