From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 181/206] Staging: hv: Include the newly created header files in storvsc.c
Date: Mon,  9 May 2011 14:57:43 -0700
Message-ID: <1304978288-22999-181-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Include the newly created header files in storvsc.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 8d7a490..3bc174e 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -27,13 +27,9 @@
 #include <linux/slab.h>
 #include <linux/mm.h>
 #include <linux/delay.h>
-#include "hv_api.h"
-#include "logging.h"
-#include "storvsc_api.h"
-#include "vmbus_packet_format.h"
-#include "vstorage.h"
-#include "channel.h"
 
+#include <linux/hyperv.h>
+#include "hyperv_storage.h"
 
 static inline struct storvsc_device *alloc_stor_device(struct hv_device *device)
 {
-- 
1.7.4.1
