From: Olaf Hering <olaf@aepfle.de>
Subject: [PATCH] Staging: hv: netvsc: advertise hv_netvsc instead of netvsc
 as driver name
Date: Fri, 9 Sep 2011 14:46:49 +0200
Message-ID: <20110909124649.GB23598@aepfle.de>
References: <20110908162650.GA10699@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110908162650.GA10699@aepfle.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Olaf Hering <olaf@aepfle.de>

--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -41,6 +41,8 @@
 #include "hyperv.h"
 #include "hyperv_net.h"
 
+#define MODULE_NAME "hv_netvsc"
+
 struct net_device_context {
 	/* point back to our device context */
 	struct hv_device *device_ctx;
@@ -291,7 +293,7 @@ int netvsc_recv_callback(struct hv_devic
 static void netvsc_get_drvinfo(struct net_device *net,
 			       struct ethtool_drvinfo *info)
 {
-	strcpy(info->driver, "hv_netvsc");
+	strcpy(info->driver, MODULE_NAME);
 	strcpy(info->version, HV_DRV_VERSION);
 	strcpy(info->fw_version, "N/A");
 }
@@ -420,7 +422,7 @@ MODULE_DEVICE_TABLE(vmbus, id_table);
 
 /* The one and only one */
 static struct  hv_driver netvsc_drv = {
-	.name = "netvsc",
+	.name = MODULE_NAME,
 	.id_table = id_table,
 	.probe = netvsc_probe,
 	.remove = netvsc_remove,
