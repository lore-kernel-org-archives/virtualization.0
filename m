From: Ladi Prosek <lprosek@redhat.com>
Subject: [PATCH v2] virtio_balloon: don't push uninitialized buffers to stats
	virtqueue
Date: Thu, 23 Mar 2017 08:04:18 +0100
Message-ID: <1490252658-17893-1-git-send-email-lprosek@redhat.com>
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

This patch updates the stats before pushing the initial buffer.
An assertion is also added to update_balloon_stats to make sure
that all stats fields are initialized.

Alternative fixes:
* Push an empty buffer in init_vqs. Not easily done with the current
  virtio implementation and violates the spec "Driver MUST supply the
  same subset of statistics in all buffers submitted to the statsq".
* Push a buffer with invalid tags in init_vqs. Violates the same
  spec clause, plus "invalid tag" is not really defined.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---

v1->v2:

* Call update_balloon_stats instead of filling the buffer with
  invalid tags.
* Add BUG_ON to update_balloon_stats to formalize the invariant that
  all slots in the buffer must be initialized.


Also, I just noticed this paragraph in the spec:

"When using the legacy interface, the device SHOULD ignore all values in
the first buffer in the statsq supplied by the driver after device
initialization. Note: Historically, drivers supplied an uninitialized
buffer in the first buffer."

So someone knew about this bug but didn't fix the Linux driver and also
didn't implement the SHOULD in QEMU. Makes me wonder if I'm missing
something here.

Thanks!


 drivers/virtio/virtio_balloon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 4e11915..42dc35f 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -266,6 +266,8 @@ static void update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(i.totalram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_AVAIL,
 				pages_to_bytes(available));
+
+	BUG_ON(idx < VIRTIO_BALLOON_S_NR);
 }
 
 /*
@@ -429,6 +431,8 @@ static int init_vqs(struct virtio_balloon *vb)
 		 * Prime this virtqueue with one buffer so the hypervisor can
 		 * use it to signal us later (it can't be broken yet!).
 		 */
+		update_balloon_stats(vb);
+
 		sg_init_one(&sg, vb->stats, sizeof vb->stats);
 		if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)
 		    < 0)
-- 
2.7.4
