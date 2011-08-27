From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 22/46] Staging: hv: storvsc: Optimize the bounce buffer
	handling in the "read" case
Date: Sat, 27 Aug 2011 11:31:21 -0700
Message-ID: <1314469905-7058-22-git-send-email-kys@microsoft.com>
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

Optimize the bounce buffer handling in the "read" case.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 90b91ad..3e00e70 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -560,12 +560,10 @@ static int storvsc_queuecommand_lck(struct scsi_cmnd *scmnd,
 				ALIGN(scsi_bufflen(scmnd), PAGE_SIZE) >>
 					PAGE_SHIFT;
 
-			/*
-			 * FIXME: We can optimize on reads by just skipping
-			 * this
-			 */
-			copy_to_bounce_buffer(sgl, cmd_request->bounce_sgl,
-					      scsi_sg_count(scmnd));
+			if (vm_srb->data_in == WRITE_TYPE)
+				copy_to_bounce_buffer(sgl,
+					cmd_request->bounce_sgl,
+					scsi_sg_count(scmnd));
 
 			sgl = cmd_request->bounce_sgl;
 			sg_count = cmd_request->bounce_sgl_count;
-- 
1.7.4.1
