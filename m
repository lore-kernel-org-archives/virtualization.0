From: Ming Lin <mlin@kernel.org>
Subject: [RFC PATCH 6/9] nvmet: add a "parse_extra_admin_cmd" hook
Date: Thu, 19 Nov 2015 16:21:05 -0800
Message-ID: <1447978868-17138-7-git-send-email-mlin@kernel.org>
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

This is used to execute controller specific cmd parse code

Signed-off-by: Ming Lin <ming.l@ssi.samsung.com>
---
 drivers/nvme/target/admin-cmd.c | 7 +++++++
 drivers/nvme/target/nvmet.h     | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d9db0d4..f009c77 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -346,6 +346,13 @@ int nvmet_parse_admin_cmd(struct nvmet_req *req)
 		req->data = 0;
 		return 0;
 #endif
+	default:
+		if (req->sq->ctrl->parse_extra_admin_cmd) {
+			int ret = req->sq->ctrl->parse_extra_admin_cmd(req);
+
+			if (!ret)
+				return 0;
+		}
 	}
 
 	pr_err("nvmet: unhandled cmd %d\n", cmd->common.opcode);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index eac008b..ef79813 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -44,6 +44,8 @@ struct nvmet_sq {
 	u16			size;
 };
 
+struct nvmet_req;
+
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_cq		**cqs;
@@ -62,6 +64,7 @@ struct nvmet_ctrl {
 
 	void			*opaque;
 	void			(*start)(void *);
+	int			(*parse_extra_admin_cmd)(struct nvmet_req *);
 };
 
 struct nvmet_subsys {
-- 
1.9.1
