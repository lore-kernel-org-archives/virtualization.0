From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 107/117] Staging: hv: storvsc: Fix a typo
Date: Fri, 15 Jul 2011 10:47:35 -0700
Message-ID: <1310752065-27895-107-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix a typo in a function name.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 9c2bb56..2d7bb41 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -1163,9 +1163,9 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 
 
 /*
- * storvsc_commmand_completion - Command completion processing
+ * storvsc_command_completion - Command completion processing
  */
-static void storvsc_commmand_completion(struct hv_storvsc_request *request)
+static void storvsc_command_completion(struct hv_storvsc_request *request)
 {
 	struct storvsc_cmd_request *cmd_request =
 		(struct storvsc_cmd_request *)request->context;
@@ -1273,7 +1273,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 		break;
 	}
 
-	request->on_io_completion = storvsc_commmand_completion;
+	request->on_io_completion = storvsc_command_completion;
 	request->context = cmd_request;/* scmnd; */
 
 	vm_srb->port_number = host_dev->port;
-- 
1.7.4.1
