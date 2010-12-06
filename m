From: Hank Janssen <hjanssen@microsoft.com>
Subject: [PATCH 7/8] staging: hv: Convert camel case function names in
	blkvsc.c to lowercase
Date: Mon,  6 Dec 2010 12:26:50 -0800
Message-ID: <1291667211-1865-7-git-send-email-hjanssen@microsoft.com>
References: <1291667211-1865-1-git-send-email-hjanssen@microsoft.com>
	<1291667211-1865-2-git-send-email-hjanssen@microsoft.com>
	<1291667211-1865-3-git-send-email-hjanssen@microsoft.com>
	<1291667211-1865-4-git-send-email-hjanssen@microsoft.com>
	<1291667211-1865-5-git-send-email-hjanssen@microsoft.com>
	<1291667211-1865-6-git-send-email-hjanssen@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1291667211-1865-6-git-send-email-hjanssen@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: hjanssen@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Hank Janssen <hjanssen@microsoft.com> 

Convert camel case function names in blkvsc.c to lowercase
 
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>

---
 drivers/staging/hv/blkvsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/blkvsc.c b/drivers/staging/hv/blkvsc.c
index 208492c..4f4a65c 100644
--- a/drivers/staging/hv/blkvsc.c
+++ b/drivers/staging/hv/blkvsc.c
@@ -35,7 +35,7 @@ static const struct hv_guid gBlkVscDeviceType = {
 	}
 };
 
-static int BlkVscOnDeviceAdd(struct hv_device *Device, void *AdditionalInfo)
+static int blk_vsc_on_device_add(struct hv_device *Device, void *AdditionalInfo)
 {
 	struct storvsc_device_info *deviceInfo;
 	int ret = 0;
@@ -93,7 +93,7 @@ int blk_vsc_initialize(struct hv_driver *Driver)
 		    storDriver->max_outstanding_req_per_channel);
 
 	/* Setup the dispatch table */
-	storDriver->base.OnDeviceAdd = BlkVscOnDeviceAdd;
+	storDriver->base.OnDeviceAdd = blk_vsc_on_device_add;
 	storDriver->base.OnDeviceRemove = stor_vsc_on_device_remove;
 	storDriver->base.OnCleanup = stor_vsc_on_cleanup;
 	storDriver->on_io_request = stor_vsc_on_io_request;
-- 
1.6.0.2
