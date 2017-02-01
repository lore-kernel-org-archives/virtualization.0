From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 12/14] vmbus: expose hv_begin/end_read
Date: Wed,  1 Feb 2017 08:28:59 -0800
Message-ID: <20170201162901.3894-13-sthemmin__35886.5256690935$1485966714$gmane$org@microsoft.com>
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

In order to implement NAPI in netvsc, the driver needs access to
control host interrupt mask.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
---
 drivers/hv/hyperv_vmbus.h |  4 ----
 drivers/hv/ring_buffer.c  | 20 --------------------
 include/linux/hyperv.h    | 30 ++++++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 6a9b54677218..e15a130de3c9 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -292,10 +292,6 @@ int hv_ringbuffer_read(struct vmbus_channel *channel,
 void hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
 			    struct hv_ring_buffer_debug_info *debug_info);
 
-void hv_begin_read(struct hv_ring_buffer_info *rbi);
-
-u32 hv_end_read(struct hv_ring_buffer_info *rbi);
-
 /*
  * Maximum channels is determined by the size of the interrupt page
  * which is PAGE_SIZE. 1/2 of PAGE_SIZE is for send endpoint interrupt
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 146fd8ab2a2a..47ab69089115 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -32,26 +32,6 @@
 
 #include "hyperv_vmbus.h"
 
-void hv_begin_read(struct hv_ring_buffer_info *rbi)
-{
-	rbi->ring_buffer->interrupt_mask = 1;
-	virt_mb();
-}
-
-u32 hv_end_read(struct hv_ring_buffer_info *rbi)
-{
-
-	rbi->ring_buffer->interrupt_mask = 0;
-	virt_mb();
-
-	/*
-	 * Now check to see if the ring buffer is still empty.
-	 * If it is not, we raced and we need to process new
-	 * incoming messages.
-	 */
-	return hv_get_bytes_to_read(rbi);
-}
-
 /*
  * When we write to the ring buffer, check if the host needs to
  * be signaled. Here is the details of this protocol:
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 9b0165b11c5c..dc50997a3fba 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1473,6 +1473,36 @@ static inline  void hv_signal_on_read(struct vmbus_channel *channel)
 }
 
 /*
+ * Mask off host interrupt callback notifications
+ */
+static inline void hv_begin_read(struct hv_ring_buffer_info *rbi)
+{
+	rbi->ring_buffer->interrupt_mask = 1;
+
+	/* make sure mask update is not reordered */
+	virt_mb();
+}
+
+/*
+ * Re-enable host callback and return number of outstanding bytes
+ */
+static inline u32 hv_end_read(struct hv_ring_buffer_info *rbi)
+{
+
+	rbi->ring_buffer->interrupt_mask = 0;
+
+	/* make sure mask update is not reordered */
+	virt_mb();
+
+	/*
+	 * Now check to see if the ring buffer is still empty.
+	 * If it is not, we raced and we need to process new
+	 * incoming messages.
+	 */
+	return hv_get_bytes_to_read(rbi);
+}
+
+/*
  * An API to support in-place processing of incoming VMBUS packets.
  */
 #define VMBUS_PKT_TRAILER	8
-- 
2.11.0
