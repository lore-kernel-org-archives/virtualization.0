From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 016/206] Staging: hv: Rename the function
	stor_vsc_on_io_request
Date: Mon,  9 May 2011 14:54:58 -0700
Message-ID: <1304978288-22999-16-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/blkvsc_drv.c  |    2 +-
 drivers/staging/hv/storvsc.c     |    2 +-
 drivers/staging/hv/storvsc_api.h |    2 +-
 drivers/staging/hv/storvsc_drv.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index ec00a16..bfec15c 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -196,7 +196,7 @@ static int blk_vsc_initialize(struct hv_driver *driver)
 		    stor_driver->max_outstanding_req_per_channel);
 
 	/* Setup the dispatch table */
-	stor_driver->on_io_request = stor_vsc_on_io_request;
+	stor_driver->on_io_request = storvsc_do_io;
 
 	return ret;
 }
diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 2e276b4..867eba1 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -520,7 +520,7 @@ int storvsc_dev_remove(struct hv_device *device)
 /*
  * stor_vsc_on_io_request - Callback to initiate an I/O request
  */
-int stor_vsc_on_io_request(struct hv_device *device,
+int storvsc_do_io(struct hv_device *device,
 			      struct hv_storvsc_request *request)
 {
 	struct storvsc_device *stor_device;
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 3168161..f8c724b 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -167,7 +167,7 @@ int storvsc_dev_add(struct hv_device *device,
 				void *additional_info);
 int storvsc_dev_remove(struct hv_device *device);
 
-int stor_vsc_on_io_request(struct hv_device *device,
+int storvsc_do_io(struct hv_device *device,
 				struct hv_storvsc_request *request);
 void storvsc_cleanup(struct hv_driver *driver);
 
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 86f2bab..799231c 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -117,7 +117,7 @@ static int stor_vsc_initialize(struct hv_driver *driver)
 	stor_driver->base.dev_rm	= storvsc_dev_remove;
 	stor_driver->base.cleanup	= storvsc_cleanup;
 
-	stor_driver->on_io_request	= stor_vsc_on_io_request;
+	stor_driver->on_io_request	= storvsc_do_io;
 
 	return 0;
 }
-- 
1.7.4.1
