From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/8] Staging: hv: vmbus: Get rid of vmbus_on_isr() by inlining the code
Date: Mon, 15 Aug 2011 15:12:00 -0700
Message-ID: <1313446327-10650-1-git-send-email-kys@microsoft.com>
References: <1313446210-10611-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313446210-10611-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of vmbus_on_isr() by inlining this code in the
real interrupt handler.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   41 +++++++++++----------------------------
 1 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index b382829..bb25c5b 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -411,53 +411,36 @@ static void vmbus_on_msg_dpc(unsigned long data)
 	}
 }
 
-/*
- * vmbus_on_isr - ISR routine
- */
-static int vmbus_on_isr(void)
+static irqreturn_t vmbus_isr(int irq, void *dev_id)
 {
-	int ret = 0;
 	int cpu = smp_processor_id();
 	void *page_addr;
 	struct hv_message *msg;
 	union hv_synic_event_flags *event;
+	bool handled = false;
 
 	page_addr = hv_context.synic_message_page[cpu];
 	msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 
 	/* Check if there are actual msgs to be process */
-	if (msg->header.message_type != HVMSG_NONE)
-		ret |= 0x1;
+	if (msg->header.message_type != HVMSG_NONE) {
+		handled = true;
+		tasklet_schedule(&msg_dpc);
+	}
 
 	page_addr = hv_context.synic_event_page[cpu];
 	event = (union hv_synic_event_flags *)page_addr + VMBUS_MESSAGE_SINT;
 
 	/* Since we are a child, we only need to check bit 0 */
-	if (sync_test_and_clear_bit(0, (unsigned long *) &event->flags32[0]))
-		ret |= 0x2;
-
-	return ret;
-}
-
-
-static irqreturn_t vmbus_isr(int irq, void *dev_id)
-{
-	int ret;
-
-	ret = vmbus_on_isr();
-
-	/* Schedules a dpc if necessary */
-	if (ret > 0) {
-		if (test_bit(0, (unsigned long *)&ret))
-			tasklet_schedule(&msg_dpc);
-
-		if (test_bit(1, (unsigned long *)&ret))
-			tasklet_schedule(&event_dpc);
+	if (sync_test_and_clear_bit(0, (unsigned long *) &event->flags32[0])) {
+		handled = true;
+		tasklet_schedule(&event_dpc);
+	}
 
+	if (handled)
 		return IRQ_HANDLED;
-	} else {
+	else
 		return IRQ_NONE;
-	}
 }
 
 /*
-- 
1.7.4.1
