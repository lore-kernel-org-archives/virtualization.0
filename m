From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 028/117] Staging: hv: storvsc: Get rid of the device type guid from storvsc_drv.c
Date: Fri, 15 Jul 2011 10:46:16 -0700
Message-ID: <1310752065-27895-28-git-send-email-kys@microsoft.com>
References: <1310752024-27854-1-git-send-email-kys@microsoft.com>
 <1310752065-27895-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1310752065-27895-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the device type guid from storvsc_drv.c as it is no longer used.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index f594ca4..46cb81a 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -43,14 +43,6 @@ MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
 
 static const char *driver_name = "storvsc";
 
-/* {ba6163d9-04a1-4d29-b605-72e2ffb1dc7f} */
-static const uuid_le stor_vsci_device_type = {
-	.b = {
-		0xd9, 0x63, 0x61, 0xba, 0xa1, 0x04, 0x29, 0x4d,
-		0xb6, 0x05, 0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f
-	}
-};
-
 struct hv_host_device {
 	struct hv_device *dev;
 	struct kmem_cache *request_pool;
@@ -759,9 +751,6 @@ static int __init storvsc_drv_init(void)
 	sizeof(struct vstor_packet) + sizeof(u64),
 	sizeof(u64)));
 
-	memcpy(&drv->dev_type, &stor_vsci_device_type,
-	       sizeof(uuid_le));
-
 	if (max_outstanding_req_per_channel <
 	    STORVSC_MAX_IO_REQUESTS)
 		return -1;
-- 
1.7.4.1
