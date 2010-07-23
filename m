From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio: fix oops on OOM
Date: Fri, 23 Jul 2010 15:48:37 +0930
Message-ID: <201007231548.38037.rusty__14089.5436671146$1279866056$gmane$org@rustcorp.com.au>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, Chris Mason <chris.mason@oracle.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>

virtio ring was changed to return an error code on OOM,
but one caller was missed and still checks for vq->vring.num.
The fix is just to check for <0 error code.

Long term it might make sense to change goto add_head to
just return an error on oom instead, but let's apply
a minimal fix for 2.6.35.

Reported-by: Chris Mason <chris.mason@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Tested-by: Chris Mason <chris.mason@oracle.com>
---

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index dd35b34..bffec32 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -164,7 +164,8 @@ int virtqueue_add_buf_gfp(struct virtqueue *_vq,
 			  gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	unsigned int i, avail, head, uninitialized_var(prev);
+	unsigned int i, avail, uninitialized_var(prev);
+	int head;
 
 	START_USE(vq);
 
@@ -174,8 +175,8 @@ int virtqueue_add_buf_gfp(struct virtqueue *_vq,
 	 * buffers, then go indirect. FIXME: tune this threshold */
 	if (vq->indirect && (out + in) > 1 && vq->num_free) {
 		head = vring_add_indirect(vq, sg, out, in, gfp);
-		if (head != vq->vring.num)
+		if (likely(head >= 0))
 			goto add_head;
 	}
 
 	BUG_ON(out + in > vq->vring.num);
