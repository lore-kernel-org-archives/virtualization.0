From: Ladi Prosek <lprosek@redhat.com>
Subject: [PATCH] virtio_balloon: don't push uninitialized buffers to stats
	virtqueue
Date: Wed, 22 Mar 2017 16:10:27 +0100
Message-ID: <1490195427-25085-1-git-send-email-lprosek@redhat.com>
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
To: virtualization@lists.linux-foundation.org
Cc: mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

When init_vqs runs, virtio_balloon.stats is either uninitialized or
contains stale values. The host updates its state with garbage data
because it has no way of knowing that this is just a marker buffer
used for signaling.

This patch initializes all tags with U16_MAX which is guaranteed to
be ignored by the host.

The alternative fix would be to push an empty buffer in init_vqs but
that's not easily done with the current virtio implementation and
would still not eliminate the invariant that update_balloon_stats
has to update all VIRTIO_BALLOON_S_NR fields.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 4e11915..d34f56f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -423,12 +423,16 @@ static int init_vqs(struct virtio_balloon *vb)
 	vb->deflate_vq = vqs[1];
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		struct scatterlist sg;
+		int idx;
 		vb->stats_vq = vqs[2];
 
 		/*
 		 * Prime this virtqueue with one buffer so the hypervisor can
 		 * use it to signal us later (it can't be broken yet!).
 		 */
+		for (idx = 0; idx < VIRTIO_BALLOON_S_NR; idx++)
+			update_stat(vb, idx, U16_MAX, 0);
+
 		sg_init_one(&sg, vb->stats, sizeof vb->stats);
 		if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)
 		    < 0)
-- 
2.7.4
