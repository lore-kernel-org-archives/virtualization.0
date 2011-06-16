From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 10/77] Staging: hv: storvsc: Use the newly introduced vmbus ID in storvsc driver
Date: Thu, 16 Jun 2011 13:16:43 -0700
Message-ID: <1308255470-3826-10-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Setup the newly introduced id_table for the storvsc driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 7effaf3..b71764d 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -646,6 +646,10 @@ static struct scsi_host_template scsi_driver = {
 	.dma_boundary =		PAGE_SIZE-1,
 };
 
+static const struct hv_vmbus_device_id id_table[] = {
+	{ "hv_scsi" },
+	{ "" }
+};
 
 /*
  * storvsc_probe - Add a new device for this driver
@@ -720,6 +724,7 @@ static int storvsc_probe(struct hv_device *device)
 /* The one and only one */
 
 static struct hv_driver storvsc_drv = {
+	.id_table = id_table,
 	.probe = storvsc_probe,
 	.remove = storvsc_remove,
 };
-- 
1.7.4.1
