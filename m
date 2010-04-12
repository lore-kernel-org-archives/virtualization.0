From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/6] virtio_blk: use virtqueue_xxx wrappers
Date: Mon, 12 Apr 2010 16:18:36 +0300
Message-ID: <3e5d10567ba12636cbbb397292cdc8508f2a81a3.1271078235.git.mst@redhat.com>
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

Switch virtio_blk to new virtqueue_xxx wrappers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/block/virtio_blk.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2138a7a..1fb4f20 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -50,7 +50,7 @@ static void blk_done(struct virtqueue *vq)
 	unsigned long flags;
 
 	spin_lock_irqsave(&vblk->lock, flags);
-	while ((vbr = vblk->vq->vq_ops->get_buf(vblk->vq, &len)) != NULL) {
+	while ((vbr = virtqueue_get_buf(vblk->vq, &len)) != NULL) {
 		int error;
 
 		switch (vbr->status) {
@@ -151,7 +151,7 @@ static bool do_req(struct request_queue *q, struct virtio_blk *vblk,
 		}
 	}
 
-	if (vblk->vq->vq_ops->add_buf(vblk->vq, vblk->sg, out, in, vbr) < 0) {
+	if (virtqueue_add_buf(vblk->vq, vblk->sg, out, in, vbr) < 0) {
 		mempool_free(vbr, vblk->pool);
 		return false;
 	}
@@ -180,7 +180,7 @@ static void do_virtblk_request(struct request_queue *q)
 	}
 
 	if (issued)
-		vblk->vq->vq_ops->kick(vblk->vq);
+		virtqueue_kick(vblk->vq);
 }
 
 static void virtblk_prepare_flush(struct request_queue *q, struct request *req)
-- 
1.7.0.2.280.gc6f05
