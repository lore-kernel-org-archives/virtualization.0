From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 16/49] Staging: hv: vmbus: Get rid of vmbus_acpi_init() by
	inlining the code
Date: Mon,  6 Jun 2011 15:49:40 -0700
Message-ID: <1307400613-13234-16-git-send-email-kys@microsoft.com>
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

Staging: hv: vmbus: Get rid of  vmbus_acpi_init() by inlining the code.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 176a8cd..d799f42 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -758,18 +758,6 @@ static struct acpi_driver vmbus_acpi_driver = {
 	},
 };
 
-static int vmbus_acpi_init(void)
-{
-	int result;
-
-
-	result = acpi_bus_register_driver(&vmbus_acpi_driver);
-	if (result < 0)
-		return result;
-
-	return 0;
-}
-
 static void vmbus_acpi_exit(void)
 {
 	acpi_bus_unregister_driver(&vmbus_acpi_driver);
@@ -800,7 +788,8 @@ static int __init hv_acpi_init(void)
 	 * Get irq resources first.
 	 */
 
-	ret = vmbus_acpi_init();
+	ret = acpi_bus_register_driver(&vmbus_acpi_driver);
+
 	if (ret)
 		return ret;
 
-- 
1.7.4.1
