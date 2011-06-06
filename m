From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 13/49] Staging: hv: vmbus: Change the signature of
	vmbus_bus_init()
Date: Mon,  6 Jun 2011 15:49:37 -0700
Message-ID: <1307400613-13234-13-git-send-email-kys@microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
	<1307400613-13234-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1307400613-13234-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for making the vmbus driver an ACPI bus driver, change the
signature of vmbus_bus_init() to accept the irq value. 

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 51af6d8..1b69339 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -528,7 +528,7 @@ static irqreturn_t vmbus_isr(int irq, void *dev_id)
  *	- get the irq resource
  *	- retrieve the channel offers
  */
-static int vmbus_bus_init(struct pci_dev *pdev)
+static int vmbus_bus_init(int irq)
 {
 	int ret;
 	unsigned int vector;
@@ -552,13 +552,13 @@ static int vmbus_bus_init(struct pci_dev *pdev)
 	}
 
 	/* Get the interrupt resource */
-	ret = request_irq(pdev->irq, vmbus_isr,
+	ret = request_irq(irq, vmbus_isr,
 			  IRQF_SHARED | IRQF_SAMPLE_RANDOM,
-			  driver_name, pdev);
+			  driver_name, hv_pci_dev);
 
 	if (ret != 0) {
 		pr_err("Unable to request IRQ %d\n",
-			   pdev->irq);
+			   irq);
 
 		bus_unregister(&hv_bus);
 
@@ -566,7 +566,7 @@ static int vmbus_bus_init(struct pci_dev *pdev)
 		goto cleanup;
 	}
 
-	vector = IRQ0_VECTOR + pdev->irq;
+	vector = IRQ0_VECTOR + irq;
 
 	/*
 	 * Notify the hypervisor of our irq and
@@ -575,7 +575,7 @@ static int vmbus_bus_init(struct pci_dev *pdev)
 	on_each_cpu(hv_synic_init, (void *)&vector, 1);
 	ret = vmbus_connect();
 	if (ret) {
-		free_irq(pdev->irq, pdev);
+		free_irq(irq, hv_pci_dev);
 		bus_unregister(&hv_bus);
 		goto cleanup;
 	}
@@ -795,7 +795,7 @@ static int __devinit hv_pci_probe(struct pci_dev *pdev,
 	if (pdev->irq == 0)
 		pdev->irq = irq;
 
-	pci_probe_error = vmbus_bus_init(pdev);
+	pci_probe_error = vmbus_bus_init(pdev->irq);
 
 	if (pci_probe_error)
 		pci_disable_device(pdev);
-- 
1.7.4.1
