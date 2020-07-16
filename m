From: Eli Cohen <eli@mellanox.com>
Subject: [PATCH vhost next 02/10] vdpa_sim: use the batching API
Date: Thu, 16 Jul 2020 10:23:19 +0300
Message-ID: <20200716072327.5359-3-eli@mellanox.com>
References: <20200716072327.5359-1-eli@mellanox.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716072327.5359-1-eli@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, saeedm@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>

Change-Id: I3751f1aecce285e0f61530c69616852d49e5f547
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 20 --------------------
 drivers/vhost/vdpa.c             |  1 -
 2 files changed, 21 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index c7334cc65bb2..82d1068af3ef 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -548,24 +548,6 @@ static int vdpasim_set_map(struct vdpa_device *vdpa,
 	return ret;
 }
 
-static int vdpasim_dma_map(struct vdpa_device *vdpa, u64 iova, u64 size,
-			   u64 pa, u32 perm)
-{
-	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
-
-	return vhost_iotlb_add_range(vdpasim->iommu, iova,
-				     iova + size - 1, pa, perm);
-}
-
-static int vdpasim_dma_unmap(struct vdpa_device *vdpa, u64 iova, u64 size)
-{
-	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
-
-	vhost_iotlb_del_range(vdpasim->iommu, iova, iova + size - 1);
-
-	return 0;
-}
-
 static void vdpasim_free(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
@@ -598,8 +580,6 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
 	.set_config             = vdpasim_set_config,
 	.get_generation         = vdpasim_get_generation,
 	.set_map                = vdpasim_set_map,
-	.dma_map                = vdpasim_dma_map,
-	.dma_unmap              = vdpasim_dma_unmap,
 	.free                   = vdpasim_free,
 };
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 8827ae31f96d..65195b30133b 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -533,7 +533,6 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 
 static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
 {
-	struct vhost_dev *dev = &v->vdev;
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 
-- 
2.27.0
