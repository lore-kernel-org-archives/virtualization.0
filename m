From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 15/20] Staging: hv: vmbus: Get rid of the ext field in struct hv_device
Date: Tue, 13 Sep 2011 10:59:51 -0700
Message-ID: <1315936796-20662-15-git-send-email-kys@microsoft.com>
References: <1315936759-20623-1-git-send-email-kys@microsoft.com>
 <1315936796-20662-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1315936796-20662-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now that we have eliminated all uses of the ext field in struct hv_device,
get rid of the ext field.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hyperv.h |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/hyperv.h b/drivers/staging/hv/hyperv.h
index e51341f..4b692ea 100644
--- a/drivers/staging/hv/hyperv.h
+++ b/drivers/staging/hv/hyperv.h
@@ -822,9 +822,6 @@ struct hv_device {
 	struct device device;
 
 	struct vmbus_channel *channel;
-
-	/* Device extension; */
-	void *ext;
 };
 
 
-- 
1.7.4.1
