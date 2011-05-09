From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 180/206] Staging: hv: Include the newly created header files in blkvsc_drv.c
Date: Mon,  9 May 2011 14:57:42 -0700
Message-ID: <1304978288-22999-180-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Include the newly created header files in blkvsc_drv.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 10da9bb..efc63f1 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -31,12 +31,9 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_eh.h>
 #include <scsi/scsi_dbg.h>
-#include "hv_api.h"
-#include "logging.h"
-#include "version_info.h"
-#include "vmbus.h"
-#include "storvsc_api.h"
 
+#include <linux/hyperv.h>
+#include "hyperv_storage.h"
 
 #define BLKVSC_MINORS	64
 
-- 
1.7.4.1
