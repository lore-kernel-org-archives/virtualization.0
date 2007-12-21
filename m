From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 8/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:24:57 +0200
Message-ID: <476BDAC9.6010202__17462.4745188796$1198251112$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
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

 From aad0cb3074950a49714cf98562a0602d11ebb3d1 Mon Sep 17 00:00:00 2001
From: Anthony Liguori <aliguori@us.ibm.com>
Date: Mon, 12 Nov 2007 21:30:26 -0600
Subject: [PATCH] virtio: add debug/performance stats to network driver

ifconfig down or remove the module to get the statistics dump.
---
 drivers/net/virtio_net.c |  120 
+++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 103 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index c4f970e..538cc37 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -49,6 +49,32 @@ struct virtnet_info
     /* Receive & send queues. */
     struct sk_buff_head recv;
     struct sk_buff_head send;
+
+    struct {
+        unsigned int free_old_xmit_skbs_manual;
+        unsigned int free_old_xmit_skbs_tasklet;
+        unsigned int hrtimer_starts;
+        unsigned int hrtimer_fires;
+        unsigned int hrtimer_cancels;
+        unsigned int sendq_kicks;
+        unsigned int sendq_packets;
+        unsigned int sendq_partial_csum;
+        unsigned int sendq_gso;
+        unsigned int sendq_sglen;
+        unsigned int sendq_full;
+        unsigned int sendq_restarted;
+        unsigned int sendq_restart_failed;
+        unsigned int sendq_cancelled;
+        unsigned int recvq_packets;
+        unsigned int recvq_refills;
+        unsigned int recvq_restarted;
+        unsigned int recvq_restart_failed;
+        unsigned int recvq_reschedule_failed;
+        unsigned int recvq_partial_csum;
+        unsigned int recvq_gso;
+        unsigned int recvq_kicks;
+        unsigned int poll;
+    } stats;
 };
 
 static inline struct virtio_net_hdr *skb_vnet_hdr(struct sk_buff *skb)
@@ -84,6 +110,7 @@ static void xmit_free(unsigned long data)
     netif_tx_lock(vi->dev);
     free_old_xmit_skbs(vi);
     netif_tx_unlock(vi->dev);
+    vi->stats.free_old_xmit_skbs_tasklet++;
 
     /* In case we were waiting for output buffers. */
     netif_wake_queue(vi->dev);
@@ -97,28 +124,31 @@ static bool skb_xmit_done(struct virtqueue *rvq)
     return false;
 }
 
