From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 6/6] Staging: hv: mousevsc: Get rid of unnecessary include files
Date: Tue, 25 Oct 2011 17:19:52 -0700
Message-ID: <1319588392-9982-6-git-send-email-kys@microsoft.com>
References: <1319588311-9935-1-git-send-email-kys@microsoft.com>
 <1319588392-9982-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319588392-9982-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, dmitry.torokhov@gmail.com, joe@perches.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Get rid of unnecessary include files.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index 21cd050..dd42411 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -14,11 +14,8 @@
  */
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/workqueue.h>
-#include <linux/sched.h>
-#include <linux/wait.h>
+#include <linux/completion.h>
 #include <linux/input.h>
 #include <linux/hid.h>
 #include <linux/hiddev.h>
-- 
1.7.4.1
