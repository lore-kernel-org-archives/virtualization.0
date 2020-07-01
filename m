From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 2/5] vhost: generialize backend features setting/getting
Date: Wed,  1 Jul 2020 17:08:36 +0800
Message-ID: <20200701090839.12994-3-jasowang@redhat.com>
References: <20200701090839.12994-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200701090839.12994-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com, mhabets@solarflare.com, vmireyno@marvell.com, gdawar@xilinx.com, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

Move the backend features setting/getting from net.c to vhost.c to be
reused by vhost-vdpa.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 18 ++----------------
 drivers/vhost/vhost.c | 15 +++++++++++++++
 drivers/vhost/vhost.h |  2 ++
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 0b509be8d7b1..d88afe3f6060 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1622,21 +1622,6 @@ static long vhost_net_reset_owner(struct vhost_net *n)
 	return err;
 }
 
-static int vhost_net_set_backend_features(struct vhost_net *n, u64 features)
-{
-	int i;
-
-	mutex_lock(&n->dev.mutex);
-	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {
-		mutex_lock(&n->vqs[i].vq.mutex);
-		n->vqs[i].vq.acked_backend_features = features;
-		mutex_unlock(&n->vqs[i].vq.mutex);
-	}
-	mutex_unlock(&n->dev.mutex);
-
-	return 0;
-}
-
 static int vhost_net_set_features(struct vhost_net *n, u64 features)
 {
 	size_t vhost_hlen, sock_hlen, hdr_len;
@@ -1737,7 +1722,8 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
 			return -EFAULT;
 		if (features & ~VHOST_NET_BACKEND_FEATURES)
 			return -EOPNOTSUPP;
-		return vhost_net_set_backend_features(n, features);
+		vhost_set_backend_features(&n->dev, features);
+		return 0;
 	case VHOST_RESET_OWNER:
 		return vhost_net_reset_owner(n);
 	case VHOST_SET_OWNER:
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index dc510dc2b1ef..ba61f499d420 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2700,6 +2700,21 @@ struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 }
 EXPORT_SYMBOL_GPL(vhost_dequeue_msg);
 
+void vhost_set_backend_features(struct vhost_dev *dev, u64 features)
+{
+	struct vhost_virtqueue *vq;
+	int i;
+
+	mutex_lock(&dev->mutex);
+	for (i = 0; i < dev->nvqs; ++i) {
+		vq = dev->vqs[i];
+		mutex_lock(&vq->mutex);
+		vq->acked_backend_features = features;
+		mutex_unlock(&vq->mutex);
+	}
+	mutex_unlock(&dev->mutex);
+}
+EXPORT_SYMBOL_GPL(vhost_set_backend_features);
 
 static int __init vhost_init(void)
 {
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 264a2a2fae97..52753aecd82a 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -223,6 +223,8 @@ void vhost_enqueue_msg(struct vhost_dev *dev,
 		       struct vhost_msg_node *node);
 struct vhost_msg_node *vhost_dequeue_msg(struct vhost_dev *dev,
 					 struct list_head *head);
+void vhost_set_backend_features(struct vhost_dev *dev, u64 features);
+
 __poll_t vhost_chr_poll(struct file *file, struct vhost_dev *dev,
 			    poll_table *wait);
 ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
-- 
2.20.1
