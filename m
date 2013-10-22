From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH RFC 6/7] virtio_blk: set request queue as dying in case
	virtqueue is broken
Date: Tue, 22 Oct 2013 14:45:10 +0200
Message-ID: <1382445911-55657-7-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1382445911-55657-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1382445911-55657-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

The request queue should be flagged as QUEUE_FLAG_DYING in case the host
kick failed for a new virtqueue request.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/block/virtio_blk.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index a787e6e..01b5d3a 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -377,8 +377,14 @@ static void virtblk_request(struct request_queue *q)
 		issued++;
 	}
 
-	if (issued)
+	if (issued) {
 		virtqueue_kick(vblk->vq);
+		if (virtqueue_is_broken(vblk->vq)) {
+			mutex_lock(&q->sysfs_lock);
+			queue_flag_set_unlocked(QUEUE_FLAG_DYING, q);
+			mutex_unlock(&q->sysfs_lock);
+		}
+	}
 }
 
 static void virtblk_make_request(struct request_queue *q, struct bio *bio)
-- 
1.8.3.1
