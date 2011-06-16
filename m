From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 67/77] Staging: hv: netvsc: Cleanup error return codes in netvsc_device_add()
Date: Thu, 16 Jun 2011 13:17:40 -0700
Message-ID: <1308255470-3826-67-git-send-email-kys@microsoft.com>
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
 drivers/staging/hv/netvsc.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index e3a2891..0ae35e7 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -918,7 +918,7 @@ int netvsc_device_add(struct hv_device *device, void *additional_info)
 
 	net_device = alloc_net_device(device);
 	if (!net_device) {
-		ret = -1;
+		ret = -ENOMEM;
 		goto cleanup;
 	}
 
@@ -947,7 +947,6 @@ int netvsc_device_add(struct hv_device *device, void *additional_info)
 
 	if (ret != 0) {
 		dev_err(&device->device, "unable to open channel: %d", ret);
-		ret = -1;
 		goto cleanup;
 	}
 
@@ -959,7 +958,6 @@ int netvsc_device_add(struct hv_device *device, void *additional_info)
 	if (ret != 0) {
 		dev_err(&device->device,
 			"unable to connect to NetVSP - %d", ret);
-		ret = -1;
 		goto close;
 	}
 
-- 
1.7.4.1
