From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 7/9] nvme-vhost: add "parse_extra_admin_cmd" callback
Date: Thu, 19 Nov 2015 16:21:06 -0800
Message-ID: <1447978868-17138-8-git-send-email-mlin@kernel.org>
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
 drivers/nvme/target/vhost.c | 153 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/drivers/nvme/target/vhost.c b/drivers/nvme/target/vhost.c
index 4a147d6..04ed0bc 100644
--- a/drivers/nvme/target/vhost.c
+++ b/drivers/nvme/target/vhost.c
@@ -39,6 +39,11 @@ enum NvmeAqaMask {
 #define NVME_AQA_ASQS(aqa) ((aqa >> AQA_ASQS_SHIFT) & AQA_ASQS_MASK)
 #define NVME_AQA_ACQS(aqa) ((aqa >> AQA_ACQS_SHIFT) & AQA_ACQS_MASK)
 
+#define NVME_CQ_FLAGS_PC(cq_flags)	(cq_flags & 0x1)
+#define NVME_CQ_FLAGS_IEN(cq_flags)	((cq_flags >> 1) & 0x1)
+
+#define NVME_SQ_FLAGS_PC(sq_flags)	(sq_flags & 0x1)
+
 struct nvmet_vhost_ctrl_eventfd {
 	struct file *call;
 	struct eventfd_ctx *call_ctx;
@@ -90,6 +95,19 @@ struct nvmet_vhost_ctrl {
 	u32 page_size;
 };
 
+#define sq_to_vsq(sq) container_of(sq, struct nvmet_vhost_sq, sq)
+#define cq_to_vcq(cq) container_of(cq, struct nvmet_vhost_cq, cq)
+
+static int nvmet_vhost_check_sqid(struct nvmet_ctrl *n, u16 sqid)
+{
+	return sqid <= n->subsys->max_qid && n->sqs[sqid] != NULL ? 0 : -1;
+}
+
+static int nvmet_vhost_check_cqid(struct nvmet_ctrl *n, u16 cqid)
+{
+	return cqid <= n->subsys->max_qid && n->cqs[cqid] != NULL ? 0 : -1;
+}
+
 static int nvmet_vhost_init_cq(struct nvmet_vhost_cq *cq,
 		struct nvmet_vhost_ctrl *n, u64 dma_addr,
 		u16 cqid, u16 size, struct eventfd_ctx *eventfd,
@@ -147,6 +165,140 @@ static void nvmet_vhost_start_ctrl(void *opaque)
 	}
 }
 
+static void nvmet_vhost_create_cq(struct nvmet_req *req)
+{
+	struct nvmet_cq *cq;
+	struct nvmet_vhost_cq *vcq;
+	struct nvmet_vhost_ctrl *n;
+	struct nvme_create_cq *c;
+	u16 cqid;
+	u16 vector;
+	u16 qsize;
+	u16 qflags;
+	u64 prp1;
+	int status;
+	int ret;
+
+	cq = req->cq;
+	vcq = cq_to_vcq(cq);
+	n = vcq->ctrl;
+	c = &req->cmd->create_cq;
+	cqid = le16_to_cpu(c->cqid);
+	vector = le16_to_cpu(c->irq_vector);
+	qsize = le16_to_cpu(c->qsize);
+	qflags = le16_to_cpu(c->cq_flags);
+	prp1 = le64_to_cpu(c->prp1);
+	status = NVME_SC_SUCCESS;
+
+	if (!cqid || (cqid && !nvmet_vhost_check_cqid(n->ctrl, cqid))) {
+		status = NVME_SC_QID_INVALID | NVME_SC_DNR;
+		goto out;
+	}
+	if (!qsize || qsize > NVME_CAP_MQES(n->ctrl->cap)) {
+		status = NVME_SC_QUEUE_SIZE | NVME_SC_DNR;
+		goto out;
+	}
+	if (!prp1) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+	if (vector > n->num_queues) {
+		status = NVME_SC_INVALID_VECTOR | NVME_SC_DNR;
+		goto out;
+	}
+	if (!(NVME_CQ_FLAGS_PC(qflags))) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
+	vcq = kmalloc(sizeof(*vcq), GFP_KERNEL);
+	if (!vcq) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		goto out;
+	}
+
+	ret = nvmet_vhost_init_cq(vcq, n, prp1, cqid, qsize+1,
+		n->eventfd[cqid].call_ctx, vector,
+		NVME_CQ_FLAGS_IEN(qflags));
+	if (ret)
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+
+out:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_vhost_create_sq(struct nvmet_req *req)
+{
+	struct nvme_create_sq *c = &req->cmd->create_sq;
+	u16 cqid = le16_to_cpu(c->cqid);
+	u16 sqid = le16_to_cpu(c->sqid);
+	u16 qsize = le16_to_cpu(c->qsize);
+	u16 qflags = le16_to_cpu(c->sq_flags);
+	u64 prp1 = le64_to_cpu(c->prp1);
+
+	struct nvmet_sq *sq = req->sq;
+	struct nvmet_vhost_sq *vsq;
+	struct nvmet_vhost_ctrl *n;
+	int status;
+	int ret;
+
+	status = NVME_SC_SUCCESS;
+	vsq = sq_to_vsq(sq);
+	n = vsq->ctrl;
+
+	if (!cqid || nvmet_vhost_check_cqid(n->ctrl, cqid)) {
+		status = NVME_SC_CQ_INVALID | NVME_SC_DNR;
+		goto out;
+	}
+	if (!sqid || (sqid && !nvmet_vhost_check_sqid(n->ctrl, sqid))) {
+		status = NVME_SC_QID_INVALID | NVME_SC_DNR;
+		goto out;
+	}
+	if (!qsize || qsize > NVME_CAP_MQES(n->ctrl->cap)) {
+		status = NVME_SC_QUEUE_SIZE | NVME_SC_DNR;
+		goto out;
+	}
+	if (!prp1 || prp1 & (n->page_size - 1)) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+	if (!(NVME_SQ_FLAGS_PC(qflags))) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
+	vsq = kmalloc(sizeof(*vsq), GFP_KERNEL);
+	if (!sq) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		goto out;
+	}
+
+	ret = nvmet_vhost_init_sq(vsq, n, prp1, sqid, cqid, qsize + 1);
+	if (ret)
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+
+out:
+	nvmet_req_complete(req, status);
+}
+
+static int nvmet_vhost_parse_admin_cmd(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->common.opcode) {
+	case nvme_admin_create_cq:
+		req->execute = nvmet_vhost_create_cq;
+		req->data_len = 0;
+		return 0;
+	case nvme_admin_create_sq:
+		req->execute = nvmet_vhost_create_sq;
+		req->data_len = 0;
+		return 0;
+	}
+
+	return -1;
+}
+
 static int
 nvmet_vhost_set_endpoint(struct nvmet_vhost_ctrl *n,
 			struct vhost_nvme_target *c)
@@ -173,6 +325,7 @@ nvmet_vhost_set_endpoint(struct nvmet_vhost_ctrl *n,
 	n->num_queues = subsys->max_qid + 1;
 	ctrl->opaque = n;
 	ctrl->start = nvmet_vhost_start_ctrl;
+	ctrl->parse_extra_admin_cmd = nvmet_vhost_parse_admin_cmd;
 
 	num_queues = ctrl->subsys->max_qid + 1;
 	n->cqs = kzalloc(sizeof(*n->cqs) * num_queues, GFP_KERNEL);
-- 
1.9.1
