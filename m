From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 1/1] staging: hv: Removed unneeded call to netif_stop_queue() in hv_netvsc
Date: Fri,  7 Jan 2011 09:25:39 -0800
Message-ID: <1294421139-18657-1-git-send-email-hjanssen@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: hjanssen@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Abhishek Kane <v-abkane@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Hank Janssen <hjanssen@microsoft.com>

Removed the call to netif_stop_queue() in netvsc_probe() as
the queue is not initialized at that point and further call
to it after queue initialization is really not necessary.

This change was prompted after an upstream change went into 
2.6.37 (netif_tx_stop_queue) that now checks if netif_stop_queue
is called before register with netdev is done.

This will eliminate the warning message to the log when hv_netvsc
driver starts up.

Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>


---
 drivers/staging/hv/netvsc_drv.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 0147b40..54706a1 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -358,7 +358,6 @@ static int netvsc_probe(struct device *device)
 
 	/* Set initial state */
 	netif_carrier_off(net);
-	netif_stop_queue(net);
 
 	net_device_ctx = netdev_priv(net);
 	net_device_ctx->device_ctx = device_ctx;
-- 
1.6.0.2
