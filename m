From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 3/6] staging: hv: change rndis_filter_device_remove() to void
	return type
Date: Mon, 23 May 2011 09:03:47 -0700
Message-ID: <1306166630-17336-3-git-send-email-haiyangz__3125.6036869765$1306165887$gmane$org@microsoft.com>
References: <1306166630-17336-1-git-send-email-haiyangz@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1306166630-17336-1-git-send-email-haiyangz@microsoft.com>
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

rndis_filter_device_remove() always return 0, so change it to void return
type. Also cleaned up the error checking in the caller.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/hyperv_net.h   |    2 +-
 drivers/staging/hv/netvsc_drv.c   |    9 ++-------
 drivers/staging/hv/rndis_filter.c |    4 +---
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hv/hyperv_net.h b/drivers/staging/hv/hyperv_net.h
index 315097d..6226dd3 100644
--- a/drivers/staging/hv/hyperv_net.h
+++ b/drivers/staging/hv/hyperv_net.h
@@ -101,7 +101,7 @@ int rndis_filter_open(struct hv_device *dev);
 int rndis_filter_close(struct hv_device *dev);
 int rndis_filte_device_add(struct hv_device *dev,
 			void *additional_info);
-int rndis_filter_device_remove(struct hv_device *dev);
+void rndis_filter_device_remove(struct hv_device *dev);
 int rndis_filter_receive(struct hv_device *dev,
 			struct hv_netvsc_packet *pkt);
 
diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index e716d4d..ad25433 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -387,7 +387,6 @@ static int netvsc_probe(struct hv_device *dev)
 static int netvsc_remove(struct hv_device *dev)
 {
 	struct net_device *net = dev_get_drvdata(&dev->device);
-	int ret;
 
 	if (net == NULL) {
 		dev_err(&dev->device, "No net device to remove\n");
@@ -404,14 +403,10 @@ static int netvsc_remove(struct hv_device *dev)
 	 * Call to the vsc driver to let it know that the device is being
 	 * removed
 	 */
-	ret = rndis_filter_device_remove(dev);
-	if (ret != 0) {
-		/* TODO: */
-		netdev_err(net, "unable to remove vsc device (ret %d)\n", ret);
-	}
+	rndis_filter_device_remove(dev);
 
 	free_netdev(net);
-	return ret;
+	return 0;
 }
 
 /* The one and only one */
diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index 60ebdb1..572cec6 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -741,7 +741,7 @@ int rndis_filte_device_add(struct hv_device *dev,
 	return ret;
 }
 
-int rndis_filter_device_remove(struct hv_device *dev)
+void rndis_filter_device_remove(struct hv_device *dev)
 {
 	struct netvsc_device *net_dev = dev->ext;
 	struct rndis_device *rndis_dev = net_dev->extension;
@@ -753,8 +753,6 @@ int rndis_filter_device_remove(struct hv_device *dev)
 	net_dev->extension = NULL;
 
 	netvsc_device_remove(dev);
-
-	return 0;
 }
 
 
-- 
1.6.3.2
