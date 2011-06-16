From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 11/77] Staging: hv: netvsc: Use the newly introduced vmbus ID in netvsc driver
Date: Thu, 16 Jun 2011 13:16:44 -0700
Message-ID: <1308255470-3826-11-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Setup the newly introduced id_table for the netvsc driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 38ca2c2..3656c0f 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -413,8 +413,14 @@ static int netvsc_remove(struct hv_device *dev)
 	return 0;
 }
 
+static const struct hv_vmbus_device_id id_table[] = {
+	{ "hv_net" },
+	{ "" }
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
