From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 4/4] vhost: vdpa: report iova range
Date: Wed, 17 Jun 2020 11:29:47 +0800
Message-ID: <20200617032947.6371-5-jasowang@redhat.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200617032947.6371-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: rob.miller@broadcom.com, lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com, zhangweining@ruijie.com.cn, eli@mellanox.com
List-Id: virtualization@lists.linuxfoundation.org

This patch introduces a new ioctl for vhost-vdpa device that can
report the iova range by the device. For device that depends on
platform IOMMU, we fetch the iova range via DOMAIN_ATTR_GEOMETRY. For
devices that has its own DMA translation unit, we fetch it directly
from vDPA bus operation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c             | 27 +++++++++++++++++++++++++++
 include/uapi/linux/vhost.h       |  4 ++++
 include/uapi/linux/vhost_types.h |  5 +++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 77a0c9fb6cc3..ad23e66cbf57 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -332,6 +332,30 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 
 	return 0;
 }
+
+static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
+{
+	struct iommu_domain_geometry geo;
+	struct vdpa_device *vdpa = v->vdpa;
+	const struct vdpa_config_ops *ops = vdpa->config;
+	struct vhost_vdpa_iova_range range;
+	struct vdpa_iova_range vdpa_range;
+
+	if (!ops->set_map && !ops->dma_map) {
+		iommu_domain_get_attr(v->domain,
+				      DOMAIN_ATTR_GEOMETRY, &geo);
+		range.start = geo.aperture_start;
+		range.end = geo.aperture_end;
+	} else {
+		vdpa_range = ops->get_iova_range(vdpa);
+		range.start = vdpa_range.start;
+		range.end = vdpa_range.end;
+	}
+
+	return copy_to_user(argp, &range, sizeof(range));
+
+}
+
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -442,6 +466,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_VDPA_SET_CONFIG_CALL:
 		r = vhost_vdpa_set_config_call(v, argp);
 		break;
+	case VHOST_VDPA_GET_IOVA_RANGE:
+		r = vhost_vdpa_get_iova_range(v, argp);
+		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
 		if (r == -ENOIOCTLCMD)
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 0c2349612e77..850956980e27 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -144,4 +144,8 @@
 
 /* Set event fd for config interrupt*/
 #define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
+
+/* Get the valid iova range */
+#define VHOST_VDPA_GET_IOVA_RANGE	_IOW(VHOST_VIRTIO, 0x78, \
+					     struct vhost_vdpa_iova_range)
 #endif
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 669457ce5c48..4025b5a36177 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -127,6 +127,11 @@ struct vhost_vdpa_config {
 	__u8 buf[0];
 };
 
+struct vhost_vdpa_iova_range {
+	__u64 start;
+	__u64 end;
+};
+
 /* Feature bits */
 /* Log all write descriptors. Can be changed while device is active. */
 #define VHOST_F_LOG_ALL 26
-- 
2.20.1
