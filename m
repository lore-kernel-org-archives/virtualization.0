From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 3/6] vhost: fix vhost map leak
Date: Tue, 23 Jul 2019 03:57:15 -0400
Message-ID: <20190723075718.6275-4-jasowang__333.137803112038$1563868694$gmane$org@redhat.com>
References: <20190723075718.6275-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190723075718.6275-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

We don't free map during vhost_map_unprefetch(). This means it could
be leaked. Fixing by free the map.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Fixes: 7f466032dc9e ("vhost: access vq metadata through kernel virtual address")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 058191d5efad..03666b702498 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -303,9 +303,7 @@ static void vhost_vq_meta_reset(struct vhost_dev *d)
 static void vhost_map_unprefetch(struct vhost_map *map)
 {
 	kfree(map->pages);
-	map->pages = NULL;
-	map->npages = 0;
-	map->addr = NULL;
+	kfree(map);
 }
 
 static void vhost_uninit_vq_maps(struct vhost_virtqueue *vq)
-- 
2.18.1
