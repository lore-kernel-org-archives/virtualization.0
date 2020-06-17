From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Date: Wed, 17 Jun 2020 11:29:44 +0800
Message-ID: <20200617032947.6371-2-jasowang@redhat.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200617032947.6371-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com, mhabets@solarflare.com, vmireyno@marvell.com, gdawar@xilinx.com, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

This patch introduce a config op to get valid iova range from the vDPA
device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 239db794357c..b7633ed2500c 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -41,6 +41,16 @@ struct vdpa_device {
 	unsigned int index;
 };
 
+/**
+ * vDPA IOVA range - the IOVA range support by the device
+ * @start: start of the IOVA range
+ * @end: end of the IOVA range
+ */
+struct vdpa_iova_range {
+	u64 start;
+	u64 end;
+};
+
 /**
  * vDPA_config_ops - operations for configuring a vDPA device.
  * Note: vDPA device drivers are required to implement all of the
@@ -134,6 +144,9 @@ struct vdpa_device {
  * @get_generation:		Get device config generation (optional)
  *				@vdev: vdpa device
  *				Returns u32: device generation
+ * @get_iova_range:		Get supported iova range (on-chip IOMMU)
+ *				@vdev: vdpa device
+ *				Returns the iova range supported by the device
  * @set_map:			Set device memory mapping (optional)
  *				Needed for device that using device
  *				specific DMA translation (on-chip IOMMU)
@@ -195,6 +208,7 @@ struct vdpa_config_ops {
 	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
 			   const void *buf, unsigned int len);
 	u32 (*get_generation)(struct vdpa_device *vdev);
+	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
 
 	/* DMA ops */
 	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
-- 
2.20.1
