From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 005/117] Staging: hv: vmbus: Introduce vmbus ID space in
	struct hv_driver
Date: Fri, 15 Jul 2011 10:45:53 -0700
Message-ID: <1310752065-27895-5-git-send-email-kys@microsoft.com>
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

In preparation for supporting auto-loading Hyper-V drivers
using vmbus specific aliases, introduce vmbus ID space in struct hv_driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hyperv.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index 399d9fe..b8199f4 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -32,6 +32,7 @@
 #include <linux/workqueue.h>
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 
 
 #include <asm/hyperv.h>
@@ -805,6 +806,7 @@ struct hv_driver {
 
 	/* the device type supported by this driver */
 	uuid_le dev_type;
+	const struct hv_vmbus_device_id *id_table;
 
 	struct device_driver driver;
 
-- 
1.7.4.1
