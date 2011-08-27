From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 29/46] Staging: hv: storvsc: In case of scsi errors offline
	the device
Date: Sat, 27 Aug 2011 11:31:28 -0700
Message-ID: <1314469905-7058-29-git-send-email-kys@microsoft.com>
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

When we do get fatal errors from the host, offline the device since the
host has already tried all possible recovery actions.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index ad0f9d4..22a1d75 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -1154,7 +1154,15 @@ static void storvsc_command_completion(struct hv_storvsc_request *request)
 		}
 	}
 
-	scmnd->result = vm_srb->scsi_status;
+	/*
+	 * If there is an error; offline the device since all
+	 * error recovery strategies would have already been
+	 * deployed on the host side.
+	 */
+	if (vm_srb->srb_status == 0x4)
+		scmnd->result = DID_TARGET_FAILURE << 16;
+	else
+		scmnd->result = vm_srb->scsi_status;
 
 	if (scmnd->result) {
 		if (scsi_normalize_sense(scmnd->sense_buffer,
-- 
1.7.4.1
