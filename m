From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 06/24] Staging: hv: mousevsc: Correctly initialize the header size
Date: Thu, 29 Sep 2011 11:54:46 -0700
Message-ID: <1317322504-9788-6-git-send-email-kys@microsoft.com>
References: <1317322456-9747-1-git-send-email-kys@microsoft.com>
 <1317322504-9788-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317322504-9788-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Correctly initialize the header size.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 19cfc23..74faa26 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -590,7 +590,7 @@ static int mousevsc_connect_to_vsp(struct hv_device *device)
 	request->size = sizeof(struct synthhid_protocol_request);
 
 	request->request.header.type = SynthHidProtocolRequest;
-	request->request.header.size = sizeof(unsigned long);
+	request->request.header.size = sizeof(unsigned int);
 	request->request.version_requested.version = SYNTHHID_INPUT_VERSION;
 
 	pr_info("synthhid protocol request...");
-- 
1.7.4.1
