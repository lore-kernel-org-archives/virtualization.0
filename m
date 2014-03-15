From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] virtio-blk: make the queue depth the max supportable by the
	hypervisor
Date: Fri, 14 Mar 2014 23:34:31 -0400
Message-ID: <1394854471-25700-1-git-send-email-tytso@mit.edu>
References: <1394841445-16142-1-git-send-email-venkateshs@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1394841445-16142-1-git-send-email-venkateshs@google.com>
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
Cc: Frank Swiderski <fes@google.com>, virtio-dev@lists.oasis-open.org, Theodore Ts'o <tytso@mit.edu>, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The current virtio block sets a queue depth of 64, which is
insufficient for very fast devices.  It has been demonstrated that
with a high IOPS device, using a queue depth of 256 can double the
IOPS which can be sustained.

As suggested by Venkatash Srinivas, set the queue depth by default to
be one half the the device's virtqueue, which is the maximum queue
depth that can be supported by the channel to the host OS (each I/O
request requires at least two VQ entries).

Also allow the queue depth to be something which can be set at module
load time or via a kernel boot-time parameter, for
testing/benchmarking purposes.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Signed-off-by: Venkatesh Srinivas <venkateshs@google.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
Cc: virtualization@lists.linux-foundation.org
Cc: Frank Swiderski <fes@google.com>
---

This is a combination of my patch and Vekatash's patch.  I agree that
setting the default automatically is better than requiring the user to
set the value by hand.

 drivers/block/virtio_blk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6a680d4..0f70c01 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -481,6 +481,9 @@ static struct blk_mq_ops virtio_mq_ops = {
 	.free_hctx	= blk_mq_free_single_hw_queue,
 };
 
+static int queue_depth = -1;
+module_param(queue_depth, int, 0444);
+
 static struct blk_mq_reg virtio_mq_reg = {
 	.ops		= &virtio_mq_ops,
 	.nr_hw_queues	= 1,
@@ -551,9 +554,14 @@ static int virtblk_probe(struct virtio_device *vdev)
 		goto out_free_vq;
 	}
 
+	virtio_mq_reg.queue_depth = queue_depth > 0 ? queue_depth :
+		(vblk->vq->num_free / 2);
 	virtio_mq_reg.cmd_size =
 		sizeof(struct virtblk_req) +
 		sizeof(struct scatterlist) * sg_elems;
+	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
+	pr_info("%s: using queue depth %d\n", vblk->disk->disk_name,
+		virtio_mq_reg.queue_depth);
 
 	q = vblk->disk->queue = blk_mq_init_queue(&virtio_mq_reg, vblk);
 	if (!q) {
@@ -565,8 +573,6 @@ static int virtblk_probe(struct virtio_device *vdev)
 
 	q->queuedata = vblk;
 
-	virtblk_name_format("vd", index, vblk->disk->disk_name, DISK_NAME_LEN);
-
 	vblk->disk->major = major;
 	vblk->disk->first_minor = index_to_minor(index);
 	vblk->disk->private_data = vblk;
-- 
1.9.0
