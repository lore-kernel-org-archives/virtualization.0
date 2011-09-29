From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 14/24] Staging: hv: mousevsc: Cleanup alloc_input_device()
Date: Thu, 29 Sep 2011 11:54:54 -0700
Message-ID: <1317322504-9788-14-git-send-email-kys@microsoft.com>
References: <1317322456-9747-1-git-send-email-kys@microsoft.com>
 <1317322504-9788-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317322504-9788-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Cleanup alloc_input_device(); you can directly set the reference count.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 092c0ff..38e31ae 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -186,7 +186,7 @@ static struct mousevsc_dev *alloc_input_device(struct hv_device *device)
 	 * Set to 2 to allow both inbound and outbound traffics
 	 * (ie get_input_device() and must_get_input_device()) to proceed.
 	 */
-	atomic_cmpxchg(&input_dev->ref_count, 0, 2);
+	atomic_set(&input_dev->ref_count, 2);
 
 	input_dev->device = device;
 	hv_set_drvdata(device, input_dev);
-- 
1.7.4.1
