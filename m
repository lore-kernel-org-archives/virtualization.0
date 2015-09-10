From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 1/2] virtio_nvme(kernel): virtual NVMe driver using virtio
Date: Wed,  9 Sep 2015 22:48:31 -0700
Message-ID: <1441864112-12765-2-git-send-email-mlin@kernel.org>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1441864112-12765-1-git-send-email-mlin@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org
Cc: Ming Lin <mlin@kernel.org>, Ming Lin <ming.l@ssi.samsung.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
---
 drivers/block/Kconfig            |   7 +
 drivers/block/Makefile           |   1 +
 drivers/block/nvme-core.c        |   1 +
 drivers/block/virtio_nvme.c      | 853 +++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_nvme.h      |  53 +++
 include/uapi/linux/virtio_ids.h  |   1 +
 include/uapi/linux/virtio_nvme.h |  30 ++
 7 files changed, 946 insertions(+)
 create mode 100644 drivers/block/virtio_nvme.c
 create mode 100644 include/linux/virtio_nvme.h
 create mode 100644 include/uapi/linux/virtio_nvme.h

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 1b8094d..7149885 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -519,6 +519,13 @@ config VIRTIO_BLK
 	  This is the virtual block driver for virtio.  It can be used with
           lguest or QEMU based VMMs (like KVM or Xen).  Say Y or M.
 
+config VIRTIO_NVME
+	tristate "Virtio NVMe driver"
+	depends on VIRTIO
+	---help---
+	  This is the virtual NVMe driver for virtio.  It can be used with
+          lguest or QEMU based VMMs (like KVM or Xen).  Say Y or M.
+
 config BLK_DEV_HD
 	bool "Very old hard disk (MFM/RLL/IDE) driver"
 	depends on HAVE_IDE
diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index 02b688d..3b73f59 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_BLK_DEV_UMEM)	+= umem.o
 obj-$(CONFIG_BLK_DEV_NBD)	+= nbd.o
 obj-$(CONFIG_BLK_DEV_CRYPTOLOOP) += cryptoloop.o
 obj-$(CONFIG_VIRTIO_BLK)	+= virtio_blk.o
+obj-$(CONFIG_VIRTIO_NVME)	+= virtio_nvme.o
 
 obj-$(CONFIG_BLK_DEV_SX8)	+= sx8.o
 obj-$(CONFIG_BLK_DEV_HD)	+= hd.o
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..7895606 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1059,6 +1059,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 {
 	return __nvme_submit_sync_cmd(q, cmd, buffer, NULL, bufflen, NULL, 0);
 }
+EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
 static int nvme_submit_async_admin_req(struct nvme_dev *dev)
 {
diff --git a/drivers/block/virtio_nvme.c b/drivers/block/virtio_nvme.c
new file mode 100644
index 0000000..57f81fc
--- /dev/null
+++ b/drivers/block/virtio_nvme.c
@@ -0,0 +1,853 @@
+/* Modified from virtio_blk.c and nvme-core.c */
+
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/virtio.h>
+#include <linux/virtio_nvme.h>
+#include <linux/scatterlist.h>
+#include <linux/string_helpers.h>
+#include <linux/idr.h>
+#include <linux/blk-mq.h>
+#include <linux/numa.h>
+#include <linux/virtio_nvme.h>
+#include <linux/nvme.h>
+#include <linux/blk-mq.h>
+
+#define ADMIN_TIMEOUT           (2 * HZ)
+#define NVME_AQ_DEPTH		256
+
+static int virtnvme_major;
+module_param(virtnvme_major, int, 0);
+
+static unsigned int virtnvme_queue_depth;
+module_param_named(queue_depth, virtnvme_queue_depth, uint, 0444);
+
+static DEFINE_SPINLOCK(dev_list_lock);
+static LIST_HEAD(dev_list);
+
+static void virtnvme_free_namespaces(struct virtio_nvme_dev *dev);
+
+static const struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_NVME, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+struct virtnvme_req
+{
+	struct request *req;
+	struct nvme_command cmd;
+	struct virtio_nvme_resp resp;
+	struct scatterlist sg[];
+};
+
+static int virtnvme_identify_ctrl(struct virtio_nvme_dev *dev, struct nvme_id_ctrl **id)
+{
+	struct nvme_command c = { };
+	int error;
+
+	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.cns = cpu_to_le32(1);
+
+	*id = kmalloc(sizeof(struct nvme_id_ctrl), GFP_KERNEL);
+	if (!*id)
+		return -ENOMEM;
+
+	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
+			sizeof(struct nvme_id_ctrl));
+	if (error)
+		kfree(*id);
+	return error;
+}
+
+static int virtnvme_identify_ns(struct virtio_nvme_dev *dev, unsigned nsid,
+		struct nvme_id_ns **id)
+{
+	struct nvme_command c = { };
+	int error;
+
+	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
+	c.identify.opcode = nvme_admin_identify,
+	c.identify.nsid = cpu_to_le32(nsid),
+
+	*id = kmalloc(sizeof(struct nvme_id_ns), GFP_KERNEL);
+	if (!*id)
+		return -ENOMEM;
+
+	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
+			sizeof(struct nvme_id_ns));
+	if (error)
+		kfree(*id);
+	return error;
+}
+
+static int virtnvme_wait_ready(struct virtio_nvme_dev *dev, u64 cap)
+{
+	struct virtio_device *vdev = dev->vdev;
+	unsigned long timeout;
+	u32 csts;
+
+	timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+
+	while (1) {
+		virtio_cread(vdev, struct virtio_nvme_config, csts, &csts);
+		if ((csts & NVME_CSTS_RDY) == NVME_CSTS_RDY)
+			break;
+
+		msleep(100);
+		if (fatal_signal_pending(current))
+			return -EINTR;
+		if (time_after(jiffies, timeout)) {
+			printk("Device not ready; aborting initialisation\n");
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
+static void virtnvme_admin_done(struct virtqueue *vq)
+{
+	struct virtio_nvme_dev *dev = vq->vdev->priv;
+	struct virtnvme_req *vnr;
+	int qid = vq->index;
+	unsigned long flags;
+	unsigned int len;
+
+	spin_lock_irqsave(&dev->vqs[qid].lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((vnr = virtqueue_get_buf(dev->vqs[qid].vq, &len)) != NULL)
+			blk_mq_complete_request(vnr->req);
+		if (unlikely(virtqueue_is_broken(vq)))
+			break;
+	} while (!virtqueue_enable_cb(vq));
+
+	spin_unlock_irqrestore(&dev->vqs[qid].lock, flags);
+}
+
+static void virtnvme_io_done(struct virtqueue *vq)
+{
+	struct virtio_nvme_dev *dev = vq->vdev->priv;
+	int qid = vq->index;
+	struct virtnvme_req *vnr;
+	unsigned long flags;
+	unsigned int len;
+	bool bio_done = false;
+
+	spin_lock_irqsave(&dev->vqs[qid].lock, flags);
+	do {
+		virtqueue_disable_cb(vq);
+		while ((vnr = virtqueue_get_buf(dev->vqs[qid].vq, &len)) != NULL) {
+			blk_mq_complete_request(vnr->req);
+			bio_done = true;
+		}
+
+		if (unlikely(virtqueue_is_broken(vq)))
+			break;
+	} while (!virtqueue_enable_cb(vq));
+
+	spin_unlock_irqrestore(&dev->vqs[qid].lock, flags);
+
+	if (bio_done)
+		wake_up(&dev->queue_wait);
+}
+
+static int virtnvme_init_vq(struct virtio_nvme_dev *dev)
+{
+	int err = 0;
+	int i;
+	vq_callback_t **callbacks;
+	const char **names;
+	struct virtqueue **vqs;
+	unsigned num_vqs;
+	struct virtio_device *vdev = dev->vdev;
+
+	err = virtio_cread_feature(vdev, VIRTIO_NVME_F_MQ,
+				   struct virtio_nvme_config, num_queues,
+				   &num_vqs);
+	if (err)
+		num_vqs = 1;
+
+	num_vqs++;
+
+	dev->vqs = kmalloc(sizeof(*dev->vqs) * num_vqs, GFP_KERNEL);
+	if (!dev->vqs) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	names = kmalloc(sizeof(*names) * num_vqs, GFP_KERNEL);
+	if (!names)
+		goto err_names;
+
+	callbacks = kmalloc(sizeof(*callbacks) * num_vqs, GFP_KERNEL);
+	if (!callbacks)
+		goto err_callbacks;
+
+	vqs = kmalloc(sizeof(*vqs) * num_vqs, GFP_KERNEL);
+	if (!vqs)
+		goto err_vqs;
+
+	callbacks[0] = virtnvme_admin_done;
+	names[0] = "admin";
+	dev->vqs[0].dev = dev;
+
+	for (i = 1; i < num_vqs; i++) {
+		callbacks[i] = virtnvme_io_done;
+		snprintf(dev->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
+		names[i] = dev->vqs[i].name;
+		dev->vqs[i].dev = dev;
+	}
+
+	/* Discover virtqueues and write information to configuration.  */
+	err = vdev->config->find_vqs(vdev, num_vqs, vqs, callbacks, names);
+	if (err)
+		goto err_find_vqs;
+
+	for (i = 0; i < num_vqs; i++) {
+		spin_lock_init(&dev->vqs[i].lock);
+		dev->vqs[i].vq = vqs[i];
+	}
+	dev->num_vqs = num_vqs;
+
+err_find_vqs:
+	kfree(vqs);
+err_vqs:
+	kfree(callbacks);
+err_callbacks:
+	kfree(names);
+err_names:
+	if (err)
+		kfree(dev->vqs);
+out:
+	return err;
+}
+
+static inline struct virtnvme_req *virtnvme_alloc_req(struct virtio_nvme_dev *dev,
+		gfp_t gfp_mask)
+{
+	struct virtnvme_req *vnr;
+
+	vnr = kmalloc(sizeof(*vnr) + dev->sg_elems*sizeof(struct scatterlist),
+			gfp_mask);
+	if (!vnr)
+		return NULL;
+
+	sg_init_table(vnr->sg, dev->sg_elems);
+
+	return vnr;
+}
+
+static inline u64 virtnvme_block_nr(struct virtio_nvme_ns *ns, sector_t sector)
+{
+        return (sector >> (ns->lba_shift - 9));
+}
+
+static int virtnvme_add_req(struct virtio_nvme_ns *ns, struct virtqueue *vq,
+			     struct virtnvme_req *vnr,
+			     struct scatterlist *data_sg,
+			     bool have_data)
+{
+	struct scatterlist cmd, resp, *sgs[5];
+	unsigned int num_out = 0, num_in = 0;
+
+	sg_init_one(&cmd, vnr->req->cmd, sizeof(struct nvme_command));
+	sgs[num_out++] = &cmd;
+
+	if (have_data) {
+		if (rq_data_dir(vnr->req))
+			sgs[num_out++] = data_sg;
+		else
+			sgs[num_out + num_in++] = data_sg;
+	}
+
+	sg_init_one(&resp, &vnr->resp, sizeof(struct virtio_nvme_resp));
+	sgs[num_out + num_in++] = &resp;
+
+	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vnr, GFP_ATOMIC);
+}
+
+static int virtnvme_setup_io(struct virtnvme_req *vnr, struct virtio_nvme_ns *ns)
+{
+	struct nvme_command *cmnd;
+	struct request *req = vnr->req;
+	u16 control = 0;
+	u32 dsmgmt = 0;
+
+#if 0 /* TODO */
+	if (req->cmd_flags & REQ_FUA)
+		control |= NVME_RW_FUA;
+	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
+		control |= NVME_RW_LR;
+
+	if (req->cmd_flags & REQ_RAHEAD)
+		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
+#endif
+
+	cmnd = &vnr->cmd;
+	req->cmd = (unsigned char *)cmnd;
+	req->cmd_len = sizeof(struct nvme_command);
+	memset(cmnd, 0, sizeof(*cmnd));
+
+	cmnd->rw.opcode = (rq_data_dir(req) ? nvme_cmd_write : nvme_cmd_read);
+	cmnd->rw.command_id = req->tag;
+	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->rw.slba = cpu_to_le64(virtnvme_block_nr(ns, blk_rq_pos(req)));
+	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	cmnd->rw.control = cpu_to_le16(control);
+	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
+
+	return 0;
+}
+
+static int virtnvme_queue_rq(struct blk_mq_hw_ctx *hctx,
+		const struct blk_mq_queue_data *bd)
+{
+	struct virtio_nvme_ns *ns = hctx->queue->queuedata;
+	struct virtio_nvme_queue *nvmeq = hctx->driver_data;
+	struct request *req = bd->rq;
+	struct virtnvme_req *vnr = blk_mq_rq_to_pdu(req);
+	unsigned long flags;
+	unsigned int num;
+	int err;
+	bool notify = false;
+
+	vnr->req = req;
+
+	if (req->cmd_type == REQ_TYPE_DRV_PRIV)
+		; /* TODO: nvme_submit_priv(nvmeq, req, iod) */
+	else if (req->cmd_flags & REQ_DISCARD)
+		; /* TODO: nvme_submit_discard(nvmeq, ns, req, iod) */
+	else if (req->cmd_flags & REQ_FLUSH)
+		; /* TODO: nvme_submit_flush(nvmeq, ns, req->tag) */
+	else
+		virtnvme_setup_io(vnr, ns);
+
+	blk_mq_start_request(req);
+
+	num = blk_rq_map_sg(hctx->queue, vnr->req, vnr->sg);
+
+	spin_lock_irqsave(&nvmeq->lock, flags);
+	err = virtnvme_add_req(ns, nvmeq->vq, vnr, vnr->sg, num);
+	if (err) {
+		virtqueue_kick(nvmeq->vq);
+		blk_mq_stop_hw_queue(hctx);
+		spin_unlock_irqrestore(&nvmeq->lock, flags);
+		if (err == -ENOMEM || err == -ENOSPC)
+			return BLK_MQ_RQ_QUEUE_BUSY;
+		return BLK_MQ_RQ_QUEUE_ERROR;
+	}
+
+	if (bd->last && virtqueue_kick_prepare(nvmeq->vq))
+		notify = true;
+	spin_unlock_irqrestore(&nvmeq->lock, flags);
+
+	if (notify)
+		virtqueue_notify(nvmeq->vq);
+	return BLK_MQ_RQ_QUEUE_OK;
+}
+
+static inline void virtnvme_request_done(struct request *req)
+{
+	struct virtnvme_req *vnr = blk_mq_rq_to_pdu(req);
+	int error = vnr->resp.status;
+
+#if 0 /* TODO */
+	if (req->cmd_type == REQ_TYPE_BLOCK_PC) {
+		req->resid_len = virtio32_to_cpu(dev->vdev, vbr->in_hdr.residual);
+		req->sense_len = virtio32_to_cpu(dev->vdev, vbr->in_hdr.sense_len);
+		req->errors = virtio32_to_cpu(dev->vdev, vbr->in_hdr.errors);
+	} else if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
+		req->errors = (error != 0);
+	}
+#endif
+
+	blk_mq_end_request(req, error);
+}
+
+static int virtnvme_init_request(void *data, struct request *rq,
+		unsigned int hctx_idx, unsigned int request_idx,
+		unsigned int numa_node)
+{
+	struct virtio_nvme_dev *dev = data;
+	struct virtnvme_req *vnr = blk_mq_rq_to_pdu(rq);
+
+	sg_init_table(vnr->sg, dev->sg_elems);
+	return 0;
+}
+
+static int virtnvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+				unsigned int hctx_idx)
+{
+	struct virtio_nvme_dev *dev = data;
+	struct virtio_nvme_queue *nvmeq = &dev->vqs[0];
+
+	hctx->driver_data = nvmeq;
+	return 0;
+}
+
+static int virtnvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
+				unsigned int hctx_idx)
+{
+	struct virtio_nvme_dev *dev = data;
+	struct virtio_nvme_queue *nvmeq = &dev->vqs[hctx_idx+1];
+
+	hctx->driver_data = nvmeq;
+	return 0;
+}
+
+static struct blk_mq_ops virtio_nvme_mq_admin_ops = {
+	.queue_rq	= virtnvme_queue_rq,
+	.map_queue	= blk_mq_map_queue,
+	.init_hctx	= virtnvme_admin_init_hctx,
+	.complete	= virtnvme_request_done,
+	.init_request	= virtnvme_init_request,
+};
+
+static struct blk_mq_ops virtio_nvme_mq_ops = {
+	.queue_rq	= virtnvme_queue_rq,
+	.map_queue	= blk_mq_map_queue,
+	.init_hctx	= virtnvme_init_hctx,
+	.complete	= virtnvme_request_done,
+	.init_request	= virtnvme_init_request,
+};
+
+static int virtnvme_open(struct block_device *bdev, fmode_t mode)
+{
+	struct virtio_nvme_ns *ns = bdev->bd_disk->private_data;
+	struct virtio_nvme_dev *dev = ns->dev;
+
+	kref_get(&dev->kref);
+	return 0;
+}
+
+static DEFINE_IDA(nvme_instance_ida);
+
+static int nvme_set_instance(struct virtio_nvme_dev *dev)
+{
+	int instance, error;
+
+	do {
+		if (!ida_pre_get(&nvme_instance_ida, GFP_KERNEL))
+			return -ENODEV;
+
+		spin_lock(&dev_list_lock);
+		error = ida_get_new(&nvme_instance_ida, &instance);
+		spin_unlock(&dev_list_lock);
+	} while (error == -EAGAIN);
+
+	if (error)
+		return -ENODEV;
+
+	dev->instance = instance;
+	return 0;
+}
+
+static void virtnvme_release_instance(struct virtio_nvme_dev *dev)
+{
+	spin_lock(&dev_list_lock);
+	ida_remove(&nvme_instance_ida, dev->instance);
+	spin_unlock(&dev_list_lock);
+}
+
+static void virtnvme_free_dev(struct kref *kref)
+{
+        struct virtio_nvme_dev *dev = container_of(kref,
+					struct virtio_nvme_dev, kref);
+
+        virtnvme_free_namespaces(dev);
+        virtnvme_release_instance(dev);
+	if (dev->tagset.tags)
+		blk_mq_free_tag_set(&dev->tagset);
+	if (dev->admin_q)
+		blk_put_queue(dev->admin_q);
+        kfree(dev);
+}
+
+static void virtnvme_release(struct gendisk *disk, fmode_t mode)
+{
+	struct virtio_nvme_ns *ns = disk->private_data;
+	struct virtio_nvme_dev *dev = ns->dev;
+
+	kref_put(&dev->kref, virtnvme_free_dev);
+}
+
+static const struct block_device_operations virtnvme_fops = {
+	.owner		= THIS_MODULE,
+	.open		= virtnvme_open,
+	.release	= virtnvme_release,
+};
+
+static struct virtio_nvme_ns *virtnvme_alloc_ns(struct virtio_nvme_dev *dev, unsigned nsid,
+			struct nvme_id_ns *id)
+{
+	struct virtio_nvme_ns *ns;
+	struct gendisk *disk;
+	int lbaf;
+
+	ns = kzalloc(sizeof(*ns), GFP_KERNEL);
+	if (!ns)
+		return NULL;
+	ns->queue = blk_mq_init_queue(&dev->tagset);
+	if (!ns->queue)
+		goto out_free_ns;
+	ns->queue->queue_flags = QUEUE_FLAG_DEFAULT;
+	queue_flag_set_unlocked(QUEUE_FLAG_NOMERGES, ns->queue);
+	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, ns->queue);
+	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, ns->queue);
+	ns->dev = dev;
+	ns->queue->queuedata = ns;
+
+	disk = alloc_disk(0);
+	if (!disk)
+		goto out_free_queue;
+	ns->ns_id = nsid;
+	ns->disk = disk;
+	lbaf = id->flbas & 0xf;
+	ns->lba_shift = id->lbaf[lbaf].ds;
+	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
+	if (dev->max_hw_sectors)
+		blk_queue_max_hw_sectors(ns->queue, dev->max_hw_sectors);
+	disk->major = virtnvme_major;
+	disk->first_minor = 0;
+	disk->fops = &virtnvme_fops;
+	disk->private_data = ns;
+	disk->queue = ns->queue;
+	disk->flags = GENHD_FL_EXT_DEVT;
+	sprintf(disk->disk_name, "vnvme%dn%d", dev->instance, nsid);
+	set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
+
+	return ns;
+
+out_free_queue:
+	blk_cleanup_queue(ns->queue);
+out_free_ns:
+	kfree(ns);
+	return NULL;
+}
+
+static unsigned int virtnvme_cmd_size(struct virtio_nvme_dev *dev)
+{
+	unsigned int ret;
+
+	ret = sizeof(struct virtnvme_req) +
+		sizeof(struct scatterlist) * dev->sg_elems;
+
+        return ret;
+}
+
+static int virtnvme_dev_add(struct virtio_nvme_dev *dev)
+{
+	int res;
+	unsigned nn, i;
+	struct virtio_nvme_ns *ns;
+	struct nvme_id_ctrl *ctrl;
+	struct nvme_id_ns *id_ns;
+	int err;
+
+	res = virtnvme_identify_ctrl(dev, &ctrl);
+	if (res) {
+		printk("Identify Controller failed (%d)\n", res);
+                res = -EIO;
+		goto out;
+	}
+
+	nn = le32_to_cpup(&ctrl->nn);
+
+	memset(&dev->tagset, 0, sizeof(dev->tagset));
+	dev->tagset.ops = &virtio_nvme_mq_ops;
+	/* Default queue sizing is to fill the ring. */
+	if (!virtnvme_queue_depth)
+		virtnvme_queue_depth = dev->vqs[1].vq->num_free;
+	dev->tagset.queue_depth = virtnvme_queue_depth;
+	dev->tagset.numa_node = NUMA_NO_NODE;
+	dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
+	dev->tagset.cmd_size = virtnvme_cmd_size(dev);
+	dev->tagset.driver_data = dev;
+	dev->tagset.nr_hw_queues = dev->num_vqs - 1;
+
+	err = blk_mq_alloc_tag_set(&dev->tagset);
+	if (err)
+		goto out;
+
+	for (i = 1; i <= nn; i++) {
+		res = virtnvme_identify_ns(dev, i, &id_ns);
+		if (res)
+			continue;
+
+		if (id_ns->ncap == 0)
+			continue;
+
+		ns = virtnvme_alloc_ns(dev, i, id_ns);
+		if (ns)
+			list_add_tail(&ns->list, &dev->namespaces);
+	}
+	list_for_each_entry(ns, &dev->namespaces, list)
+		add_disk(ns->disk);
+
+out:
+	return res;
+}
+
+static void virtnvme_dev_remove_admin(struct virtio_nvme_dev *dev)
+{
+	if (dev->admin_q && !blk_queue_dying(dev->admin_q)) {
+		blk_cleanup_queue(dev->admin_q);
+		blk_mq_free_tag_set(&dev->admin_tagset);
+	}
+}
+
+static int virtnvme_alloc_admin_tags(struct virtio_nvme_dev *dev)
+{
+	if (!dev->admin_q) {
+		dev->admin_tagset.ops = &virtio_nvme_mq_admin_ops;
+		dev->admin_tagset.nr_hw_queues = 1;
+		dev->admin_tagset.queue_depth = NVME_AQ_DEPTH;
+		dev->admin_tagset.reserved_tags = 1;
+		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
+		dev->admin_tagset.numa_node = NUMA_NO_NODE;
+		dev->admin_tagset.cmd_size = virtnvme_cmd_size(dev);
+		dev->admin_tagset.driver_data = dev;
+
+		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
+			return -ENOMEM;
+
+		dev->admin_q = blk_mq_init_queue(&dev->admin_tagset);
+		if (IS_ERR(dev->admin_q)) {
+			blk_mq_free_tag_set(&dev->admin_tagset);
+			return -ENOMEM;
+		}
+		if (!blk_get_queue(dev->admin_q)) {
+			virtnvme_dev_remove_admin(dev);
+			dev->admin_q = NULL;
+			return -ENODEV;
+		}
+	} else
+		blk_mq_unfreeze_queue(dev->admin_q);
+
+	return 0;
+}
+
+static int virtnvme_probe(struct virtio_device *vdev)
+{
+	struct virtio_nvme_dev *dev;
+	u64 cap;
+	u32 ctrl_config;
+	u32 sg_elems;
+	int err;
+
+	if (!vdev->config->get) {
+		printk("%s failure: config access disabled\n", __func__);
+		return -EINVAL;
+	}
+
+	vdev->priv = dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&dev->namespaces);
+	kref_init(&dev->kref);
+
+	init_waitqueue_head(&dev->queue_wait);
+	dev->vdev = vdev;
+
+	err = nvme_set_instance(dev);
+	if (err)
+		goto out_free_dev;
+
+	/* We need to know how many segments before we allocate. */
+	err = virtio_cread_feature(vdev, VIRTIO_NVME_F_SEG_MAX,
+				   struct virtio_nvme_config, seg_max,
+				   &sg_elems);
+	/* We need at least one SG element, whatever they say. */
+	if (err || !sg_elems)
+		sg_elems = 1;
+
+	/* We need two extra sg elements at head for command and response */
+	sg_elems += 2;
+	dev->sg_elems = sg_elems;
+
+	/*
+	 * 1. The host determines the controller capabilities
+	 */
+	virtio_cread(vdev, struct virtio_nvme_config, cap, &cap);
+
+	/*
+	 * 2. The host configures controller settings. Specific settings include:
+	 *	a. The arbitration mechanism should be selected in CC.AMS.
+	 *	b. The memory page size should be initialized in CC.MPS.
+	 *	c. The I/O Command Set that is to be used should be selected in CC.CSS.
+	 * 3. The controller should be enabled by setting CC.EN to 1
+	 */
+	ctrl_config = NVME_CC_ENABLE | NVME_CC_CSS_NVM;
+	ctrl_config |= (PAGE_SHIFT - 12) << NVME_CC_MPS_SHIFT;
+	ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
+	ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
+	virtio_cwrite(vdev, struct virtio_nvme_config, ctrl_config, &ctrl_config);
+
+	/*
+	 * 4. The host should wait for the controller to indicate it is ready to
+	 *    process commands. The controller is ready to process commands when
+	 *    CSTS.RDY is set to 1.
+	 */
+	err = virtnvme_wait_ready(dev, cap);
+	if (err)
+		goto release;
+
+	/* Qemu starts controller and creates VQs */
+	err = virtnvme_init_vq(dev);
+	if (err)
+		goto release;
+
+	err = virtnvme_alloc_admin_tags(dev);
+	if (err)
+		goto release;
+
+	spin_lock(&dev_list_lock);
+	list_add(&dev->node, &dev_list);
+	spin_unlock(&dev_list_lock);
+
+	/*
+	 * 6. The host should determine the configuration of the controller by
+	 *    issuing the Identify command, specifying the Controller data
+	 *    structure. The host should then determine the configuration of
+	 *    each namespace by issuing the Identify command for each namespace,
+	 *    specifying the Namespace data structure
+	 */
+	err = virtnvme_dev_add(dev);
+	if (err)
+		goto out_free_vq;
+
+	return 0;
+
+out_free_vq:
+	vdev->config->del_vqs(vdev);
+
+release:
+	virtnvme_release_instance(dev);
+
+out_free_dev:
+	kfree(dev);
+	return err;
+}
+
+static void virtnvme_ns_remove(struct virtio_nvme_ns *ns)
+{
+	bool kill = !blk_queue_dying(ns->queue);
+
+	if (kill)
+		blk_set_queue_dying(ns->queue);
+	if (ns->disk->flags & GENHD_FL_UP) {
+		if (blk_get_integrity(ns->disk))
+			blk_integrity_unregister(ns->disk);
+		del_gendisk(ns->disk);
+	}
+	if (kill || !blk_queue_dying(ns->queue)) {
+		blk_mq_abort_requeue_list(ns->queue);
+		blk_cleanup_queue(ns->queue);
+        }
+}
+
+static void virtnvme_dev_remove(struct virtio_nvme_dev *dev)
+{
+	struct virtio_nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list)
+		virtnvme_ns_remove(ns);
+}
+
+static void virtnvme_free_namespace(struct virtio_nvme_ns *ns)
+{
+	list_del(&ns->list);
+
+	spin_lock(&dev_list_lock);
+	ns->disk->private_data = NULL;
+	spin_unlock(&dev_list_lock);
+
+	put_disk(ns->disk);
+	kfree(ns);
+}
+
+static void virtnvme_free_namespaces(struct virtio_nvme_dev *dev)
+{
+	struct virtio_nvme_ns *ns, *next;
+
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list)
+		virtnvme_free_namespace(ns);
+}
+
+static void virtnvme_remove(struct virtio_device *vdev)
+{
+	struct virtio_nvme_dev *dev = vdev->priv;
+
+	spin_lock(&dev_list_lock);
+	list_del_init(&dev->node);
+	spin_unlock(&dev_list_lock);
+
+	/* Stop all the virtqueues. */
+	vdev->config->reset(vdev);
+
+	vdev->config->del_vqs(vdev);
+
+	virtnvme_dev_remove(dev);
+	virtnvme_dev_remove_admin(dev);
+
+	blk_mq_free_tag_set(&dev->tagset);
+	kfree(dev->vqs);
+
+	kref_put(&dev->kref, virtnvme_free_dev);
+}
+
+static unsigned int features[] = {
+	VIRTIO_NVME_F_SEG_MAX, VIRTIO_NVME_F_MQ,
+};
+
+static struct virtio_driver virtio_nvme_driver = {
+	.feature_table			= features,
+	.feature_table_size		= ARRAY_SIZE(features),
+	.driver.name			= KBUILD_MODNAME,
+	.driver.owner			= THIS_MODULE,
+	.id_table			= id_table,
+	.probe				= virtnvme_probe,
+	.remove				= virtnvme_remove,
+};
+
+static int __init virtnvme_init(void)
+{
+	int error;
+
+	virtnvme_major = register_blkdev(0, "virtnvme");
+	if (virtnvme_major < 0) {
+		error = virtnvme_major;
+		goto out;
+	}
+
+	error = register_virtio_driver(&virtio_nvme_driver);
+	if (error)
+		goto out_unregister_blkdev;
+	return 0;
+
+out_unregister_blkdev:
+	unregister_blkdev(virtnvme_major, "virtnvme");
+out:
+	return error;
+}
+
+static void __exit virtnvme_exit(void)
+{
+	unregister_virtio_driver(&virtio_nvme_driver);
+	unregister_blkdev(virtnvme_major, "virtnvme");
+}
+module_init(virtnvme_init);
+module_exit(virtnvme_exit);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Virtio NVMe driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ming Lin <ming.l@ssi.samsung.com>");
diff --git a/include/linux/virtio_nvme.h b/include/linux/virtio_nvme.h
new file mode 100644
index 0000000..c8db9a2
--- /dev/null
+++ b/include/linux/virtio_nvme.h
@@ -0,0 +1,53 @@
+#ifndef _LINUX_VIRTIO_NVME_H
+#define _LINUX_VIRTIO_NVME_H
+
+#include <uapi/linux/virtio_nvme.h>
+#include <linux/blk-mq.h>
+
+#define VQ_NAME_LEN 16
+
+struct virtio_nvme_dev;
+struct virtio_nvme_queue {
+	struct virtio_nvme_dev *dev;
+	struct virtqueue *vq;
+	spinlock_t lock;
+	char name[VQ_NAME_LEN];
+} ____cacheline_aligned_in_smp;
+
+struct virtio_nvme_dev {
+	struct virtio_device *vdev;
+	wait_queue_head_t queue_wait;
+	struct request_queue *admin_q;
+	struct blk_mq_tag_set admin_tagset;
+	struct blk_mq_tag_set tagset;
+
+	/* num of vqs */
+	int num_vqs;
+	struct virtio_nvme_queue *vqs;
+	struct list_head node;
+	int instance;
+	u32 ctrl_config;
+	struct list_head namespaces;
+	struct kref kref;
+	char name[12];
+	char serial[20];
+	char model[40];
+	char firmware_rev[8];
+	u32 max_hw_sectors;
+
+	unsigned int sg_elems;
+};
+
+struct virtio_nvme_ns {
+	struct list_head list;
+
+	struct virtio_nvme_dev *dev;
+	struct request_queue *queue;
+	struct gendisk *disk;
+
+	unsigned ns_id;
+	int lba_shift;
+	int ms;
+};
+
+#endif
diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 77925f5..d59d323 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -41,5 +41,6 @@
 #define VIRTIO_ID_CAIF	       12 /* Virtio caif */
 #define VIRTIO_ID_GPU          16 /* virtio GPU */
 #define VIRTIO_ID_INPUT        18 /* virtio input */
