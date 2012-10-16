From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 5/5] virtio: make virtqueue_add_buf() returning 0 on success,
	not capacity.
Date: Wed, 17 Oct 2012 00:00:52 +1030
Message-ID: <1350394252-23934-5-git-send-email-rusty@rustcorp.com.au>
References: <1350394252-23934-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350394252-23934-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Now noone relies on this behavior, we simplify virtqueue_add_buf() so it
return 0 or -errno.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_ring.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 335dcec..5fde312 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -181,10 +181,7 @@ static int vring_add_indirect(struct vring_virtqueue *vq,
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
- * Returns remaining capacity of queue or a negative error
- * (ie. ENOSPC).  Note that it only really makes sense to treat all
- * positive return values as "available": indirect buffers mean that
- * we can put an entire sg[] array inside a single queue entry.
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM).
  */
 int virtqueue_add_buf(struct virtqueue *_vq,
 		      struct scatterlist sg[],
@@ -284,7 +281,7 @@ add_head:
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
 
-	return vq->vq.num_free;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_buf);
 
-- 
1.7.9.5
