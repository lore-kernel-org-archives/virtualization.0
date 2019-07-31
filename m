From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 8/9] vhost: correctly set dirty pages in MMU notifiers
	callback
Date: Wed, 31 Jul 2019 04:46:54 -0400
Message-ID: <20190731084655.7024-9-jasowang__24772.3827183776$1564563481$gmane$org@redhat.com>
References: <20190731084655.7024-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190731084655.7024-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
List-Id: virtualization@lists.linuxfoundation.org

We need make sure there's no reference on the map before trying to
mark set dirty pages.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index db2c81cb1e90..fc2da8a0c671 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -414,14 +414,13 @@ static void vhost_invalidate_vq_start(struct vhost_virtqueue *vq,
 	++vq->invalidate_count;
 
 	map = vq->maps[index];
-	if (map) {
-		vhost_set_map_dirty(vq, map, index);
+	if (map)
 		vq->maps[index] = NULL;
-	}
 	spin_unlock(&vq->mmu_lock);
 
 	if (map) {
 		vhost_vq_sync_access(vq);
+		vhost_set_map_dirty(vq, map, index);
 		vhost_map_unprefetch(map);
 	}
 }
-- 
2.18.1
