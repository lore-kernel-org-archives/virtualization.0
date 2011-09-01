From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 08/10] staging: hv: fix the return status of netvsc_start_xmit()
Date: Thu,  1 Sep 2011 12:19:46 -0700
Message-ID: <1314904788-32746-9-git-send-email-haiyangz@microsoft.com>
References: <1314904788-32746-1-git-send-email-haiyangz@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314904788-32746-1-git-send-email-haiyangz@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Fix the return status, so the upper layer will retry if transmission
fails.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 81e3c49..30b9c80 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -140,12 +140,12 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 			 (num_pages * sizeof(struct hv_page_buffer)) +
 			 sizeof(struct rndis_filter_packet), GFP_ATOMIC);
 	if (!packet) {
-		/* out of memory, silently drop packet */
+		/* out of memory, drop packet */
 		netdev_err(net, "unable to allocate hv_netvsc_packet\n");
 
 		dev_kfree_skb(skb);
 		net->stats.tx_dropped++;
-		return NETDEV_TX_OK;
+		return NETDEV_TX_BUSY;
 	}
 
 	packet->extension = (void *)(unsigned long)packet +
@@ -194,7 +194,7 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 		dev_kfree_skb_any(skb);
 	}
 
-	return NETDEV_TX_OK;
+	return ret ? NETDEV_TX_BUSY : NETDEV_TX_OK;
 }
 
 /*
-- 
1.6.3.2
