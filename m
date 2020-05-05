From: Julia Lawall <Julia.Lawall@inria.fr>
Subject: [PATCH] iommu/virtio: reverse arguments to list_add
Date: Tue,  5 May 2020 20:47:47 +0200
Message-ID: <1588704467-13431-1-git-send-email-Julia.Lawall@inria.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: kernel-janitors@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, eugene.volanschi@inria.fr
List-Id: virtualization@lists.linuxfoundation.org

Elsewhere in the file, there is a list_for_each_entry with
&vdev->resv_regions as the second argument, suggesting that
&vdev->resv_regions is the list head.  So exchange the
arguments on the list_add call to put the list head in the
second argument.

Fixes: 2a5a31487445 ("iommu/virtio: Add probe request")
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/iommu/virtio-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index d5cac4f46ca5..4e1d11af23c8 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -453,7 +453,7 @@ static int viommu_add_resv_mem(struct viommu_endpoint *vdev,
 	if (!region)
 		return -ENOMEM;
 
-	list_add(&vdev->resv_regions, &region->list);
+	list_add(&region->list, &vdev->resv_regions);
 	return 0;
 }
 
