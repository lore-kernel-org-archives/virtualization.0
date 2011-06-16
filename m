From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 12/77] Staging: hv: mousevsc: Use the newly introduced vmbus ID in mouse driver
Date: Thu, 16 Jun 2011 13:16:45 -0700
Message-ID: <1308255470-3826-12-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Setup the newly introduced id_table for the mouse driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index b191810..cc7f9e8 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -915,8 +915,13 @@ static void reportdesc_callback(struct hv_device *dev, void *packet, u32 len)
 	kfree(hid_dev);
 }
 
+static const struct hv_vmbus_device_id id_table[] = {
+	{ "hv_mouse" },
+	{ "" }
+};
 
 static struct  hv_driver mousevsc_drv = {
+	.id_table = id_table,
 	.probe = mousevsc_probe,
 	.remove = mousevsc_remove,
 };
-- 
1.7.4.1
