From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 37/46] Staging: hv: vmbus: Check for events before messages
Date: Sat, 27 Aug 2011 11:31:36 -0700
Message-ID: <1314469905-7058-37-git-send-email-kys@microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314469905-7058-1-git-send-email-kys@microsoft.com>
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

Conform to Windows specification by checking for events before messages.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 5dcc8c3..4e07d4f 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -445,15 +445,6 @@ static irqreturn_t vmbus_isr(int irq, void *dev_id)
 	union hv_synic_event_flags *event;
 	bool handled = false;
 
-	page_addr = hv_context.synic_message_page[cpu];
-	msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
-
-	/* Check if there are actual msgs to be process */
-	if (msg->header.message_type != HVMSG_NONE) {
-		handled = true;
-		tasklet_schedule(&msg_dpc);
-	}
-
 	page_addr = hv_context.synic_event_page[cpu];
 	event = (union hv_synic_event_flags *)page_addr + VMBUS_MESSAGE_SINT;
 
@@ -463,6 +454,15 @@ static irqreturn_t vmbus_isr(int irq, void *dev_id)
 		tasklet_schedule(&event_dpc);
 	}
 
+	page_addr = hv_context.synic_message_page[cpu];
+	msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
+
+	/* Check if there are actual msgs to be processed */
+	if (msg->header.message_type != HVMSG_NONE) {
+		handled = true;
+		tasklet_schedule(&msg_dpc);
+	}
+
 	if (handled)
 		return IRQ_HANDLED;
 	else
-- 
1.7.4.1
