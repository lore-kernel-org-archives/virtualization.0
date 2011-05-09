From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 082/206] Staging: hv: Get rid of the mouse cleanup() function
Date: Mon,  9 May 2011 14:56:04 -0700
Message-ID: <1304978288-22999-82-git-send-email-kys@microsoft.com>
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

mousevsc_on_cleanup() is an empty function; get rid of it.


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index b7016e2..41bfa3f 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -782,9 +782,6 @@ static int mousevsc_on_device_remove(struct hv_device *device)
 	return ret;
 }
 
-static void mousevsc_on_cleanup(struct hv_driver *drv)
-{
-}
 
 /*
  * Data types
@@ -994,7 +991,6 @@ static int mouse_vsc_initialize(struct hv_driver *driver)
 	/* Setup the dispatch table */
 	input_drv->base.dev_add = mousevsc_on_device_add;
 	input_drv->base.dev_rm = mousevsc_on_device_remove;
-	input_drv->base.cleanup = mousevsc_on_cleanup;
 
 	return ret;
 }
-- 
1.7.4.1
