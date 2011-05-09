From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 063/206] Staging: hv: Get rid of the indirection in invoking
	storvsc_dev_add()
Date: Mon,  9 May 2011 14:55:45 -0700
Message-ID: <1304978288-22999-63-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 233aa4c..599b5d2 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -784,15 +784,10 @@ static struct scsi_host_template scsi_driver = {
 static int storvsc_probe(struct hv_device *device)
 {
 	int ret;
-	struct storvsc_driver *storvsc_drv_obj =
-		 drv_to_stordrv(device->device.driver);
 	struct Scsi_Host *host;
 	struct hv_host_device *host_dev;
 	struct storvsc_device_info device_info;
 
-	if (!storvsc_drv_obj->base.dev_add)
-		return -1;
-
 	host = scsi_host_alloc(&scsi_driver,
 			       sizeof(struct hv_host_device));
 	if (!host)
@@ -818,7 +813,7 @@ static int storvsc_probe(struct hv_device *device)
 
 	device_info.port_number = host->host_no;
 	/* Call to the vsc driver to add the device */
-	ret = storvsc_drv_obj->base.dev_add(device, (void *)&device_info);
+	ret = storvsc_dev_add(device, (void *)&device_info);
 
 	if (ret != 0) {
 		kmem_cache_destroy(host_dev->request_pool);
-- 
1.7.4.1
