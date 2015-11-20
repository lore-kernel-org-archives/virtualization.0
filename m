From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 9/9] nvme-vhost: add nvme queue handlers
Date: Thu, 19 Nov 2015 16:21:08 -0800
Message-ID: <1447978868-17138-10-git-send-email-mlin@kernel.org>
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
Cc: Ming Lin <ming.l@ssi.samsung.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Ming Lin <ming.l@ssi.samsung.com>

This adds nvme submission/completion queue handlers,
which are ported from qemu-nvme.

And hooks into nvme-target to do the real job.

Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
---
 drivers/nvme/target/vhost.c | 420 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 416 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/vhost.c b/drivers/nvme/target/vhost.c
index 6847c86..3ce1348 100644
--- a/drivers/nvme/target/vhost.c
+++ b/drivers/nvme/target/vhost.c
@@ -6,10 +6,12 @@
 #include <linux/mutex.h>
 #include <linux/file.h>
 #include <linux/highmem.h>
+#include <linux/kthread.h>
 #include "../../vhost/vhost.h"
 #include "nvmet.h"
 
 #define NVMET_VHOST_AQ_DEPTH		256
+#define NVMET_VHOST_MAX_SEGMENTS	32
 
 enum NvmeCcShift {
 	CC_MPS_SHIFT	= 7,
@@ -52,6 +54,15 @@ struct nvmet_vhost_ctrl_eventfd {
 	int __user *vector;
 };
 
+struct nvmet_vhost_iod {
+	struct nvmet_vhost_sq	*sq;
+	struct scatterlist	sg[NVMET_VHOST_MAX_SEGMENTS];
+	struct nvme_command	cmd;
+	struct nvme_completion	rsp;
+	struct nvmet_req	req;
+	struct list_head	entry;
+};
+
 struct nvmet_vhost_cq {
 	struct nvmet_cq		cq;
 	struct nvmet_vhost_ctrl	*ctrl;
@@ -61,6 +72,12 @@ struct nvmet_vhost_cq {
 	u8			phase;
 	u64			dma_addr;
 	struct eventfd_ctx	*eventfd;
+
+	struct list_head	sq_list;
+	struct list_head	req_list;
+	spinlock_t		lock;
+	struct task_struct	*thread;
+	int			scheduled;
 };
 
 struct nvmet_vhost_sq {
@@ -71,6 +88,13 @@ struct nvmet_vhost_sq {
 	u32			tail;
 	u64			dma_addr;
 	u16			cqid;
+
+	struct nvmet_vhost_iod	*io_req;
+	struct list_head	req_list;
+	struct list_head	entry;
+	struct mutex            lock;
+	struct task_struct	*thread;
+	int			scheduled;
 };
 
 struct nvmet_vhost_ctrl {
@@ -191,13 +215,13 @@ static int nvmet_vhost_rw(struct vhost_dev *dev, u64 guest_pa,
 	return 0;
 }
 
-int nvmet_vhost_read(struct vhost_dev *dev, u64 guest_pa,
+static int nvmet_vhost_read(struct vhost_dev *dev, u64 guest_pa,
 		void *buf, uint32_t size)
 {
 	return nvmet_vhost_rw(dev, guest_pa, buf, size, 0);
 }
 
-int nvmet_vhost_write(struct vhost_dev *dev, u64 guest_pa,
+static int nvmet_vhost_write(struct vhost_dev *dev, u64 guest_pa,
 		void *buf, uint32_t size)
 {
 	return nvmet_vhost_rw(dev, guest_pa, buf, size, 1);
@@ -216,6 +240,289 @@ static int nvmet_vhost_check_cqid(struct nvmet_ctrl *n, u16 cqid)
 	return cqid <= n->subsys->max_qid && n->cqs[cqid] != NULL ? 0 : -1;
 }
 
+static void nvmet_vhost_inc_cq_tail(struct nvmet_vhost_cq *cq)
+{
+	cq->tail++;
+	if (cq->tail >= cq->cq.size) {
+		cq->tail = 0;
+		cq->phase = !cq->phase;
+	}
+}
+
+static void nvmet_vhost_inc_sq_head(struct nvmet_vhost_sq *sq)
+{
+	sq->head = (sq->head + 1) % sq->sq.size;
+}
+
+static uint8_t nvmet_vhost_cq_full(struct nvmet_vhost_cq *cq)
+{
+	return (cq->tail + 1) % cq->cq.size == cq->head;
+}
+
+static uint8_t nvmet_vhost_sq_empty(struct nvmet_vhost_sq *sq)
+{
+	return sq->head == sq->tail;
+}
+
+static void nvmet_vhost_post_cqes(struct nvmet_vhost_cq *cq)
+{
+	struct nvmet_vhost_ctrl *n = cq->ctrl;
+	struct nvmet_vhost_iod *req;
+	struct list_head *p, *tmp;
+	int signal = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cq->lock, flags);
+	list_for_each_safe(p, tmp, &cq->req_list) {
+		struct nvmet_vhost_sq *sq;
+		u64 addr;
+
+		if (nvmet_vhost_cq_full(cq))
+			goto unlock;
+
+		req = list_entry(p, struct nvmet_vhost_iod, entry);
+		list_del(p);
+
+		sq = req->sq;
+		req->rsp.status |= cq->phase;
+		req->rsp.sq_id = cpu_to_le16(sq->sq.qid);
+		req->rsp.sq_head = cpu_to_le16(sq->head);
+		addr = cq->dma_addr + cq->tail * n->cqe_size;
+		nvmet_vhost_inc_cq_tail(cq);
+		spin_unlock_irqrestore(&cq->lock, flags);
+
+		nvmet_vhost_write(&n->dev, addr, (void *)&req->rsp,
+			sizeof(req->rsp));
+
+		mutex_lock(&sq->lock);
+		list_add_tail(p, &sq->req_list);
+		mutex_unlock(&sq->lock);
+
+		signal = 1;
+
+		spin_lock_irqsave(&cq->lock, flags);
+	}
+
+	if (signal)
+		eventfd_signal(cq->eventfd, 1);
+
+unlock:
+	cq->scheduled = 0;
+	spin_unlock_irqrestore(&cq->lock, flags);
+}
+
+static int nvmet_vhost_cq_thread(void *arg)
+{
+	struct nvmet_vhost_cq *sq = arg;
+
+	while (1) {
+		if (kthread_should_stop())
+			break;
+
+		nvmet_vhost_post_cqes(sq);
+
+		schedule();
+	}
+
+	return 0;
+}
+
+static void nvmet_vhost_enqueue_req_completion(
+		struct nvmet_vhost_cq *cq, struct nvmet_vhost_iod *iod)
+{
+	unsigned long flags;
+
+	BUG_ON(cq->cq.qid != iod->sq->sq.qid);
+	spin_lock_irqsave(&cq->lock, flags);
+	list_add_tail(&iod->entry, &cq->req_list);
+	if (!cq->scheduled) {
+		wake_up_process(cq->thread);
+		cq->scheduled = 1;
+	}
+	spin_unlock_irqrestore(&cq->lock, flags);
+}
+
+static void nvmet_vhost_queue_response(struct nvmet_req *req)
+{
+	struct nvmet_vhost_iod *iod =
+		container_of(req, struct nvmet_vhost_iod, req);
+	struct nvmet_vhost_sq *sq = iod->sq;
+	struct nvmet_vhost_ctrl *n = sq->ctrl;
+	struct nvmet_vhost_cq *cq = n->cqs[sq->sq.qid];
+
+	nvmet_vhost_enqueue_req_completion(cq, iod);
+}
+
+static int nvmet_vhost_sglist_add(struct nvmet_vhost_ctrl *n, struct scatterlist *sg,
+		u64 guest_addr, int len, int is_write)
+{
+	void __user *host_addr;
+	struct page *page;
+	unsigned int offset, nbytes;
+	int ret;
+
+	host_addr = map_guest_to_host(&n->dev, guest_addr, len);
+	if (unlikely(!host_addr)) {
+		pr_warn("cannot map guest addr %p, error %ld\n",
+			(void *)guest_addr, PTR_ERR(host_addr));
+		return PTR_ERR(host_addr);
+	}
+
+	ret = get_user_pages(current, n->dev.mm, (unsigned long)host_addr, 1,
+			is_write, 0, &page, NULL);
+	BUG_ON(ret == 0); /* we should either get our page or fail */
+	if (ret < 0) {
+		pr_warn("get_user_pages faild: host_addr %p, %d\n",
+			host_addr, ret);
+		return ret;
+	}
+
+	offset = (uintptr_t)host_addr & ~PAGE_MASK;
+	nbytes = min_t(unsigned int, PAGE_SIZE - offset, len);
+	sg_set_page(sg, page, nbytes, offset);
+
+	return 0;
+}
+
+static int nvmet_vhost_map_prp(struct nvmet_vhost_ctrl *n, struct scatterlist *sgl,
+	u64 prp1, u64 prp2, unsigned int len)
+{
+	unsigned int trans_len = n->page_size - (prp1 % n->page_size);
+	int num_prps = (len >> n->page_bits) + 1;
+	//FIXME
+	int is_write = 1;
+
+	trans_len = min(len, trans_len);
+	if (!prp1)
+		return -1;
+
+	sg_init_table(sgl, num_prps);
+
+	nvmet_vhost_sglist_add(n, sgl, prp1, trans_len, is_write);
+
+	len -= trans_len;
+	if (len) {
+		if (!prp2)
+			goto error;
+		if (len > n->page_size) {
+			u64 prp_list[n->max_prp_ents];
+			u16 nents, prp_trans;
+			int i = 0;
+
+			nents = (len + n->page_size - 1) >> n->page_bits;
+			prp_trans = min(n->max_prp_ents, nents) * sizeof(u64);
+			nvmet_vhost_read(&n->dev, prp2, (void *)prp_list, prp_trans);
+
+			while (len != 0) {
+				u64 prp_ent = le64_to_cpu(prp_list[i]);
+
+				if (i == n->max_prp_ents - 1 && len > n->page_size) {
+					if (!prp_ent || prp_ent & (n->page_size - 1))
+						goto error;
+					i = 0;
+					nents = (len + n->page_size - 1) >> n->page_bits;
+					prp_trans = min(n->max_prp_ents, nents) * sizeof(u64);
+					nvmet_vhost_read(&n->dev, prp_ent, (void *)prp_list, prp_trans);
+					prp_ent = le64_to_cpu(prp_list[i]);
+				}
+
+				if (!prp_ent || prp_ent & (n->page_size - 1))
+					goto error;
+
+				trans_len = min(len, n->page_size);
+				nvmet_vhost_sglist_add(n, sgl, prp_ent, trans_len, is_write);
+				sgl++;
+				len -= trans_len;
+				i++;
+			}
+		} else {
+			if (prp2 & (n->page_size - 1))
+				goto error;
+			nvmet_vhost_sglist_add(n, sgl, prp2, trans_len, is_write);
+		}
+	}
+
+	return num_prps;
+
+error:
+	return -1;
+}
+
+static void nvmet_vhost_process_sq(struct nvmet_vhost_sq *sq)
+{
+	struct nvmet_vhost_ctrl *n = sq->ctrl;
+	struct nvmet_vhost_cq *cq = n->cqs[sq->sq.qid];
+	struct nvmet_vhost_iod *iod;
+	struct nvme_command *cmd;
+	int ret;
+
+	mutex_lock(&sq->lock);
+
+	while (!(nvmet_vhost_sq_empty(sq) || list_empty(&sq->req_list))) {
+		u64 addr = sq->dma_addr + sq->head * n->sqe_size;;
+
+		nvmet_vhost_inc_sq_head(sq);
+		iod = list_first_entry(&sq->req_list,
+					struct nvmet_vhost_iod, entry);
+		list_del(&iod->entry);
+		mutex_unlock(&sq->lock);
+
+		cmd = &iod->cmd;
+		ret = nvmet_vhost_read(&n->dev, addr,
+				(void *)cmd, sizeof(*cmd));
+		if (ret) {
+			pr_warn("nvmet_vhost_read fail\n");
+			goto out;
+		}
+
+		ret = nvmet_req_init(&iod->req, &cq->cq, &sq->sq,
+					nvmet_vhost_queue_response);
+		if (ret) {
+			pr_warn("nvmet_req_init error: ret 0x%x, qid %d\n", ret, sq->sq.qid);
+			goto out;
+		}
+		if (iod->req.data_len) {
+			ret = nvmet_vhost_map_prp(n, iod->sg, cmd->common.prp1,
+					cmd->common.prp2, iod->req.data_len);
+			if (ret > 0) {
+				iod->req.sg = iod->sg;
+				iod->req.sg_cnt = ret;
+			} else {
+				pr_warn("map prp error\n");
+				goto out;
+			}
+		}
+		iod->req.execute(&iod->req);
+		mutex_lock(&sq->lock);
+        }
+
+unlock:
+	sq->scheduled = 0;
+	mutex_unlock(&sq->lock);
+	return;
+
+out:
+	mutex_lock(&sq->lock);
+	list_add_tail(&iod->entry, &sq->req_list);
+	goto unlock;
+}
+
+static int nvmet_vhost_sq_thread(void *opaque)
+{
+	struct nvmet_vhost_sq *sq = opaque;
+
+	while (1) {
+		if (kthread_should_stop())
+			break;
+
+		nvmet_vhost_process_sq(sq);
+
+		schedule();
+	}
+
+	return 0;
+}
+
 static int nvmet_vhost_init_cq(struct nvmet_vhost_cq *cq,
 		struct nvmet_vhost_ctrl *n, u64 dma_addr,
 		u16 cqid, u16 size, struct eventfd_ctx *eventfd,
@@ -228,6 +535,12 @@ static int nvmet_vhost_init_cq(struct nvmet_vhost_cq *cq,
 	cq->eventfd = eventfd;
 	n->cqs[cqid] = cq;
 
+	spin_lock_init(&cq->lock);
+	INIT_LIST_HEAD(&cq->req_list);
+	INIT_LIST_HEAD(&cq->sq_list);
+	cq->scheduled = 0;
+	cq->thread = kthread_create(nvmet_vhost_cq_thread, cq, "nvmet_vhost_cq");
+
 	nvmet_cq_init(n->ctrl, &cq->cq, cqid, size);
 
 	return 0;
@@ -237,12 +550,36 @@ static int nvmet_vhost_init_sq(struct nvmet_vhost_sq *sq,
 		struct nvmet_vhost_ctrl *n, u64 dma_addr,
 		u16 sqid, u16 cqid, u16 size)
 {
+	struct nvmet_vhost_cq *cq;
+	struct nvmet_vhost_iod *iod;
+	int i;
+
 	sq->ctrl = n;
 	sq->dma_addr = dma_addr;
 	sq->cqid = cqid;
 	sq->head = sq->tail = 0;
 	n->sqs[sqid] = sq;
 
+	mutex_init(&sq->lock);
+	INIT_LIST_HEAD(&sq->req_list);
+	sq->io_req = kmalloc(sizeof(struct nvmet_vhost_iod) * size, GFP_KERNEL);
+	if (!sq->io_req)
+		return -ENOMEM;
+	for (i = 0; i < size; i++) {
+		iod = &sq->io_req[i];
+
+		iod->req.cmd = &iod->cmd;
+		iod->req.rsp = &iod->rsp;
+		iod->sq = sq;
+		list_add_tail(&iod->entry, &sq->req_list);
+	}
+	sq->scheduled = 0;
+	sq->thread = kthread_create(nvmet_vhost_sq_thread, sq, "nvmet_vhost_sq");
+
+	cq = n->cqs[cqid];
+	list_add_tail(&sq->entry, &cq->sq_list);
+	n->sqs[sqid] = sq;
+
 	nvmet_sq_init(n->ctrl, &sq->sq, sqid, size);
 
 	return 0;
@@ -564,12 +901,84 @@ static int nvmet_bar_write(struct nvmet_vhost_ctrl *n, int offset, u64 val)
 	return status;
 }
 
+static int nvmet_vhost_process_db(struct nvmet_ctrl *ctrl, int offset, u64 val)
+{
+	u16 qid;
+
+	if (offset & ((1 << 2) - 1))
+		return -EINVAL;
+
+	if (((offset - 0x1000) >> 2) & 1) {
+		u16 new_head = val & 0xffff;
+		int start_sqs;
+		struct nvmet_vhost_cq *vcq;
+		struct nvmet_cq *cq;
+		unsigned long flags;
+
+		qid = (offset - (0x1000 + (1 << 2))) >> 3;
+		if (nvmet_vhost_check_cqid(ctrl, qid))
+			return -EINVAL;
+
+		cq = ctrl->cqs[qid];
+		if (new_head >= cq->size)
+			return -EINVAL;
+
+		vcq = cq_to_vcq(cq);
+		spin_lock_irqsave(&vcq->lock, flags);
+		start_sqs = nvmet_vhost_cq_full(vcq) ? 1 : 0;
+		vcq->head = new_head;
+		spin_unlock_irqrestore(&vcq->lock, flags);
+		if (start_sqs) {
+			struct nvmet_vhost_sq *sq;
+			struct list_head *p;
+
+			list_for_each(p, &vcq->sq_list) {
+				sq = list_entry(p, struct nvmet_vhost_sq, entry);
+				if (!sq->scheduled) {
+					sq->scheduled = 1;
+					wake_up_process(sq->thread);
+				}
+			}
+			if (!vcq->scheduled) {
+				vcq->scheduled = 1;
+				wake_up_process(vcq->thread);
+			}
+		}
+
+		if (vcq->tail != vcq->head)
+			eventfd_signal(vcq->eventfd, 1);
+	} else {
+		struct nvmet_vhost_sq *vsq;
+		struct nvmet_sq *sq;
+		u16 new_tail = val & 0xffff;
+
+		qid = (offset - 0x1000) >> 3;
+		if (nvmet_vhost_check_sqid(ctrl, qid))
+			return -EINVAL;
+
+		sq = ctrl->sqs[qid];
+		if (new_tail >= sq->size)
+			return -ENOSPC;
+
+		vsq = sq_to_vsq(sq);
+		mutex_lock(&vsq->lock);
+		vsq->tail = new_tail;
+		if (!vsq->scheduled) {
+			vsq->scheduled = 1;
+			wake_up_process(vsq->thread);
+		}
+		mutex_unlock(&vsq->lock);
+	}
+
+	return 0;
+}
+
 static int nvmet_vhost_bar_write(struct nvmet_vhost_ctrl *n, int offset, u64 val)
 {
 	if (offset < 0x1000)
 		return nvmet_bar_write(n, offset, val);
-
-	return -1;
+	else
+		return nvmet_vhost_process_db(n->ctrl, offset, val);
 }
 
 static int nvmet_vhost_ioc_bar(struct nvmet_vhost_ctrl *n, void __user *argp)
@@ -612,6 +1021,8 @@ static void nvme_free_sq(struct nvmet_vhost_sq *sq,
 		struct nvmet_vhost_ctrl *n)
 {
 	n->sqs[sq->sq.qid] = NULL;
+	kthread_stop(sq->thread);
+	kfree(sq->io_req);
 	if (sq->sq.qid)
 		kfree(sq);
 }
@@ -620,6 +1031,7 @@ static void nvme_free_cq(struct nvmet_vhost_cq *cq,
 		struct nvmet_vhost_ctrl *n)
 {
 	n->cqs[cq->cq.qid] = NULL;
+	kthread_stop(cq->thread);
 	if (cq->cq.qid)
 		kfree(cq);
 }
-- 
1.9.1
