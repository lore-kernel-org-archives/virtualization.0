From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 3/4] Staging: hv: vmbus: Check for events before messages
Date: Wed, 31 Aug 2011 14:35:56 -0700
Message-ID: <1314826557-28755-3-git-send-email-kys@microsoft.com>
References: <1314826529-28716-1-git-send-email-kys@microsoft.com>
	<1314826557-28755-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314826557-28755-1-git-send-email-kys@microsoft.com>
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

The Windows team has informed us that on Windows guests on Hyper-V,
they check for events before messages. They also recommended that we do
the same. This patch addresses this.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index b5e06d6..cd43ddd 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -442,14 +442,11 @@ static irqreturn_t vmbus_isr(int irq, void *dev_id)
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
+	/*
+	 * Check for events before checking for messages. This is the order
+	 * in which events and messages are checked in Windows guests on
+	 * Hyper-V, and the Windows team suggested we do the same.
+	 */
 
 	page_addr = hv_context.synic_event_page[cpu];
 	event = (union hv_synic_event_flags *)page_addr + VMBUS_MESSAGE_SINT;
@@ -460,6 +457,15 @@ static irqreturn_t vmbus_isr(int irq, void *dev_id)
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
