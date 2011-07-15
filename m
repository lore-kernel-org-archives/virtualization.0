From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 009/117] Staging: hv: mousevsc: Use the newly introduced vmbus
	ID in mouse driver
Date: Fri, 15 Jul 2011 10:45:57 -0700
Message-ID: <1310752065-27895-9-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
	<1310752065-27895-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use the newly introduced vmbus ID in mouse driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 6f0992a..b8514fd 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -915,8 +915,24 @@ static void reportdesc_callback(struct hv_device *dev, void *packet, u32 len)
 	kfree(hid_dev);
 }
 
+static const struct hv_vmbus_device_id id_table[] = {
+	{
+		/* Mouse guid */
+		.guid = {
+			0x9E, 0xB6, 0xA8, 0xCF, 0x4A, 0x5B, 0xc0, 0x4c,
+			0xB9, 0x8B, 0x8B, 0xA1, 0xA1, 0xF3, 0xF9, 0x5A
+		}
+	},
+	{
+		.guid = {
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+		}
+	},
+};
 
 static struct  hv_driver mousevsc_drv = {
+	.id_table = id_table,
 	.probe = mousevsc_probe,
 	.remove = mousevsc_remove,
 };
-- 
1.7.4.1
