From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 8/8] Staging: hv: vmbus: Get rid of an unnecessary check in vmbus_connect()
Date: Mon, 15 Aug 2011 15:12:07 -0700
Message-ID: <1313446327-10650-8-git-send-email-kys@microsoft.com>
References: <1313446210-10611-1-git-send-email-kys@microsoft.com>
 <1313446327-10650-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313446327-10650-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of an unnecessary check in vmbus_connect(). Since vmbus_connect is
only called once, the check being removed is redundant.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/connection.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index 66b7c4b..9e99c04 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -50,10 +50,6 @@ int vmbus_connect(void)
 	struct vmbus_channel_initiate_contact *msg;
 	unsigned long flags;
 
-	/* Make sure we are not connecting or connected */
-	if (vmbus_connection.conn_state != DISCONNECTED)
-		return -EISCONN;
-
 	/* Initialize the vmbus connection */
 	vmbus_connection.conn_state = CONNECTING;
 	vmbus_connection.work_queue = create_workqueue("hv_vmbus_con");
-- 
1.7.4.1
