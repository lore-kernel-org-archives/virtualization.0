From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 03/21] Staging: hv: Get rid of the function vmbus_msg_dpc()
Date: Thu, 10 Mar 2011 14:04:53 -0800
Message-ID: <1299794693-933-1-git-send-email-kys@microsoft.com>
References: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <[PATCH 00/21] Staging: hv: Cleanup vmbus driver>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: kys@microsoft.com, gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Mike Sterling <mike.sterling@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

vmbus_msg_dpc() was a  wrapper adding no additional value;
get rid of this function.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 95654b1..7e67933 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -56,7 +56,6 @@ static int vmbus_probe(struct device *device);
 static int vmbus_remove(struct device *device);
 static void vmbus_shutdown(struct device *device);
 static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env);
-static void vmbus_msg_dpc(unsigned long data);
 static void vmbus_event_dpc(unsigned long data);
 
 static irqreturn_t vmbus_isr(int irq, void *dev_id);
@@ -214,7 +213,7 @@ static void vmbus_onmessage_work(struct work_struct *work)
 /*
  * vmbus_on_msg_dpc - DPC routine to handle messages from the hypervisior
  */
-static void vmbus_on_msg_dpc(struct hv_driver *drv)
+static void vmbus_on_msg_dpc(unsigned long data)
 {
 	int cpu = smp_processor_id();
 	void *page_addr = hv_context.synic_message_page[cpu];
@@ -484,7 +483,7 @@ static int vmbus_bus_init(void)
 	vmbus_drv_ctx->bus.name = driver_name;
 
 	/* Initialize the bus context */
-	tasklet_init(&vmbus_drv_ctx->msg_dpc, vmbus_msg_dpc,
+	tasklet_init(&vmbus_drv_ctx->msg_dpc, vmbus_on_msg_dpc,
 		     (unsigned long)NULL);
 	tasklet_init(&vmbus_drv_ctx->event_dpc, vmbus_event_dpc,
 		     (unsigned long)NULL);
@@ -985,16 +984,6 @@ static void vmbus_device_release(struct device *device)
 	/* !!DO NOT REFERENCE device_ctx anymore at this point!! */
 }
 
-/*
- * vmbus_msg_dpc - Tasklet routine to handle hypervisor messages
- */
-static void vmbus_msg_dpc(unsigned long data)
-{
-	struct hv_driver *driver = (struct hv_driver *)data;
-
-	/* Call to bus driver to handle interrupt */
-	vmbus_on_msg_dpc(driver);
-}
 
 /*
  * vmbus_event_dpc - Tasklet routine to handle hypervisor events
-- 
1.5.5.6
