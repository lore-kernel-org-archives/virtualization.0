From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 24/25] Staging: hv: netvsc: Rename rndisDevice to rndis_device
Date: Thu,  8 Sep 2011 07:24:35 -0700
Message-ID: <1315491876-9554-24-git-send-email-kys@microsoft.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1315491876-9554-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Rename rndisDevice to rndis_device.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/rndis_filter.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index fb46a88..cb9d4f6 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -695,11 +695,11 @@ int rndis_filter_device_add(struct hv_device *dev,
 {
 	int ret;
 	struct netvsc_device *net_device;
-	struct rndis_device *rndisDevice;
+	struct rndis_device *rndis_device;
 	struct netvsc_device_info *deviceInfo = additional_info;
 
-	rndisDevice = get_rndis_device();
-	if (!rndisDevice)
+	rndis_device = get_rndis_device();
+	if (!rndis_device)
 		return -ENODEV;
 
 	/*
@@ -709,7 +709,7 @@ int rndis_filter_device_add(struct hv_device *dev,
 	 */
 	ret = netvsc_device_add(dev, additional_info);
 	if (ret != 0) {
-		kfree(rndisDevice);
+		kfree(rndis_device);
 		return ret;
 	}
 
@@ -717,11 +717,11 @@ int rndis_filter_device_add(struct hv_device *dev,
 	/* Initialize the rndis device */
 	net_device = (struct netvsc_device *)hv_get_drvdata(dev);
 
-	net_device->extension = rndisDevice;
-	rndisDevice->net_dev = net_device;
+	net_device->extension = rndis_device;
+	rndis_device->net_dev = net_device;
 
 	/* Send the rndis initialization message */
-	ret = rndis_filter_init_device(rndisDevice);
+	ret = rndis_filter_init_device(rndis_device);
 	if (ret != 0) {
 		/*
 		 * TODO: If rndis init failed, we will need to shut down the
@@ -730,21 +730,21 @@ int rndis_filter_device_add(struct hv_device *dev,
 	}
 
 	/* Get the mac address */
-	ret = rndis_filter_query_device_mac(rndisDevice);
+	ret = rndis_filter_query_device_mac(rndis_device);
 	if (ret != 0) {
 		/*
 		 * TODO: shutdown rndis device and the channel
 		 */
 	}
 
-	memcpy(deviceInfo->mac_adr, rndisDevice->hw_mac_adr, ETH_ALEN);
+	memcpy(deviceInfo->mac_adr, rndis_device->hw_mac_adr, ETH_ALEN);
 
-	rndis_filter_query_device_link_status(rndisDevice);
+	rndis_filter_query_device_link_status(rndis_device);
 
-	deviceInfo->link_state = rndisDevice->link_stat;
+	deviceInfo->link_state = rndis_device->link_stat;
 
 	dev_info(&dev->device, "Device MAC %pM link state %s",
-		 rndisDevice->hw_mac_adr,
+		 rndis_device->hw_mac_adr,
 		 ((deviceInfo->link_state) ? ("down\n") : ("up\n")));
 
 	return ret;
-- 
1.7.4.1
