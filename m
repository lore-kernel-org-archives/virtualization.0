From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 04/24] Staging: hv: mousevsc: Change the allocation flags to
	reflect interrupt context
Date: Thu, 29 Sep 2011 11:54:44 -0700
Message-ID: <1317322504-9788-4-git-send-email-kys@microsoft.com>
References: <1317322456-9747-1-git-send-email-kys@microsoft.com>
	<1317322504-9788-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1317322504-9788-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Change the allocation flags to reflect interrupt context.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 016d7e5..b7cc164 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -329,7 +329,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	desc = &device_info->hid_descriptor;
 	WARN_ON(desc->bLength == 0);
 
-	input_device->hid_desc = kzalloc(desc->bLength, GFP_KERNEL);
+	input_device->hid_desc = kzalloc(desc->bLength, GFP_ATOMIC);
 
 	if (!input_device->hid_desc) {
 		pr_err("unable to allocate hid descriptor - size %d",
@@ -342,7 +342,7 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 	/* Save the report desc */
 	input_device->report_desc_size = desc->desc[0].wDescriptorLength;
 	input_device->report_desc = kzalloc(input_device->report_desc_size,
-					  GFP_KERNEL);
+					  GFP_ATOMIC);
 
 	if (!input_device->report_desc) {
 		pr_err("unable to allocate report descriptor - size %d",
@@ -541,7 +541,7 @@ static void mousevsc_on_channel_callback(void *context)
 		} else if (ret == -ENOBUFS) {
 			/* Handle large packet */
 			bufferlen = bytes_recvd;
-			buffer = kzalloc(bytes_recvd, GFP_KERNEL);
+			buffer = kzalloc(bytes_recvd, GFP_ATOMIC);
 
 			if (buffer == NULL) {
 				buffer = packet;
-- 
1.7.4.1
