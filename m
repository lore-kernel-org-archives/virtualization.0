From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 151/206] Staging: hv: Get rid of some unused code
Date: Mon,  9 May 2011 14:57:13 -0700
Message-ID: <1304978288-22999-151-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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

Now, get rid of struct mousevsc_drv_obj.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 0eca451..af4db64 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -45,20 +45,6 @@ struct hv_input_dev_info {
 	char name[128];
 };
 
-/* Represents the input vsc driver */
-/* FIXME - can be removed entirely */
-struct mousevsc_drv_obj {
-	struct hv_driver base;
-};
-
-
-static inline
-struct mousevsc_drv_obj *drv_to_mousedrv(struct device_driver *d)
-{
-	struct hv_driver *hvdrv = drv_to_hv_drv(d);
-	return container_of(hvdrv, struct mousevsc_drv_obj, base);
-}
-
 /* The maximum size of a synthetic input message. */
 #define SYNTHHID_MAX_INPUT_REPORT_SIZE 16
 
-- 
1.7.4.1
