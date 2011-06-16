From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 32/77] Staging: hv: netvsc: Get rid of the driver name initialization in netvsc.c
Date: Thu, 16 Jun 2011 13:17:05 -0700
Message-ID: <1308255470-3826-32-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Now, get rid of the driver name initialization in struct hv_driver. 

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hv/netvsc.c b/drivers/staging/hv/netvsc.c
index d59b9bd..763358a 100644
--- a/drivers/staging/hv/netvsc.c
+++ b/drivers/staging/hv/netvsc.c
@@ -32,9 +32,6 @@
 #include "hyperv_net.h"
 
 
-/* Globals */
-static const char *driver_name = "netvsc";
-
 static struct netvsc_device *alloc_net_device(struct hv_device *device)
 {
 	struct netvsc_device *net_device;
@@ -999,7 +996,5 @@ cleanup:
 int netvsc_initialize(struct hv_driver *drv)
 {
 
-	drv->name = driver_name;
-
 	return 0;
 }
-- 
1.7.4.1
