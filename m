From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH] vdpa_sim: do not reset IOTLB during device reset
Date: Thu, 14 May 2020 15:25:49 +0800
Message-ID: <20200514072549.29694-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

We reset IOTLB during device reset this breaks the assumption that the
mapping needs to be controlled via vDPA DMA ops explicitly in a
incremental way. So the networking will be broken after e.g a guest
reset.

Fix this by not resetting the IOTLB during device reset.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 7957d2d41fc4..cc5525743a25 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -119,8 +119,6 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 	for (i = 0; i < VDPASIM_VQ_NUM; i++)
 		vdpasim_vq_reset(&vdpasim->vqs[i]);
 
-	vhost_iotlb_reset(vdpasim->iommu);
-
 	vdpasim->features = 0;
 	vdpasim->status = 0;
 	++vdpasim->generation;
-- 
2.20.1
