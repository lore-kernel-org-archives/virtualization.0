From: Rob Landley <rlandley@parallels.com>
Subject: [RFC PATCH TRIVIAL] Reading the virtio code...
Date: Sat, 23 Apr 2011 18:13:34 -0500
Message-ID: <4DB35D1E.3030509@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Rob Landley <rlandley@parallels.com>

Going indirect for only two buffers isn't likely to be a performance win
because the kmalloc/kfree overhead for the indirect block can't be cheaper
than one extra linked list traversal.

Properly "tuning" the threshold would probably be workload-specific.
(One big downside of not going indirect is extra pressure on the table
entries, and table size varies.)  But I think that in the general case,
2 is a defensible minimum?

Signed-off-by: Rob Landley <rlandley@parallels.com>
---

 drivers/virtio/virtio_ring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b0043fb..2b69441 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -173,7 +173,7 @@ int virtqueue_add_buf_gfp(struct virtqueue *_vq,
 
 	/* If the host supports indirect descriptor tables, and we have multiple
 	 * buffers, then go indirect. FIXME: tune this threshold */
-	if (vq->indirect && (out + in) > 1 && vq->num_free) {
+	if (vq->indirect && (out + in) > 2 && vq->num_free) {
 		head = vring_add_indirect(vq, sg, out, in, gfp);
 		if (likely(head >= 0))
 			goto add_head;
