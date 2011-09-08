From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 02/25] Staging: hv: vmbus: Rename vmbus_child_device_register
Date: Thu,  8 Sep 2011 07:24:13 -0700
Message-ID: <1315491876-9554-2-git-send-email-kys@microsoft.com>
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

The vmbus devices are NOT child devices; rename vmbus_child_device_register
to reflect this.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/channel_mgmt.c |    2 +-
 drivers/staging/hv/hyperv_vmbus.h |    2 +-
 drivers/staging/hv/vmbus_drv.c    |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index f99b944..a927046 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -393,7 +393,7 @@ static void vmbus_process_offer(struct work_struct *work)
 	 * binding which eventually invokes the device driver's AddDevice()
 	 * method.
 	 */
-	ret = vmbus_child_device_register(newchannel->device_obj);
+	ret = vmbus_device_register(newchannel->device_obj);
 	if (ret != 0) {
 		pr_err("unable to add child device object (relid %d)\n",
 			   newchannel->offermsg.child_relid);
diff --git a/drivers/staging/hv/hyperv_vmbus.h b/drivers/staging/hv/hyperv_vmbus.h
index e97e2cf..b2dfcd6 100644
--- a/drivers/staging/hv/hyperv_vmbus.h
+++ b/drivers/staging/hv/hyperv_vmbus.h
@@ -605,7 +605,7 @@ struct hv_device *vmbus_device_create(uuid_le *type,
 					 uuid_le *instance,
 					 struct vmbus_channel *channel);
 
-int vmbus_child_device_register(struct hv_device *child_device_obj);
+int vmbus_device_register(struct hv_device *child_device_obj);
 void vmbus_child_device_unregister(struct hv_device *device_obj);
 
 /* static void */
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 382baee..6d54ea1 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -619,9 +619,9 @@ struct hv_device *vmbus_device_create(uuid_le *type,
 }
 
 /*
- * vmbus_child_device_register - Register the child device
+ * vmbus_device_register - Register the child device
  */
-int vmbus_child_device_register(struct hv_device *child_device_obj)
+int vmbus_device_register(struct hv_device *child_device_obj)
 {
 	int ret = 0;
 
-- 
1.7.4.1
