From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] tools/virtio: add noring tool
Date: Tue, 24 May 2016 15:23:25 +0300
Message-ID: <1464092577-12135-1-git-send-email-mst@redhat.com>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Useful to measure testing framework overhead.

Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/ringtest/noring.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 tools/virtio/ringtest/Makefile |  4 ++-
 2 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100644 tools/virtio/ringtest/noring.c

diff --git a/tools/virtio/ringtest/noring.c b/tools/virtio/ringtest/noring.c
new file mode 100644
index 0000000..eda2f48
--- /dev/null
+++ b/tools/virtio/ringtest/noring.c
@@ -0,0 +1,69 @@
+#define _GNU_SOURCE
+#include "main.h"
+#include <assert.h>
+
+/* stub implementation: useful for measuring overhead */
+void alloc_ring(void)
+{
+}
+
+/* guest side */
+int add_inbuf(unsigned len, void *buf, void *datap)
+{
+	return 0;
+}
+
+/*
+ * skb_array API provides no way for producer to find out whether a given
+ * buffer was consumed.  Our tests merely require that a successful get_buf
+ * implies that add_inbuf succeed in the past, and that add_inbuf will succeed,
+ * fake it accordingly.
+ */
+void *get_buf(unsigned *lenp, void **bufp)
+{
+	return "Buffer";
+}
+
+void poll_used(void)
+{
+}
+
+void disable_call()
+{
+	assert(0);
+}
+
+bool enable_call()
+{
+	assert(0);
+}
+
+void kick_available(void)
+{
+	assert(0);
+}
+
+/* host side */
+void disable_kick()
+{
+	assert(0);
+}
+
+bool enable_kick()
+{
+	assert(0);
+}
+
+void poll_avail(void)
+{
+}
+
+bool use_buf(unsigned *lenp, void **bufp)
+{
+	return true;
+}
+
+void call_used(void)
+{
+	assert(0);
+}
diff --git a/tools/virtio/ringtest/Makefile b/tools/virtio/ringtest/Makefile
index a8356d8..b3d5bc8 100644
--- a/tools/virtio/ringtest/Makefile
+++ b/tools/virtio/ringtest/Makefile
@@ -1,6 +1,6 @@
 all:
 
-all: ring virtio_ring_0_9 virtio_ring_poll virtio_ring_inorder skb_array
+all: ring virtio_ring_0_9 virtio_ring_poll virtio_ring_inorder skb_array noring
 
 CFLAGS += -Wall
 CFLAGS += -pthread -O2 -ggdb
@@ -17,6 +17,7 @@ virtio_ring_0_9: virtio_ring_0_9.o main.o
 virtio_ring_poll: virtio_ring_poll.o main.o
 virtio_ring_inorder: virtio_ring_inorder.o main.o
 skb_array: skb_array.o main.o
+noring: noring.o main.o
 clean:
 	-rm main.o
 	-rm ring.o ring
@@ -24,5 +25,6 @@ clean:
 	-rm virtio_ring_poll.o virtio_ring_poll
 	-rm virtio_ring_inorder.o virtio_ring_inorder
 	-rm skb_array.o skb_array
+	-rm noring.o noring
 
 .PHONY: all clean
-- 
MST
