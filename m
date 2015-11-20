From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 3/9] nvme-vhost: add basic nvme bar read/write
Date: Thu, 19 Nov 2015 16:21:02 -0800
Message-ID: <1447978868-17138-4-git-send-email-mlin@kernel.org>
References: <1447978868-17138-1-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447978868-17138-1-git-send-email-mlin@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-nvme@lists.infradead.org
Cc: Ming Lin <ming.l@ssi.samsung.com>, Christoph Hellwig <hch@lst.de>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Ming Lin <ming.l@ssi.samsung.com>

Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
---
 drivers/nvme/target/vhost.c | 102 ++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h  |  17 ++++++--
 2 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/vhost.c b/drivers/nvme/target/vhost.c
index fa2e668..01c44b8 100644
--- a/drivers/nvme/target/vhost.c
+++ b/drivers/nvme/target/vhost.c
@@ -8,6 +8,8 @@
 #include "../../vhost/vhost.h"
 #include "nvmet.h"
 
+#define NVMET_VHOST_AQ_DEPTH		256
+
 struct nvmet_vhost_ctrl_eventfd {
 	struct file *call;
 	struct eventfd_ctx *call_ctx;
@@ -35,6 +37,10 @@ struct nvmet_vhost_ctrl {
 
 	struct nvmet_vhost_cq **cqs;
 	struct nvmet_vhost_sq **sqs;
+
+	u32 aqa;
+	u64 asq;
+	u64 acq;
 };
 
 static int
@@ -127,6 +133,100 @@ static int nvmet_vhost_set_eventfd(struct nvmet_vhost_ctrl *n, void __user *argp
 	return 0;
 }
 
+static int nvmet_vhost_bar_read(struct nvmet_ctrl *ctrl, int offset, u64 *val)
+{
+	int status = NVME_SC_SUCCESS;
+
+	switch(offset) {
+	case NVME_REG_CAP:
+		*val = ctrl->cap;
+		break;
+	case NVME_REG_CAP+4:
+		*val = ctrl->cap >> 32;
+	case NVME_REG_VS:
+		*val = ctrl->subsys->ver;
+		break;
+	case NVME_REG_CC:
+		*val = ctrl->cc;
+		break;
+	case NVME_REG_CSTS:
+		*val = ctrl->csts;
+		break;
+	case NVME_REG_AQA:
+		*val = (NVMET_VHOST_AQ_DEPTH - 1) |
+		      (((NVMET_VHOST_AQ_DEPTH - 1) << 16));
+		break;
+	default:
+		printk("Unknown offset: 0x%x\n", offset);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		break;
+	}
+
+	return status;
+}
+
+static int nvmet_bar_write(struct nvmet_vhost_ctrl *n, int offset, u64 val)
+{
+	struct nvmet_ctrl *ctrl = n->ctrl;
+	int status = NVME_SC_SUCCESS;
+
+	switch(offset) {
+	case NVME_REG_CC:
+		nvmet_update_cc(ctrl, val);
+		break;
+	case NVME_REG_AQA:
+		n->aqa = val & 0xffffffff;
+		break;
+	case NVME_REG_ASQ:
+		n->asq = val;
+		break;
+	case NVME_REG_ASQ + 4:
+		n->asq |= val << 32;
+		break;
+	case NVME_REG_ACQ:
+		n->acq = val;
+		break;
+	case NVME_REG_ACQ + 4:
+		n->acq |= val << 32;
+		break;
+	default:
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		break;
+	}
+
+	return status;
+}
+
+static int nvmet_vhost_bar_write(struct nvmet_vhost_ctrl *n, int offset, u64 val)
+{
+	if (offset < 0x1000)
+		return nvmet_bar_write(n, offset, val);
+
+	return -1;
+}
+
+static int nvmet_vhost_ioc_bar(struct nvmet_vhost_ctrl *n, void __user *argp)
+{
+	struct nvmet_vhost_bar bar;
+	struct nvmet_vhost_bar __user *user_bar = argp;
+	int ret = -EINVAL;
+
+	ret = copy_from_user(&bar, argp, sizeof(bar));
+	if (unlikely(ret))
+		return ret;
+
+	if (bar.type == VHOST_NVME_BAR_READ) {
+		u64 val;
+		ret = nvmet_vhost_bar_read(n->ctrl, bar.offset, &val);
+		if (ret != NVME_SC_SUCCESS)
+			return ret;
+		ret = copy_to_user(&user_bar->val, &val, sizeof(u64));
+	} else if (bar.type == VHOST_NVME_BAR_WRITE)
+		ret = nvmet_vhost_bar_write(n, bar.offset, bar.val);
+
+	return ret;
+}
+
 static int nvmet_vhost_open(struct inode *inode, struct file *f)
 {
 	struct nvmet_vhost_ctrl *n = kzalloc(sizeof(*n), GFP_KERNEL);
@@ -223,6 +323,8 @@ static long nvmet_vhost_ioctl(struct file *f, unsigned int ioctl,
 	case VHOST_NVME_SET_EVENTFD:
 		r = nvmet_vhost_set_eventfd(n, argp);
 		return r;
+	case VHOST_NVME_BAR:
+		return nvmet_vhost_ioc_bar(n, argp);
 	case VHOST_GET_FEATURES:
 		features = VHOST_FEATURES;
 		if (copy_to_user(featurep, &features, sizeof(features)))
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index ae4b619..a0cefcc 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -180,8 +180,19 @@ struct nvmet_vhost_eventfd {
 	int *vector;
 };
 
-#define VHOST_NVME_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x47, struct vhost_nvme_target)
-#define VHOST_NVME_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x48, struct vhost_nvme_target)
-#define VHOST_NVME_SET_EVENTFD _IOW(VHOST_VIRTIO, 0x45, struct nvmet_vhost_eventfd)
+#define VHOST_NVME_BAR_READ 0
+#define VHOST_NVME_BAR_WRITE 1
+
+struct nvmet_vhost_bar {
+	int type; /* read/write */
+	u64 offset;
+	unsigned size;
+	u64 val;
+};
+
+#define VHOST_NVME_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x45, struct vhost_nvme_target)
+#define VHOST_NVME_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x46, struct vhost_nvme_target)
+#define VHOST_NVME_SET_EVENTFD _IOW(VHOST_VIRTIO, 0x47, struct nvmet_vhost_eventfd)
+#define VHOST_NVME_BAR _IOW(VHOST_VIRTIO, 0x48, struct nvmet_vhost_bar)
 
 #endif
-- 
1.9.1
