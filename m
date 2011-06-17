From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 5/5] staging: hv: fix a kernel warning in
	netvsc_linkstatus_callback()
Date: Fri, 17 Jun 2011 07:58:08 -0700
Message-ID: <1308322688-9796-5-git-send-email-haiyangz__22183.7974655957$1308321986$gmane$org@microsoft.com>
References: <1308322688-9796-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1308322688-9796-1-git-send-email-haiyangz@microsoft.com>
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
Cc: stable <stable@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

netif_notify_peers() is not allowed in netvsc_linkstatus_callback() on some
distros, because netvsc_linkstatus_callback() is within IRQ context. So we
move the first call to netif_notify_peers() into queued work as well, but with
zero delay.

This should also be back-ported to stable kernels 2.6.32 and later.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Cc: stable <stable@kernel.org>
---
 drivers/staging/hv/netvsc_drv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index c9ed19a..2299b88 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -216,8 +216,8 @@ void netvsc_linkstatus_callback(struct hv_device *device_obj,
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
