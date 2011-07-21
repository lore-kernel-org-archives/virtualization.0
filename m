From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 5/9] staging: hv: re-order the code in netvsc_probe()
Date: Thu, 21 Jul 2011 10:14:53 -0700
Message-ID: <1311268497-8671-6-git-send-email-haiyangz__38158.679745584$1311269840$gmane$org@microsoft.com>
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

Re-order the code in netvsc_probe() to prevent a guest crash caused by
packets possibly received from NetVSP before call to register_netdev().

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index c8e2f24..816e382 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -350,19 +350,6 @@ static int netvsc_probe(struct hv_device *dev)
 	dev_set_drvdata(&dev->device, net);
 	INIT_DELAYED_WORK(&net_device_ctx->dwork, netvsc_send_garp);
 
-	/* Notify the netvsc driver of the new device */
-	device_info.ring_size = ring_size;
-	ret = rndis_filter_device_add(dev, &device_info);
-	if (ret != 0) {
-		free_netdev(net);
-		dev_set_drvdata(&dev->device, NULL);
-		return ret;
-	}
-
-	netif_carrier_on(net);
-
-	memcpy(net->dev_addr, device_info.mac_adr, ETH_ALEN);
-
 	net->netdev_ops = &device_ops;
 
 	/* TODO: Add GSO and Checksum offload */
@@ -374,11 +361,26 @@ static int netvsc_probe(struct hv_device *dev)
 
 	ret = register_netdev(net);
 	if (ret != 0) {
-		/* Remove the device and release the resource */
-		rndis_filter_device_remove(dev);
+		pr_err("Unable to register netdev.\n");
 		free_netdev(net);
+		goto out;
 	}
 
+	/* Notify the netvsc driver of the new device */
+	device_info.ring_size = ring_size;
+	ret = rndis_filter_device_add(dev, &device_info);
+	if (ret != 0) {
+		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
+		unregister_netdev(net);
+		free_netdev(net);
+		dev_set_drvdata(&dev->device, NULL);
+		return ret;
+	}
+	memcpy(net->dev_addr, device_info.mac_adr, ETH_ALEN);
+
+	netif_carrier_on(net);
+
+out:
 	return ret;
 }
 
-- 
1.6.3.2
