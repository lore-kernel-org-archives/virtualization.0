From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 42/46] Staging: hv: vmbus: Get rid of an unnecessary check in vmbus_connect()
Date: Sat, 27 Aug 2011 11:31:41 -0700
Message-ID: <1314469905-7058-42-git-send-email-kys@microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
 <1314469905-7058-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314469905-7058-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of an unnecessary check in vmbus_connect().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/connection.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index 6aab802..ca92ca3 100644
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
