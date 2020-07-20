From: Eli Cohen <eli@mellanox.com>
Subject: [PATCH V2 vhost next 01/10] vhost-vdpa: support batch updating
Date: Mon, 20 Jul 2020 10:14:07 +0300
Message-ID: <20200720071416.32112-2-eli@mellanox.com>
References: <20200720071416.32112-1-eli@mellanox.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200720071416.32112-1-eli@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, saeedm@mellanox.com, parav@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>

Change-Id: Ifd7139cfbd122dc22493f4bb93fa884f8edbddb6
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c             | 23 +++++++++++++++++------
 include/uapi/linux/vhost_types.h |  2 ++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index a54b60d6623f..8827ae31f96d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -73,6 +73,7 @@ struct vhost_vdpa {
 	int virtio_id;
 	int minor;
 	struct eventfd_ctx *config_ctx;
+	bool in_batch;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -521,9 +522,9 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 
 	if (ops->dma_map)
 		r = ops->dma_map(vdpa, iova, size, pa, perm);
-	else if (ops->set_map)
-		r = ops->set_map(vdpa, dev->iotlb);
-	else
+	else if (ops->set_map) {
+
+	} else
 		r = iommu_map(v->domain, iova, pa, size,
 			      perm_to_iommu_flags(perm));
 
@@ -540,9 +541,8 @@ static void vhost_vdpa_unmap(struct vhost_vdpa *v, u64 iova, u64 size)
 
 	if (ops->dma_map)
 		ops->dma_unmap(vdpa, iova, size);
-	else if (ops->set_map)
-		ops->set_map(vdpa, dev->iotlb);
-	else
+	else if (ops->set_map) {
+	} else
 		iommu_unmap(v->domain, iova, size);
 }
 
@@ -636,6 +636,8 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 					struct vhost_iotlb_msg *msg)
 {
 	struct vhost_vdpa *v = container_of(dev, struct vhost_vdpa, vdev);
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
 	int r = 0;
 
 	r = vhost_dev_check_owner(dev);
@@ -649,6 +651,15 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 	case VHOST_IOTLB_INVALIDATE:
 		vhost_vdpa_unmap(v, msg->iova, msg->size);
 		break;
+	case VHOST_IOTLB_BATCH_BEGIN:
+		v->in_batch = true;
+		break;
+	case VHOST_IOTLB_BATCH_END:
+		if (v->in_batch && ops->set_map) {
+			ops->set_map(vdpa, dev->iotlb);
+		}
+		v->in_batch = false;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 669457ce5c48..7f52245f8d5d 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -60,6 +60,8 @@ struct vhost_iotlb_msg {
 #define VHOST_IOTLB_UPDATE         2
 #define VHOST_IOTLB_INVALIDATE     3
 #define VHOST_IOTLB_ACCESS_FAIL    4
+#define VHOST_IOTLB_BATCH_BEGIN    5
+#define VHOST_IOTLB_BATCH_END      6
 	__u8 type;
 };
 
-- 
2.26.0
