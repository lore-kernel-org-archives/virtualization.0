From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 170/206] Staging: hv: Cleanup the newly created header file
Date: Mon,  9 May 2011 14:57:32 -0700
Message-ID: <1304978288-22999-170-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hyperv_vmbus.h |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/hyperv_vmbus.h b/drivers/staging/hv/hyperv_vmbus.h
index 8ccae84..104dc8f 100644
--- a/drivers/staging/hv/hyperv_vmbus.h
+++ b/drivers/staging/hv/hyperv_vmbus.h
@@ -26,6 +26,7 @@
 #define _HYPERV_VMBUS_H
 
 #include <linux/hyperv.h>
+#include <asm/sync_bitops.h>
 
 /*
  * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
@@ -393,8 +394,6 @@ union hv_x64_msr_hypercall_contents {
 };
 
 
-#include "hv_api.h"
-
 enum {
 	VMBUS_MESSAGE_CONNECTION_ID	= 1,
 	VMBUS_MESSAGE_PORT_ID		= 1,
@@ -534,8 +533,6 @@ void hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
 			    struct hv_ring_buffer_debug_info *debug_info);
 
 
-#include <asm/sync_bitops.h>
-
 
 /*
  * Maximum channels is determined by the size of the interrupt page
-- 
1.7.4.1
