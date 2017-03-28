From: Ladi Prosek <lprosek@redhat.com>
Subject: [PATCH v3 1/3] virtio_balloon: don't push uninitialized buffers to
	stats virtqueue
Date: Tue, 28 Mar 2017 18:46:57 +0200
Message-ID: <20170328164659.4311-2-lprosek@redhat.com>
References: <20170328164659.4311-1-lprosek@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170328164659.4311-1-lprosek@redhat.com>
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
Cc: arnd@arndb.de, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

When init_vqs runs, virtio_balloon.stats is either uninitialized or
contains stale values. The host updates its state with garbage data
because it has no way of knowing that this is just a marker buffer
used for signaling.

This patch updates the stats before pushing the initial buffer.

Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 4e11915..fcd06e1 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -429,6 +429,8 @@ static int init_vqs(struct virtio_balloon *vb)
 		 * Prime this virtqueue with one buffer so the hypervisor can
 		 * use it to signal us later (it can't be broken yet!).
 		 */
+		update_balloon_stats(vb);
+
 		sg_init_one(&sg, vb->stats, sizeof vb->stats);
 		if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)
 		    < 0)
-- 
2.9.3
