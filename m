From: Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH V4 1/3] vdpa: Support config interrupt in vhost_vdpa
Date: Sun, 26 Apr 2020 19:43:24 +0800
Message-ID: <1587901406-27400-2-git-send-email-lingshan.zhu@intel.com>
References: <1587901406-27400-1-git-send-email-lingshan.zhu@intel.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1587901406-27400-1-git-send-email-lingshan.zhu@intel.com>
Sender: netdev-owner@vger.kernel.org
To: mst@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jasowang@redhat.com
Cc: lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com, Zhu Lingshan <lingshan.zhu@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This commit implements config interrupt support in
vhost_vdpa layer.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vhost/vdpa.c       | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h |  4 ++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 421f02a..c370ec5 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -21,6 +21,7 @@
 #include <linux/nospec.h>
 #include <linux/vhost.h>
 #include <linux/virtio_net.h>
+#include <linux/kernel.h>
 
 #include "vhost.h"
 
@@ -70,6 +71,7 @@ struct vhost_vdpa {
 	int nvqs;
 	int virtio_id;
 	int minor;
+	struct eventfd_ctx *config_ctx;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -101,6 +103,17 @@ static irqreturn_t vhost_vdpa_virtqueue_cb(void *private)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t vhost_vdpa_config_cb(void *private)
+{
+	struct vhost_vdpa *v = private;
+	struct eventfd_ctx *config_ctx = v->config_ctx;
+
+	if (config_ctx)
+		eventfd_signal(config_ctx, 1);
+
+	return IRQ_HANDLED;
+}
+
 static void vhost_vdpa_reset(struct vhost_vdpa *v)
 {
 	struct vdpa_device *vdpa = v->vdpa;
@@ -288,6 +301,36 @@ static long vhost_vdpa_get_vring_num(struct vhost_vdpa *v, u16 __user *argp)
 	return 0;
 }
 
+static void vhost_vdpa_config_put(struct vhost_vdpa *v)
+{
+	if (v->config_ctx)
+		eventfd_ctx_put(v->config_ctx);
+}
+
+static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
+{
+	struct vdpa_callback cb;
+	int fd;
+	struct eventfd_ctx *ctx;
+
+	cb.callback = vhost_vdpa_config_cb;
+	cb.private = v->vdpa;
+	if (copy_from_user(&fd, argp, sizeof(fd)))
+		return  -EFAULT;
+
+	ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
+	swap(ctx, v->config_ctx);
+
+	if (!IS_ERR_OR_NULL(ctx))
+		eventfd_ctx_put(ctx);
+
+	if (IS_ERR(v->config_ctx))
+		return PTR_ERR(v->config_ctx);
+
+	v->vdpa->config->set_config_cb(v->vdpa, &cb);
+
+	return 0;
+}
 static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
 				   void __user *argp)
 {
@@ -398,6 +441,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
 	case VHOST_SET_LOG_FD:
 		r = -ENOIOCTLCMD;
 		break;
+	case VHOST_VDPA_SET_CONFIG_CALL:
+		r = vhost_vdpa_set_config_call(v, argp);
+		break;
 	default:
 		r = vhost_dev_ioctl(&v->vdev, cmd, argp);
 		if (r == -ENOIOCTLCMD)
@@ -734,6 +780,7 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 	vhost_dev_stop(&v->vdev);
 	vhost_vdpa_iotlb_free(v);
 	vhost_vdpa_free_domain(v);
+	vhost_vdpa_config_put(v);
 	vhost_dev_cleanup(&v->vdev);
 	kfree(v->vdev.vqs);
 	mutex_unlock(&d->mutex);
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index 9fe72e4..0c23496 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -15,6 +15,8 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+#define VHOST_FILE_UNBIND -1
+
 /* ioctls */
 
 #define VHOST_VIRTIO 0xAF
@@ -140,4 +142,6 @@
 /* Get the max ring size. */
 #define VHOST_VDPA_GET_VRING_NUM	_IOR(VHOST_VIRTIO, 0x76, __u16)
 
+/* Set event fd for config interrupt*/
+#define VHOST_VDPA_SET_CONFIG_CALL	_IOW(VHOST_VIRTIO, 0x77, int)
 #endif
-- 
1.8.3.1
