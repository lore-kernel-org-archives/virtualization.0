From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 6/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:23:40 +0200
Message-ID: <476BDA7C.6080809__14494.2457358868$1198250733$gmane$org@qumranet.com>
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
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rus>
List-Id: virtualization@lists.linuxfoundation.org

 From c1e1126c39fe107f68adec196d4e558a14540939 Mon Sep 17 00:00:00 2001
From: Anthony Liguori <aliguori@us.ibm.com>
Date: Mon, 12 Nov 2007 21:30:26 -0600
Subject: [PATCH] virtio: use an hrtimer for tx coalescing.

Not sure why hrtimer's cb_mode only exists with CONFIG_HIGH_RES_TIMERS; that
seems like a bug to me.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/net/virtio_net.c |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index aff25b0..6526e0b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -23,6 +23,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_net.h>
 #include <linux/scatterlist.h>
+#include <linux/hrtimer.h>
 
 /* FIXME: MTU in config. */
 #define MAX_PACKET_LEN (ETH_HLEN+ETH_DATA_LEN)
@@ -34,9 +35,15 @@ struct virtnet_info
     struct net_device *dev;
     struct napi_struct napi;
 
+    /* TX coalescing. */
+    struct hrtimer tx_timer;
+
     /* Number of input buffers, and max we've ever had. */
     unsigned int num, max;
 
+    /* Number of queued output buffers, and max we've ever had. */
+    unsigned int out_num, out_max;
+
     /* Receive & send queues. */
     struct sk_buff_head recv;
     struct sk_buff_head send;
@@ -223,6 +230,20 @@ static void free_old_xmit_skbs(struct virtnet_info *vi)
     }
 }
 
+static enum hrtimer_restart kick_xmit(struct hrtimer *t)
+{
+    struct virtnet_info *vi = container_of(t,struct virtnet_info,tx_timer);
+
+    BUG_ON(!in_softirq());
+    BUG_ON(in_irq());
+    netif_tx_lock(vi->dev);
+    vi->svq->vq_ops->kick(vi->svq);
+    vi->out_num = 0;
+    netif_tx_unlock(vi->dev);
+
+    return HRTIMER_NORESTART;
+}
+
 static int start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
     struct virtnet_info *vi = netdev_priv(dev);
@@ -273,11 +294,25 @@ static int start_xmit(struct sk_buff *skb, struct 
net_device *dev)
     if (err) {
         pr_debug("%s: virtio not prepared to send\n", dev->name);
         skb_unlink(skb, &vi->send);
+        if (vi->out_max != vi->out_num)
+            printk("%s: out_max changed from %u to %u\n",
+                   dev->name, vi->out_max, vi->out_num);
+        vi->out_max = vi->out_num;
+        vi->out_num = 0;
+        /* Kick off send immediately. */
+        hrtimer_cancel(&vi->tx_timer);
+        vi->svq->vq_ops->kick(vi->svq);
         netif_stop_queue(dev);
         return NETDEV_TX_BUSY;
     }
-    vi->svq->vq_ops->kick(vi->svq);
 
+    if (++vi->out_num == vi->out_max) {
+        hrtimer_cancel(&vi->tx_timer);
+        vi->svq->vq_ops->kick(vi->svq);
+        vi->out_num = 0;
+    } else
+        hrtimer_start(&vi->tx_timer, ktime_set(0,500000),
+                  HRTIMER_MODE_REL);
     return 0;
 }
 
@@ -363,6 +398,10 @@ static int virtnet_probe(struct virtio_device *vdev)
     netif_napi_add(dev, &vi->napi, virtnet_poll, 16);
     vi->dev = dev;
     vi->vdev = vdev;
+    hrtimer_init(&vi->tx_timer, CLOCK_REALTIME, HRTIMER_MODE_REL);
+    vi->tx_timer.function = kick_xmit;
+    vi->tx_timer.cb_mode = HRTIMER_CB_SOFTIRQ;
+    vi->out_max = -1U;
 
     /* We expect two virtqueues, receive then send. */
     vi->rvq = vdev->config->find_vq(vdev, 0, skb_recv_done);
-- 
1.5.3.3
