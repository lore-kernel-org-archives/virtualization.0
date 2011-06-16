From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 37/77] Staging: hv: vmbus: Do not initialize dev_type guid in vmbus_child_device_create()
Date: Thu, 16 Jun 2011 13:17:10 -0700
Message-ID: <1308255470-3826-37-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Do not initialize dev_type guid in vmbus_child_device_create(), as this is
not used.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/vmbus_drv.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/vmbus_drv.c b/drivers/staging/hv/vmbus_drv.c
index 6ec6ef3..2702c48 100644
--- a/drivers/staging/hv/vmbus_drv.c
+++ b/drivers/staging/hv/vmbus_drv.c
@@ -580,7 +580,6 @@ struct hv_device *vmbus_child_device_create(struct hv_guid *type,
 	}
 
 	child_device_obj->channel = channel;
-	memcpy(&child_device_obj->dev_type, type, sizeof(struct hv_guid));
 	/*
 	 * Get the human readable device type name and stash it away.
 	 */
-- 
1.7.4.1
