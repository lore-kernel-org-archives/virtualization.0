From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/3] Staging: hv: netvsc: Fix a bug in accounting transmit slots
Date: Mon,  6 Jun 2011 15:57:35 -0700
Message-ID: <1307401055-13608-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The current code manipulates the available transmit slots without proper
locking; fix it.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 33cab9c..38ca2c2 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -21,6 +21,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/init.h>
+#include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/device.h>
@@ -45,7 +46,7 @@
 struct net_device_context {
 	/* point back to our device context */
 	struct hv_device *device_ctx;
-	unsigned long avail;
+	atomic_t avail;
 	struct delayed_work dwork;
 };
 
@@ -118,8 +119,9 @@ static void netvsc_xmit_completion(void *context)
 
 		dev_kfree_skb_any(skb);
 
-		net_device_ctx->avail += num_pages;
-		if (net_device_ctx->avail >= PACKET_PAGES_HIWATER)
+		atomic_add(num_pages, &net_device_ctx->avail);
+		if (atomic_read(&net_device_ctx->avail) >=
+				PACKET_PAGES_HIWATER)
  			netif_wake_queue(net);
 	}
 }
@@ -133,7 +135,7 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 
 	/* Add 1 for skb->data and additional one for RNDIS */
 	num_pages = skb_shinfo(skb)->nr_frags + 1 + 1;
-	if (num_pages > net_device_ctx->avail)
+	if (num_pages > atomic_read(&net_device_ctx->avail))
 		return NETDEV_TX_BUSY;
 
 	/* Allocate a netvsc packet based on # of frags. */
@@ -185,8 +187,8 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 		net->stats.tx_bytes += skb->len;
 		net->stats.tx_packets++;
 
-		net_device_ctx->avail -= num_pages;
-		if (net_device_ctx->avail < PACKET_PAGES_LOWATER)
+		atomic_sub(num_pages, &net_device_ctx->avail);
+		if (atomic_read(&net_device_ctx->avail) < PACKET_PAGES_LOWATER)
 			netif_stop_queue(net);
 	} else {
 		/* we are shutting down or bus overloaded, just drop packet */
@@ -345,7 +347,7 @@ static int netvsc_probe(struct hv_device *dev)
 
 	net_device_ctx = netdev_priv(net);
 	net_device_ctx->device_ctx = dev;
-	net_device_ctx->avail = ring_size;
+	atomic_set(&net_device_ctx->avail, ring_size);
 	dev_set_drvdata(&dev->device, net);
 	INIT_DELAYED_WORK(&net_device_ctx->dwork, netvsc_send_garp);
 
-- 
1.7.4.1
