From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 072/117] Staging: hv: mouse: Get rid of the unused PCI
	signature
Date: Fri, 15 Jul 2011 10:47:00 -0700
Message-ID: <1310752065-27895-72-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of  the unused  PCI signature.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 1c17658..6e1c4ce 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -22,8 +22,6 @@
 #include <linux/input.h>
 #include <linux/hid.h>
 #include <linux/hiddev.h>
-#include <linux/pci.h>
-#include <linux/dmi.h>
 #include <linux/delay.h>
 
 #include "hyperv.h"
@@ -960,25 +958,6 @@ static void __exit mousevsc_exit(void)
 	mousevsc_drv_exit();
 }
 
-/*
- * We don't want to automatically load this driver just yet, it's quite
- * broken.  It's safe if you want to load it yourself manually, but
- * don't inflict it on unsuspecting users, that's just mean.
- */
-#if 0
-
-/*
- * We use a PCI table to determine if we should autoload this driver  This is
- * needed by distro tools to determine if the hyperv drivers should be
- * installed and/or configured.  We don't do anything else with the table, but
- * it needs to be present.
- */
-const static struct pci_device_id microsoft_hv_pci_table[] = {
-	{ PCI_DEVICE(0x1414, 0x5353) },	/* VGA compatible controller */
-	{ 0 }
-};
-MODULE_DEVICE_TABLE(pci, microsoft_hv_pci_table);
-#endif
 
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HV_DRV_VERSION);
-- 
1.7.4.1
