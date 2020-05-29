From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 3/6] vdpa: introduce get_vq_notification method
Date: Fri, 29 May 2020 16:03:00 +0800
Message-ID: <20200529080303.15449-4-jasowang@redhat.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200529080303.15449-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com, jasowang@redhat.com
Cc: shahafs@mellanox.com, lulu@redhat.com, kvm@vger.kernel.org, saugatm@xilinx.com, netdev@vger.kernel.org, mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org, gdawar@xilinx.com, virtualization@lists.linux-foundation.org, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

This patch introduces a new method in the vdpa_config_ops which
reports the physical address and the size of the doorbell for a
specific virtqueue.

This will be used by the future patches that maps doorbell to
userspace.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 5453af87a33e..239db794357c 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -17,6 +17,16 @@ struct vdpa_callback {
 	void *private;
 };
 
+/**
+ * vDPA notification area
+ * @addr: base address of the notification area
+ * @size: size of the notification area
+ */
+struct vdpa_notification_area {
+	resource_size_t addr;
+	resource_size_t size;
+};
+
 /**
  * vDPA device - representation of a vDPA device
  * @dev: underlying device
@@ -73,6 +83,10 @@ struct vdpa_device {
  *				@vdev: vdpa device
  *				@idx: virtqueue index
  *				Returns virtqueue state (last_avail_idx)
+ * @get_vq_notification: 	Get the notification area for a virtqueue
+ *				@vdev: vdpa device
+ *				@idx: virtqueue index
+ *				Returns the notifcation area
  * @get_vq_align:		Get the virtqueue align requirement
  *				for the device
  *				@vdev: vdpa device
@@ -162,6 +176,8 @@ struct vdpa_config_ops {
 	bool (*get_vq_ready)(struct vdpa_device *vdev, u16 idx);
 	int (*set_vq_state)(struct vdpa_device *vdev, u16 idx, u64 state);
 	u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
+	struct vdpa_notification_area
+	(*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
 
 	/* Device ops */
 	u32 (*get_vq_align)(struct vdpa_device *vdev);
-- 
2.20.1
