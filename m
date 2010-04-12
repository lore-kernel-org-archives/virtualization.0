From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/6] virtio_balloon: use virtqueue_xxx wrappers
Date: Mon, 12 Apr 2010 16:18:28 +0300
Message-ID: <43367b72d188c910d6e1444c0c425ed508741dcd.1271078235.git.mst@redhat.com>
References: <cover.1271078235.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1271078235.git.mst@redhat.com>
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

Switch virtio_balloon to new virtqueue_xxx wrappers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 3aed388..6caab1a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -75,7 +75,7 @@ static void balloon_ack(struct virtqueue *vq)
 	struct virtio_balloon *vb;
 	unsigned int len;
 
-	vb = vq->vq_ops->get_buf(vq, &len);
+	vb = virtqueue_get_buf(vq, &len);
 	if (vb)
 		complete(&vb->acked);
 }
@@ -89,9 +89,9 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
 	init_completion(&vb->acked);
 
 	/* We should always be able to add one buffer to an empty queue. */
-	if (vq->vq_ops->add_buf(vq, &sg, 1, 0, vb) < 0)
+	if (virtqueue_add_buf(vq, &sg, 1, 0, vb) < 0)
 		BUG();
-	vq->vq_ops->kick(vq);
+	virtqueue_kick(vq);
 
 	/* When host has read buffer, this completes via balloon_ack */
 	wait_for_completion(&vb->acked);
@@ -203,7 +203,7 @@ static void stats_request(struct virtqueue *vq)
 	struct virtio_balloon *vb;
 	unsigned int len;
 
-	vb = vq->vq_ops->get_buf(vq, &len);
+	vb = virtqueue_get_buf(vq, &len);
 	if (!vb)
 		return;
 	vb->need_stats_update = 1;
@@ -220,9 +220,9 @@ static void stats_handle_request(struct virtio_balloon *vb)
 
 	vq = vb->stats_vq;
 	sg_init_one(&sg, vb->stats, sizeof(vb->stats));
-	if (vq->vq_ops->add_buf(vq, &sg, 1, 0, vb) < 0)
+	if (virtqueue_add_buf(vq, &sg, 1, 0, vb) < 0)
 		BUG();
-	vq->vq_ops->kick(vq);
+	virtqueue_kick(vq);
 }
 
 static void virtballoon_changed(struct virtio_device *vdev)
@@ -313,10 +313,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		 * use it to signal us later.
 		 */
 		sg_init_one(&sg, vb->stats, sizeof vb->stats);
-		if (vb->stats_vq->vq_ops->add_buf(vb->stats_vq,
-						  &sg, 1, 0, vb) < 0)
+		if (virtqueue_add_buf(vb->stats_vq, &sg, 1, 0, vb) < 0)
 			BUG();
-		vb->stats_vq->vq_ops->kick(vb->stats_vq);
+		virtqueue_kick(vb->stats_vq);
 	}
 
 	vb->thread = kthread_run(balloon, vb, "vballoon");
-- 
1.7.0.2.280.gc6f05
