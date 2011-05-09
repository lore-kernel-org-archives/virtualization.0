From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 039/206] Staging: hv: Get rid of the forward declaration for
	storvsc_device_alloc()
Date: Mon,  9 May 2011 14:55:21 -0700
Message-ID: <1304978288-22999-39-git-send-email-kys@microsoft.com>
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

Get rid of the forward declaration by moving the code around.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   24 ++++++++++--------------
 1 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 52d8974..2bd9c09 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -112,10 +112,19 @@ static int stor_vsc_initialize(struct hv_driver *driver)
 	return 0;
 }
 
+static int storvsc_device_alloc(struct scsi_device *sdevice)
+{
+	/*
+	 * This enables luns to be located sparsely. Otherwise, we may not
+	 * discovered them.
+	 */
+	sdevice->sdev_bflags |= BLIST_SPARSELUN | BLIST_LARGELUN;
+	return 0;
+}
+
 /* Static decl */
 static int storvsc_probe(struct hv_device *dev);
 static int storvsc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *scmnd);
-static int storvsc_device_alloc(struct scsi_device *);
 static int storvsc_device_configure(struct scsi_device *);
 static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd);
 static int storvsc_remove(struct hv_device *dev);
@@ -821,19 +830,6 @@ static int storvsc_merge_bvec(struct request_queue *q,
 	return bvec->bv_len;
 }
 
-/*
- * storvsc_device_configure - Configure the specified scsi device
- */
-static int storvsc_device_alloc(struct scsi_device *sdevice)
-{
-	/*
-	 * This enables luns to be located sparsely. Otherwise, we may not
-	 * discovered them.
-	 */
-	sdevice->sdev_bflags |= BLIST_SPARSELUN | BLIST_LARGELUN;
-	return 0;
-}
-
 static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	scsi_adjust_queue_depth(sdevice, MSG_SIMPLE_TAG,
-- 
1.7.4.1
