From: Eli Cohen <eli@mellanox.com>
Subject: [PATCH vhost next 05/10] vhost: Fix documentation
Date: Thu, 16 Jul 2020 10:23:22 +0300
Message-ID: <20200716072327.5359-6-eli@mellanox.com>
References: <20200716072327.5359-1-eli@mellanox.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716072327.5359-1-eli@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, saeedm@mellanox.com, Eli Cohen <eli@mellanox.com>, Parav Pandit <parav@mellanox.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix documentation to match actual function prototypes.

Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
---
 drivers/vhost/iotlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index 1f0ca6e44410..0d4213a54a88 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_free);
  * vhost_iotlb_itree_first - return the first overlapped range
  * @iotlb: the IOTLB
  * @start: start of IOVA range
- * @end: end of IOVA range
+ * @last: last byte in IOVA range
  */
 struct vhost_iotlb_map *
 vhost_iotlb_itree_first(struct vhost_iotlb *iotlb, u64 start, u64 last)
@@ -162,7 +162,7 @@ EXPORT_SYMBOL_GPL(vhost_iotlb_itree_first);
  * vhost_iotlb_itree_first - return the next overlapped range
  * @iotlb: the IOTLB
  * @start: start of IOVA range
- * @end: end of IOVA range
+ * @last: last byte IOVA range
  */
 struct vhost_iotlb_map *
 vhost_iotlb_itree_next(struct vhost_iotlb_map *map, u64 start, u64 last)
-- 
2.27.0
