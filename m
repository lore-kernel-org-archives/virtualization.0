From: Jiang Biao <benbjiang@tencent.com>
Subject: [PATCH] virtio/virtio_ring: do some comment fixes
Date: Tue, 23 Apr 2019 18:25:12 +0800
Message-ID: <20190423102512.72265-1-benbjiang__46739.1672240169$1558282666$gmane$org@tencent.com>
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
To: mst@redhat.com, jasowang@redhat.com
Cc: benbjiang@tencent.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

There are lots of mismatches between comments and codes, this
patch do these comment fixes.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
---
 drivers/virtio/virtio_ring.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5df92c308286..3794c7666a99 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1718,10 +1718,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 
 /**
  * virtqueue_add_sgs - expose buffers to other end
- * @vq: the struct virtqueue we're talking about.
+ * @_vq: the struct virtqueue we're talking about.
  * @sgs: array of terminated scatterlists.
- * @out_num: the number of scatterlists readable by other side
- * @in_num: the number of scatterlists which are writable (after readable ones)
+ * @out_sgs: the number of scatterlists readable by other side
+ * @in_sgs: the number of scatterlists which are writable (after readable ones)
  * @data: the token identifying the buffer.
  * @gfp: how to do memory allocations (if necessary).
  *
@@ -1821,7 +1821,7 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
 /**
  * virtqueue_kick_prepare - first half of split virtqueue_kick call.
- * @vq: the struct virtqueue
+ * @_vq: the struct virtqueue
  *
  * Instead of virtqueue_kick(), you can do:
  *	if (virtqueue_kick_prepare(vq))
@@ -1841,7 +1841,7 @@ EXPORT_SYMBOL_GPL(virtqueue_kick_prepare);
 
 /**
  * virtqueue_notify - second half of split virtqueue_kick call.
- * @vq: the struct virtqueue
+ * @_vq: the struct virtqueue
  *
  * This does not need to be serialized.
  *
@@ -1885,8 +1885,9 @@ EXPORT_SYMBOL_GPL(virtqueue_kick);
 
 /**
  * virtqueue_get_buf - get the next used buffer
- * @vq: the struct virtqueue we're talking about.
+ * @_vq: the struct virtqueue we're talking about.
  * @len: the length written into the buffer
+ * @ctx: extra context for the token
  *
  * If the device wrote data into the buffer, @len will be set to the
  * amount written.  This means you don't need to clear the buffer
@@ -1916,7 +1917,7 @@ void *virtqueue_get_buf(struct virtqueue *_vq, unsigned int *len)
 EXPORT_SYMBOL_GPL(virtqueue_get_buf);
 /**
  * virtqueue_disable_cb - disable callbacks
- * @vq: the struct virtqueue we're talking about.
+ * @_vq: the struct virtqueue we're talking about.
  *
  * Note that this is not necessarily synchronous, hence unreliable and only
  * useful as an optimization.
@@ -1936,7 +1937,7 @@ EXPORT_SYMBOL_GPL(virtqueue_disable_cb);
 
 /**
  * virtqueue_enable_cb_prepare - restart callbacks after disable_cb
- * @vq: the struct virtqueue we're talking about.
+ * @_vq: the struct virtqueue we're talking about.
  *
  * This re-enables callbacks; it returns current queue state
  * in an opaque unsigned value. This value should be later tested by
@@ -1957,7 +1958,7 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_prepare);
 
 /**
  * virtqueue_poll - query pending used buffers
- * @vq: the struct virtqueue we're talking about.
+ * @_vq: the struct virtqueue we're talking about.
  * @last_used_idx: virtqueue state (from call to virtqueue_enable_cb_prepare).
  *
  * Returns "true" if there are pending used buffers in the queue.
@@ -1976,7 +1977,7 @@ EXPORT_SYMBOL_GPL(virtqueue_poll);
 
 /**
  * virtqueue_enable_cb - restart callbacks after disable_cb.
- * @vq: the struct virtqueue we're talking about.
+ * @_vq: the struct virtqueue we're talking about.
  *
  * This re-enables callbacks; it returns "false" if there are pending
  * buffers in the queue, to detect a possible race between the driver
@@ -1995,7 +1996,7 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb);
 
 /**
  * virtqueue_enable_cb_delayed - restart callbacks after disable_cb.
- * @vq: the struct virtqueue we're talking about.
+ * @_vq: the struct virtqueue we're talking about.
  *
  * This re-enables callbacks but hints to the other side to delay
  * interrupts until most of the available buffers have been processed;
@@ -2017,7 +2018,7 @@ EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
 
 /**
  * virtqueue_detach_unused_buf - detach first unused buffer
- * @vq: the struct virtqueue we're talking about.
+ * @_vq: the struct virtqueue we're talking about.
  *
  * Returns NULL or the "data" token handed to virtqueue_add_*().
  * This is not valid on an active queue; it is useful only for device
@@ -2249,7 +2250,7 @@ EXPORT_SYMBOL_GPL(vring_transport_features);
 
 /**
  * virtqueue_get_vring_size - return the size of the virtqueue's vring
- * @vq: the struct virtqueue containing the vring of interest.
+ * @_vq: the struct virtqueue containing the vring of interest.
  *
  * Returns the size of the vring.  This is mainly used for boasting to
  * userspace.  Unlike other operations, this need not be serialized.
-- 
2.17.2 (Apple Git-113)
