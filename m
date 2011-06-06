From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 46/49] Staging: hv: vmbus: Cleanup error codes in connection.c
Date: Mon,  6 Jun 2011 15:50:10 -0700
Message-ID: <1307400613-13234-46-git-send-email-kys@microsoft.com>
References: <1307400540-13193-1-git-send-email-kys@microsoft.com>
	<1307400613-13234-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1307400613-13234-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup error codes in connection.c.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
---
 drivers/staging/hv/connection.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/connection.c b/drivers/staging/hv/connection.c
index 7d7f1d5..7e15392 100644
--- a/drivers/staging/hv/connection.c
+++ b/drivers/staging/hv/connection.c
@@ -51,13 +51,13 @@ int vmbus_connect(void)
 
 	/* Make sure we are not connecting or connected */
 	if (vmbus_connection.conn_state != DISCONNECTED)
-		return -1;
+		return -EISCONN;
 
 	/* Initialize the vmbus connection */
 	vmbus_connection.conn_state = CONNECTING;
 	vmbus_connection.work_queue = create_workqueue("hv_vmbus_con");
 	if (!vmbus_connection.work_queue) {
-		ret = -1;
+		ret = -ENOMEM;
 		goto cleanup;
 	}
 
@@ -74,7 +74,7 @@ int vmbus_connect(void)
 	vmbus_connection.int_page =
 	(void *)__get_free_pages(GFP_KERNEL|__GFP_ZERO, 0);
 	if (vmbus_connection.int_page == NULL) {
-		ret = -1;
+		ret = -ENOMEM;
 		goto cleanup;
 	}
 
@@ -90,7 +90,7 @@ int vmbus_connect(void)
 	vmbus_connection.monitor_pages =
 	(void *)__get_free_pages((GFP_KERNEL|__GFP_ZERO), 1);
 	if (vmbus_connection.monitor_pages == NULL) {
-		ret = -1;
+		ret = -ENOMEM;
 		goto cleanup;
 	}
 
@@ -157,7 +157,7 @@ int vmbus_connect(void)
 		pr_err("Unable to connect, "
 			"Version %d not supported by Hyper-V\n",
 			VMBUS_REVISION_NUMBER);
-		ret = -1;
+		ret = -ECONNREFUSED;
 		goto cleanup;
 	}
 
-- 
1.7.4.1
