From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 026/206] Staging: hv: Rename stor_vsc_on_io_completion
Date: Mon,  9 May 2011 14:55:08 -0700
Message-ID: <1304978288-22999-26-git-send-email-kys@microsoft.com>
References: <1304978242-22958-1-git-send-email-kys@microsoft.com>
	<1304978288-22999-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1304978288-22999-1-git-send-email-kys@microsoft.com>
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

The subject line says it all.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 50ac806..ecc62e1 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -277,7 +277,7 @@ cleanup:
 	return ret;
 }
 
-static void stor_vsc_on_io_completion(struct hv_device *device,
+static void storvsc_on_io_completion(struct hv_device *device,
 				  struct vstor_packet *vstor_packet,
 				  struct hv_storvsc_request *request)
 {
@@ -348,7 +348,7 @@ static void stor_vsc_on_receive(struct hv_device *device,
 	switch (vstor_packet->operation) {
 	case VSTOR_OPERATION_COMPLETE_IO:
 		DPRINT_DBG(STORVSC, "IO_COMPLETE_OPERATION");
-		stor_vsc_on_io_completion(device, vstor_packet, request);
+		storvsc_on_io_completion(device, vstor_packet, request);
 		break;
 	case VSTOR_OPERATION_REMOVE_DEVICE:
 		DPRINT_INFO(STORVSC, "REMOVE_DEVICE_OPERATION");
-- 
1.7.4.1
