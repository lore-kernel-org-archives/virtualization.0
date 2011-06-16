From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 14/77] Staging: hv: util: Make hv_utils a vmbus device driver
Date: Thu, 16 Jun 2011 13:16:47 -0700
Message-ID: <1308255470-3826-14-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Make hv_utils a vmbus device driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/hv_util.c |   34 +++++++++++++++++++++++++++++++++-
 1 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/hv_util.c b/drivers/staging/hv/hv_util.c
index c164b54..4d2a282 100644
--- a/drivers/staging/hv/hv_util.c
+++ b/drivers/staging/hv/hv_util.c
@@ -36,6 +36,8 @@ static u8 *shut_txf_buf;
 static u8 *time_txf_buf;
 static u8 *hbeat_txf_buf;
 
+static const char *driver_name = "hv_util";
+
 static void shutdown_onchannelcallback(void *context)
 {
 	struct vmbus_channel *channel = context;
@@ -210,6 +212,34 @@ static void heartbeat_onchannelcallback(void *context)
 	}
 }
 
+/*
+ * The devices managed by the util driver don't need any additional
+ * setup.
+ */
+static int util_probe(struct hv_device *dev)
+{
+	return 0;
+}
+
+static int util_remove(struct hv_device *dev)
+{
+	return 0;
+}
+
+
+static const struct hv_vmbus_device_id id_table[] = {
+	{ "hv_util" },
+	{ "" }
+};
+
+
+/* The one and only one */
+static  struct hv_driver util_drv = {
+	.id_table = id_table,
+	.probe =  util_probe,
+	.remove =  util_remove,
+};
+
 static const struct pci_device_id __initconst
 hv_utils_pci_table[] __maybe_unused = {
 	{ PCI_DEVICE(0x1414, 0x5353) }, /* Hyper-V emulated VGA controller */
@@ -264,7 +294,9 @@ static int __init init_hyperv_utils(void)
 
 	hv_cb_utils[HV_KVP_MSG].callback = &hv_kvp_onchannelcallback;
 
-	return 0;
+	util_drv.driver.name = driver_name;
+
+	return vmbus_child_driver_register(&util_drv.driver);
 }
 
 static void exit_hyperv_utils(void)
-- 
1.7.4.1
