From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 097/206] Staging: hv: Rename ringbuffer_write
Date: Mon,  9 May 2011 14:56:19 -0700
Message-ID: <1304978288-22999-97-git-send-email-kys@microsoft.com>
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

Rename ringbuffer_write.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel.c     |    6 +++---
 drivers/staging/hv/ring_buffer.c |    4 ++--
 drivers/staging/hv/ring_buffer.h |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 44b81e8..859771c 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -718,7 +718,7 @@ int vmbus_sendpacket(struct vmbus_channel *channel, const void *buffer,
 	sg_set_buf(&bufferlist[2], &aligned_data,
 		   packetlen_aligned - packetlen);
 
-	ret = ringbuffer_write(&channel->outbound, bufferlist, 3);
+	ret = hv_ringbuffer_write(&channel->outbound, bufferlist, 3);
 
 	/* TODO: We should determine if this is optional */
 	if (ret == 0 && !get_ringbuffer_interrupt_mask(&channel->outbound))
@@ -783,7 +783,7 @@ int vmbus_sendpacket_pagebuffer(struct vmbus_channel *channel,
 	sg_set_buf(&bufferlist[2], &aligned_data,
 		packetlen_aligned - packetlen);
 
-	ret = ringbuffer_write(&channel->outbound, bufferlist, 3);
+	ret = hv_ringbuffer_write(&channel->outbound, bufferlist, 3);
 
 	/* TODO: We should determine if this is optional */
 	if (ret == 0 && !get_ringbuffer_interrupt_mask(&channel->outbound))
@@ -848,7 +848,7 @@ int vmbus_sendpacket_multipagebuffer(struct vmbus_channel *channel,
 	sg_set_buf(&bufferlist[2], &aligned_data,
 		packetlen_aligned - packetlen);
 
-	ret = ringbuffer_write(&channel->outbound, bufferlist, 3);
+	ret = hv_ringbuffer_write(&channel->outbound, bufferlist, 3);
 
 	/* TODO: We should determine if this is optional */
 	if (ret == 0 && !get_ringbuffer_interrupt_mask(&channel->outbound))
diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
index 9bab40c..483678c 100644
--- a/drivers/staging/hv/ring_buffer.c
+++ b/drivers/staging/hv/ring_buffer.c
@@ -341,13 +341,13 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
 /*++
 
 Name:
-	ringbuffer_write()
+	hv_ringbuffer_write()
 
 Description:
 	Write to the ring buffer
 
 --*/
-int ringbuffer_write(struct hv_ring_buffer_info *outring_info,
+int hv_ringbuffer_write(struct hv_ring_buffer_info *outring_info,
 		    struct scatterlist *sglist, u32 sgcount)
 {
 	int i = 0;
diff --git a/drivers/staging/hv/ring_buffer.h b/drivers/staging/hv/ring_buffer.h
index 66d9a2d..5c17288 100644
--- a/drivers/staging/hv/ring_buffer.h
+++ b/drivers/staging/hv/ring_buffer.h
@@ -81,7 +81,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info, void *buffer,
 
 void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
 
-int ringbuffer_write(struct hv_ring_buffer_info *ring_info,
+int hv_ringbuffer_write(struct hv_ring_buffer_info *ring_info,
 		    struct scatterlist *sglist,
 		    u32 sgcount);
 
-- 
1.7.4.1
