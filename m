From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 16/59] Staging: hv: netvsc: Get rid of the PCI signature
Date: Thu, 25 Aug 2011 09:48:42 -0700
Message-ID: <1314290965-2698-16-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
	<1314290965-2698-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
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

Now that we have implemented a vmbus specific mechanism for auto-loading,
get rid of the PCI signature.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 2e25c95..ea5c289 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -34,7 +34,6 @@
 #include <linux/in.h>
 #include <linux/slab.h>
 #include <linux/dmi.h>
-#include <linux/pci.h>
 #include <net/arp.h>
 #include <net/route.h>
 #include <net/sock.h>
@@ -477,13 +476,6 @@ static int __init netvsc_drv_init(void)
 	return ret;
 }
 
-static const struct pci_device_id __initconst
-hv_netvsc_pci_table[] __maybe_unused = {
-	{ PCI_DEVICE(0x1414, 0x5353) }, /* VGA compatible controller */
-	{ 0 }
-};
-MODULE_DEVICE_TABLE(pci, hv_netvsc_pci_table);
-
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HV_DRV_VERSION);
 MODULE_DESCRIPTION("Microsoft Hyper-V network driver");
-- 
1.7.4.1
