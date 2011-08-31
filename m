From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/4] Staging: hv: vmbus: Fix a bug in error handling in vmbus_bus_init()
Date: Wed, 31 Aug 2011 14:35:55 -0700
Message-ID: <1314826557-28755-2-git-send-email-kys@microsoft.com>
References: <1314826529-28716-1-git-send-email-kys@microsoft.com>
 <1314826557-28755-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314826557-28755-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix a bug in error handling in vmbus_bus_init().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 757943b..b5e06d6 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -492,7 +492,7 @@ static int vmbus_bus_init(int irq)
 
 	ret = bus_register(&hv_bus);
 	if (ret)
-		return ret;
+		goto err_cleanup;
 
 	ret = request_irq(irq, vmbus_isr, IRQF_SAMPLE_RANDOM,
 			driver_name, hv_acpi_dev);
@@ -500,10 +500,7 @@ static int vmbus_bus_init(int irq)
 	if (ret != 0) {
 		pr_err("Unable to request IRQ %d\n",
 			   irq);
-
-		bus_unregister(&hv_bus);
-
-		return ret;
+		goto err_unregister;
 	}
 
 	vector = IRQ0_VECTOR + irq;
@@ -514,16 +511,23 @@ static int vmbus_bus_init(int irq)
 	 */
 	on_each_cpu(hv_synic_init, (void *)&vector, 1);
 	ret = vmbus_connect();
-	if (ret) {
-		free_irq(irq, hv_acpi_dev);
-		bus_unregister(&hv_bus);
-		return ret;
-	}
-
+	if (ret)
+		goto err_irq;
 
 	vmbus_request_offers();
 
 	return 0;
+
+err_irq:
+	free_irq(irq, hv_acpi_dev);
+
+err_unregister:
+	bus_unregister(&hv_bus);
+
+err_cleanup:
+	hv_cleanup();
+
+	return ret;
 }
 
 /**
-- 
1.7.4.1
