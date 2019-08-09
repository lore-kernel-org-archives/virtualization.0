From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V5 5/9] vhost: mark dirty pages during map uninit
Date: Fri,  9 Aug 2019 01:48:47 -0400
Message-ID: <20190809054851.20118-6-jasowang__32170.5237891123$1565329791$gmane$org@redhat.com>
References: <20190809054851.20118-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190809054851.20118-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, jgg@ziepe.ca
List-Id: virtualization@lists.linuxfoundation.org

We don't mark dirty pages if the map was teared down outside MMU
notifier. This will lead untracked dirty pages. Fixing by marking
dirty pages during map uninit.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2a7217c33668..c12cdadb0855 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -305,6 +305,18 @@ static void vhost_map_unprefetch(struct vhost_map *map)
 	kfree(map);
 }
 
+static void vhost_set_map_dirty(struct vhost_virtqueue *vq,
+				struct vhost_map *map, int index)
+{
+	struct vhost_uaddr *uaddr = &vq->uaddrs[index];
+	int i;
+
+	if (uaddr->write) {
+		for (i = 0; i < map->npages; i++)
+			set_page_dirty(map->pages[i]);
+	}
+}
+
 static void vhost_uninit_vq_maps(struct vhost_virtqueue *vq)
 {
 	struct vhost_map *map[VHOST_NUM_ADDRS];
@@ -314,8 +326,10 @@ static void vhost_uninit_vq_maps(struct vhost_virtqueue *vq)
 	for (i = 0; i < VHOST_NUM_ADDRS; i++) {
 		map[i] = rcu_dereference_protected(vq->maps[i],
 				  lockdep_is_held(&vq->mmu_lock));
-		if (map[i])
+		if (map[i]) {
+			vhost_set_map_dirty(vq, map[i], i);
 			rcu_assign_pointer(vq->maps[i], NULL);
+		}
 	}
 	spin_unlock(&vq->mmu_lock);
 
@@ -353,7 +367,6 @@ static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
 {
 	struct vhost_uaddr *uaddr = &vq->uaddrs[index];
 	struct vhost_map *map;
-	int i;
 
 	if (!vhost_map_range_overlap(uaddr, start, end))
 		return;
@@ -364,10 +377,7 @@ static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
 	map = rcu_dereference_protected(vq->maps[index],
 					lockdep_is_held(&vq->mmu_lock));
 	if (map) {
-		if (uaddr->write) {
-			for (i = 0; i < map->npages; i++)
-				set_page_dirty(map->pages[i]);
-		}
+		vhost_set_map_dirty(vq, map, index);
 		rcu_assign_pointer(vq->maps[index], NULL);
 	}
 	spin_unlock(&vq->mmu_lock);
-- 
2.18.1
