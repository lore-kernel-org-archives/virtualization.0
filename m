From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 25/25] Staging: hv: netvsc: Rename deviceInfo as device_info
Date: Thu,  8 Sep 2011 07:24:36 -0700
Message-ID: <1315491876-9554-25-git-send-email-kys@microsoft.com>
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

Rename deviceInfo as device_info.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/rndis_filter.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index cb9d4f6..732dfe7 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -696,7 +696,7 @@ int rndis_filter_device_add(struct hv_device *dev,
 	int ret;
 	struct netvsc_device *net_device;
 	struct rndis_device *rndis_device;
-	struct netvsc_device_info *deviceInfo = additional_info;
+	struct netvsc_device_info *device_info = additional_info;
 
 	rndis_device = get_rndis_device();
 	if (!rndis_device)
@@ -737,15 +737,15 @@ int rndis_filter_device_add(struct hv_device *dev,
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
