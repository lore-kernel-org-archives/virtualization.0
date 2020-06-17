From: Eli Cohen <eli@mellanox.com>
Subject: [PATCH] net/vdpa: Use struct for set/get vq state
Date: Wed, 17 Jun 2020 11:01:51 +0300
Message-ID: <20200617080152.23408-1-eli@mellanox.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
Cc: eli@mellanox.com, lulu@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

For now VQ state involves 16 bit available index value encoded in u64
variable. In the future it will be extended to contain more fields. Use
struct to contain the state, now containing only a single u16 for the
available index. In the future we can add fields to this struct.

Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eli Cohen <eli@mellanox.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c  |  4 ++--
 drivers/vdpa/ifcvf/ifcvf_base.h  |  4 ++--
 drivers/vdpa/ifcvf/ifcvf_main.c  |  9 +++++----
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 10 ++++++----
 drivers/vhost/vdpa.c             | 10 +++++++---
 include/linux/vdpa.h             | 18 ++++++++++++++----
 6 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index e24371d644b5..763cb5ed4745 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -269,7 +269,7 @@ static int ifcvf_config_features(struct ifcvf_hw *hw)
 	return 0;
 }
 
-u64 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
+u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
 {
 	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
 	void __iomem *avail_idx_addr;
@@ -284,7 +284,7 @@ u64 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
 	return last_avail_idx;
 }
 
-int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u64 num)
+int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
 {
 	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
 	void __iomem *avail_idx_addr;
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index e80307092351..d929748d0664 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -112,7 +112,7 @@ void ifcvf_set_status(struct ifcvf_hw *hw, u8 status);
 void io_write64_twopart(u64 val, u32 *lo, u32 *hi);
 void ifcvf_reset(struct ifcvf_hw *hw);
 u64 ifcvf_get_features(struct ifcvf_hw *hw);
-u64 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
-int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u64 num);
+u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
+int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num);
 struct ifcvf_adapter *vf_to_adapter(struct ifcvf_hw *hw);
 #endif /* _IFCVF_H_ */
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index abf6a061cab6..09588c67b520 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -143,19 +143,20 @@ static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
 	return IFCVF_QUEUE_MAX;
 }
 
-static u64 ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid)
+static void ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
+				    struct vdpa_vq_state *state)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	return ifcvf_get_vq_state(vf, qid);
+	state->avail_index = ifcvf_get_vq_state(vf, qid);
 }
 
 static int ifcvf_vdpa_set_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
-				   u64 num)
+				   struct vdpa_vq_state *state)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	return ifcvf_set_vq_state(vf, qid, num);
+	return ifcvf_set_vq_state(vf, qid, state->avail_index);
 }
 
 static void ifcvf_vdpa_set_vq_cb(struct vdpa_device *vdpa_dev, u16 qid,
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index bd9686726dcd..a25d4b6abfcd 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -413,26 +413,28 @@ static bool vdpasim_get_vq_ready(struct vdpa_device *vdpa, u16 idx)
 	return vq->ready;
 }
 
-static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx, u64 state)
+static int vdpasim_set_vq_state(struct vdpa_device *vdpa, u16 idx,
+				struct vdpa_vq_state *state)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	struct vringh *vrh = &vq->vring;
 
 	spin_lock(&vdpasim->lock);
-	vrh->last_avail_idx = state;
+	vrh->last_avail_idx = state->avail_index;
 	spin_unlock(&vdpasim->lock);
 
 	return 0;
 }
 
-static u64 vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx)
+static void vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx,
+				 struct vdpa_vq_state *state)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 	struct vringh *vrh = &vq->vring;
 
-	return vrh->last_avail_idx;
+	state->avail_index = vrh->last_avail_idx;
 }
 
 static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 55c2575ffadf..9cd9d4617a8d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -294,6 +294,7 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 {
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
+	struct vdpa_vq_state vq_state;
 	struct vdpa_callback cb;
 	struct vhost_virtqueue *vq;
 	struct vhost_vring_state s;
@@ -317,8 +318,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		return 0;
 	}
 
-	if (cmd == VHOST_GET_VRING_BASE)
-		vq->last_avail_idx = ops->get_vq_state(v->vdpa, idx);
+	if (cmd == VHOST_GET_VRING_BASE) {
+		ops->get_vq_state(v->vdpa, idx, &vq_state);
+		vq->last_avail_idx = vq_state.avail_index;
+	}
 
 	r = vhost_vring_ioctl(&v->vdev, cmd, argp);
 	if (r)
@@ -334,7 +337,8 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 		break;
 
 	case VHOST_SET_VRING_BASE:
-		if (ops->set_vq_state(vdpa, idx, vq->last_avail_idx))
+		vq_state.avail_index = vq->last_avail_idx;
+		if (ops->set_vq_state(vdpa, idx, &vq_state))
 			r = -EINVAL;
 		break;
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 5453af87a33e..9253477e6e38 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -17,6 +17,14 @@ struct vdpa_callback {
 	void *private;
 };
 
+/**
+ * vDPA vq_state definition
+ * @avail_index: available index
+ */
+struct vdpa_vq_state {
+	u16	avail_index;
+};
+
 /**
  * vDPA device - representation of a vDPA device
  * @dev: underlying device
@@ -67,12 +75,12 @@ struct vdpa_device {
  * @set_vq_state:		Set the state for a virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
- *				@state: virtqueue state (last_avail_idx)
+ *				@state: pointer to set virtqueue state (last_avail_idx)
  *				Returns integer: success (0) or error (< 0)
  * @get_vq_state:		Get the state for a virtqueue
  *				@vdev: vdpa device
  *				@idx: virtqueue index
- *				Returns virtqueue state (last_avail_idx)
+ *				@state: pointer to returned state (last_avail_idx)
  * @get_vq_align:		Get the virtqueue align requirement
  *				for the device
  *				@vdev: vdpa device
@@ -160,8 +168,10 @@ struct vdpa_config_ops {
 			  struct vdpa_callback *cb);
 	void (*set_vq_ready)(struct vdpa_device *vdev, u16 idx, bool ready);
 	bool (*get_vq_ready)(struct vdpa_device *vdev, u16 idx);
-	int (*set_vq_state)(struct vdpa_device *vdev, u16 idx, u64 state);
-	u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
+	int (*set_vq_state)(struct vdpa_device *vdev, u16 idx,
+			    struct vdpa_vq_state *state);
+	void (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
+			     struct vdpa_vq_state *state);
 
 	/* Device ops */
 	u32 (*get_vq_align)(struct vdpa_device *vdev);
-- 
2.26.0