-static void receive_skb(struct net_device *dev, struct sk_buff *skb,
+static void receive_skb(struct virtnet_info *vi, struct sk_buff *skb,
             unsigned len)
 {
     struct virtio_net_hdr *hdr = skb_vnet_hdr(skb);
 
+    vi->stats.recvq_packets++;
+
     if (unlikely(len < sizeof(struct virtio_net_hdr) + ETH_HLEN)) {
-        pr_debug("%s: short packet %i\n", dev->name, len);
-        dev->stats.rx_length_errors++;
+        pr_debug("%s: short packet %i\n", vi->dev->name, len);
+        vi->dev->stats.rx_length_errors++;
         goto drop;
     }
     len -= sizeof(struct virtio_net_hdr);
     BUG_ON(len > MAX_PACKET_LEN);
 
     skb_trim(skb, len);
-    skb->protocol = eth_type_trans(skb, dev);
+    skb->protocol = eth_type_trans(skb, vi->dev);
     pr_debug("Receiving skb proto 0x%04x len %i type %i\n",
          ntohs(skb->protocol), skb->len, skb->pkt_type);
-    dev->stats.rx_bytes += skb->len;
-    dev->stats.rx_packets++;
+    vi->dev->stats.rx_bytes += skb->len;
+    vi->dev->stats.rx_packets++;
 
     if (hdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM) {
         pr_debug("Needs csum!\n");
+        vi->stats.recvq_partial_csum++;
         skb->ip_summed = CHECKSUM_PARTIAL;
         skb->csum_start = hdr->csum_start;
         skb->csum_offset = hdr->csum_offset;
@@ -126,7 +156,7 @@ static void receive_skb(struct net_device *dev, 
struct sk_buff *skb,
             || skb->csum_offset > skb->len - 2) {
             if (net_ratelimit())
                 printk(KERN_WARNING "%s: csum=%u/%u len=%u\n",
-                       dev->name, skb->csum_start,
+                       vi->dev->name, skb->csum_start,
                        skb->csum_offset, skb->len);
             goto frame_err;
         }
@@ -134,6 +164,7 @@ static void receive_skb(struct net_device *dev, 
struct sk_buff *skb,
 
     if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
         pr_debug("GSO!\n");
+        vi->stats.recvq_gso++;
         switch (hdr->gso_type) {
         case VIRTIO_NET_HDR_GSO_TCPV4:
             skb_shinfo(skb)->gso_type = SKB_GSO_TCPV4;
@@ -150,7 +181,7 @@ static void receive_skb(struct net_device *dev, 
struct sk_buff *skb,
         default:
             if (net_ratelimit())
                 printk(KERN_WARNING "%s: bad gso type %u.\n",
-                       dev->name, hdr->gso_type);
+                       vi->dev->name, hdr->gso_type);
             goto frame_err;
         }
 
@@ -158,7 +189,7 @@ static void receive_skb(struct net_device *dev, 
struct sk_buff *skb,
         if (skb_shinfo(skb)->gso_size == 0) {
             if (net_ratelimit())
                 printk(KERN_WARNING "%s: zero gso size.\n",
-                       dev->name);
+                       vi->dev->name);
             goto frame_err;
         }
 
@@ -171,7 +202,7 @@ static void receive_skb(struct net_device *dev, 
struct sk_buff *skb,
     return;
 
 frame_err:
-    dev->stats.rx_frame_errors++;
+    vi->dev->stats.rx_frame_errors++;
 drop:
     dev_kfree_skb(skb);
 }
@@ -203,6 +234,7 @@ static void try_fill_recv(struct virtnet_info *vi)
     }
     if (unlikely(vi->num > vi->max))
         vi->max = vi->num;
+    vi->stats.recvq_kicks++;
     vi->rvq->vq_ops->kick(vi->rvq);
 }
 
@@ -220,26 +252,33 @@ static int virtnet_poll(struct napi_struct *napi, 
int budget)
     struct sk_buff *skb = NULL;
     unsigned int len, received = 0;
 
+    vi->stats.poll++;
 again:
     while (received < budget &&
            (skb = vi->rvq->vq_ops->get_buf(vi->rvq, &len)) != NULL) {
         __skb_unlink(skb, &vi->recv);
-        receive_skb(vi->dev, skb, len);
+        receive_skb(vi, skb, len);
         vi->num--;
         received++;
     }
 
     /* FIXME: If we oom and completely run out of inbufs, we need
      * to start a timer trying to fill more. */
-    if (vi->num < vi->max / 2)
+    if (vi->num < vi->max / 2) {
+        vi->stats.recvq_refills++;
         try_fill_recv(vi);
+    }
 
     /* Out of packets? */
     if (received < budget) {
         netif_rx_complete(vi->dev, napi);
-        if (unlikely(!vi->rvq->vq_ops->restart(vi->rvq))
-            && netif_rx_reschedule(vi->dev, napi))
-            goto again;
+        vi->stats.recvq_restarted++;
+        if (unlikely(!vi->rvq->vq_ops->restart(vi->rvq))) {
+            vi->stats.recvq_restart_failed++;
+            if (netif_rx_reschedule(vi->dev, napi))
+                goto again;
+            vi->stats.recvq_reschedule_failed++;
+        }
     }
 
     return received;
@@ -249,9 +288,11 @@ static enum hrtimer_restart kick_xmit(struct 
hrtimer *t)
 {
     struct virtnet_info *vi = container_of(t,struct virtnet_info,tx_timer);
 
+    vi->stats.hrtimer_fires++;
     BUG_ON(!in_softirq());
     BUG_ON(in_irq());
     netif_tx_lock(vi->dev);
+    vi->stats.sendq_kicks++;
     vi->svq->vq_ops->kick(vi->svq);
     vi->out_num = 0;
     netif_tx_unlock(vi->dev);
@@ -272,12 +313,14 @@ static int start_xmit(struct sk_buff *skb, struct 
net_device *dev)
 
     pr_debug("%s: xmit %p %s\n", dev->name, skb, print_mac(mac, dest));
 
+    vi->stats.sendq_packets++;
     /* Encode metadata header at front. */
     hdr = skb_vnet_hdr(skb);
     if (skb->ip_summed == CHECKSUM_PARTIAL) {
         hdr->flags = VIRTIO_NET_HDR_F_NEEDS_CSUM;
         hdr->csum_start = skb->csum_start - skb_headroom(skb);
         hdr->csum_offset = skb->csum_offset;
+        vi->stats.sendq_partial_csum++;
     } else {
         hdr->flags = 0;
         hdr->csum_offset = hdr->csum_start = 0;
@@ -285,6 +328,7 @@ static int start_xmit(struct sk_buff *skb, struct 
net_device *dev)
 
     if (skb_is_gso(skb)) {
         hdr->gso_size = skb_shinfo(skb)->gso_size;
+        vi->stats.sendq_gso++;
         if (skb_shinfo(skb)->gso_type & SKB_GSO_TCP_ECN)
             hdr->gso_type = VIRTIO_NET_HDR_GSO_TCPV4_ECN;
         else if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4)
@@ -303,18 +347,23 @@ static int start_xmit(struct sk_buff *skb, struct 
net_device *dev)
     vnet_hdr_to_sg(sg, skb);
     num = skb_to_sgvec(skb, sg+1, 0, skb->len) + 1;
     __skb_queue_head(&vi->send, skb);
+    vi->stats.sendq_sglen += num;
 
 again:
     err = vi->svq->vq_ops->add_buf(vi->svq, sg, num, 0, skb);
     if (err) {
+        vi->stats.sendq_full++;
+
         /* Can we free any used skbs? */
+        vi->stats.free_old_xmit_skbs_manual++;
         if (free_old_xmit_skbs(vi))
             goto again;
 
         /* Activate callback for using skbs: if this fails it
          * means some were used in the meantime. */
+        vi->stats.sendq_restarted++;
         if (unlikely(!vi->svq->vq_ops->restart(vi->svq))) {
-            printk("Unlikely: restart svq failed\n");
+            vi->stats.sendq_restart_failed++;
             goto again;
         }
 
@@ -326,20 +375,28 @@ again:
                    dev->name, vi->out_max, vi->out_num);
         vi->out_max = vi->out_num;
         vi->out_num = 0;
+        vi->stats.sendq_cancelled++;
+
         /* Kick off send immediately. */
+        vi->stats.hrtimer_cancels++;
         hrtimer_cancel(&vi->tx_timer);
+        vi->stats.sendq_kicks++;
         vi->svq->vq_ops->kick(vi->svq);
         netif_stop_queue(dev);
         return NETDEV_TX_BUSY;
     }
 
     if (++vi->out_num == vi->out_max) {
+        vi->stats.hrtimer_cancels++;
         hrtimer_cancel(&vi->tx_timer);
+        vi->stats.sendq_kicks++;
         vi->svq->vq_ops->kick(vi->svq);
         vi->out_num = 0;
-    } else
+    } else {
+        vi->stats.hrtimer_starts++;
         hrtimer_start(&vi->tx_timer, ktime_set(0,500000),
                   HRTIMER_MODE_REL);
+    }
     return 0;
 }
 
@@ -376,6 +433,35 @@ static int virtnet_close(struct net_device *dev)
         kfree_skb(skb);
 
     BUG_ON(vi->num != 0);
+
+    printk("Stats for %s\n", dev->name);
+    printk("free_old_xmit_skbs_manual = %u\n",
+           vi->stats.free_old_xmit_skbs_manual);
+    printk("free_old_xmit_skbs_tasklet = %u\n",
+           vi->stats.free_old_xmit_skbs_tasklet);
+    printk("hrtimer_starts = %u\n", vi->stats.hrtimer_starts);
+    printk("hrtimer_fires = %u\n", vi->stats.hrtimer_fires);
+    printk("hrtimer_cancels = %u\n", vi->stats.hrtimer_cancels);
+    printk("sendq_kicks = %u\n", vi->stats.sendq_kicks);
+    printk("sendq_packets = %u\n", vi->stats.sendq_packets);
+    printk("sendq_partial_csum = %u\n", vi->stats.sendq_partial_csum);
+    printk("sendq_gso = %u\n", vi->stats.sendq_gso);
+    printk("sendq_sglen = %u\n", vi->stats.sendq_sglen);
+    printk("sendq_full = %u\n", vi->stats.sendq_full);
+    printk("sendq_restarted = %u\n", vi->stats.sendq_restarted);
+    printk("sendq_restart_failed = %u\n", vi->stats.sendq_restart_failed);
+    printk("sendq_cancelled = %u\n", vi->stats.sendq_cancelled);
+    printk("recvq_packets = %u\n", vi->stats.recvq_packets);
+    printk("recvq_refills = %u\n", vi->stats.recvq_refills);
+    printk("recvq_restarted = %u\n", vi->stats.recvq_restarted);
+    printk("recvq_restart_failed = %u\n", vi->stats.recvq_restart_failed);
+    printk("recvq_reschedule_failed = %u\n",
+           vi->stats.recvq_reschedule_failed);
+    printk("recvq_partial_csum = %u\n", vi->stats.recvq_partial_csum);
+    printk("recvq_gso = %u\n", vi->stats.recvq_gso);
+    printk("recvq_kicks = %u\n", vi->stats.recvq_kicks);
+    printk("poll = %u\n", vi->stats.poll);
+
     return 0;
 }
 
-- 
1.5.3.3
