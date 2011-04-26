From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 16/25] Staging: hv: Make msg_dpc a global variable
Date: Tue, 26 Apr 2011 09:20:33 -0700
Message-ID: <1303834842-5022-16-git-send-email-kys@microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303834842-5022-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for cleaning up (getting rid of) of the hv_bus structure,
make msg_dpc a global variable.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index f779d4e..028051d 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -42,10 +42,11 @@
 
 static struct pci_dev *hv_pci_dev;
 
+static struct tasklet_struct msg_dpc;
+
 /* Main vmbus driver data structure */
 struct hv_bus {
 	struct bus_type bus;
-	struct tasklet_struct msg_dpc;
 	struct tasklet_struct event_dpc;
 };
 
@@ -517,7 +518,7 @@ static irqreturn_t vmbus_isr(int irq, void *dev_id)
 	/* Schedules a dpc if necessary */
 	if (ret > 0) {
 		if (test_bit(0, (unsigned long *)&ret))
-			tasklet_schedule(&hv_bus.msg_dpc);
+			tasklet_schedule(&msg_dpc);
 
 		if (test_bit(1, (unsigned long *)&ret))
 			tasklet_schedule(&hv_bus.event_dpc);
@@ -552,7 +553,7 @@ static int vmbus_bus_init(struct pci_dev *pdev)
 	hv_bus.bus.name = driver_name;
 
 	/* Initialize the bus context */
-	tasklet_init(&hv_bus.msg_dpc, vmbus_on_msg_dpc, 0);
+	tasklet_init(&msg_dpc, vmbus_on_msg_dpc, 0);
 	tasklet_init(&hv_bus.event_dpc, vmbus_on_event, 0);
 
 	/* Now, register the bus  with LDM */
-- 
1.7.4.1
