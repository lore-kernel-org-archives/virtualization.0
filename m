From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] tools/virtio: add inorder option
Date: Sun, 15 May 2016 13:03:35 +0300
Message-ID: <1463306294-4325-1-git-send-email-mst@redhat.com>
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
Cc: Jesper Dangaard Brouer <jbrouer@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

skips ring accesses but drops out of order support
At high level this follows alf design
https://github.com/netoptimizer/prototype-kernel/blob/master/kernel/lib/alf_queue.c
but on most (single-threaded) benchmarks this seems to be slower than the layout
without index use.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/virtio_ring_0_9.c     | 49 ++++++++++++++++++++++++++++-
 tools/virtio/ringtest/virtio_ring_inorder.c |  2 ++
 tools/virtio/ringtest/Makefile              |  4 ++-
 3 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 tools/virtio/ringtest/virtio_ring_inorder.c

diff --git a/tools/virtio/ringtest/virtio_ring_0_9.c b/tools/virtio/ringtest/virtio_ring_0_9.c
index 47c9a1a..7618662 100644
--- a/tools/virtio/ringtest/virtio_ring_0_9.c
+++ b/tools/virtio/ringtest/virtio_ring_0_9.c
@@ -26,6 +26,14 @@ struct vring ring;
  * high bits of ring id ^ 0x8000).
  */
 /* #ifdef RING_POLL */
+/* enabling the below activates experimental in-order code
+ * (which skips ring updates and reads and writes len in descriptor).
+ */
+/* #ifdef INORDER */
+
+#if defined(RING_POLL) && defined(INORDER)
+#error "RING_POLL and INORDER are mutually exclusive"
+#endif
 
 /* how much padding is needed to avoid false cache sharing */
 #define HOST_GUEST_PADDING 0x80
@@ -35,7 +43,11 @@ struct guest {
 	unsigned short last_used_idx;
 	unsigned short num_free;
 	unsigned short kicked_avail_idx;
+#ifndef INORDER
 	unsigned short free_head;
+#else
+	unsigned short reserved_free_head;
+#endif
 	unsigned char reserved[HOST_GUEST_PADDING - 10];
 } guest;
 
@@ -66,8 +78,10 @@ void alloc_ring(void)
 	guest.avail_idx = 0;
 	guest.kicked_avail_idx = -1;
 	guest.last_used_idx = 0;
+#ifndef INORDER
 	/* Put everything in free lists. */
 	guest.free_head = 0;
+#endif
 	for (i = 0; i < ring_size - 1; i++)
 		ring.desc[i].next = i + 1;
 	host.used_idx = 0;
@@ -84,13 +98,20 @@ void alloc_ring(void)
 /* guest side */
 int add_inbuf(unsigned len, void *buf, void *datap)
 {
-	unsigned head, avail;
+	unsigned head;
+#ifndef INORDER
+	unsigned avail;
+#endif
 	struct vring_desc *desc;
 
 	if (!guest.num_free)
 		return -1;
 
+#ifdef INORDER
+	head = (ring_size - 1) & (guest.avail_idx++);
+#else
 	head = guest.free_head;
+#endif
 	guest.num_free--;
 
 	desc = ring.desc;
@@ -102,7 +123,9 @@ int add_inbuf(unsigned len, void *buf, void *datap)
 	 * descriptors.
 	 */
 	desc[head].flags &= ~VRING_DESC_F_NEXT;
+#ifndef INORDER
 	guest.free_head = desc[head].next;
+#endif
 
 	data[head].data = datap;
 
@@ -113,8 +136,12 @@ int add_inbuf(unsigned len, void *buf, void *datap)
 	ring.avail->ring[avail & (ring_size - 1)] =
 		(head | (avail & ~(ring_size - 1))) ^ 0x8000;
 #else
+#ifndef INORDER
+	/* Barrier A (for pairing) */
+	smp_release();
 	avail = (ring_size - 1) & (guest.avail_idx++);
 	ring.avail->ring[avail] = head;
+#endif
 	/* Barrier A (for pairing) */
 	smp_release();
 #endif
@@ -141,15 +168,27 @@ void *get_buf(unsigned *lenp, void **bufp)
 		return NULL;
 	/* Barrier B (for pairing) */
 	smp_acquire();
+#ifdef INORDER
+	head = (ring_size - 1) & guest.last_used_idx;
+	index = head;
+#else
 	head = (ring_size - 1) & guest.last_used_idx;
 	index = ring.used->ring[head].id;
 #endif
+
+#endif
+#ifdef INORDER
+	*lenp = ring.desc[index].len;
+#else
 	*lenp = ring.used->ring[head].len;
+#endif
 	datap = data[index].data;
 	*bufp = (void*)(unsigned long)ring.desc[index].addr;
 	data[index].data = NULL;
+#ifndef INORDER
 	ring.desc[index].next = guest.free_head;
 	guest.free_head = index;
+#endif
 	guest.num_free++;
 	guest.last_used_idx++;
 	return datap;
@@ -283,16 +322,24 @@ bool use_buf(unsigned *lenp, void **bufp)
 	smp_acquire();
 
 	used_idx &= ring_size - 1;
+#ifdef INORDER
+	head = used_idx;
+#else
 	head = ring.avail->ring[used_idx];
+#endif
 	desc = &ring.desc[head];
 #endif
 
 	*lenp = desc->len;
 	*bufp = (void *)(unsigned long)desc->addr;
 
+#ifdef INORDER
+	desc->len = desc->len - 1;
+#else
 	/* now update used ring */
 	ring.used->ring[used_idx].id = head;
 	ring.used->ring[used_idx].len = desc->len - 1;
+#endif
 	/* Barrier B (for pairing) */
 	smp_release();
 	host.used_idx++;
diff --git a/tools/virtio/ringtest/virtio_ring_inorder.c b/tools/virtio/ringtest/virtio_ring_inorder.c
new file mode 100644
index 0000000..2438ca5
--- /dev/null
+++ b/tools/virtio/ringtest/virtio_ring_inorder.c
@@ -0,0 +1,2 @@
+#define INORDER 1
+#include "virtio_ring_0_9.c"
diff --git a/tools/virtio/ringtest/Makefile b/tools/virtio/ringtest/Makefile
index feaa64a..8037971 100644
--- a/tools/virtio/ringtest/Makefile
+++ b/tools/virtio/ringtest/Makefile
@@ -1,6 +1,6 @@
 all:
 
-all: ring virtio_ring_0_9 virtio_ring_poll
+all: ring virtio_ring_0_9 virtio_ring_poll virtio_ring_inorder
 
 CFLAGS += -Wall
 CFLAGS += -pthread -O2 -ggdb
@@ -13,10 +13,12 @@ virtio_ring_poll.o: virtio_ring_poll.c virtio_ring_0_9.c main.h
 ring: ring.o main.o
 virtio_ring_0_9: virtio_ring_0_9.o main.o
 virtio_ring_poll: virtio_ring_poll.o main.o
+virtio_ring_inorder: virtio_ring_inorder.o main.o
 clean:
 	-rm main.o
 	-rm ring.o ring
 	-rm virtio_ring_0_9.o virtio_ring_0_9
 	-rm virtio_ring_poll.o virtio_ring_poll
+	-rm virtio_ring_inorder.o virtio_ring_inorder
 
 .PHONY: all clean
-- 
MST
