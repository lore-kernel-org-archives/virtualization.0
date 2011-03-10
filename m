From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 04/21] Staging: hv: Eliminate vmbus_event_dpc()
Date: Thu, 10 Mar 2011 14:05:16 -0800
Message-ID: <1299794716-963-1-git-send-email-kys@microsoft.com>
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

vmbus_event_dpc() was a wrapper function not adding any value;
get rid of it.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/connection.c    |    2 +-
 drivers/staging/hv/vmbus_drv.c     |   11 +----------
 drivers/staging/hv/vmbus_private.h |    2 +-
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index f7df479..fd589e3 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -285,7 +285,7 @@ static void process_chn_event(void *context)
 /*
  * vmbus_on_event - Handler for events
  */
-void vmbus_on_event(void)
+void vmbus_on_event(unsigned long data)
 {
 	int dword;
 	int maxdword = MAX_NUM_CHANNELS_SUPPORTED >> 5;
diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 7e67933..4b4483b 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -56,7 +56,6 @@ static int vmbus_probe(struct device *device);
 static int vmbus_remove(struct device *device);
 static void vmbus_shutdown(struct device *device);
 static int vmbus_uevent(struct device *device, struct kobj_uevent_env *env);
-static void vmbus_event_dpc(unsigned long data);
 
 static irqreturn_t vmbus_isr(int irq, void *dev_id);
 
@@ -485,7 +484,7 @@ static int vmbus_bus_init(void)
 	/* Initialize the bus context */
 	tasklet_init(&vmbus_drv_ctx->msg_dpc, vmbus_on_msg_dpc,
 		     (unsigned long)NULL);
-	tasklet_init(&vmbus_drv_ctx->event_dpc, vmbus_event_dpc,
+	tasklet_init(&vmbus_drv_ctx->event_dpc, vmbus_on_event,
 		     (unsigned long)NULL);
 
 	/* Now, register the bus  with LDM */
@@ -985,14 +984,6 @@ static void vmbus_device_release(struct device *device)
 }
 
 
-/*
- * vmbus_event_dpc - Tasklet routine to handle hypervisor events
- */
-static void vmbus_event_dpc(unsigned long data)
-{
-	/* Call to bus driver to handle interrupt */
-	vmbus_on_event();
-}
 
 static irqreturn_t vmbus_isr(int irq, void *dev_id)
 {
diff --git a/drivers/staging/hv/vmbus_private.h b/drivers/staging/hv/vmbus_private.h
index 9f505c4..1b88b6f 100644
--- a/drivers/staging/hv/vmbus_private.h
+++ b/drivers/staging/hv/vmbus_private.h
@@ -129,7 +129,7 @@ int vmbus_post_msg(void *buffer, size_t buflen);
 
 int vmbus_set_event(u32 child_relid);
 
-void vmbus_on_event(void);
+void vmbus_on_event(unsigned long data);
 
 
 #endif /* _VMBUS_PRIVATE_H_ */
-- 
1.5.5.6
