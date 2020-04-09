From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vdpa: allow a 32 bit vq alignment
Date: Thu, 9 Apr 2020 16:28:49 -0400
Message-ID: <20200409202825.10115-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

get_vq_align returns u16 now, but that's not enough for
systems/devices with 64K pages. All callers assign it to
a u32 variable anyway, so let's just change the return
value type to u32.

Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c  | 2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 include/linux/vdpa.h             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 28d9e5de5675..abf6a061cab6 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -226,7 +226,7 @@ static u32 ifcvf_vdpa_get_vendor_id(struct vdpa_device *vdpa_dev)
 	return IFCVF_SUBSYS_VENDOR_ID;
 }
 
-static u16 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
+static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
 {
 	return IFCVF_QUEUE_ALIGNMENT;
 }
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 72863d01a12a..7957d2d41fc4 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -435,7 +435,7 @@ static u64 vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx)
 	return vrh->last_avail_idx;
 }
 
-static u16 vdpasim_get_vq_align(struct vdpa_device *vdpa)
+static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
 {
 	return VDPASIM_QUEUE_ALIGN;
 }
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 733acfb7ef84..5453af87a33e 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -164,7 +164,7 @@ struct vdpa_config_ops {
 	u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
 
 	/* Device ops */
-	u16 (*get_vq_align)(struct vdpa_device *vdev);
+	u32 (*get_vq_align)(struct vdpa_device *vdev);
 	u64 (*get_features)(struct vdpa_device *vdev);
 	int (*set_features)(struct vdpa_device *vdev, u64 features);
 	void (*set_config_cb)(struct vdpa_device *vdev,
-- 
MST
