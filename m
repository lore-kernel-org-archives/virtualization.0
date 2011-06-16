From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 29/77] Staging: hv: storvsc: Get rid of the device type guid
	from storvsc_drv.c
Date: Thu, 16 Jun 2011 13:17:02 -0700
Message-ID: <1308255470-3826-29-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
	<1308255470-3826-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
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
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of the device type guid from storvsc_drv.c as it is no longer used.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 7d605c9..c908fd8 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -43,14 +43,6 @@ MODULE_PARM_DESC(storvsc_ringbuffer_size, "Ring buffer size (bytes)");
 
 static const char *driver_name = "storvsc";
 
-/* {ba6163d9-04a1-4d29-b605-72e2ffb1dc7f} */
-static const struct hv_guid stor_vsci_device_type = {
-	.data = {
-		0xd9, 0x63, 0x61, 0xba, 0xa1, 0x04, 0x29, 0x4d,
-		0xb6, 0x05, 0x72, 0xe2, 0xff, 0xb1, 0xdc, 0x7f
-	}
-};
-
 struct hv_host_device {
 	struct hv_device *dev;
 	struct kmem_cache *request_pool;
@@ -747,8 +739,6 @@ static int __init storvsc_drv_init(void)
 	sizeof(struct vstor_packet) + sizeof(u64),
 	sizeof(u64)));
 
-	memcpy(&drv->dev_type, &stor_vsci_device_type,
-	       sizeof(struct hv_guid));
 
 	if (max_outstanding_req_per_channel <
 	    STORVSC_MAX_IO_REQUESTS)
-- 
1.7.4.1
