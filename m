From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] virtio-blk: make the queue depth configurable
Date: Fri, 14 Mar 2014 13:31:03 -0400
Message-ID: <1394818263-29947-1-git-send-email-tytso__21109.5327315435$1394818411$gmane$org@mit.edu>
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
To: Linux Kernel Developers List <linux-kernel@vger.kernel.org>
Cc: fes@google.com, virtio-dev@lists.oasis-open.org, Theodore Ts'o <tytso@mit.edu>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The current virtio block sets a queue depth of 64.  With a
sufficiently fast device, using a queue depth of 256 can double the
IOPS which can be sustained.  So make the queue depth something which
can be set at module load time or via a kernel boot-time parameter.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
Cc: virtualization@lists.linux-foundation.org
Cc: fes@google.com
---
 drivers/block/virtio_blk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6a680d4..0c9e57f 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -481,6 +481,9 @@ static struct blk_mq_ops virtio_mq_ops = {
 	.free_hctx	= blk_mq_free_single_hw_queue,
 };
 
+static int queue_depth = 64;
+module_param(queue_depth, int, 444);
+
 static struct blk_mq_reg virtio_mq_reg = {
 	.ops		= &virtio_mq_ops,
 	.nr_hw_queues	= 1,
@@ -551,6 +554,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 		goto out_free_vq;
 	}
 
+	virtio_mq_reg.queue_depth = queue_depth;
 	virtio_mq_reg.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * sg_elems;
-- 
1.9.0
