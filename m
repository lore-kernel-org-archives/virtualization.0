From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 17/77] Staging: hv: netvsc: Add the appropriate MODULE_ALIAS() line
Date: Thu, 16 Jun 2011 13:16:50 -0700
Message-ID: <1308255470-3826-17-git-send-email-kys@microsoft.com>
References: <1308255393-3785-1-git-send-email-kys@microsoft.com>
 <1308255470-3826-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308255470-3826-1-git-send-email-kys@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Hank Janssen <hjanssen@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

Add the appropriate MODULE_ALIAS() line to support auto-loading.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/netvsc_drv.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/hv/netvsc_drv.c b/drivers/staging/hv/netvsc_drv.c
index 3656c0f..34b1ed3 100644
--- a/drivers/staging/hv/netvsc_drv.c
+++ b/drivers/staging/hv/netvsc_drv.c
@@ -477,6 +477,7 @@ MODULE_DEVICE_TABLE(pci, hv_netvsc_pci_table);
 MODULE_LICENSE("GPL");
 MODULE_VERSION(HV_DRV_VERSION);
 MODULE_DESCRIPTION("Microsoft Hyper-V network driver");
+MODULE_ALIAS("vmbus:hv_net");
 
 module_init(netvsc_drv_init);
 module_exit(netvsc_drv_exit);
-- 
1.7.4.1
