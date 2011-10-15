From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/2] Staging: hv: mousevsc: Fix a checkpatch warning
Date: Fri, 14 Oct 2011 21:31:56 -0700
Message-ID: <1318653117-7154-1-git-send-email-kys@microsoft.com>
References: <1318653084-7115-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318653084-7115-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Fix a checkpatch warning.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index c354ade..ccd39c7 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -597,4 +597,3 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(HV_DRV_VERSION);
 module_init(mousevsc_init);
 module_exit(mousevsc_exit);
-
-- 
1.7.4.1
