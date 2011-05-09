From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 159/206] Staging: hv: Include the contents of version_info.h
Date: Mon,  9 May 2011 14:57:21 -0700
Message-ID: <1304978288-22999-159-git-send-email-kys@microsoft.com>
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
 include/linux/hyperv.h |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2e72a47..fc05036 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -706,4 +706,24 @@ extern unsigned int vmbus_loglevel;
 	} while (0)
 
 
+/*
+ * We use the same version numbering for all Hyper-V modules.
+ *
+ * Definition of versioning is as follows;
+ *
+ *	Major Number	Changes for these scenarios;
+ *			1.	When a new version of Windows Hyper-V
+ *				is released.
+ *			2.	A Major change has occurred in the
+ *				Linux IC's.
+ *			(For example the merge for the first time
+ *			into the kernel) Every time the Major Number
+ *			changes, the Revision number is reset to 0.
+ *	Minor Number	Changes when new functionality is added
+ *			to the Linux IC's that is not a bug fix.
+ *
+ * 3.1 - Added completed hv_utils driver. Shutdown/Heartbeat/Timesync
+ */
+#define HV_DRV_VERSION           "3.1"
+
 #endif /* _HYPERV_H_ */
-- 
1.7.4.1
