From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] ptr_ring: add barriers
Date: Tue, 5 Dec 2017 21:29:37 +0200
Message-ID: <1512501990-30029-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: George Cherian <george.cherian@cavium.com>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, edumazet@google.com, davem@davemloft.net
List-Id: virtualization@lists.linuxfoundation.org

Users of ptr_ring expect that it's safe to give the
data structure a pointer and have it be available
to consumers, but that actually requires an smb_wmb
or a stronger barrier.

In absence of such barriers and on architectures that reorder writes,
consumer might read an un=initialized value from an skb pointer stored
in the skb array.  This was observed causing crashes.

To fix, add memory barriers.  The barrier we use is a wmb, the
assumption being that producers do not need to read the value so we do
not need to order these reads.

Reported-by: George Cherian <george.cherian@cavium.com>
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

George, could you pls report whether this patch fixes
the issue for you?

This seems to be needed in stable as well.




 include/linux/ptr_ring.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 37b4bb2..6866df4 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -101,12 +101,18 @@ static inline bool ptr_ring_full_bh(struct ptr_ring *r)
 
 /* Note: callers invoking this in a loop must use a compiler barrier,
  * for example cpu_relax(). Callers must hold producer_lock.
+ * Callers are responsible for making sure pointer that is being queued
+ * points to a valid data.
  */
 static inline int __ptr_ring_produce(struct ptr_ring *r, void *ptr)
 {
 	if (unlikely(!r->size) || r->queue[r->producer])
 		return -ENOSPC;
 
+	/* Make sure the pointer we are storing points to a valid data. */
+	/* Pairs with smp_read_barrier_depends in __ptr_ring_consume. */
+	smp_wmb();
+
 	r->queue[r->producer++] = ptr;
 	if (unlikely(r->producer >= r->size))
 		r->producer = 0;
@@ -275,6 +281,9 @@ static inline void *__ptr_ring_consume(struct ptr_ring *r)
 	if (ptr)
 		__ptr_ring_discard_one(r);
 
+	/* Make sure anyone accessing data through the pointer is up to date. */
+	/* Pairs with smp_wmb in __ptr_ring_produce. */
+	smp_read_barrier_depends();
 	return ptr;
 }
 
-- 
MST
