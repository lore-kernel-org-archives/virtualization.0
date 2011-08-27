From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 28/46] Staging: hv: storvsc: Fix a typo
Date: Sat, 27 Aug 2011 11:31:27 -0700
Message-ID: <1314469905-7058-28-git-send-email-kys@microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314469905-7058-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix a typo in a function name.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 72ca25c..ad0f9d4 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -1130,9 +1130,9 @@ static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 
 
 /*
- * storvsc_commmand_completion - Command completion processing
+ * storvsc_command_completion - Command completion processing
  */
-static void storvsc_commmand_completion(struct hv_storvsc_request *request)
+static void storvsc_command_completion(struct hv_storvsc_request *request)
 {
 	struct storvsc_cmd_request *cmd_request =
 		(struct storvsc_cmd_request *)request->context;
@@ -1240,7 +1240,7 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 		break;
 	}
 
-	request->on_io_completion = storvsc_commmand_completion;
+	request->on_io_completion = storvsc_command_completion;
 	request->context = cmd_request;/* scmnd; */
 
 	vm_srb->port_number = host_dev->port;
-- 
1.7.4.1
