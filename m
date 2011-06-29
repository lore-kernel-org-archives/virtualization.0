From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 01/40] Staging: hv: storvsc: Do not aquire an unnecessary reference on stor_device
Date: Wed, 29 Jun 2011 07:38:58 -0700
Message-ID: <1309358377-8537-1-git-send-email-kys@microsoft.com>
References: <1309358301-8488-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309358301-8488-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Abhishek Kane <v-abkane@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

On entry into storvsc_on_io_completion() we have already acquired a reference
on the stor_device; there is no need to acquire an additional reference here.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Abhishek Kane <v-abkane@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/storvsc.c b/drivers/staging/hv/storvsc.c
index 8c62829..cd38cd6 100644
--- a/drivers/staging/hv/storvsc.c
+++ b/drivers/staging/hv/storvsc.c
@@ -232,9 +232,7 @@ static void storvsc_on_io_completion(struct hv_device *device,
 	struct storvsc_device *stor_device;
 	struct vstor_packet *stor_pkt;
 
-	stor_device = must_get_stor_device(device);
-	if (!stor_device)
-		return;
+	stor_device = (struct storvsc_device *)device->ext;
 
 	stor_pkt = &request->vstor_packet;
 
@@ -279,7 +277,6 @@ static void storvsc_on_io_completion(struct hv_device *device,
 		wake_up(&stor_device->waiting_to_drain);
 
 
-	put_stor_device(device);
 }
 
 static void storvsc_on_receive(struct hv_device *device,
-- 
1.7.4.1
