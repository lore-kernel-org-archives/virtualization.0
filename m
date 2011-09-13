From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 18/20] Staging: hv: netvsc: Rename netDevice as net_device
Date: Tue, 13 Sep 2011 10:59:54 -0700
Message-ID: <1315936796-20662-18-git-send-email-kys@microsoft.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315936796-20662-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Rename netDevice as net_device.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc.c       |    5 ++++-
 drivers/staging/hv/rndis_filter.c |   14 +++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 2bcc8b2..b902579 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -382,7 +382,10 @@ int netvsc_device_remove(struct hv_device *device)
 	hv_set_drvdata(device, NULL);
 	spin_unlock_irqrestore(&device->channel->inbound_lock, flags);
 
-	/* At this point, no one should be accessing netDevice except in here */
+	/*
+	 * At this point, no one should be accessing net_device
+	 * except in here
+	 */
 	dev_notice(&device->device, "net device safe to remove\n");
 
 	/* Now, we can close the channel safely */
diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index b354b0b..efa7df5 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -689,7 +689,7 @@ int rndis_filter_device_add(struct hv_device *dev,
 				  void *additional_info)
 {
 	int ret;
-	struct netvsc_device *netDevice;
+	struct netvsc_device *net_device;
 	struct rndis_device *rndisDevice;
 	struct netvsc_device_info *deviceInfo = additional_info;
 
@@ -710,10 +710,10 @@ int rndis_filter_device_add(struct hv_device *dev,
 
 
 	/* Initialize the rndis device */
-	netDevice = hv_get_drvdata(dev);
+	net_device = hv_get_drvdata(dev);
 
-	netDevice->extension = rndisDevice;
-	rndisDevice->net_dev = netDevice;
+	net_device->extension = rndisDevice;
+	rndisDevice->net_dev = net_device;
 
 	/* Send the rndis initialization message */
 	ret = rndis_filter_init_device(rndisDevice);
@@ -762,12 +762,12 @@ void rndis_filter_device_remove(struct hv_device *dev)
 
 int rndis_filter_open(struct hv_device *dev)
 {
-	struct netvsc_device *netDevice = hv_get_drvdata(dev);
+	struct netvsc_device *net_device = hv_get_drvdata(dev);
 
-	if (!netDevice)
+	if (!net_device)
 		return -EINVAL;
 
-	return rndis_filter_open_device(netDevice->extension);
+	return rndis_filter_open_device(net_device->extension);
 }
 
 int rndis_filter_close(struct hv_device *dev)
-- 
1.7.4.1
