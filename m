From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 7/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:24:21 +0200
Message-ID: <476BDAA5.20406__302.113421685313$1198250781$gmane$org@qumranet.com>
Reply-To: Dor Laor <dor.laor@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>Anthony Liguori <a>
List-Id: virtualization@lists.linuxfoundation.org

 From e49289d5a2137118a61b00a184a07f47ba9d04f5 Mon Sep 17 00:00:00 2001
From: Anthony Liguori <aliguori@us.ibm.com>
Date: Wed, 7 Nov 2007 20:46:31 -0600
Subject: [PATCH] virtio: free transmit skbs when notified, not on next xmit.

This fixes a potential dangling xmit problem.

We also suppress refill interrupts until we need them.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |   69 
++++++++++++++++++++++++++++++++-------------
 1 files changed, 49 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6526e0b..c4f970e 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -35,6 +35,8 @@ struct virtnet_info
     struct net_device *dev;
     struct napi_struct napi;
 
+    struct tasklet_struct xmit_free;
+
     /* TX coalescing. */
     struct hrtimer tx_timer;
 
@@ -59,13 +61,40 @@ static inline void vnet_hdr_to_sg(struct scatterlist 
*sg, struct sk_buff *skb)
     sg_init_one(sg, skb_vnet_hdr(skb), sizeof(struct virtio_net_hdr));
 }
 
-static bool skb_xmit_done(struct virtqueue *rvq)
+static unsigned free_old_xmit_skbs(struct virtnet_info *vi)
 {
-    struct virtnet_info *vi = rvq->vdev->priv;
+    struct sk_buff *skb;
+    unsigned int len, i = 0;
+
+    while ((skb = vi->svq->vq_ops->get_buf(vi->svq, &len)) != NULL) {
+        pr_debug("Sent skb %p\n", skb);
+        __skb_unlink(skb, &vi->send);
+        vi->dev->stats.tx_bytes += len;
+        vi->dev->stats.tx_packets++;
+        kfree_skb(skb);
+        i++;
+    }
+    return i;
+}
+
+static void xmit_free(unsigned long data)
+{
+    struct virtnet_info *vi = (void *)data;
+
+    netif_tx_lock(vi->dev);
+    free_old_xmit_skbs(vi);
+    netif_tx_unlock(vi->dev);
 
     /* In case we were waiting for output buffers. */
     netif_wake_queue(vi->dev);
-    return true;
+}    
+
+static bool skb_xmit_done(struct virtqueue *rvq)
+{
+    struct virtnet_info *vi = rvq->vdev->priv;
+
+    tasklet_schedule(&vi->xmit_free);
+    return false;
 }
 
 static void receive_skb(struct net_device *dev, struct sk_buff *skb,
@@ -216,20 +245,6 @@ again:
     return received;
 }
 
-static void free_old_xmit_skbs(struct virtnet_info *vi)
-{
-    struct sk_buff *skb;
-    unsigned int len;
-
-    while ((skb = vi->svq->vq_ops->get_buf(vi->svq, &len)) != NULL) {
-        pr_debug("Sent skb %p\n", skb);
-        __skb_unlink(skb, &vi->send);
-        vi->dev->stats.tx_bytes += len;
-        vi->dev->stats.tx_packets++;
-        kfree_skb(skb);
-    }
-}
-
 static enum hrtimer_restart kick_xmit(struct hrtimer *t)
 {
     struct virtnet_info *vi = container_of(t,struct virtnet_info,tx_timer);
@@ -257,8 +272,6 @@ static int start_xmit(struct sk_buff *skb, struct 
net_device *dev)
 
     pr_debug("%s: xmit %p %s\n", dev->name, skb, print_mac(mac, dest));
 
-    free_old_xmit_skbs(vi);
-
     /* Encode metadata header at front. */
     hdr = skb_vnet_hdr(skb);
     if (skb->ip_summed == CHECKSUM_PARTIAL) {
@@ -290,10 +303,24 @@ static int start_xmit(struct sk_buff *skb, struct 
net_device *dev)
     vnet_hdr_to_sg(sg, skb);
     num = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
     __skb_queue_head(&vi->send, skb);
+
+again:
     err = vi->svq->vq_ops->add_buf(vi->svq, sg, num, 0, skb);
     if (err) {
+        /* Can we free any used skbs? */
+        if (free_old_xmit_skbs(vi))
+            goto again;
+
+        /* Activate callback for using skbs: if this fails it
+         * means some were used in the meantime. */
+        if (unlikely(!vi->svq->vq_ops->restart(vi->svq))) {
+            printk("Unlikely: restart svq failed\n");
+            goto again;
+        }
+
+        __skb_unlink(skb, &vi->send);
+
         pr_debug("%s: virtio not prepared to send\n", dev->name);
-        skb_unlink(skb, &vi->send);
         if (vi->out_max != vi->out_num)
             printk("%s: out_max changed from %u to %u\n",
                    dev->name, vi->out_max, vi->out_num);
@@ -403,6 +430,8 @@ static int virtnet_probe(struct virtio_device *vdev)
     vi->tx_timer.cb_mode = HRTIMER_CB_SOFTIRQ;
     vi->out_max = -1U;
 
+    tasklet_init(&vi->xmit_free, xmit_free, (unsigned long)vi);
+    
     /* We expect two virtqueues, receive then send. */
     vi->rvq = vdev->config->find_vq(vdev, 0, skb_recv_done);
     if (IS_ERR(vi->rvq)) {
-- 
1.5.3.3
