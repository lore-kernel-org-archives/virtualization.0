From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 2/9] nvme-vhost: add basic ioctl handlers
Date: Thu, 19 Nov 2015 16:21:01 -0800
Message-ID: <1447978868-17138-3-git-send-email-mlin@kernel.org>
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
 drivers/nvme/target/core.c  |   1 +
 drivers/nvme/target/vhost.c | 264 +++++++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vhost.h  |  15 +++
 3 files changed, 279 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5c770bf..1bfef66 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -378,6 +378,7 @@ void nvmet_ctrl_put(struct nvmet_ctrl *ctrl)
 {
 	kref_put(&ctrl->ref, nvmet_ctrl_free);
 }
+EXPORT_SYMBOL_GPL(nvmet_ctrl_put);
 
 struct nvmet_subsys *nvmet_find_subsys(char *subsys_name)
 {
diff --git a/drivers/nvme/target/vhost.c b/drivers/nvme/target/vhost.c
index 623af00..fa2e668 100644
--- a/drivers/nvme/target/vhost.c
+++ b/drivers/nvme/target/vhost.c
@@ -1,13 +1,275 @@
 #include <linux/module.h>
+#include <linux/compat.h>
+#include <linux/eventfd.h>
+#include <linux/vhost.h>
+#include <linux/miscdevice.h>
+#include <linux/mutex.h>
+#include <linux/file.h>
+#include "../../vhost/vhost.h"
+#include "nvmet.h"
 
-static int __init nvmet_vhost_init(void)
+struct nvmet_vhost_ctrl_eventfd {
+	struct file *call;
+	struct eventfd_ctx *call_ctx;
+	int __user *irq_enabled;
+	int __user *vector;
+};
+
+struct nvmet_vhost_cq {
+	struct nvmet_cq		cq;
+
+	struct eventfd_ctx	*eventfd;
+};
+
+struct nvmet_vhost_sq {
+	struct nvmet_sq		sq;
+};
+
+struct nvmet_vhost_ctrl {
+	struct vhost_dev dev;
+	struct nvmet_vhost_ctrl_eventfd *eventfd;
+
+	u16 cntlid;
+	struct nvmet_ctrl *ctrl;
+	u32 num_queues;
+
+	struct nvmet_vhost_cq **cqs;
+	struct nvmet_vhost_sq **sqs;
+};
+
+static int
+nvmet_vhost_set_endpoint(struct nvmet_vhost_ctrl *n,
+			struct vhost_nvme_target *c)
 {
+	struct nvmet_subsys *subsys;
+	struct nvmet_ctrl *ctrl;
+	int num_queues;
+	int ret = 0;
+
+	subsys = nvmet_find_subsys(c->vhost_wwpn);
+        if (!subsys) {
+		pr_warn("connect request for invalid subsystem!\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&subsys->lock);
+	ctrl = nvmet_alloc_ctrl(subsys, c->vhost_wwpn);
+	if (IS_ERR(ctrl)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	n->cntlid = ctrl->cntlid;
+	n->ctrl = ctrl;
+	n->num_queues = subsys->max_qid + 1;
+
+	num_queues = ctrl->subsys->max_qid + 1;
+	n->cqs = kzalloc(sizeof(*n->cqs) * num_queues, GFP_KERNEL);
+	if (!n->cqs) {
+		ret = -ENOMEM;
+		goto out_ctrl_put;
+	}
+	n->sqs = kzalloc(sizeof(*n->sqs) * num_queues, GFP_KERNEL);
+	if (!n->sqs) {
+		ret = -ENOMEM;
+		goto free_cqs;
+	}
+
+	n->eventfd = kmalloc(sizeof(struct nvmet_vhost_ctrl_eventfd)
+				* num_queues, GFP_KERNEL);
+	if (!n->eventfd) {
+		ret = -ENOMEM;
+		goto free_sqs;
+	}
+
+	mutex_unlock(&subsys->lock);
 	return 0;
+
+free_sqs:
+	kfree(n->sqs);
+
+free_cqs:
+	kfree(n->cqs);
+
+out_ctrl_put:
+	nvmet_ctrl_put(ctrl);
+
+out_unlock:
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
+static int nvmet_vhost_set_eventfd(struct nvmet_vhost_ctrl *n, void __user *argp)
+{
+	struct nvmet_vhost_eventfd eventfd;
+	int num;
+	int ret;
+
+	ret = copy_from_user(&eventfd, argp, sizeof(struct nvmet_vhost_eventfd));
+	if (unlikely(ret))
+		return ret;
+
+	num = eventfd.num;
+	if (num > n->ctrl->subsys->max_qid)
+		return -EINVAL;
+
+	n->eventfd[num].call = eventfd_fget(eventfd.fd);
+	if (IS_ERR(n->eventfd[num].call))
+		return -EBADF;
+	n->eventfd[num].call_ctx = eventfd_ctx_fileget(n->eventfd[num].call);
+	if (IS_ERR(n->eventfd[num].call_ctx)) {
+		fput(n->eventfd[num].call);
+		return -EBADF;
+	}
+
+	n->eventfd[num].irq_enabled = eventfd.irq_enabled;
+	n->eventfd[num].vector = eventfd.vector;
+
+	return 0;
+}
+
+static int nvmet_vhost_open(struct inode *inode, struct file *f)
+{
+	struct nvmet_vhost_ctrl *n = kzalloc(sizeof(*n), GFP_KERNEL);
+
+	if (!n)
+		return -ENOMEM;
+
+	/* We don't use virtqueue */
+	vhost_dev_init(&n->dev, NULL, 0);
+	f->private_data = n;
+
+	return 0;
+}
+
+static void nvme_free_sq(struct nvmet_vhost_sq *sq,
+		struct nvmet_vhost_ctrl *n)
+{
+	n->sqs[sq->sq.qid] = NULL;
+	if (sq->sq.qid)
+		kfree(sq);
+}
+
+static void nvme_free_cq(struct nvmet_vhost_cq *cq,
+		struct nvmet_vhost_ctrl *n)
+{
+	n->cqs[cq->cq.qid] = NULL;
+	if (cq->cq.qid)
+		kfree(cq);
+}
+
+static void nvmet_vhost_clear_ctrl(struct nvmet_vhost_ctrl *n)
+{
+	int i;
+
+	for (i = 0; i < n->num_queues; i++) {
+		if (n->sqs[i] != NULL)
+			nvme_free_sq(n->sqs[i], n);
+	}
+	for (i = 0; i < n->num_queues; i++) {
+		if (n->cqs[i] != NULL)
+			nvme_free_cq(n->cqs[i], n);
+	}
+
+	kfree(n->eventfd);
+	kfree(n->cqs);
+	kfree(n->sqs);
+	nvmet_ctrl_put(n->ctrl);
+}
+
+static void nvmet_vhost_clear_eventfd(struct nvmet_vhost_ctrl *n)
+{
+	int i;
+
+	for (i = 0; i < n->num_queues; i++) {
+		if (n->eventfd[i].call_ctx) {
+			eventfd_ctx_put(n->eventfd[i].call_ctx);
+			fput(n->eventfd[i].call);
+		}
+	}
+}
+
+static int nvmet_vhost_release(struct inode *inode, struct file *f)
+{
+	struct nvmet_vhost_ctrl *n = f->private_data;
+
+	nvmet_vhost_clear_eventfd(n);
+	nvmet_vhost_clear_ctrl(n);
+
+	vhost_dev_stop(&n->dev);
+	vhost_dev_cleanup(&n->dev, false);
+
+	kfree(n);
+	return 0;
+}
+
+static long nvmet_vhost_ioctl(struct file *f, unsigned int ioctl,
+			     unsigned long arg)
+{
+	struct nvmet_vhost_ctrl *n = f->private_data;
+	void __user *argp = (void __user *)arg;
+	u64 __user *featurep = argp;
+	u64 features;
+	int r;
+
+	switch (ioctl) {
+	case VHOST_NVME_SET_ENDPOINT:
+	{
+		struct vhost_nvme_target conf;
+		if (copy_from_user(&conf, argp, sizeof(conf)))
+			return -EFAULT;
+
+		return nvmet_vhost_set_endpoint(n, &conf);
+	}
+	case VHOST_NVME_SET_EVENTFD:
+		r = nvmet_vhost_set_eventfd(n, argp);
+		return r;
+	case VHOST_GET_FEATURES:
+		features = VHOST_FEATURES;
+		if (copy_to_user(featurep, &features, sizeof(features)))
+			return -EFAULT;
+		return 0;
+	default:
+		mutex_lock(&n->dev.mutex);
+		r = vhost_dev_ioctl(&n->dev, ioctl, argp);
+		mutex_unlock(&n->dev.mutex);
+		return r;
+	}
+}
+
+#ifdef CONFIG_COMPAT
+static long nvmet_vhost_compat_ioctl(struct file *f, unsigned int ioctl,
+				   unsigned long arg)
+{
+	return nvmet_vhost_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
+}
+#endif
+
+static const struct file_operations nvmet_vhost_fops = {
+	.owner          = THIS_MODULE,
+	.release        = nvmet_vhost_release,
+	.unlocked_ioctl = nvmet_vhost_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl   = nvmet_vhost_compat_ioctl,
+#endif
+	.open           = nvmet_vhost_open,
+	.llseek		= noop_llseek,
+};
+
+static struct miscdevice nvmet_vhost_misc = {
+	MISC_DYNAMIC_MINOR,
+	"vhost-nvme",
+	&nvmet_vhost_fops,
+};
+
+static int __init nvmet_vhost_init(void)
+{
+	return misc_register(&nvmet_vhost_misc);
 }
 module_init(nvmet_vhost_init);
 
 static void nvmet_vhost_exit(void)
 {
+	misc_deregister(&nvmet_vhost_misc);
 }
 module_exit(nvmet_vhost_exit);
 
diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index ab373191..ae4b619 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -169,4 +169,19 @@ struct vhost_scsi_target {
 #define VHOST_SCSI_SET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x43, __u32)
 #define VHOST_SCSI_GET_EVENTS_MISSED _IOW(VHOST_VIRTIO, 0x44, __u32)
 
+struct vhost_nvme_target {
+	char vhost_wwpn[224]; /* TRANSPORT_IQN_LEN */
+};
+
+struct nvmet_vhost_eventfd {
+	int num;
+	int fd;
+	int *irq_enabled;
+	int *vector;
+};
+
+#define VHOST_NVME_SET_ENDPOINT _IOW(VHOST_VIRTIO, 0x47, struct vhost_nvme_target)
+#define VHOST_NVME_CLEAR_ENDPOINT _IOW(VHOST_VIRTIO, 0x48, struct vhost_nvme_target)
+#define VHOST_NVME_SET_EVENTFD _IOW(VHOST_VIRTIO, 0x45, struct nvmet_vhost_eventfd)
+
 #endif
-- 
1.9.1
