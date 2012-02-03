From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/4] drivers: hv: Cleanup the kvp related state in hyperv.h
Date: Thu,  2 Feb 2012 16:56:48 -0800
Message-ID: <1328230611-3315-1-git-send-email-kys@microsoft.com>
References: <1328230577-3263-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328230577-3263-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now cleanup the hyperv.h with regards to KVP definitions.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 include/linux/hyperv.h |   27 ++++++++++++++-------------
 1 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 7332b3f..b822978 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -137,7 +137,6 @@ struct hv_ku_msg {
 
 
 
-#ifdef __KERNEL__
 
 /*
  * Registry value types.
@@ -163,28 +162,30 @@ enum hv_kvp_exchg_pool {
 };
 
 struct hv_kvp_hdr {
-	u8 operation;
-	u8 pool;
-};
+	__u8 operation;
+	__u8 pool;
+	__u16 pad;
+} __attribute__((packed));
 
 struct hv_kvp_exchg_msg_value {
-	u32 value_type;
-	u32 key_size;
-	u32 value_size;
-	u8 key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
-	u8 value[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
-};
+	__u32 value_type;
+	__u32 key_size;
+	__u32 value_size;
+	__u8 key[HV_KVP_EXCHANGE_MAX_KEY_SIZE];
+	__u8 value[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
+} __attribute__((packed));
 
 struct hv_kvp_msg_enumerate {
-	u32 index;
+	__u32 index;
 	struct hv_kvp_exchg_msg_value data;
-};
+} __attribute__((packed));
 
 struct hv_kvp_msg {
 	struct hv_kvp_hdr	kvp_hdr;
 	struct hv_kvp_msg_enumerate	kvp_data;
-};
+} __attribute__((packed));
 
+#ifdef __KERNEL__
 #include <linux/scatterlist.h>
 #include <linux/list.h>
 #include <linux/uuid.h>
-- 
1.7.4.1
