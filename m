From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 007/117] Staging: hv: storvsc: Use the newly introduced vmbus
	ID in storvsc driver
Date: Fri, 15 Jul 2011 10:45:55 -0700
Message-ID: <1310752065-27895-7-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use the newly introduced vmbus ID in storvsc driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index e4cdbc5..e30f11c 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -646,6 +646,21 @@ static struct scsi_host_template scsi_driver = {
 	.dma_boundary =		PAGE_SIZE-1,
 };
 
+static const struct hv_vmbus_device_id id_table[] = {
+	{
+		/* SCSI guid */
+		.guid = {
+			0xd9, 0x63, 0x61, 0xba, 0xa1, 0x04, 0x29, 0x4d,
+			0xb6, 0x05, 0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f
+		}
+	},
+	{
+		.guid = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		}
+	},
+};
 
 /*
  * storvsc_probe - Add a new device for this driver
@@ -720,6 +735,7 @@ static int storvsc_probe(struct hv_device *device)
 /* The one and only one */
 
 static struct hv_driver storvsc_drv = {
+	.id_table = id_table,
 	.probe = storvsc_probe,
 	.remove = storvsc_remove,
 };
-- 
1.7.4.1
