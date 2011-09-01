From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 04/10] staging: hv: fix a kernel warning in
	netvsc_linkstatus_callback()
Date: Thu,  1 Sep 2011 12:19:42 -0700
Message-ID: <1314904788-32746-5-git-send-email-haiyangz@microsoft.com>
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
Cc: stable <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

netif_notify_peers() caused a kernel warning in netvsc_linkstatus_callback(),
because netvsc_linkstatus_callback() is within IRQ context. So we move
the first call to netif_notify_peers() into queued work as well, but with
zero delay.

In addition to "staging-next", this should also be back-ported to stable
kernels 2.6.32 and later.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Cc: stable <stable@kernel.org>
---
 drivers/staging/hv/netvsc_drv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 30a0cb2..e6513be 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -214,8 +214,8 @@ void netvsc_linkstatus_callback(struct hv_device *device_obj,
 	if (status == 1) {
 		netif_carrier_on(net);
 		netif_wake_queue(net);
-		netif_notify_peers(net);
 		ndev_ctx = netdev_priv(net);
+		schedule_delayed_work(&ndev_ctx->dwork, 0);
 		schedule_delayed_work(&ndev_ctx->dwork, msecs_to_jiffies(20));
 	} else {
 		netif_carrier_off(net);
-- 
1.6.3.2
