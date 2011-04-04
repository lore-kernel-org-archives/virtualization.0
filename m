From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 20/22] Staging: hv: Fix a jump label (Remove) in blkvsc_drv.c
Date: Mon,  4 Apr 2011 15:48:09 -0700
Message-ID: <1301957291-8035-20-git-send-email-kys@microsoft.com>
References: <1301957186-7853-1-git-send-email-kys@microsoft.com>
 <1301957291-8035-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1301957291-8035-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

One of the jump labels was named Remove; change it to remove.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 0891bc2..8874654 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -1004,7 +1004,7 @@ static int blkvsc_probe(struct device *device)
 				DPRINT_ERR(BLKVSC_DRV,
 					   "register_blkdev() failed! ret %d",
 					   ret);
-				goto Remove;
+				goto remove;
 			}
 
 			ide0_registered = 1;
@@ -1019,7 +1019,7 @@ static int blkvsc_probe(struct device *device)
 				DPRINT_ERR(BLKVSC_DRV,
 					   "register_blkdev() failed! ret %d",
 					   ret);
-				goto Remove;
+				goto remove;
 			}
 
 			ide1_registered = 1;
@@ -1069,7 +1069,7 @@ static int blkvsc_probe(struct device *device)
 
 	return ret;
 
-Remove:
+remove:
 	storvsc_drv_obj->base.dev_rm(device_obj);
 
 cleanup:
-- 
1.7.4.1
