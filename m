From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 06/14] vmbus: remove per channel state
Date: Wed,  1 Feb 2017 08:28:53 -0800
Message-ID: <20170201162901.3894-7-sthemmin__5513.89378165386$1485966632$gmane$org@microsoft.com>
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

The netvsc no longer needs per channel state hook to track receive buffer.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 include/linux/hyperv.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 8c6a1505b876..39d493ce550d 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -823,10 +823,6 @@ struct vmbus_channel {
 	 */
 	struct vmbus_channel *primary_channel;
 	/*
-	 * Support per-channel state for use by vmbus drivers.
-	 */
-	void *per_channel_state;
-	/*
 	 * To support per-cpu lookup mapping of relid to channel,
 	 * link up channels based on their CPU affinity.
 	 */
@@ -903,16 +899,6 @@ static inline void set_channel_read_state(struct vmbus_channel *c, bool state)
 	c->batched_reading = state;
 }
 
-static inline void set_per_channel_state(struct vmbus_channel *c, void *s)
-{
-	c->per_channel_state = s;
-}
-
-static inline void *get_per_channel_state(struct vmbus_channel *c)
-{
-	return c->per_channel_state;
-}
-
 static inline void set_channel_pending_send_size(struct vmbus_channel *c,
 						 u32 size)
 {
-- 
2.11.0
