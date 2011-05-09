From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 109/206] Staging: hv: Rename the variable gSupportedDeviceClasses
Date: Mon,  9 May 2011 14:56:31 -0700
Message-ID: <1304978288-22999-109-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
 <1304978288-22999-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/channel_mgmt.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/channel_mgmt.c b/drivers/staging/hv/channel_mgmt.c
index 1929ab3..71b79c6 100644
--- a/drivers/staging/hv/channel_mgmt.c
+++ b/drivers/staging/hv/channel_mgmt.c
@@ -42,7 +42,7 @@ struct vmbus_channel_message_table_entry {
 #define MAX_NUM_DEVICE_CLASSES_SUPPORTED 8
 
 static const struct hv_guid
-	gSupportedDeviceClasses[MAX_NUM_DEVICE_CLASSES_SUPPORTED] = {
+	supported_device_classes[MAX_NUM_DEVICE_CLASSES_SUPPORTED] = {
 	/* {ba6163d9-04a1-4d29-b605-72e2ffb1dc7f} */
 	/* Storage - SCSI */
 	{
@@ -459,7 +459,8 @@ static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
 	offer = (struct vmbus_channel_offer_channel *)hdr;
 	for (i = 0; i < MAX_NUM_DEVICE_CLASSES_SUPPORTED; i++) {
 		if (memcmp(&offer->offer.if_type,
-		    &gSupportedDeviceClasses[i], sizeof(struct hv_guid)) == 0) {
+			&supported_device_classes[i],
+			sizeof(struct hv_guid)) == 0) {
 			fsupported = 1;
 			break;
 		}
-- 
1.7.4.1
