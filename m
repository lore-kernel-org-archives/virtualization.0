From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 04/11] Staging: hv: storvsc: Fix error handling
	storvsc_host_reset()
Date: Tue,  8 Nov 2011 09:01:43 -0800
Message-ID: <1320771710-29139-4-git-send-email-kys@microsoft.com>
References: <1320771677-29095-1-git-send-email-kys@microsoft.com>
	<1320771710-29139-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1320771710-29139-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, James.Bottomley@HansenPartnership.com, hch@infradead.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix error handling storvsc_host_reset(). I would like to thank
Long Li <longli@microsoft.com> for reporting this.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Reported-by: Long Li <longli@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   20 ++++++--------------
 1 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index e16c7a3..a145245 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -1019,7 +1019,7 @@ static int storvsc_host_reset(struct hv_device *device)
 
 	stor_device = get_out_stor_device(device);
 	if (!stor_device)
-		return -ENODEV;
+		return FAILED;
 
 	request = &stor_device->reset_request;
 	vstor_packet = &request->vstor_packet;
@@ -1036,13 +1036,11 @@ static int storvsc_host_reset(struct hv_device *device)
 			       VM_PKT_DATA_INBAND,
 			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret != 0)
-		goto cleanup;
+		return FAILED;
 
 	t = wait_for_completion_timeout(&request->wait_event, 5*HZ);
-	if (t == 0) {
-		ret = -ETIMEDOUT;
-		goto cleanup;
-	}
+	if (t == 0)
+		return TIMEOUT_ERROR;
 
 
 	/*
@@ -1050,8 +1048,7 @@ static int storvsc_host_reset(struct hv_device *device)
 	 * should have been flushed out and return to us
 	 */
 
-cleanup:
-	return ret;
+	return SUCCESS;
 }
 
 
@@ -1060,16 +1057,11 @@ cleanup:
  */
 static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 {
-	int ret;
 	struct hv_host_device *host_dev =
 		(struct hv_host_device *)scmnd->device->host->hostdata;
 	struct hv_device *dev = host_dev->dev;
 
-	ret = storvsc_host_reset(dev);
-	if (ret != 0)
-		return ret;
-
-	return ret;
+	return storvsc_host_reset(dev);
 }
 
 
-- 
1.7.4.1
