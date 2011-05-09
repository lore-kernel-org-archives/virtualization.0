From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 069/206] Staging: hv: Get rid of netvsc_cleanup()
Date: Mon,  9 May 2011 14:55:51 -0700
Message-ID: <1304978288-22999-69-git-send-email-kys@microsoft.com>
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

netvsc_cleanup() is an empty function; get rid of it.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index 8790f0f..34828c4 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -622,13 +622,6 @@ int netvsc_device_remove(struct hv_device *device)
 	return 0;
 }
 
-/*
- * netvsc_cleanup - Perform any cleanup when the driver is removed
- */
-static void netvsc_cleanup(struct hv_driver *drv)
-{
-}
-
 static void netvsc_send_completion(struct hv_device *device,
 				   struct vmpacket_descriptor *packet)
 {
@@ -1194,7 +1187,6 @@ int netvsc_initialize(struct hv_driver *drv)
 	/* Setup the dispatch table */
 	driver->base.dev_add	= netvsc_device_add;
 	driver->base.dev_rm	= netvsc_device_remove;
-	driver->base.cleanup		= netvsc_cleanup;
 
 	driver->send			= netvsc_send;
 
-- 
1.7.4.1
