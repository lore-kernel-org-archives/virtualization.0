From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 03/14] vmbus: remove no longer used signal_policy
Date: Wed,  1 Feb 2017 08:28:50 -0800
Message-ID: <20170201162901.3894-4-sthemmin__6296.62669166482$1485966586$gmane$org@microsoft.com>
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

The explicit signal policy is no longer used. A different mechanism
will be added later when xmit_more is supported.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 include/linux/hyperv.h | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 85b26f06e172..423fc96cc26a 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -670,11 +670,6 @@ struct hv_input_signal_event_buffer {
 	struct hv_input_signal_event event;
 };
 
-enum hv_signal_policy {
-	HV_SIGNAL_POLICY_DEFAULT = 0,
-	HV_SIGNAL_POLICY_EXPLICIT,
-};
-
 enum hv_numa_policy {
 	HV_BALANCED = 0,
 	HV_LOCALIZED,
@@ -837,13 +832,6 @@ struct vmbus_channel {
 	 */
 	struct list_head percpu_list;
 	/*
-	 * Host signaling policy: The default policy will be
-	 * based on the ring buffer state. We will also support
-	 * a policy where the client driver can have explicit
-	 * signaling control.
-	 */
-	enum hv_signal_policy  signal_policy;
-	/*
 	 * On the channel send side, many of the VMBUS
 	 * device drivers explicity serialize access to the
 	 * outgoing ring buffer. Give more control to the
@@ -904,12 +892,6 @@ static inline bool is_hvsock_channel(const struct vmbus_channel *c)
 		  VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER);
 }
 
-static inline void set_channel_signal_state(struct vmbus_channel *c,
-					    enum hv_signal_policy policy)
-{
-	c->signal_policy = policy;
-}
-
 static inline void set_channel_affinity_state(struct vmbus_channel *c,
 					      enum hv_numa_policy policy)
 {
-- 
2.11.0
