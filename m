From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 112/117] Staging: hv: util: Forcefully shutdown when shutdown is requested
Date: Fri, 15 Jul 2011 10:47:40 -0700
Message-ID: <1310752065-27895-112-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

When the host requests a "shutdown", make sure we shutdown!

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_util.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
index 4712d22..070e61f 100644
--- a/drivers/staging/hv/hv_util.c
+++ b/drivers/staging/hv/hv_util.c
@@ -91,7 +91,7 @@ static void shutdown_onchannelcallback(void *context)
 	}
 
 	if (execute_shutdown == true)
-		orderly_poweroff(false);
+		orderly_poweroff(true);
 }
 
 /*
-- 
1.7.4.1
