From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/18] Staging: hv: Make event_dpc a stand alone variable
Date: Fri, 29 Apr 2011 13:45:07 -0700
Message-ID: <1304109916-24874-9-git-send-email-kys@microsoft.com>
References: <1304109779-24819-1-git-send-email-kys@microsoft.com>
 <1304109916-24874-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304109916-24874-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for getting rid of struct hv_bus, Make event_dpc a
stand alone variable.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 38bfff0..6cc01c2 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -43,11 +43,11 @@
 static struct pci_dev *hv_pci_dev;
 
 static struct tasklet_struct msg_dpc;
+static struct tasklet_struct event_dpc;
 
 /* Main vmbus driver data structure */
 struct hv_bus {
 	struct bus_type bus;
-	struct tasklet_struct event_dpc;
 };
 
 unsigned int vmbus_loglevel = (ALL_MODULES << 16 | INFO_LVL);
@@ -519,7 +519,7 @@ static irqreturn_t vmbus_isr(int irq, void *dev_id)
 			tasklet_schedule(&msg_dpc);
 
 		if (test_bit(1, (unsigned long *)&ret))
-			tasklet_schedule(&hv_bus.event_dpc);
+			tasklet_schedule(&event_dpc);
 
 		return IRQ_HANDLED;
 	} else {
@@ -552,7 +552,7 @@ static int vmbus_bus_init(struct pci_dev *pdev)
 
 	/* Initialize the bus context */
 	tasklet_init(&msg_dpc, vmbus_on_msg_dpc, 0);
-	tasklet_init(&hv_bus.event_dpc, vmbus_on_event, 0);
+	tasklet_init(&event_dpc, vmbus_on_event, 0);
 
 	/* Now, register the bus  with LDM */
 	ret = bus_register(&hv_bus.bus);
-- 
1.7.4.1
