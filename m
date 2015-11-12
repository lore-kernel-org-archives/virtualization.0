From: Jorgen Hansen <jhansen@vmware.com>
Subject: [PATCH] VMCI: Use 32bit atomics for queue headers on X86_32
Date: Thu, 12 Nov 2015 01:29:32 -0800
Message-ID: <1447320572-30242-1-git-send-email-jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

This change restricts the reading and setting of the head and tail
pointers on 32bit X86 to 32bit for both correctness and
performance reasons. On uniprocessor X86_32, the atomic64_read
may be implemented as a non-locked cmpxchg8b. This may result in
updates to the pointers done by the VMCI device being overwritten.
On MP systems, there is no such correctness issue, but using 32bit
atomics avoids the overhead of the locked 64bit operation. All this
is safe because the queue size on 32bit systems will never exceed
a 32bit value.

Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_driver.c |    2 +-
 include/linux/vmw_vmci_defs.h       |   43 +++++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_driver.c b/drivers/misc/vmw_vmci/vmci_driver.c
index b823f9a..896be15 100644
--- a/drivers/misc/vmw_vmci/vmci_driver.c
+++ b/drivers/misc/vmw_vmci/vmci_driver.c
@@ -113,5 +113,5 @@ module_exit(vmci_drv_exit);
 
 MODULE_AUTHOR("VMware, Inc.");
 MODULE_DESCRIPTION("VMware Virtual Machine Communication Interface.");
-MODULE_VERSION("1.1.3.0-k");
+MODULE_VERSION("1.1.4.0-k");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 65ac54c..1bd31a3 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -734,6 +734,41 @@ static inline void *vmci_event_data_payload(struct vmci_event_data *ev_data)
 }
 
 /*
+ * Helper to read a value from a head or tail pointer. For X86_32, the
+ * pointer is treated as a 32bit value, since the pointer value
+ * never exceeds a 32bit value in this case. Also, doing an
+ * atomic64_read on X86_32 uniprocessor systems may be implemented
+ * as a non locked cmpxchg8b, that may end up overwriting updates done
+ * by the VMCI device to the memory location. On 32bit SMP, the lock
+ * prefix will be used, so correctness isn't an issue, but using a
+ * 64bit operation still adds unnecessary overhead.
+ */
+static inline u64 vmci_q_read_pointer(atomic64_t *var)
+{
+#if defined(CONFIG_X86_32)
+	return atomic_read((atomic_t *)var);
+#else
+	return atomic64_read(var);
+#endif
+}
+
+/*
+ * Helper to set the value of a head or tail pointer. For X86_32, the
+ * pointer is treated as a 32bit value, since the pointer value
+ * never exceeds a 32bit value in this case. On 32bit SMP, using a
+ * locked cmpxchg8b adds unnecessary overhead.
+ */
+static inline void vmci_q_set_pointer(atomic64_t *var,
+				      u64 new_val)
+{
+#if defined(CONFIG_X86_32)
+	return atomic_set((atomic_t *)var, (u32)new_val);
+#else
+	return atomic64_set(var, new_val);
+#endif
+}
+
+/*
  * Helper to add a given offset to a head or tail pointer. Wraps the
  * value of the pointer around the max size of the queue.
  */
@@ -741,14 +776,14 @@ static inline void vmci_qp_add_pointer(atomic64_t *var,
 				       size_t add,
 				       u64 size)
 {
-	u64 new_val = atomic64_read(var);
+	u64 new_val = vmci_q_read_pointer(var);
 
 	if (new_val >= size - add)
 		new_val -= size;
 
 	new_val += add;
 
-	atomic64_set(var, new_val);
+	vmci_q_set_pointer(var, new_val);
 }
 
 /*
@@ -758,7 +793,7 @@ static inline u64
 vmci_q_header_producer_tail(const struct vmci_queue_header *q_header)
 {
 	struct vmci_queue_header *qh = (struct vmci_queue_header *)q_header;
-	return atomic64_read(&qh->producer_tail);
+	return vmci_q_read_pointer(&qh->producer_tail);
 }
 
 /*
@@ -768,7 +803,7 @@ static inline u64
 vmci_q_header_consumer_head(const struct vmci_queue_header *q_header)
 {
 	struct vmci_queue_header *qh = (struct vmci_queue_header *)q_header;
-	return atomic64_read(&qh->consumer_head);
+	return vmci_q_read_pointer(&qh->consumer_head);
 }
 
 /*
-- 
1.7.0
