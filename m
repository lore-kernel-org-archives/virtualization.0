From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 27/77] Staging: hv: vmbus: Cleanup vmbus_match() function
Date: Thu, 16 Jun 2011 13:17:00 -0700
Message-ID: <1308255470-3826-27-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
	<1308255470-3826-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, based on the newly introduved id_table, cleanup the 
vmbus_match function. This mechanism will also permit us to handle
multiple device types using a common driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index cbb80ec..0e1a13c 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -250,16 +250,16 @@ static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env)
  */
 static int vmbus_match(struct device *device, struct device_driver *driver)
 {
-	int match = 0;
 	struct hv_driver *drv = drv_to_hv_drv(driver);
 	struct hv_device *hv_dev = device_to_hv_device(device);
+	const struct hv_vmbus_device_id *id_array = drv->id_table;
 
-	/* We found our driver ? */
-	if (memcmp(&hv_dev->dev_type, &drv->dev_type,
-		   sizeof(struct hv_guid)) == 0)
-		match = 1;
+	for (; *id_array->device_type != '\0'; id_array++) {
+		if (!strcmp(id_array->device_type, hv_dev->device_type))
+			return 1;
+	}
 
-	return match;
+	return 0;
 }
 
 /*
-- 
1.7.4.1
