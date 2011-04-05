From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 04/22] Staging: hv: Add a function to map a hv_driver pointer to storvsc driver
Date: Tue,  5 Apr 2011 07:04:48 -0700
Message-ID: <1302012306-21277-4-git-send-email-kys@microsoft.com>
References: <1302012261-21236-1-git-send-email-kys@microsoft.com>
 <1302012306-21277-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1302012306-21277-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the need for struct hv_device to be the first
element of struct host_device_context.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c  |    2 +-
 drivers/staging/hv/storvsc_api.h |    8 ++++++--
 drivers/staging/hv/storvsc_drv.c |    2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 3672e15..1e5320e 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -154,7 +154,7 @@ static int blk_vsc_initialize(struct hv_driver *driver)
 	struct storvsc_driver_object *stor_driver;
 	int ret = 0;
 
-	stor_driver = (struct storvsc_driver_object *)driver;
+	stor_driver = hvdr_to_stordr(driver);
 
 	/* Make sure we are at least 2 pages since 1 page is used for control */
 	/* ASSERT(stor_driver->RingBufferSize >= (PAGE_SIZE << 1)); */
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index eeaeaef..5c80cdb 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -25,6 +25,7 @@
 #ifndef _STORVSC_API_H_
 #define _STORVSC_API_H_
 
+#include <linux/kernel.h>
 #include "vstorage.h"
 #include "vmbus_api.h"
 
@@ -90,8 +91,6 @@ struct hv_storvsc_request {
 
 /* Represents the block vsc driver */
 struct storvsc_driver_object {
-	/* Must be the first field */
-	/* Which is a bug FIXME! */
 	struct hv_driver base;
 
 	/* Set by caller (in bytes) */
@@ -159,6 +158,11 @@ static inline void put_stor_device(struct hv_device *device)
 	atomic_dec(&stor_device->ref_count);
 }
 
+static inline struct storvsc_driver_object *hvdr_to_stordr(struct hv_driver *d)
+{
+	return container_of(d, struct storvsc_driver_object, base);
+}
+
 /* Interface */
 
 int stor_vsc_on_device_add(struct hv_device *device,
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 1d13f1b..268c607 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -79,7 +79,7 @@ static int stor_vsc_initialize(struct hv_driver *driver)
 {
 	struct storvsc_driver_object *stor_driver;
 
-	stor_driver = (struct storvsc_driver_object *)driver;
+	stor_driver = hvdr_to_stordr(driver);
 
 	DPRINT_DBG(STORVSC, "sizeof(STORVSC_REQUEST)=%zd "
 		   "sizeof(struct storvsc_request_extension)=%zd "
-- 
1.7.4.1
