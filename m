From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 008/117] Staging: hv: netvsc: Use the newly introduced vmbus
	ID in netvsc driver
Date: Fri, 15 Jul 2011 10:45:56 -0700
Message-ID: <1310752065-27895-8-git-send-email-kys@microsoft.com>
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

Use the newly introduced vmbus ID in netvsc driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 61989f0..1f4b7b4 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -413,8 +413,25 @@ static int netvsc_remove(struct hv_device *dev)
 	return 0;
 }
 
+static const struct hv_vmbus_device_id id_table[] = {
+	{
+		/* Network guid */
+		.guid = {
+			0x63, 0x51, 0x61, 0xF8, 0x3E, 0xDF, 0xc5, 0x46,
+			0x91, 0x3F, 0xF2, 0xD2, 0xF9, 0x65, 0xED, 0x0E
+		}
+	},
+	{
+		.guid = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		}
+	},
+};
+
 /* The one and only one */
 static struct  hv_driver netvsc_drv = {
+	.id_table = id_table,
 	.probe = netvsc_probe,
 	.remove = netvsc_remove,
 };
-- 
1.7.4.1
