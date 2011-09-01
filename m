From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 07/10] staging: hv: fix counting of available buffer slots
	when send fails
Date: Thu,  1 Sep 2011 12:19:45 -0700
Message-ID: <1314904788-32746-8-git-send-email-haiyangz@microsoft.com>
References: <1314904788-32746-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314904788-32746-1-git-send-email-haiyangz@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: haiyangz@microsoft.com, hjanssen@microsoft.com, kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
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
index b49a08f..81e3c49 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -190,7 +190,8 @@ static int netvsc_start_xmit(struct sk_buff *skb, struct net_device *net)
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
