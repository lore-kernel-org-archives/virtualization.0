From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/22] Staging: hv: Move the definition of struct
	storvsc_request_extension
Date: Tue,  5 Apr 2011 07:04:45 -0700
Message-ID: <1302012306-21277-1-git-send-email-kys@microsoft.com>
References: <1302012261-21236-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1302012261-21236-1-git-send-email-kys@microsoft.com>
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

In preperation for embedding struct storvsc_request_extension into
struct hv_storvsc_request, move the definition of
struct storvsc_request_extension.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_api.h |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index 5f41ef6..800ebbf 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -53,6 +53,18 @@ enum storvsc_request_type{
 	UNKNOWN_TYPE,
 };
 
+
+struct storvsc_request_extension {
+	struct hv_storvsc_request *request;
+	struct hv_device *device;
+
+	/* Synchronize the request/response if needed */
+	int wait_condition;
+	wait_queue_head_t wait_event;
+
+	struct vstor_packet vstor_packet;
+};
+
 struct hv_storvsc_request {
 	enum storvsc_request_type type;
 	u32 host;
@@ -103,17 +115,6 @@ struct storvsc_device_info {
 	unsigned char target_id;
 };
 
-struct storvsc_request_extension {
-	struct hv_storvsc_request *request;
-	struct hv_device *device;
-
-	/* Synchronize the request/response if needed */
-	int wait_condition;
-	wait_queue_head_t wait_event;
-
-	struct vstor_packet vstor_packet;
-};
-
 /* A storvsc device is a device object that contains a vmbus channel */
 struct storvsc_device {
 	struct hv_device *device;
-- 
1.7.4.1
