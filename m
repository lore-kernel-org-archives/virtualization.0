From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 27/40] Staging: hv: storvsc: Handle IDE devices correctly in
	storvsc_remove()
Date: Wed, 29 Jun 2011 07:39:24 -0700
Message-ID: <1309358377-8537-27-git-send-email-kys@microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
	<1309358377-8537-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1309358377-8537-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Properly deal with cleaning up of resources on storvsc_remove().
Keep in mind that while on the scsi side, we don't get called for each
scsi disk configured for the guest, on the IDE side, we will get called
for each IDE device that was probed. Perform all the cleanup in the 
context of the HBA owner.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index c0d6e16..a6da132 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -350,6 +350,7 @@ static int storvsc_remove(struct hv_device *dev)
 	struct hv_host_device *host_dev =
 			(struct hv_host_device *)host->hostdata;
 	struct storvsc_device *stor_dev = dev->ext;
+	int i;
 
 	if (!stor_dev->hba_owner)
 		return 0;
@@ -359,6 +360,14 @@ static int storvsc_remove(struct hv_device *dev)
 	scsi_host_put(host);
 
 	storvsc_dev_remove(dev);
+
+	for (i = 0; i < 4; i++) {
+		struct hv_device *d = ide_devices[i];
+
+		if (d)
+			storvsc_dev_remove(d);
+	}
+
 	if (host_dev->request_pool) {
 		kmem_cache_destroy(host_dev->request_pool);
 		host_dev->request_pool = NULL;
-- 
1.7.4.1
