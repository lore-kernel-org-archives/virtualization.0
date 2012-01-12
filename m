From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 05/15] Staging:hv: storvsc: Cleanup storvsc_host_reset_handler()
Date: Thu, 12 Jan 2012 12:37:58 -0800
Message-ID: <1326400688-13544-5-git-send-email-kys@microsoft.com>
References: <1326400637-13494-1-git-send-email-kys@microsoft.com>
 <1326400688-13544-1-git-send-email-kys@microsoft.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1326400688-13544-1-git-send-email-kys@microsoft.com>
Sender: linux-scsi-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, jbottomley@parallels.com, hch@infradead.org, linux-scsi@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup storvsc_host_reset_handler() by getting rid of storvsc_host_reset().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 979f25b..8340387 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -1122,8 +1122,11 @@ static int storvsc_get_chs(struct scsi_device *sdev, struct block_device * bdev,
 	return 0;
 }
 
-static int storvsc_host_reset(struct hv_device *device)
+static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
 {
+	struct hv_host_device *host_dev = shost_priv(scmnd->device->host);
+	struct hv_device *device = host_dev->dev;
+
 	struct storvsc_device *stor_device;
 	struct hv_storvsc_request *request;
 	struct vstor_packet *vstor_packet;
@@ -1165,15 +1168,6 @@ static int storvsc_host_reset(struct hv_device *device)
 }
 
 
-static int storvsc_host_reset_handler(struct scsi_cmnd *scmnd)
-{
-	struct hv_host_device *host_dev = shost_priv(scmnd->device->host);
-	struct hv_device *dev = host_dev->dev;
-
-	return storvsc_host_reset(dev);
-}
-
-
 static void storvsc_command_completion(struct hv_storvsc_request *request)
 {
 	struct storvsc_cmd_request *cmd_request =
-- 
1.7.4.1

