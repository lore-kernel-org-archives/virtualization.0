From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 04/25] Staging: hv: Introduce a function to map a generic driver pointer to a pointer to struct netvsc_driver
Date: Tue, 26 Apr 2011 09:20:21 -0700
Message-ID: <1303834842-5022-4-git-send-email-kys@microsoft.com>
References: <1303834785-4981-1-git-send-email-kys@microsoft.com>
 <1303834842-5022-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1303834842-5022-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for getting rid of the priv element from struct hv_driver,
introduce a function to map a generic driver pointer to a pointer to
struct netvsc_driver.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc_api.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/netvsc_api.h b/drivers/staging/hv/netvsc_api.h
index b4bed36..48b512b 100644
--- a/drivers/staging/hv/netvsc_api.h
+++ b/drivers/staging/hv/netvsc_api.h
@@ -26,6 +26,7 @@
 #define _NETVSC_API_H_
 
 #include "vmbus_api.h"
+#include "vmbus.h"
 
 /* Fwd declaration */
 struct hv_netvsc_packet;
@@ -103,6 +104,13 @@ struct netvsc_driver {
 	void *ctx;
 };
 
+static inline
+struct netvsc_driver *drv_to_netvscdrv(struct device_driver *d)
+{
+	struct hv_driver *hvdrv = drv_to_hv_drv(d);
+	return container_of(hvdrv, struct netvsc_driver, base);
+}
+
 struct netvsc_device_info {
 	unsigned char mac_adr[6];
 	bool link_state;	/* 0 - link up, 1 - link down */
-- 
1.7.4.1
