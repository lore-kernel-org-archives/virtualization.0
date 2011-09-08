From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 09/25] Staging: hv: util: Perform some service specific
	de-initialization in util_remove()
Date: Thu,  8 Sep 2011 07:24:20 -0700
Message-ID: <1315491876-9554-9-git-send-email-kys@microsoft.com>
References: <1315491843-9513-1-git-send-email-kys@microsoft.com>
	<1315491876-9554-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1315491876-9554-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for modifying the util driver to fully conform to the
Linux Driver Model, perform some service specific de-initialization in
util_remove() as opposed to in exit_hyperv_utils() as is currently done.


Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_util.c |   29 ++++++++++++++++++++++++-----
 1 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
index b86128a..2475ab2 100644
--- a/drivers/staging/hv/hv_util.c
+++ b/drivers/staging/hv/hv_util.c
@@ -291,6 +291,30 @@ error:
 static int util_remove(struct hv_device *dev,
 			const struct hv_vmbus_device_id *dev_id)
 {
+	int service = dev_id->driver_data;
+
+	switch (service) {
+	case HV_SHUTDOWN:
+		kfree(shut_txf_buf);
+		break;
+
+	case HV_TIMESYNC:
+		kfree(time_txf_buf);
+		break;
+
+	case HV_HEARTBEAT:
+		kfree(hbeat_txf_buf);
+		break;
+
+	case HV_KVP:
+		hv_kvp_deinit();
+		break;
+
+	default:
+		pr_err("unknown util service\n");
+		return -ENODEV;
+	}
+
 	return 0;
 }
 
@@ -370,11 +394,6 @@ static void exit_hyperv_utils(void)
 			&chn_cb_negotiate;
 	hv_cb_utils[HV_KVP_MSG].callback = NULL;
 
-	hv_kvp_deinit();
-
-	kfree(shut_txf_buf);
-	kfree(time_txf_buf);
-	kfree(hbeat_txf_buf);
 	vmbus_driver_unregister(&util_drv);
 }
 
-- 
1.7.4.1
