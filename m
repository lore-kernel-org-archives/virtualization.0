From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 169/206] Staging: hv: Include the contents of vmbus_private.h
Date: Mon,  9 May 2011 14:57:31 -0700
Message-ID: <1304978288-22999-169-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/hyperv_vmbus.h |   93 +++++++++++++++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hyperv_vmbus.h b/drivers/staging/hv/hyperv_vmbus.h
index bd943fe..8ccae84 100644
--- a/drivers/staging/hv/hyperv_vmbus.h
+++ b/drivers/staging/hv/hyperv_vmbus.h
@@ -533,4 +533,97 @@ void hv_dump_ring_info(struct hv_ring_buffer_info *ring_info, char *prefix);
 void hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
 			    struct hv_ring_buffer_debug_info *debug_info);
 
+
+#include <asm/sync_bitops.h>
+
+
+/*
+ * Maximum channels is determined by the size of the interrupt page
+ * which is PAGE_SIZE. 1/2 of PAGE_SIZE is for send endpoint interrupt
+ * and the other is receive endpoint interrupt
+ */
+#define MAX_NUM_CHANNELS	((PAGE_SIZE >> 1) << 3)	/* 16348 channels */
+
+/* The value here must be in multiple of 32 */
+/* TODO: Need to make this configurable */
+#define MAX_NUM_CHANNELS_SUPPORTED	256
+
+
+enum vmbus_connect_state {
+	DISCONNECTED,
+	CONNECTING,
+	CONNECTED,
+	DISCONNECTING
+};
+
+#define MAX_SIZE_CHANNEL_MESSAGE	HV_MESSAGE_PAYLOAD_BYTE_COUNT
+
+struct vmbus_connection {
+	enum vmbus_connect_state conn_state;
+
+	atomic_t next_gpadl_handle;
+
+	/*
+	 * Represents channel interrupts. Each bit position represents a
+	 * channel.  When a channel sends an interrupt via VMBUS, it finds its
+	 * bit in the sendInterruptPage, set it and calls Hv to generate a port
+	 * event. The other end receives the port event and parse the
+	 * recvInterruptPage to see which bit is set
+	 */
+	void *int_page;
+	void *send_int_page;
+	void *recv_int_page;
+
+	/*
+	 * 2 pages - 1st page for parent->child notification and 2nd
+	 * is child->parent notification
+	 */
+	void *monitor_pages;
+	struct list_head chn_msg_list;
+	spinlock_t channelmsg_lock;
+
+	/* List of channels */
+	struct list_head chn_list;
+	spinlock_t channel_lock;
+
+	struct workqueue_struct *work_queue;
+};
+
+
+struct vmbus_msginfo {
+	/* Bookkeeping stuff */
+	struct list_head msglist_entry;
+
+	/* The message itself */
+	unsigned char msg[0];
+};
+
+
+extern struct vmbus_connection vmbus_connection;
+
+/* General vmbus interface */
+
+struct hv_device *vmbus_child_device_create(struct hv_guid *type,
+					 struct hv_guid *instance,
+					 struct vmbus_channel *channel);
+
+int vmbus_child_device_register(struct hv_device *child_device_obj);
+void vmbus_child_device_unregister(struct hv_device *device_obj);
+
+struct vmbus_channel *relid2channel(u32 relid);
+
+
+/* Connection interface */
+
+int vmbus_connect(void);
+
+int vmbus_disconnect(void);
+
+int vmbus_post_msg(void *buffer, size_t buflen);
+
+int vmbus_set_event(u32 child_relid);
+
+void vmbus_on_event(unsigned long data);
+
+
 #endif /* _HYPERV_VMBUS_H */
-- 
1.7.4.1
