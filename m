From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 153/206] Staging: hv:Include the contents of channel.h
Date: Mon,  9 May 2011 14:57:15 -0700
Message-ID: <1304978288-22999-153-git-send-email-kys@microsoft.com>
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
 include/linux/hyperv.h |   89 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index ce27244..d13d72a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -21,3 +21,92 @@
  *   K. Y. Srinivasan <kys@microsoft.com>
  *
  */
+
+#ifndef _HYPERV_H
+#define _HYPERV_H
+
+#include "channel_mgmt.h"
+
+/* The format must be the same as struct vmdata_gpa_direct */
+struct vmbus_channel_packet_page_buffer {
+	u16 type;
+	u16 dataoffset8;
+	u16 length8;
+	u16 flags;
+	u64 transactionid;
+	u32 reserved;
+	u32 rangecount;
+	struct hv_page_buffer range[MAX_PAGE_BUFFER_COUNT];
+} __packed;
+
+/* The format must be the same as struct vmdata_gpa_direct */
+struct vmbus_channel_packet_multipage_buffer {
+	u16 type;
+	u16 dataoffset8;
+	u16 length8;
+	u16 flags;
+	u64 transactionid;
+	u32 reserved;
+	u32 rangecount;		/* Always 1 in this case */
+	struct hv_multipage_buffer range;
+} __packed;
+
+
+extern int vmbus_open(struct vmbus_channel *channel,
+			    u32 send_ringbuffersize,
+			    u32 recv_ringbuffersize,
+			    void *userdata,
+			    u32 userdatalen,
+			    void(*onchannel_callback)(void *context),
+			    void *context);
+
+extern void vmbus_close(struct vmbus_channel *channel);
+
+extern int vmbus_sendpacket(struct vmbus_channel *channel,
+				  const void *buffer,
+				  u32 bufferLen,
+				  u64 requestid,
+				  enum vmbus_packet_type type,
+				  u32 flags);
+
+extern int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
+					    struct hv_page_buffer pagebuffers[],
+					    u32 pagecount,
+					    void *buffer,
+					    u32 bufferlen,
+					    u64 requestid);
+
+extern int vmbus_sendpacket_multipagebuffer(struct vmbus_channel *channel,
+					struct hv_multipage_buffer *mpb,
+					void *buffer,
+					u32 bufferlen,
+					u64 requestid);
+
+extern int vmbus_establish_gpadl(struct vmbus_channel *channel,
+				      void *kbuffer,
+				      u32 size,
+				      u32 *gpadl_handle);
+
+extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
+				     u32 gpadl_handle);
+
+extern int vmbus_recvpacket(struct vmbus_channel *channel,
+				  void *buffer,
+				  u32 bufferlen,
+				  u32 *buffer_actual_len,
+				  u64 *requestid);
+
+extern int vmbus_recvpacket_raw(struct vmbus_channel *channel,
+				     void *buffer,
+				     u32 bufferlen,
+				     u32 *buffer_actual_len,
+				     u64 *requestid);
+
+extern void vmbus_onchannel_event(struct vmbus_channel *channel);
+
+extern void vmbus_get_debug_info(struct vmbus_channel *channel,
+				     struct vmbus_channel_debug_info *debug);
+
+extern void vmbus_ontimer(unsigned long data);
+
+#endif /* _HYPERV_H_ */
-- 
1.7.4.1
