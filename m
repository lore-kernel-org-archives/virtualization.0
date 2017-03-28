From: Ladi Prosek <lprosek@redhat.com>
Subject: [PATCH v3 2/3] virtio-balloon: use actual number of stats for stats
	queue buffers
Date: Tue, 28 Mar 2017 18:46:58 +0200
Message-ID: <20170328164659.4311-3-lprosek@redhat.com>
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

The virtio balloon driver contained a not-so-obvious invariant that
update_balloon_stats has to update exactly VIRTIO_BALLOON_S_NR counters
in order to send valid stats to the host. This commit fixes it by having
update_balloon_stats return the actual number of counters, and its
callers use it when pushing buffers to the stats virtqueue.

Note that it is still out of spec to change the number of counters
at run-time. "Driver MUST supply the same subset of statistics in all
buffers submitted to the statsq."

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ladi Prosek <lprosek@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index fcd06e1..d9544db 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -242,11 +242,11 @@ static inline void update_stat(struct virtio_balloon *vb, int idx,
 
 #define pages_to_bytes(x) ((u64)(x) << PAGE_SHIFT)
 
-static void update_balloon_stats(struct virtio_balloon *vb)
+static unsigned int update_balloon_stats(struct virtio_balloon *vb)
 {
 	unsigned long events[NR_VM_EVENT_ITEMS];
 	struct sysinfo i;
-	int idx = 0;
+	unsigned int idx = 0;
 	long available;
 
 	all_vm_events(events);
@@ -266,6 +266,8 @@ static void update_balloon_stats(struct virtio_balloon *vb)
 				pages_to_bytes(i.totalram));
 	update_stat(vb, idx++, VIRTIO_BALLOON_S_AVAIL,
 				pages_to_bytes(available));
+
+	return idx;
 }
 
 /*
@@ -291,14 +293,14 @@ static void stats_handle_request(struct virtio_balloon *vb)
 {
 	struct virtqueue *vq;
 	struct scatterlist sg;
-	unsigned int len;
+	unsigned int len, num_stats;
 
-	update_balloon_stats(vb);
+	num_stats = update_balloon_stats(vb);
 
 	vq = vb->stats_vq;
 	if (!virtqueue_get_buf(vq, &len))
 		return;
-	sg_init_one(&sg, vb->stats, sizeof(vb->stats));
+	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
 	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
 	virtqueue_kick(vq);
 }
@@ -423,15 +425,16 @@ static int init_vqs(struct virtio_balloon *vb)
 	vb->deflate_vq = vqs[1];
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		struct scatterlist sg;
+		unsigned int num_stats;
 		vb->stats_vq = vqs[2];
 
 		/*
 		 * Prime this virtqueue with one buffer so the hypervisor can
 		 * use it to signal us later (it can't be broken yet!).
 		 */
-		update_balloon_stats(vb);
+		num_stats = update_balloon_stats(vb);
 
-		sg_init_one(&sg, vb->stats, sizeof vb->stats);
+		sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
 		if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)
 		    < 0)
 			BUG();
-- 
2.9.3
