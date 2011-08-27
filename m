From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 31/46] Staging: hv: util: Forcefully shutdown when shutdown is requested
Date: Sat, 27 Aug 2011 11:31:30 -0700
Message-ID: <1314469905-7058-31-git-send-email-kys@microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314469905-7058-1-git-send-email-kys@microsoft.com>
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
index f2f456f..876d44a 100644
--- a/drivers/staging/hv/hv_util.c
+++ b/drivers/staging/hv/hv_util.c
@@ -89,7 +89,7 @@ static void shutdown_onchannelcallback(void *context)
 	}
 
 	if (execute_shutdown == true)
-		orderly_poweroff(false);
+		orderly_poweroff(true);
 }
 
 /*
-- 
1.7.4.1
