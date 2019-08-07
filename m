From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V4 9/9] vhost: do not return -EAGAIN for non blocking
	invalidation too early
Date: Wed,  7 Aug 2019 03:06:17 -0400
Message-ID: <20190807070617.23716-10-jasowang__48743.3210642607$1565161676$gmane$org@redhat.com>
References: <20190807070617.23716-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190807070617.23716-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
List-Id: virtualization@lists.linuxfoundation.org

Instead of returning -EAGAIN unconditionally, we'd better do that only
we're sure the range is overlapped with the metadata area.

Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6650a3ff88c1..0271f853fa9c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -395,16 +395,19 @@ static void inline vhost_vq_sync_access(struct vhost_virtqueue *vq)
 	smp_mb();
 }
 
-static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
-				      int index,
-				      unsigned long start,
-				      unsigned long end)
+static int vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
+				     int index,
+				     unsigned long start,
+				     unsigned long end,
+				     bool blockable)
 {
 	struct vhost_uaddr *uaddr = &vq->uaddrs[index];
 	struct vhost_map *map;
 
 	if (!vhost_map_range_overlap(uaddr, start, end))
-		return;
+		return 0;
+	else if (!blockable)
+		return -EAGAIN;
 
 	spin_lock(&vq->mmu_lock);
 	++vq->invalidate_count;
@@ -419,6 +422,8 @@ static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
 		vhost_set_map_dirty(vq, map, index);
 		vhost_map_unprefetch(map);
 	}
+
+	return 0;
 }
 
 static void vhost_invalidate_vq_end(struct vhost_virtqueue *vq,
@@ -439,18 +444,19 @@ static int vhost_invalidate_range_start(struct mmu_notifier *mn,
 {
 	struct vhost_dev *dev = container_of(mn, struct vhost_dev,
 					     mmu_notifier);
-	int i, j;
-
-	if (!mmu_notifier_range_blockable(range))
-		return -EAGAIN;
+	bool blockable = mmu_notifier_range_blockable(range);
+	int i, j, ret;
 
 	for (i = 0; i < dev->nvqs; i++) {
 		struct vhost_virtqueue *vq = dev->vqs[i];
 
-		for (j = 0; j < VHOST_NUM_ADDRS; j++)
-			vhost_invalidate_vq_start(vq, j,
-						  range->start,
-						  range->end);
+		for (j = 0; j < VHOST_NUM_ADDRS; j++) {
+			ret = vhost_invalidate_vq_start(vq, j,
+							range->start,
+							range->end, blockable);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return 0;
-- 
2.18.1
