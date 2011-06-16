From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 50/77] Staging: hv: vmbus: Cleanup the error return value in vmbus_recvpacket_raw()
Date: Thu, 16 Jun 2011 13:17:23 -0700
Message-ID: <1308255470-3826-50-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use standard Linux errno values.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel.c  |    2 +-
 drivers/staging/hv/hv_mouse.c |    2 +-
 drivers/staging/hv/netvsc.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/channel.c b/drivers/staging/hv/channel.c
index 5476863..dd34c33 100644
--- a/drivers/staging/hv/channel.c
+++ b/drivers/staging/hv/channel.c
@@ -811,7 +811,7 @@ int vmbus_recvpacket_raw(struct vmbus_channel *channel, void *buffer,
 		pr_err("Buffer too small - needed %d bytes but "
 			"got space for only %d bytes\n",
 			packetlen, bufferlen);
-		return -2;
+		return -ENOBUFS;
 	}
 
 	*requestid = desc.trans_id;
diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index b902e0e..0338030 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -542,7 +542,7 @@ static void mousevsc_on_channel_callback(void *context)
 				}
 				break;
 			}
-		} else if (ret == -2) {
+		} else if (ret == -ENOBUFS) {
 			/* Handle large packet */
 			bufferlen = bytes_recvd;
 			buffer = kzalloc(bytes_recvd, GFP_KERNEL);
diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index c060b28..34b62ed 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -884,7 +884,7 @@ static void netvsc_channel_cb(void *context)
 
 				break;
 			}
-		} else if (ret == -2) {
+		} else if (ret == -ENOBUFS) {
 			/* Handle large packet */
 			buffer = kmalloc(bytes_recvd, GFP_ATOMIC);
 			if (buffer == NULL) {
-- 
1.7.4.1
