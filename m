From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 55/77] Staging: hv: storvsc: Cleanup error handling in storvsc_connect_to_vsp()
Date: Thu, 16 Jun 2011 13:17:28 -0700
Message-ID: <1308255470-3826-55-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup error handling in storvsc_connect_to_vsp().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 1470ccf..04b14e6 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -376,7 +376,7 @@ static int storvsc_connect_to_vsp(struct hv_device *device, u32 ring_size)
 			 storvsc_on_channel_callback, device);
 
 	if (ret != 0)
-		return -1;
+		return ret;
 
 	ret = storvsc_channel_init(device);
 
-- 
1.7.4.1
