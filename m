From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 5/9] nvme-vhost: add controller "start" callback
Date: Thu, 19 Nov 2015 16:21:04 -0800
Message-ID: <1447978868-17138-6-git-send-email-mlin@kernel.org>
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
 drivers/nvme/target/vhost.c | 106 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/nvme/target/vhost.c b/drivers/nvme/target/vhost.c
index 01c44b8..4a147d6 100644
--- a/drivers/nvme/target/vhost.c
+++ b/drivers/nvme/target/vhost.c
@@ -10,6 +10,35 @@
 
 #define NVMET_VHOST_AQ_DEPTH		256
 
+enum NvmeCcShift {
+	CC_MPS_SHIFT	= 7,
+	CC_IOSQES_SHIFT	= 16,
+	CC_IOCQES_SHIFT	= 20,
+};
+
+enum NvmeCcMask {
+	CC_MPS_MASK	= 0xf,
+	CC_IOSQES_MASK	= 0xf,
+	CC_IOCQES_MASK	= 0xf,
+};
+
+#define NVME_CC_MPS(cc)    ((cc >> CC_MPS_SHIFT)    & CC_MPS_MASK)
+#define NVME_CC_IOSQES(cc) ((cc >> CC_IOSQES_SHIFT) & CC_IOSQES_MASK)
+#define NVME_CC_IOCQES(cc) ((cc >> CC_IOCQES_SHIFT) & CC_IOCQES_MASK)
+
+enum NvmeAqaShift {
+	AQA_ASQS_SHIFT	= 0,
+	AQA_ACQS_SHIFT	= 16,
+};
+
+enum NvmeAqaMask {
+	AQA_ASQS_MASK	= 0xfff,
+	AQA_ACQS_MASK	= 0xfff,
+};
+
+#define NVME_AQA_ASQS(aqa) ((aqa >> AQA_ASQS_SHIFT) & AQA_ASQS_MASK)
+#define NVME_AQA_ACQS(aqa) ((aqa >> AQA_ACQS_SHIFT) & AQA_ACQS_MASK)
+
 struct nvmet_vhost_ctrl_eventfd {
 	struct file *call;
 	struct eventfd_ctx *call_ctx;
@@ -19,12 +48,23 @@ struct nvmet_vhost_ctrl_eventfd {
 
 struct nvmet_vhost_cq {
 	struct nvmet_cq		cq;
+	struct nvmet_vhost_ctrl	*ctrl;
 
+	u32			head;
+	u32			tail;
+	u8			phase;
+	u64			dma_addr;
 	struct eventfd_ctx	*eventfd;
 };
 
 struct nvmet_vhost_sq {
 	struct nvmet_sq		sq;
+	struct nvmet_vhost_ctrl	*ctrl;
+
+	u32			head;
+	u32			tail;
+	u64			dma_addr;
+	u16			cqid;
 };
 
 struct nvmet_vhost_ctrl {
@@ -37,12 +77,76 @@ struct nvmet_vhost_ctrl {
 
 	struct nvmet_vhost_cq **cqs;
 	struct nvmet_vhost_sq **sqs;
+	struct nvmet_vhost_cq admin_cq;
+	struct nvmet_vhost_sq admin_sq;
 
 	u32 aqa;
 	u64 asq;
 	u64 acq;
+	u16 cqe_size;
+	u16 sqe_size;
+	u16 max_prp_ents;
+	u16 page_bits;
+	u32 page_size;
 };
 
+static int nvmet_vhost_init_cq(struct nvmet_vhost_cq *cq,
+		struct nvmet_vhost_ctrl *n, u64 dma_addr,
+		u16 cqid, u16 size, struct eventfd_ctx *eventfd,
+		u16 vector, u16 irq_enabled)
+{
+	cq->ctrl = n;
+	cq->dma_addr = dma_addr;
+	cq->phase = 1;
+	cq->head = cq->tail = 0;
+	cq->eventfd = eventfd;
+	n->cqs[cqid] = cq;
+
+	nvmet_cq_init(n->ctrl, &cq->cq, cqid, size);
+
+	return 0;
+}
+
+static int nvmet_vhost_init_sq(struct nvmet_vhost_sq *sq,
+		struct nvmet_vhost_ctrl *n, u64 dma_addr,
+		u16 sqid, u16 cqid, u16 size)
+{
+	sq->ctrl = n;
+	sq->dma_addr = dma_addr;
+	sq->cqid = cqid;
+	sq->head = sq->tail = 0;
+	n->sqs[sqid] = sq;
+
+	nvmet_sq_init(n->ctrl, &sq->sq, sqid, size);
+
+	return 0;
+}
+
+static void nvmet_vhost_start_ctrl(void *opaque)
+{
+	struct nvmet_vhost_ctrl *n = opaque;
+	u32 page_bits = NVME_CC_MPS(n->ctrl->cc) + 12;
+	u32 page_size = 1 << page_bits;
+	int ret;
+
+	n->page_bits = page_bits;
+	n->page_size = page_size;
+	n->max_prp_ents = n->page_size / sizeof(uint64_t);
+	n->cqe_size = 1 << NVME_CC_IOCQES(n->ctrl->cc);
+	n->sqe_size = 1 << NVME_CC_IOSQES(n->ctrl->cc);
+
+	nvmet_vhost_init_cq(&n->admin_cq, n, n->acq, 0,
+		NVME_AQA_ACQS(n->aqa) + 1, n->eventfd[0].call_ctx,
+		0, 1);
+
+	ret = nvmet_vhost_init_sq(&n->admin_sq, n, n->asq, 0, 0,
+		NVME_AQA_ASQS(n->aqa) + 1);
+	if (ret) {
+		pr_warn("nvmet_vhost_init_sq failed!!!\n");
+		BUG_ON(1);
+	}
+}
+
 static int
 nvmet_vhost_set_endpoint(struct nvmet_vhost_ctrl *n,
 			struct vhost_nvme_target *c)
@@ -67,6 +171,8 @@ nvmet_vhost_set_endpoint(struct nvmet_vhost_ctrl *n,
 	n->cntlid = ctrl->cntlid;
 	n->ctrl = ctrl;
 	n->num_queues = subsys->max_qid + 1;
+	ctrl->opaque = n;
+	ctrl->start = nvmet_vhost_start_ctrl;
 
 	num_queues = ctrl->subsys->max_qid + 1;
 	n->cqs = kzalloc(sizeof(*n->cqs) * num_queues, GFP_KERNEL);
-- 
1.9.1
