From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 20/20] Staging: hv: netvsc: Rename deviceInfo as device_info
Date: Tue, 13 Sep 2011 10:59:56 -0700
Message-ID: <1315936796-20662-20-git-send-email-kys@microsoft.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315936796-20662-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Rename deviceInfo as device_info.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/rndis_filter.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index bfe9129..963582a 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -691,7 +691,7 @@ int rndis_filter_device_add(struct hv_device *dev,
 	int ret;
 	struct netvsc_device *net_device;
 	struct rndis_device *rndis_device;
-	struct netvsc_device_info *deviceInfo = additional_info;
+	struct netvsc_device_info *device_info = additional_info;
 
 	rndis_device = get_rndis_device();
 	if (!rndis_device)
@@ -732,15 +732,15 @@ int rndis_filter_device_add(struct hv_device *dev,
 		 */
 	}
 
-	memcpy(deviceInfo->mac_adr, rndis_device->hw_mac_adr, ETH_ALEN);
+	memcpy(device_info->mac_adr, rndis_device->hw_mac_adr, ETH_ALEN);
 
 	rndis_filter_query_device_link_status(rndis_device);
 
-	deviceInfo->link_state = rndis_device->link_stat;
+	device_info->link_state = rndis_device->link_stat;
 
 	dev_info(&dev->device, "Device MAC %pM link state %s",
 		 rndis_device->hw_mac_adr,
-		 ((deviceInfo->link_state) ? ("down\n") : ("up\n")));
+		 ((device_info->link_state) ? ("down\n") : ("up\n")));
 
 	return ret;
 }
-- 
1.7.4.1
