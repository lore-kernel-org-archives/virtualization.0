From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 033/117] Staging: hv: vmbus: Get rid of the unused name field in struct hv_driver
Date: Fri, 15 Jul 2011 10:46:21 -0700
Message-ID: <1310752065-27895-33-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the unused "name" field in struct hv_driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hyperv.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index b8199f4..60ead66 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -802,8 +802,6 @@ struct hv_device_info {
 
 /* Base driver object */
 struct hv_driver {
-	const char *name;
-
 	/* the device type supported by this driver */
 	uuid_le dev_type;
 	const struct hv_vmbus_device_id *id_table;
-- 
1.7.4.1
