From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 4/9] nvmet: add a controller "start" hook
Date: Thu, 19 Nov 2015 16:21:03 -0800
Message-ID: <1447978868-17138-5-git-send-email-mlin@kernel.org>
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

This is used to execute controller specific start code

Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
---
 drivers/nvme/target/core.c  | 3 +++
 drivers/nvme/target/nvmet.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1bfef66..0a0fc48 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -251,6 +251,9 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	}
 
 	ctrl->csts = NVME_CSTS_RDY;
+
+	if (ctrl->start)
+		ctrl->start(ctrl->opaque);
 }
 
 static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9335584..eac008b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -59,6 +59,9 @@ struct nvmet_ctrl {
 	struct kref		ref;
 #define NVMET_SUBSYS_NAME_LEN		256
 	char			subsys_name[NVMET_SUBSYS_NAME_LEN];
+
+	void			*opaque;
+	void			(*start)(void *);
 };
 
 struct nvmet_subsys {
-- 
1.9.1
