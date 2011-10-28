From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 3/3] Staging: hv: mousevsc: Use the KBUILD_MODNAME macro
Date: Fri, 28 Oct 2011 15:11:28 -0700
Message-ID: <1319839888-29000-3-git-send-email-kys@microsoft.com>
References: <1319839847-28959-1-git-send-email-kys@microsoft.com>
 <1319839888-29000-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1319839888-29000-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, joe@perches.com, dmitry.torokhov@gmail.com, jkosina@suse.cz
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use the KBUILD_MODNAME macro.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 drivers/staging/hv/hv_mouse.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/hv_mouse.c b/drivers/staging/hv/hv_mouse.c
index c22f729..2c2e1b4 100644
--- a/drivers/staging/hv/hv_mouse.c
+++ b/drivers/staging/hv/hv_mouse.c
@@ -578,7 +578,7 @@ static const struct hv_vmbus_device_id id_table[] = {
 MODULE_DEVICE_TABLE(vmbus, id_table);
 
 static struct  hv_driver mousevsc_drv = {
-	.name = "mousevsc",
+	.name = KBUILD_MODNAME,
 	.id_table = id_table,
 	.probe = mousevsc_probe,
 	.remove = mousevsc_remove,
-- 
1.7.4.1
