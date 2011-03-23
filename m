From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 03/16] Staging: hv: Move the definition of struct storvsc_device
Date: Wed, 23 Mar 2011 10:50:21 -0700
Message-ID: <1300902635-1347-3-git-send-email-kys@microsoft.com>
References: <1300902537-1290-1-git-send-email-kys@microsoft.com>
 <1300902635-1347-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1300902635-1347-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

In preparation for getting rid of the inclusion of storvsc.c from
blkvsc.c, move the definition of struct storvsc_device
from storvsc.c to storvsc_api.h.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c     |   26 --------------------------
 drivers/staging/hv/storvsc_api.h |   26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 56f3cc9..be1c77a 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -33,32 +33,6 @@
 #include "channel.h"
 
 
-/* A storvsc device is a device object that contains a vmbus channel */
-struct storvsc_device {
-	struct hv_device *device;
-
-	/* 0 indicates the device is being destroyed */
-	atomic_t ref_count;
-
-	atomic_t num_outstanding_req;
-
-	/*
-	 * Each unique Port/Path/Target represents 1 channel ie scsi
-	 * controller. In reality, the pathid, targetid is always 0
-	 * and the port is set by us
-	 */
-	unsigned int port_number;
-	unsigned char path_id;
-	unsigned char target_id;
-
-	/* LIST_ENTRY OutstandingRequestList; */
-	/* HANDLE OutstandingRequestLock; */
-
-	/* Used for vsc/vsp channel reset process */
-	struct storvsc_request_extension init_request;
-	struct storvsc_request_extension reset_request;
-};
-
 
 static const char *g_driver_name = "storvsc";
 
diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 629144c..2b814bd 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -114,6 +114,32 @@ struct storvsc_request_extension {
 	struct vstor_packet vstor_packet;
 };
 
+/* A storvsc device is a device object that contains a vmbus channel */
+struct storvsc_device {
+	struct hv_device *device;
+
+	/* 0 indicates the device is being destroyed */
+	atomic_t ref_count;
+
+	atomic_t num_outstanding_req;
+
+	/*
+	 * Each unique Port/Path/Target represents 1 channel ie scsi
+	 * controller. In reality, the pathid, targetid is always 0
+	 * and the port is set by us
+	 */
+	unsigned int port_number;
+	unsigned char path_id;
+	unsigned char target_id;
+
+	/* LIST_ENTRY OutstandingRequestList; */
+	/* HANDLE OutstandingRequestLock; */
+
+	/* Used for vsc/vsp channel reset process */
+	struct storvsc_request_extension init_request;
+	struct storvsc_request_extension reset_request;
+};
+
 /* Interface */
 int stor_vsc_initialize(struct hv_driver *driver);
 int stor_vsc_on_host_reset(struct hv_device *device);
-- 
1.7.4.1
