From: Bob Liu <bob.liu@oracle.com>
Subject: [PATCH] drivers: virtio_blk: notify blk-core when hw-queue number
	changes
Date: Mon, 13 Jun 2016 17:58:26 +0800
Message-ID: <1465811906-24510-1-git-send-email-bob.liu__9616.24590349874$1465832216$gmane$org@oracle.com>
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
To: linux-kernel@vger.kernel.org
Cc: Bob Liu <bob.liu@oracle.com>, virtualization@lists.linux-foundation.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

A guest might be migrated to other hosts with different num_queues, the
blk-core should aware of that else the reference of &vblk->vqs[qid] may be wrong.

Signed-off-by: Bob Liu <bob.liu@oracle.com>
---
 drivers/block/virtio_blk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 42758b5..c169238 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -819,6 +819,9 @@ static int virtblk_restore(struct virtio_device *vdev)
 	if (ret)
 		return ret;
 
+	if (vblk->num_vqs != vblk->tag_set.nr_hw_queues)
+		blk_mq_update_nr_hw_queues(&vblk->tag_set, vblk->num_vqs);
+
 	virtio_device_ready(vdev);
 
 	blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-- 
2.7.4
