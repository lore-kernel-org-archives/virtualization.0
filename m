From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 08/25] Staging: hv: vmbus_driver cannot be unloaded;
	cleanup accordingly
Date: Tue, 26 Apr 2011 09:20:25 -0700
Message-ID: <1303834842-5022-8-git-send-email-kys@microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
	<1303834842-5022-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1303834842-5022-1-git-send-email-kys@microsoft.com>
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

The vmbus driver cannot be unloaded; the windows host does not
permit this. Cleanup accordingly.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   32 --------------------------------
 1 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index bf124a7..d597dd4 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -622,30 +622,6 @@ cleanup:
 	return ret;
 }
 
-/*
- * vmbus_bus_exit - Terminate the vmbus driver.
- *
- * This routine is opposite of vmbus_bus_init()
- */
-static void vmbus_bus_exit(void)
-{
-
-
-	vmbus_release_unattached_channels();
-	vmbus_disconnect();
-	on_each_cpu(hv_synic_cleanup, NULL, 1);
-
-	hv_cleanup();
-
-	bus_unregister(&hv_bus.bus);
-
-	free_irq(hv_pci_dev->irq, hv_pci_dev);
-
-	tasklet_kill(&hv_bus.msg_dpc);
-	tasklet_kill(&hv_bus.event_dpc);
-}
-
-
 /**
  * vmbus_child_driver_register() - Register a vmbus's child driver
  * @drv:        Pointer to driver structure you want to register
@@ -814,17 +790,9 @@ static int __init hv_pci_init(void)
 	return pci_register_driver(&hv_bus_driver);
 }
 
-static void __exit hv_pci_exit(void)
-{
-	vmbus_bus_exit();
-	pci_unregister_driver(&hv_bus_driver);
-}
-
-
 
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HV_DRV_VERSION);
 module_param(vmbus_loglevel, int, S_IRUGO|S_IWUSR);
 
 module_init(hv_pci_init);
-module_exit(hv_pci_exit);
-- 
1.7.4.1