+#define VIRTIO_ID_NVME         19 /* TBD: virtio NVMe, need Redhat's help to get this id */
 
 #endif /* _LINUX_VIRTIO_IDS_H */
diff --git a/include/uapi/linux/virtio_nvme.h b/include/uapi/linux/virtio_nvme.h
new file mode 100644
index 0000000..33f6077
--- /dev/null
+++ b/include/uapi/linux/virtio_nvme.h
@@ -0,0 +1,30 @@
+#ifndef _UAPI_LINUX_VIRTIO_NVME_H
+#define _UAPI_LINUX_VIRTIO_NVME_H
+
+#include <linux/types.h>
+#include <linux/virtio_ids.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_types.h>
+
+/* Feature bits */
+#define VIRTIO_NVME_F_SEG_MAX	1	/* Indicates maximum # of segments */
+#define VIRTIO_NVME_F_MQ	2	/* support more than one vq */
+
+struct virtio_nvme_config {
+	__u64	cap;
+	__u32	ctrl_config;
+	__u32	csts;
+
+	/* The maximum number of segments (if VIRTIO_NVME_F_SEG_MAX) */
+	__u32	seg_max;
+	/* number of vqs, only available when VIRTIO_NVME_F_MQ is set */
+	__u32 num_queues;
+} __attribute__((packed));
+
+struct virtio_nvme_resp {
+    __u32	result;
+    __u16	cid;
+    __u16	status;
+};
+
+#endif
-- 
1.9.1
