From: Tiwei Bie <tiwei.bie@intel.com>
Subject: [RFC] vhost_mdev: add network control vq support
Date: Tue, 29 Oct 2019 18:17:26 +0800
Message-ID: <20191029101726.12699-1-tiwei.bie__45086.5690408804$1572344235$gmane$org@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, zhihong.wang@intel.com, lingshan.zhu@intel.com
List-Id: virtualization@lists.linuxfoundation.org

This patch adds the network control vq support in vhost-mdev.
A vhost-mdev specific op is introduced to allow parent drivers
to handle the network control commands come from userspace.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
This patch depends on below patch:
https://lkml.org/lkml/2019/10/29/335

 drivers/vhost/mdev.c             | 37 ++++++++++++++++++++++++++++++--
 include/linux/virtio_mdev_ops.h  | 10 +++++++++
 include/uapi/linux/vhost.h       |  7 ++++++
 include/uapi/linux/vhost_types.h |  6 ++++++
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/mdev.c b/drivers/vhost/mdev.c
index 35b2fb33e686..c9b3eaa77405 100644
--- a/drivers/vhost/mdev.c
+++ b/drivers/vhost/mdev.c
@@ -47,6 +47,13 @@ enum {
 		(1ULL << VIRTIO_NET_F_HOST_UFO) |
 		(1ULL << VIRTIO_NET_F_MRG_RXBUF) |
 		(1ULL << VIRTIO_NET_F_STATUS) |
+		(1ULL << VIRTIO_NET_F_CTRL_GUEST_OFFLOADS) |
+		(1ULL << VIRTIO_NET_F_CTRL_VQ) |
+		(1ULL << VIRTIO_NET_F_CTRL_RX) |
+		(1ULL << VIRTIO_NET_F_CTRL_VLAN) |
+		(1ULL << VIRTIO_NET_F_CTRL_RX_EXTRA) |
+		(1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE) |
+		(1ULL << VIRTIO_NET_F_CTRL_MAC_ADDR) |
 		(1ULL << VIRTIO_NET_F_SPEED_DUPLEX),
 };
 
@@ -362,6 +369,29 @@ static long vhost_mdev_vring_ioctl(struct vhost_mdev *m, unsigned int cmd,
 	return r;
 }
 
+/*
+ * Device specific (e.g. network) ioctls.
+ */
+static long vhost_mdev_dev_ioctl(struct vhost_mdev *m, unsigned int cmd,
+				 void __user *argp)
+{
+	struct mdev_device *mdev = m->mdev;
+	const struct virtio_mdev_device_ops *ops = mdev_get_vhost_ops(mdev);
+
+	switch (m->virtio_id) {
+	case VIRTIO_ID_NET:
+		switch (cmd) {
+		case VHOST_MDEV_NET_CTRL:
+			if (!ops->net.ctrl)
+				return -ENOTSUPP;
+			return ops->net.ctrl(mdev, argp);
+		}
+		break;
+	}
+
+	return -ENOIOCTLCMD;
+}
+
 static int vhost_mdev_open(void *device_data)
 {
 	struct vhost_mdev *m = device_data;
@@ -460,8 +490,11 @@ static long vhost_mdev_unlocked_ioctl(void *device_data,
 		 * VHOST_SET_LOG_FD are not used yet.
 		 */
 		r = vhost_dev_ioctl(&m->dev, cmd, argp);
-		if (r == -ENOIOCTLCMD)
-			r = vhost_mdev_vring_ioctl(m, cmd, argp);
+		if (r == -ENOIOCTLCMD) {
+			r = vhost_mdev_dev_ioctl(m, cmd, argp);
+			if (r == -ENOIOCTLCMD)
+				r = vhost_mdev_vring_ioctl(m, cmd, argp);
+		}
 	}
 
 	mutex_unlock(&m->mutex);
diff --git a/include/linux/virtio_mdev_ops.h b/include/linux/virtio_mdev_ops.h
index d417b41f2845..622861804ebd 100644
--- a/include/linux/virtio_mdev_ops.h
+++ b/include/linux/virtio_mdev_ops.h
@@ -20,6 +20,8 @@ struct virtio_mdev_callback {
 	void *private;
 };
 
+struct vhost_mdev_net_ctrl;
+
 /**
  * struct vfio_mdev_device_ops - Structure to be registered for each
  * mdev device to register the device for virtio/vhost drivers.
@@ -151,6 +153,14 @@ struct virtio_mdev_device_ops {
 
 	/* Mdev device ops */
 	u64 (*get_mdev_features)(struct mdev_device *mdev);
+
+	/* Vhost-mdev (MDEV_CLASS_ID_VHOST) specific ops */
+	union {
+		struct {
+			int (*ctrl)(struct mdev_device *mdev,
+				    struct vhost_mdev_net_ctrl __user *ctrl);
+		} net;
+	};
 };
 
 void mdev_set_virtio_ops(struct mdev_device *mdev,
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 061a2824a1b3..3693b2cba0c4 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -134,4 +134,11 @@
 /* Get the max ring size. */
 #define VHOST_MDEV_GET_VRING_NUM	_IOR(VHOST_VIRTIO, 0x76, __u16)
 
+/* VHOST_MDEV device specific defines */
+
+/* Send virtio-net commands. The commands follow the same definition
+ * of the virtio-net commands defined in virtio-spec.
+ */
+#define VHOST_MDEV_NET_CTRL		_IOW(VHOST_VIRTIO, 0x77, struct vhost_mdev_net_ctrl *)
+
 #endif
diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_types.h
index 7b105d0b2fb9..e76b4d8e35e5 100644
--- a/include/uapi/linux/vhost_types.h
+++ b/include/uapi/linux/vhost_types.h
@@ -127,6 +127,12 @@ struct vhost_mdev_config {
 	__u8 buf[0];
 };
 
+struct vhost_mdev_net_ctrl {
+	__u8 class;
+	__u8 cmd;
+	__u8 cmd_data[0];
+} __attribute__((packed));
+
 /* Feature bits */
 /* Log all write descriptors. Can be changed while device is active. */
 #define VHOST_F_LOG_ALL 26
-- 
2.23.0
