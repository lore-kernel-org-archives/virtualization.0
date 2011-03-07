From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 04/16] Staging: hv: Remove unnecessary function pointers in
	driver_context
Date: Mon,  7 Mar 2011 13:23:18 -0800
Message-ID: <1299532998-22581-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the unnecessary function pointers for probe(),
remove() and shutdown() from struct driver_context.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus.h |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/vmbus.h b/drivers/staging/hv/vmbus.h
index 42f2adb..8bcfb40 100644
--- a/drivers/staging/hv/vmbus.h
+++ b/drivers/staging/hv/vmbus.h
@@ -33,14 +33,6 @@ struct driver_context {
 
 	struct device_driver driver;
 
-	/*
-	 * Use these methods instead of the struct device_driver so 2.6 kernel
-	 * stops complaining
-	 * TODO - fix this!
-	 */
-	int (*probe)(struct device *);
-	int (*remove)(struct device *);
-	void (*shutdown)(struct device *);
 };
 
 struct vm_device {
-- 
1.5.5.6
