From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 16/16] Staging: hv: Make the function stor_vsc_on_host_reset() static
Date: Wed, 23 Mar 2011 10:50:34 -0700
Message-ID: <1300902635-1347-16-git-send-email-kys@microsoft.com>
References: <1300902537-1290-1-git-send-email-kys@microsoft.com>
 <1300902635-1347-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1300902635-1347-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Make stor_vsc_on_host_reset() a static function.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/storvsc_api.h |    1 -
 drivers/staging/hv/storvsc_drv.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hv/storvsc_api.h b/drivers/staging/hv/storvsc_api.h
index d46b4de..5f41ef6 100644
--- a/drivers/staging/hv/storvsc_api.h
+++ b/drivers/staging/hv/storvsc_api.h
@@ -163,7 +163,6 @@ static inline void put_stor_device(struct hv_device *device)
 }
 
 /* Interface */
-int stor_vsc_on_host_reset(struct hv_device *device);
 
 int stor_vsc_on_device_add(struct hv_device *device,
 				void *additional_info);
diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index e0a1195..127d122 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -233,7 +233,7 @@ static int storvsc_drv_init(void)
 }
 
 
-int stor_vsc_on_host_reset(struct hv_device *device)
+static int stor_vsc_on_host_reset(struct hv_device *device)
 {
 	struct storvsc_device *stor_device;
 	struct storvsc_request_extension *request;
-- 
1.7.4.1
