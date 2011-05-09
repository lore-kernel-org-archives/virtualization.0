From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 096/206] Staging: hv: Rename ringbuffer_cleanup
Date: Mon,  9 May 2011 14:56:18 -0700
Message-ID: <1304978288-22999-96-git-send-email-kys@microsoft.com>
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

Rename ringbuffer_cleanup.


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel.c     |    8 ++++----
 drivers/staging/hv/ring_buffer.c |    4 ++--
 drivers/staging/hv/ring_buffer.h |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 43e54b5..44b81e8 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -292,8 +292,8 @@ Cleanup:
 	return err;
 
 errorout:
-	ringbuffer_cleanup(&newchannel->outbound);
-	ringbuffer_cleanup(&newchannel->inbound);
+	hv_ringbuffer_cleanup(&newchannel->outbound);
+	hv_ringbuffer_cleanup(&newchannel->inbound);
 	free_pages((unsigned long)out,
 		get_order(send_ringbuffer_size + recv_ringbuffer_size));
 	kfree(openInfo);
@@ -651,8 +651,8 @@ void vmbus_close(struct vmbus_channel *channel)
 	/* TODO: Send a msg to release the childRelId */
 
 	/* Cleanup the ring buffers for this channel */
-	ringbuffer_cleanup(&channel->outbound);
-	ringbuffer_cleanup(&channel->inbound);
+	hv_ringbuffer_cleanup(&channel->outbound);
+	hv_ringbuffer_cleanup(&channel->inbound);
 
 	free_pages((unsigned long)channel->ringbuffer_pages,
 		get_order(channel->ringbuffer_pagecount * PAGE_SIZE));
diff --git a/drivers/staging/hv/ring_buffer.c b/drivers/staging/hv/ring_buffer.c
index 9653ab5..9bab40c 100644
--- a/drivers/staging/hv/ring_buffer.c
+++ b/drivers/staging/hv/ring_buffer.c
@@ -328,13 +328,13 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 /*++
 
 Name:
-	ringbuffer_cleanup()
+	hv_ringbuffer_cleanup()
 
 Description:
 	Cleanup the ring buffer
 
 --*/
-void ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
+void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
 {
 }
 
diff --git a/drivers/staging/hv/ring_buffer.h b/drivers/staging/hv/ring_buffer.h
index 3c66dc0..66d9a2d 100644
--- a/drivers/staging/hv/ring_buffer.h
+++ b/drivers/staging/hv/ring_buffer.h
@@ -79,7 +79,7 @@ struct hv_ring_buffer_debug_info {
 int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info, void *buffer,
 		   u32 buflen);
 
-void ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
+void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
 
 int ringbuffer_write(struct hv_ring_buffer_info *ring_info,
 		    struct scatterlist *sglist,
-- 
1.7.4.1
