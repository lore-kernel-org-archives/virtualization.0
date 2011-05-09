From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 101/206] Staging: hv: Rename dump_ring_info
Date: Mon,  9 May 2011 14:56:23 -0700
Message-ID: <1304978288-22999-101-git-send-email-kys@microsoft.com>
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

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel.c     |    4 ++--
 drivers/staging/hv/ring_buffer.c |    4 ++--
 drivers/staging/hv/ring_buffer.h |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 3274b29..be4e004 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -1001,6 +1001,6 @@ void vmbus_ontimer(unsigned long data)
 static void dump_vmbus_channel(struct vmbus_channel *channel)
 {
 	DPRINT_DBG(VMBUS, "Channel (%d)", channel->offermsg.child_relid);
-	dump_ring_info(&channel->outbound, "Outbound ");
-	dump_ring_info(&channel->inbound, "Inbound ");
+	hv_dump_ring_info(&channel->outbound, "Outbound ");
+	hv_dump_ring_info(&channel->inbound, "Inbound ");
 }
diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
index 013b7a5..abf0091 100644
--- a/drivers/staging/hv/ring_buffer.c
+++ b/drivers/staging/hv/ring_buffer.c
@@ -203,13 +203,13 @@ get_ring_bufferindices(struct hv_ring_buffer_info *ring_info)
 /*++
 
 Name:
-	dump_ring_info()
+	hv_dump_ring_info()
 
 Description:
 	Dump out to console the ring buffer info
 
 --*/
-void dump_ring_info(struct hv_ring_buffer_info *ring_info, char *prefix)
+void hv_dump_ring_info(struct hv_ring_buffer_info *ring_info, char *prefix)
 {
 	u32 bytes_avail_towrite;
 	u32 bytes_avail_toread;
diff --git a/drivers/staging/hv/ring_buffer.h b/drivers/staging/hv/ring_buffer.h
index 6454105..61470a3 100644
--- a/drivers/staging/hv/ring_buffer.h
+++ b/drivers/staging/hv/ring_buffer.h
@@ -95,7 +95,7 @@ int hv_ringbuffer_read(struct hv_ring_buffer_info *ring_info,
 
 u32 hv_get_ringbuffer_interrupt_mask(struct hv_ring_buffer_info *ring_info);
 
-void dump_ring_info(struct hv_ring_buffer_info *ring_info, char *prefix);
+void hv_dump_ring_info(struct hv_ring_buffer_info *ring_info, char *prefix);
 
 void ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
 			    struct hv_ring_buffer_debug_info *debug_info);
-- 
1.7.4.1
