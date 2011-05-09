From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 168/206] Staging: hv: Add the ringbuffer interfaces
Date: Mon,  9 May 2011 14:57:30 -0700
Message-ID: <1304978288-22999-168-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/hyperv_vmbus.h |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv_vmbus.h b/drivers/staging/hv/hyperv_vmbus.h
index ea06691..bd943fe 100644
--- a/drivers/staging/hv/hyperv_vmbus.h
+++ b/drivers/staging/hv/hyperv_vmbus.h
@@ -505,4 +505,32 @@ extern void hv_synic_init(void *irqarg);
 
 extern void hv_synic_cleanup(void *arg);
 
+
+/* Interface */
+
+
+int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info, void *buffer,
+		   u32 buflen);
+
+void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
+
+int hv_ringbuffer_write(struct hv_ring_buffer_info *ring_info,
+		    struct scatterlist *sglist,
+		    u32 sgcount);
+
+int hv_ringbuffer_peek(struct hv_ring_buffer_info *ring_info, void *buffer,
+		   u32 buflen);
+
+int hv_ringbuffer_read(struct hv_ring_buffer_info *ring_info,
+		   void *buffer,
+		   u32 buflen,
+		   u32 offset);
+
+u32 hv_get_ringbuffer_interrupt_mask(struct hv_ring_buffer_info *ring_info);
+
+void hv_dump_ring_info(struct hv_ring_buffer_info *ring_info, char *prefix);
+
+void hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
+			    struct hv_ring_buffer_debug_info *debug_info);
+
 #endif /* _HYPERV_VMBUS_H */
-- 
1.7.4.1
