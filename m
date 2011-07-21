From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 8/9] staging: hv: fix the return status of netvsc_start_xmit()
Date: Thu, 21 Jul 2011 10:14:56 -0700
Message-ID: <1311268497-8671-9-git-send-email-haiyangz__39505.498801782$1311267648$gmane$org@microsoft.com>
References: <1311268497-8671-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1311268497-8671-1-git-send-email-haiyangz@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, v-abkane@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, vir
List-Id: virtualization@lists.linuxfoundation.org

Fix the return status, so the upper layer will retry if transmission
fails.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index a15165e..818ddf8 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -142,12 +142,12 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
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
@@ -196,7 +196,7 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 		dev_kfree_skb_any(skb);
 	}
 
-	return NETDEV_TX_OK;
+	return ret ? NETDEV_TX_BUSY : NETDEV_TX_OK;
 }
 
 /*
-- 
1.6.3.2
