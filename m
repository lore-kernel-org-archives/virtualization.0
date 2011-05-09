From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 040/206] Staging: hv: Move the function storvsc_merge_bvec()
	to earlier in the file
Date: Mon,  9 May 2011 14:55:22 -0700
Message-ID: <1304978288-22999-40-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 2bd9c09..44dbaae 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -122,6 +122,13 @@ static int storvsc_device_alloc(struct scsi_device *sdevice)
 	return 0;
 }
 
+static int storvsc_merge_bvec(struct request_queue *q,
+			      struct bvec_merge_data *bmd, struct bio_vec *bvec)
+{
+	/* checking done by caller. */
+	return bvec->bv_len;
+}
+
 /* Static decl */
 static int storvsc_probe(struct hv_device *dev);
 static int storvsc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd);
@@ -823,13 +830,6 @@ retry_request:
 
 static DEF_SCSI_QCMD(storvsc_queuecommand)
 
-static int storvsc_merge_bvec(struct request_queue *q,
-			      struct bvec_merge_data *bmd, struct bio_vec *bvec)
-{
-	/* checking done by caller. */
-	return bvec->bv_len;
-}
-
 static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	scsi_adjust_queue_depth(sdevice, MSG_SIMPLE_TAG,
-- 
1.7.4.1
