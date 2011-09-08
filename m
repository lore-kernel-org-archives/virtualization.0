From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/25] Staging: hv: vmbus: Rename vmbus_child_device_create
Date: Thu,  8 Sep 2011 07:24:12 -0700
Message-ID: <1315491876-9554-1-git-send-email-kys@microsoft.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1315491843-9513-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The vmbus devices are NOT child devices; rename vmbus_child_device_create
to reflect this.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/channel_mgmt.c |    2 +-
 drivers/staging/hv/hyperv_vmbus.h |    2 +-
 drivers/staging/hv/vmbus_drv.c    |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index 11beb41..f99b944 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -383,7 +383,7 @@ static void vmbus_process_offer(struct work_struct *work)
 	 * We need to set the DeviceObject field before calling
 	 * vmbus_child_dev_add()
 	 */
-	newchannel->device_obj = vmbus_child_device_create(
+	newchannel->device_obj = vmbus_device_create(
 		&newchannel->offermsg.offer.if_type,
 		&newchannel->offermsg.offer.if_instance,
 		newchannel);
diff --git a/drivers/staging/hv/hyperv_vmbus.h b/drivers/staging/hv/hyperv_vmbus.h
index 16ca90d..e97e2cf 100644
--- a/drivers/staging/hv/hyperv_vmbus.h
+++ b/drivers/staging/hv/hyperv_vmbus.h
@@ -601,7 +601,7 @@ extern struct vmbus_connection vmbus_connection;
 
 /* General vmbus interface */
 
-struct hv_device *vmbus_child_device_create(uuid_le *type,
+struct hv_device *vmbus_device_create(uuid_le *type,
 					 uuid_le *instance,
 					 struct vmbus_channel *channel);
 
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index c0f3b7a..382baee 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -594,10 +594,10 @@ void vmbus_driver_unregister(struct hv_driver *hv_driver)
 EXPORT_SYMBOL_GPL(vmbus_driver_unregister);
 
 /*
- * vmbus_child_device_create - Creates and registers a new child device
+ * vmbus_device_create - Creates and registers a new child device
  * on the vmbus.
  */
-struct hv_device *vmbus_child_device_create(uuid_le *type,
+struct hv_device *vmbus_device_create(uuid_le *type,
 					    uuid_le *instance,
 					    struct vmbus_channel *channel)
 {
-- 
1.7.4.1
