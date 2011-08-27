From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 45/46] Staging: hv: mousevsc: Fix checkpatch errors and
	warnings
Date: Sat, 27 Aug 2011 11:31:44 -0700
Message-ID: <1314469905-7058-45-git-send-email-kys@microsoft.com>
References: <1314469874-7017-1-git-send-email-kys@microsoft.com>
	<1314469905-7058-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1314469905-7058-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix checkpatch errors and warnings.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 090736a..dbb04ee 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -335,7 +335,8 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	input_device->hid_desc = kzalloc(desc->bLength, GFP_KERNEL);
 
 	if (!input_device->hid_desc) {
-		pr_err("unable to allocate hid descriptor - size %d", desc->bLength);
+		pr_err("unable to allocate hid descriptor - size %d",
+			 desc->bLength);
 		goto cleanup;
 	}
 
@@ -598,12 +599,12 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 	pr_info("synthhid protocol request...");
 
 	ret = vmbus_sendpacket(device->channel, request,
-					sizeof(struct pipe_prt_msg) -
-					sizeof(unsigned char) +
-					sizeof(struct synthhid_protocol_request),
-					(unsigned long)request,
-					VM_PKT_DATA_INBAND,
-					VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
+				sizeof(struct pipe_prt_msg) -
+				sizeof(unsigned char) +
+				sizeof(struct synthhid_protocol_request),
+				(unsigned long)request,
+				VM_PKT_DATA_INBAND,
+				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
 	if (ret != 0) {
 		pr_err("unable to send synthhid protocol request.");
 		goto cleanup;
-- 
1.7.4.1
