From: Haiyang Zhang <haiyangz@microsoft.com>
Subject: [PATCH 5/6] staging: hv: fix typo in name rndis_filte_device_add()
Date: Mon, 23 May 2011 09:03:49 -0700
Message-ID: <1306166630-17336-5-git-send-email-haiyangz__28165.6580431902$1306167621$gmane$org@microsoft.com>
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

rename rndis_filte_device_add to rndis_filter_device_add

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/hyperv_net.h   |    2 +-
 drivers/staging/hv/netvsc_drv.c   |    2 +-
 drivers/staging/hv/rndis_filter.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/hyperv_net.h b/drivers/staging/hv/hyperv_net.h
index 6226dd3..cf762bd 100644
--- a/drivers/staging/hv/hyperv_net.h
+++ b/drivers/staging/hv/hyperv_net.h
@@ -99,7 +99,7 @@ int netvsc_recv_callback(struct hv_device *device_obj,
 int netvsc_initialize(struct hv_driver *drv);
 int rndis_filter_open(struct hv_device *dev);
 int rndis_filter_close(struct hv_device *dev);
-int rndis_filte_device_add(struct hv_device *dev,
+int rndis_filter_device_add(struct hv_device *dev,
 			void *additional_info);
 void rndis_filter_device_remove(struct hv_device *dev);
 int rndis_filter_receive(struct hv_device *dev,
diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 6a2f17d..f510959 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -352,7 +352,7 @@ static int netvsc_probe(struct hv_device *dev)
 
 	/* Notify the netvsc driver of the new device */
 	device_info.ring_size = ring_size;
-	ret = rndis_filte_device_add(dev, &device_info);
+	ret = rndis_filter_device_add(dev, &device_info);
 	if (ret != 0) {
 		free_netdev(net);
 		dev_set_drvdata(&dev->device, NULL);
diff --git a/drivers/staging/hv/rndis_filter.c b/drivers/staging/hv/rndis_filter.c
index 572cec6..b142aae 100644
--- a/drivers/staging/hv/rndis_filter.c
+++ b/drivers/staging/hv/rndis_filter.c
@@ -681,7 +681,7 @@ static int rndis_filter_close_device(struct rndis_device *dev)
 	return ret;
 }
 
-int rndis_filte_device_add(struct hv_device *dev,
+int rndis_filter_device_add(struct hv_device *dev,
 				  void *additional_info)
 {
 	int ret;
-- 
1.6.3.2
