From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 21/59] Staging: hv: netvsc: Get rid of the empty function netvsc_initialize()
Date: Thu, 25 Aug 2011 09:48:47 -0700
Message-ID: <1314290965-2698-21-git-send-email-kys@microsoft.com>
References: <1314290866-2644-1-git-send-email-kys@microsoft.com>
 <1314290965-2698-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1314290965-2698-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, get rid of the empty function netvsc_initialize().

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hyperv_net.h |    1 -
 drivers/staging/hv/netvsc.c     |    9 ---------
 drivers/staging/hv/netvsc_drv.c |    3 ---
 3 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/hv/hyperv_net.h b/drivers/staging/hv/hyperv_net.h
index 27f987b..5782fea 100644
--- a/drivers/staging/hv/hyperv_net.h
+++ b/drivers/staging/hv/hyperv_net.h
@@ -96,7 +96,6 @@ void netvsc_linkstatus_callback(struct hv_device *device_obj,
 				unsigned int status);
 int netvsc_recv_callback(struct hv_device *device_obj,
 			struct hv_netvsc_packet *packet);
-int netvsc_initialize(struct hv_driver *drv);
 int rndis_filter_open(struct hv_device *dev);
 int rndis_filter_close(struct hv_device *dev);
 int rndis_filter_device_add(struct hv_device *dev,
diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index d085018..cb02eed 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -989,12 +989,3 @@ cleanup:
 
 	return ret;
 }
-
-/*
- * netvsc_initialize - Main entry point
- */
-int netvsc_initialize(struct hv_driver *drv)
-{
-
-	return 0;
-}
diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 61de6f2..bb46216 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -448,9 +448,6 @@ static int __init netvsc_drv_init(void)
 
 	pr_info("initializing....");
 
-	/* Callback to client driver to complete the initialization */
-	netvsc_initialize(drv);
-
 	drv->driver.name = driver_name;
 
 	/* The driver belongs to vmbus */
-- 
1.7.4.1
