From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 05/24] Staging: hv: mousevsc: Handle the case where we may get bogus report desc size
Date: Thu, 29 Sep 2011 11:54:45 -0700
Message-ID: <1317322504-9788-5-git-send-email-kys@microsoft.com>
References: <1317322456-9747-1-git-send-email-kys@microsoft.com>
 <1317322504-9788-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317322504-9788-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Handle the case where we may get bogus report desc size from the host.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index b7cc164..19cfc23 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -341,6 +341,8 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 
 	/* Save the report desc */
 	input_device->report_desc_size = desc->desc[0].wDescriptorLength;
+	if (input_device->report_desc_size == 0)
+		goto cleanup;
 	input_device->report_desc = kzalloc(input_device->report_desc_size,
 					  GFP_ATOMIC);
 
-- 
1.7.4.1
