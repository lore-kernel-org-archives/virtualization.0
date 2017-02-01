From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 02/14] vmbus: drop no longer used kick_q argument
Date: Wed,  1 Feb 2017 08:28:49 -0800
Message-ID: <20170201162901.3894-3-sthemmin@microsoft.com>
References: <20170201162901.3894-1-sthemmin@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170201162901.3894-1-sthemmin@microsoft.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kys@microsoft.com, gregkh@linuxfoundation.org
Cc: devel@linuxdriverproject.org, Stephen Hemminger <sthemmin@microsoft.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The flag to cause notification of host is unused after
commit a01a291a282f7c2e ("Drivers: hv: vmbus: Base host signaling
strictly on the ring state"). Therefore remove it from the ring
buffer internal API.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/hv/channel.c      | 13 ++++---------
 drivers/hv/hyperv_vmbus.h |  5 ++---
 drivers/hv/ring_buffer.c  |  8 +++-----
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index a016c5c0e472..e26285cde8e0 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -670,9 +670,7 @@ int vmbus_sendpacket_ctl(struct vmbus_channel *channel, void *buffer,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, num_vecs,
-				   lock, kick_q);
-
+	return hv_ringbuffer_write(channel, bufferlist, num_vecs, lock);
 }
 EXPORT_SYMBOL(vmbus_sendpacket_ctl);
 
@@ -757,8 +755,7 @@ int vmbus_sendpacket_pagebuffer_ctl(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3,
-				   lock, kick_q);
+	return hv_ringbuffer_write(channel, bufferlist, 3, lock);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_pagebuffer_ctl);
 
@@ -813,8 +810,7 @@ int vmbus_sendpacket_mpb_desc(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3,
-				   lock, true);
+	return hv_ringbuffer_write(channel, bufferlist, 3, lock);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_mpb_desc);
 
@@ -871,8 +867,7 @@ int vmbus_sendpacket_multipagebuffer(struct vmbus_channel *channel,
 	bufferlist[2].iov_base = &aligned_data;
 	bufferlist[2].iov_len = (packetlen_aligned - packetlen);
 
-	return hv_ringbuffer_write(channel, bufferlist, 3,
-				   lock, true);
+	return hv_ringbuffer_write(channel, bufferlist, 3, lock);
 }
 EXPORT_SYMBOL_GPL(vmbus_sendpacket_multipagebuffer);
 
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 2749a4142889..c375ec89db6f 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -275,9 +275,8 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info);
 
 int hv_ringbuffer_write(struct vmbus_channel *channel,
-		    struct kvec *kv_list,
-		    u32 kv_count, bool lock,
-		    bool kick_q);
+			struct kvec *kv_list,
+			u32 kv_count, bool lock);
 
 int hv_ringbuffer_read(struct vmbus_channel *channel,
 		       void *buffer, u32 buflen, u32 *buffer_actual_len,
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 2cd402986858..30ca55aefd24 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -77,8 +77,7 @@ u32 hv_end_read(struct hv_ring_buffer_info *rbi)
  * host logic is fixed.
  */
 
-static void hv_signal_on_write(u32 old_write, struct vmbus_channel *channel,
-			       bool kick_q)
+static void hv_signal_on_write(u32 old_write, struct vmbus_channel *channel)
 {
 	struct hv_ring_buffer_info *rbi = &channel->outbound;
 
@@ -285,8 +284,7 @@ void hv_ringbuffer_cleanup(struct hv_ring_buffer_info *ring_info)
 
 /* Write to the ring buffer. */
 int hv_ringbuffer_write(struct vmbus_channel *channel,
-		    struct kvec *kv_list, u32 kv_count, bool lock,
-		    bool kick_q)
+			struct kvec *kv_list, u32 kv_count, bool lock)
 {
 	int i = 0;
 	u32 bytes_avail_towrite;
@@ -352,7 +350,7 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
 	if (lock)
 		spin_unlock_irqrestore(&outring_info->ring_lock, flags);
 
-	hv_signal_on_write(old_write, channel, kick_q);
+	hv_signal_on_write(old_write, channel);
 
 	if (channel->rescind)
 		return -ENODEV;
-- 
2.11.0
