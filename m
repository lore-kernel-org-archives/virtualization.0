From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 14/49] Staging: hv: vmbus: Use the DSDT specified irq for vmbus
Date: Mon,  6 Jun 2011 15:49:38 -0700
Message-ID: <1307400613-13234-14-git-send-email-kys@microsoft.com>
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

DSDT specifies the irq value for the vmbus driver; use it unconditionally.
This is an exclusive interrupt line dedicated for the vmbus driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 1b69339..5d7ecfd 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -552,9 +552,8 @@ static int vmbus_bus_init(int irq)
 	}
 
 	/* Get the interrupt resource */
-	ret = request_irq(irq, vmbus_isr,
-			  IRQF_SHARED | IRQF_SAMPLE_RANDOM,
-			  driver_name, hv_pci_dev);
+	ret = request_irq(irq, vmbus_isr, IRQF_SAMPLE_RANDOM,
+			driver_name, hv_pci_dev);
 
 	if (ret != 0) {
 		pr_err("Unable to request IRQ %d\n",
@@ -787,15 +786,7 @@ static int __devinit hv_pci_probe(struct pci_dev *pdev,
 	if (pci_probe_error)
 		goto probe_cleanup;
 
-	/*
-	 * If the PCI sub-sytem did not assign us an
-	 * irq, use the bios provided one.
-	 */
-
-	if (pdev->irq == 0)
-		pdev->irq = irq;
-
-	pci_probe_error = vmbus_bus_init(pdev->irq);
+	pci_probe_error = vmbus_bus_init(irq);
 
 	if (pci_probe_error)
 		pci_disable_device(pdev);
-- 
1.7.4.1
