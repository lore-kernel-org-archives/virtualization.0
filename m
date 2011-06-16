From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/77] Staging: hv: blkvsc: Use the newly introduced vmbus ID in the blockvsc driver
Date: Thu, 16 Jun 2011 13:16:42 -0700
Message-ID: <1308255470-3826-9-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Setup the newly introduced id_table for the blkvsc driver.:

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 3612574..5842db8 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -802,10 +802,15 @@ static void blkvsc_request(struct request_queue *queue)
 	}
 }
 
+static const struct hv_vmbus_device_id id_table[] = {
+	{ "hv_block" },
+	{ "" }
+};
 
 
 /* The one and only one */
 static  struct hv_driver blkvsc_drv = {
+	.id_table = id_table,
 	.probe =  blkvsc_probe,
 	.remove =  blkvsc_remove,
 	.shutdown = blkvsc_shutdown,
-- 
1.7.4.1
