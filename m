From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 12/21] Staging: hv: Cleanup irq management
Date: Thu, 10 Mar 2011 14:08:53 -0800
Message-ID: <1299794933-1259-1-git-send-email-kys@microsoft.com>
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

Now that vmbus_driver is a platform pci driver,
cleanup the irq allocation mess by using the standard
irq allocation mechanisms.

Note that this patch generates an error when the checkpatch
script is run because of the IRQF_SAMPLE_RANDOM flag used in
request_irq() function. This interrupt is the only
external event this VM will get and consequently if this
flag (IRQF_SAMPLE_RANDOM) is not  specified, experimentally
we have shown that the entropy in the VM will very very low.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Mike Sterling <mike.sterling@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index e4855ac..4e45016 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -17,6 +17,8 @@
  * Authors:
  *   Haiyang Zhang <haiyangz@microsoft.com>
  *   Hank Janssen  <hjanssen@microsoft.com>
+ *
+ * 3/9/2011: K. Y. Srinivasan	- Significant restructuring and cleanup
  */
 #include <linux/init.h>
 #include <linux/err.h>
@@ -37,10 +39,6 @@
 #include "vmbus_private.h"
 
 
-/* FIXME! We need to do this dynamically for PIC and APIC system */
-#define VMBUS_IRQ		0x5
-#define VMBUS_IRQ_VECTOR	IRQ5_VECTOR
-
 static struct device *root_dev; /* Root device */
 
 struct pci_dev *hv_pci_dev;
@@ -74,7 +72,6 @@ EXPORT_SYMBOL(vmbus_loglevel);
 	/* (ALL_MODULES << 16 | DEBUG_LVL_ENTEREXIT); */
 	/* (((VMBUS | VMBUS_DRV)<<16) | DEBUG_LVL_ENTEREXIT); */
 
-static int vmbus_irq = VMBUS_IRQ;
 
 /* Set up per device attributes in /sys/bus/vmbus/devices/<bus device> */
 static struct device_attribute vmbus_device_attrs[] = {
@@ -375,7 +372,7 @@ static ssize_t vmbus_show_device_attr(struct device *dev,
  *	- setup the vmbus root device
  *	- retrieve the channel offers
  */
-static int vmbus_bus_init(void)
+static int vmbus_bus_init(struct pci_dev *pdev)
 {
 	struct vmbus_driver_context *vmbus_drv_ctx = &vmbus_drv;
 	int ret;
@@ -418,21 +415,23 @@ static int vmbus_bus_init(void)
 	}
 
 	/* Get the interrupt resource */
-	ret = request_irq(vmbus_irq, vmbus_isr, IRQF_SAMPLE_RANDOM,
-			  driver_name, NULL);
+	ret = request_irq(pdev->irq, vmbus_isr,
+			  IRQF_SHARED | IRQF_SAMPLE_RANDOM,
+			  driver_name, pdev);
 
 	if (ret != 0) {
 		DPRINT_ERR(VMBUS_DRV, "ERROR - Unable to request IRQ %d",
-			   vmbus_irq);
+			   pdev->irq);
 
 		bus_unregister(&vmbus_drv_ctx->bus);
 
 		ret = -1;
 		goto cleanup;
 	}
-	vector = VMBUS_IRQ_VECTOR;
 
-	DPRINT_INFO(VMBUS_DRV, "irq 0x%x vector 0x%x", vmbus_irq, vector);
+	vector = IRQ0_VECTOR + pdev->irq;
+	DPRINT_INFO(VMBUS_DRV, "irq 0x%x vector 0x%x", pdev->irq,
+			IRQ0_VECTOR + pdev->irq);
 
 	/* Register the root device */
 	root_dev = root_device_register(driver_name);
@@ -441,7 +440,7 @@ static int vmbus_bus_init(void)
 		DPRINT_ERR(VMBUS_DRV,
 			   "ERROR - Unable to register vmbus root device");
 
-		free_irq(vmbus_irq, NULL);
+		free_irq(pdev->irq, pdev);
 		bus_unregister(&vmbus_drv_ctx->bus);
 
 		ret = PTR_ERR(root_dev);
@@ -456,7 +455,7 @@ static int vmbus_bus_init(void)
 	ret = vmbus_connect();
 	if (ret) {
 		root_device_unregister(root_dev);
-		free_irq(vmbus_irq, NULL);
+		free_irq(pdev->irq, pdev);
 		bus_unregister(&vmbus_drv_ctx->bus);
 		goto cleanup;
 	}
@@ -490,7 +489,7 @@ static void vmbus_bus_exit(void)
 
 	bus_unregister(&vmbus_drv_ctx->bus);
 
-	free_irq(vmbus_irq, NULL);
+	free_irq(hv_pci_dev->irq, hv_pci_dev);
 
 	tasklet_kill(&vmbus_drv_ctx->msg_dpc);
 	tasklet_kill(&vmbus_drv_ctx->event_dpc);
@@ -902,7 +901,7 @@ static int __devinit hv_pci_probe(struct pci_dev *pdev,
 	if (err)
 		return err;
 
-	err = vmbus_bus_init();
+	err = vmbus_bus_init(pdev);
 	if (err)
 		pci_disable_device(pdev);
 
@@ -942,7 +941,6 @@ static void __exit hv_pci_exit(void)
 
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HV_DRV_VERSION);
-module_param(vmbus_irq, int, S_IRUGO);
 module_param(vmbus_loglevel, int, S_IRUGO);
 
 module_init(hv_pci_init);
-- 
1.5.5.6
