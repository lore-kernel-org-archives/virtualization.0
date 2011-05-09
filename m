From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 098/206] Staging: hv: Rename ringbuffer_peek
Date: Mon,  9 May 2011 14:56:20 -0700
Message-ID: <1304978288-22999-98-git-send-email-kys@microsoft.com>
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
index 859771c..d625517 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -885,7 +885,7 @@ int vmbus_recvpacket(struct vmbus_channel *channel, void *buffer,
 
 	spin_lock_irqsave(&channel->inbound_lock, flags);
 
-	ret = ringbuffer_peek(&channel->inbound, &desc,
+	ret = hv_ringbuffer_peek(&channel->inbound, &desc,
 			     sizeof(struct vmpacket_descriptor));
 	if (ret != 0) {
 		spin_unlock_irqrestore(&channel->inbound_lock, flags);
@@ -938,7 +938,7 @@ int vmbus_recvpacket_raw(struct vmbus_channel *channel, void *buffer,
 
 	spin_lock_irqsave(&channel->inbound_lock, flags);
 
-	ret = ringbuffer_peek(&channel->inbound, &desc,
+	ret = hv_ringbuffer_peek(&channel->inbound, &desc,
 			     sizeof(struct vmpacket_descriptor));
 	if (ret != 0) {
 		spin_unlock_irqrestore(&channel->inbound_lock, flags);
diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
index 483678c..bf04397 100644
--- a/drivers/staging/hv/ring_buffer.c
+++ b/drivers/staging/hv/ring_buffer.c
@@ -418,13 +418,13 @@ int hv_ringbuffer_write(struct hv_ring_buffer_info *outring_info,
 /*++
 
 Name:
-	ringbuffer_peek()
+	hv_ringbuffer_peek()
 
 Description:
 	Read without advancing the read index
 
 --*/
-int ringbuffer_peek(struct hv_ring_buffer_info *Inring_info,
+int hv_ringbuffer_peek(struct hv_ring_buffer_info *Inring_info,
 		   void *Buffer, u32 buflen)
 {
 	u32 bytes_avail_towrite;
diff --git a/drivers/staging/hv/ring_buffer.h b/drivers/staging/hv/ring_buffer.h
index 5c17288..c684d97 100644
--- a/drivers/staging/hv/ring_buffer.h
+++ b/drivers/staging/hv/ring_buffer.h
@@ -85,7 +85,7 @@ int hv_ringbuffer_write(struct hv_ring_buffer_info *ring_info,
 		    struct scatterlist *sglist,
 		    u32 sgcount);
 
-int ringbuffer_peek(struct hv_ring_buffer_info *ring_info, void *buffer,
+int hv_ringbuffer_peek(struct hv_ring_buffer_info *ring_info, void *buffer,
 		   u32 buflen);
 
 int ringbuffer_read(struct hv_ring_buffer_info *ring_info,
-- 
1.7.4.1
