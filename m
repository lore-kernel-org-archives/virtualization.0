From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 1/6] staging: hv: remove unnecessary code in netvsc_probe().
Date: Mon, 23 May 2011 09:03:45 -0700
Message-ID: <1306166630-17336-1-git-send-email-haiyangz__14669.748026836$1306165886$gmane$org@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

netif_carrier_off() was called earlier in this function, and there is
no other thread access this device yet. The status checking code is not
necessary here.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/netvsc_drv.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 7b9c229..456d3df 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -364,17 +364,7 @@ static int netvsc_probe(struct hv_device *dev)
 		return ret;
 	}
 
-	/*
-	 * If carrier is still off ie we did not get a link status callback,
-	 * update it if necessary
-	 */
-	/*
-	 * FIXME: We should use a atomic or test/set instead to avoid getting
-	 * out of sync with the device's link status
-	 */
-	if (!netif_carrier_ok(net))
-		if (!device_info.link_state)
-			netif_carrier_on(net);
+	netif_carrier_on(net);
 
 	memcpy(net->dev_addr, device_info.mac_adr, ETH_ALEN);
 
-- 
1.6.3.2
