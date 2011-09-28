From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH] staging: hv: remove the carrier status check from netvsc_open()
Date: Wed, 28 Sep 2011 13:24:15 -0700
Message-ID: <1317241455-30493-1-git-send-email-haiyangz@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: haiyangz@microsoft.com, kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Checking carrier status in netvsc_open() is not necessary.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>

---
 drivers/staging/hv/TODO         |    2 --
 drivers/staging/hv/netvsc_drv.c |   19 +++++++------------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/hv/TODO b/drivers/staging/hv/TODO
index fcc57c2..ed4d636 100644
--- a/drivers/staging/hv/TODO
+++ b/drivers/staging/hv/TODO
@@ -1,7 +1,5 @@
 TODO:
 	- audit the network driver
-	  - checking for carrier inside open is wrong, network device API
-            confusion??
 	- audit the scsi driver
 
 Please send patches for this code to Greg Kroah-Hartman <gregkh@suse.de>,
diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 69c233e..561ba58 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -69,20 +69,15 @@ static int netvsc_open(struct net_device *net)
 	struct hv_device *device_obj = net_device_ctx->device_ctx;
 	int ret = 0;
 
-	if (netif_carrier_ok(net)) {
-		/* Open up the device */
-		ret = rndis_filter_open(device_obj);
-		if (ret != 0) {
-			netdev_err(net, "unable to open device (ret %d).\n",
-				   ret);
-			return ret;
-		}
-
-		netif_start_queue(net);
-	} else {
-		netdev_err(net, "unable to open device...link is down.\n");
+	/* Open up the device */
+	ret = rndis_filter_open(device_obj);
+	if (ret != 0) {
+		netdev_err(net, "unable to open device (ret %d).\n", ret);
+		return ret;
 	}
 
+	netif_start_queue(net);
+
 	return ret;
 }
 
-- 
1.6.3.2
