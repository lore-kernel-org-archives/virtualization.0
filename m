From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 7/9] staging: hv: fix counting of available buffer slots when
	send fails
Date: Thu, 21 Jul 2011 10:14:55 -0700
Message-ID: <1311268497-8671-8-git-send-email-haiyangz__18801.7780347311$1311267670$gmane$org@microsoft.com>
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

Because the number of available buffer slots doesn't decrease for failed
sends, we should not call netvsc_xmit_completion(), which increase the
count of available slots. In this failed case, just free the memory is
enough.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 816e382..a15165e 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -192,7 +192,8 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
 	} else {
 		/* we are shutting down or bus overloaded, just drop packet */
 		net->stats.tx_dropped++;
-		netvsc_xmit_completion(packet);
+		kfree(packet);
+		dev_kfree_skb_any(skb);
 	}
 
 	return NETDEV_TX_OK;
-- 
1.6.3.2
