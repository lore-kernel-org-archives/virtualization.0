From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/2] reset support: make net driver alloc/cleanup in probe
	and remove
Date: Thu, 24 Jan 2008 01:16:25 +1100
Message-ID: <200801240116.26160.rusty__38538.72403638$1201098370$gmane$org@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Dor Laor <dor.laor@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Since we want to reset the device to remove them, this is simpler
(device is reset for us on driver remove).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |   44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff -r 7e5b3ff06f60 drivers/net/virtio_net.c
--- a/drivers/net/virtio_net.c	Wed Jan 23 22:53:14 2008 +1100
+++ b/drivers/net/virtio_net.c	Wed Jan 23 23:52:46 2008 +1100
@@ -300,12 +300,6 @@ static int virtnet_open(struct net_devic
 {
 	struct virtnet_info *vi = netdev_priv(dev);
 
-	try_fill_recv(vi);
-
-	/* If we didn't even get one input buffer, we're useless. */
-	if (vi->num == 0)
-		return -ENOMEM;
-
 	napi_enable(&vi->napi);
 
 	/* If all buffers were filled by other side before we napi_enabled, we
@@ -320,22 +314,9 @@ static int virtnet_close(struct net_devi
 static int virtnet_close(struct net_device *dev)
 {
 	struct virtnet_info *vi = netdev_priv(dev);
-	struct sk_buff *skb;
 
 	napi_disable(&vi->napi);
 
-	/* networking core has neutered skb_xmit_done/skb_recv_done, so don't
-	 * worry about races vs. get(). */
-	vi->rvq->vq_ops->shutdown(vi->rvq);
-	while ((skb = __skb_dequeue(&vi->recv)) != NULL) {
-		kfree_skb(skb);
-		vi->num--;
-	}
-	vi->svq->vq_ops->shutdown(vi->svq);
-	while ((skb = __skb_dequeue(&vi->send)) != NULL)
-		kfree_skb(skb);
-
-	BUG_ON(vi->num != 0);
 	return 0;
 }
 
@@ -403,10 +384,22 @@ static int virtnet_probe(struct virtio_d
 		pr_debug("virtio_net: registering device failed\n");
 		goto free_send;
 	}
+
+	/* Last of all, set up some receive buffers. */
+	try_fill_recv(vi);
+
+	/* If we didn't even get one input buffer, we're useless. */
+	if (vi->num == 0) {
+		err = -ENOMEM;
+		goto unregister;
+	}
+
 	pr_debug("virtnet: registered device %s\n", dev->name);
 	vdev->priv = vi;
 	return 0;
 
+unregister:
+	unregister_netdev(dev);
 free_send:
 	vdev->config->del_vq(vi->svq);
 free_recv:
@@ -419,6 +412,19 @@ static void virtnet_remove(struct virtio
 static void virtnet_remove(struct virtio_device *vdev)
 {
 	struct virtnet_info *vi = vdev->priv;
+	struct sk_buff *skb;
+
+	/* Free our skbs in send and recv queues, if any. */
+	vi->rvq->vq_ops->shutdown(vi->rvq);
+	while ((skb = __skb_dequeue(&vi->recv)) != NULL) {
+		kfree_skb(skb);
+		vi->num--;
+	}
+	vi->svq->vq_ops->shutdown(vi->svq);
+	while ((skb = __skb_dequeue(&vi->send)) != NULL)
+		kfree_skb(skb);
+
+	BUG_ON(vi->num != 0);
 
 	vdev->config->del_vq(vi->svq);
 	vdev->config->del_vq(vi->rvq);
