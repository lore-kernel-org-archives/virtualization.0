From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 07/11] Staging: hv: storvsc: use the macro KBUILD_MODNAME
Date: Tue,  8 Nov 2011 09:01:46 -0800
Message-ID: <1320771710-29139-7-git-send-email-kys@microsoft.com>
References: <1320771677-29095-1-git-send-email-kys@microsoft.com>
 <1320771710-29139-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320771710-29139-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, ohering@suse.com, James.Bottomley@HansenPartnership.com, hch@infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Use the macro KBUILD_MODNAME.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/storvsc_drv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/storvsc_drv.c b/drivers/staging/hv/storvsc_drv.c
index 827bc68..916f5d0 100644
--- a/drivers/staging/hv/storvsc_drv.c
+++ b/drivers/staging/hv/storvsc_drv.c
@@ -1444,7 +1444,7 @@ err_out0:
 /* The one and only one */
 
 static struct hv_driver storvsc_drv = {
-	.name = "storvsc",
+	.name = KBUILD_MODNAME,
 	.id_table = id_table,
 	.probe = storvsc_probe,
 	.remove = storvsc_remove,
-- 
1.7.4.1
