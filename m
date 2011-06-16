From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 60/77] Staging: hv: storvsc: Cleanup error code returned in storvsc_probe()
Date: Thu, 16 Jun 2011 13:17:33 -0700
Message-ID: <1308255470-3826-60-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use standard Linux error codes.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 03ca79e..97ef81d 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -684,7 +684,7 @@ static int storvsc_probe(struct hv_device *device)
 	if (ret != 0) {
 		kmem_cache_destroy(host_dev->request_pool);
 		scsi_host_put(host);
-		return -1;
+		return -ENODEV;
 	}
 
 	host_dev->path = device_info.path_id;
@@ -705,7 +705,7 @@ static int storvsc_probe(struct hv_device *device)
 
 		kmem_cache_destroy(host_dev->request_pool);
 		scsi_host_put(host);
-		return -1;
+		return -ENODEV;
 	}
 
 	scsi_scan_host(host);
-- 
1.7.4.1
