From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 156/206] Staging: hv: Include the contents of vmbus_channel_interface.h
Date: Mon,  9 May 2011 14:57:18 -0700
Message-ID: <1304978288-22999-156-git-send-email-kys@microsoft.com>
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
 include/linux/hyperv.h |   64 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index d0eec1d..4872ba8 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -74,7 +74,69 @@ struct hv_ring_buffer_debug_info {
 	u32 bytes_avail_towrite;
 };
 
-#include "vmbus_channel_interface.h"
+
+/*
+ * A revision number of vmbus that is used for ensuring both ends on a
+ * partition are using compatible versions.
+ */
+#define VMBUS_REVISION_NUMBER		13
+
+/* Make maximum size of pipe payload of 16K */
+#define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
+
+/* Define PipeMode values. */
+#define VMBUS_PIPE_TYPE_BYTE		0x00000000
+#define VMBUS_PIPE_TYPE_MESSAGE		0x00000004
+
+/* The size of the user defined data buffer for non-pipe offers. */
+#define MAX_USER_DEFINED_BYTES		120
+
+/* The size of the user defined data buffer for pipe offers. */
+#define MAX_PIPE_USER_DEFINED_BYTES	116
+
+/*
+ * At the center of the Channel Management library is the Channel Offer. This
+ * struct contains the fundamental information about an offer.
+ */
+struct vmbus_channel_offer {
+	struct hv_guid if_type;
+	struct hv_guid if_instance;
+	u64 int_latency; /* in 100ns units */
+	u32 if_revision;
+	u32 server_ctx_size;	/* in bytes */
+	u16 chn_flags;
+	u16 mmio_megabytes;		/* in bytes * 1024 * 1024 */
+
+	union {
+		/* Non-pipes: The user has MAX_USER_DEFINED_BYTES bytes. */
+		struct {
+			unsigned char user_def[MAX_USER_DEFINED_BYTES];
+		} std;
+
+		/*
+		 * Pipes:
+		 * The following sructure is an integrated pipe protocol, which
+		 * is implemented on top of standard user-defined data. Pipe
+		 * clients have MAX_PIPE_USER_DEFINED_BYTES left for their own
+		 * use.
+		 */
+		struct {
+			u32  pipe_mode;
+			unsigned char user_def[MAX_PIPE_USER_DEFINED_BYTES];
+		} pipe;
+	} u;
+	u32 padding;
+} __packed;
+
+/* Server Flags */
+#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE	1
+#define VMBUS_CHANNEL_SERVER_SUPPORTS_TRANSFER_PAGES	2
+#define VMBUS_CHANNEL_SERVER_SUPPORTS_GPADLS		4
+#define VMBUS_CHANNEL_NAMED_PIPE_MODE			0x10
+#define VMBUS_CHANNEL_LOOPBACK_OFFER			0x100
+#define VMBUS_CHANNEL_PARENT_OFFER			0x200
+#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x400
+
 #include "vmbus_packet_format.h"
 
 /* Version 1 messages */
-- 
1.7.4.1
