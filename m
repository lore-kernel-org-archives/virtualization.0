From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] Staging: hv: Add the necessary dependencies to hyperv Kconfig
Date: Wed,  4 May 2011 12:19:30 -0700
Message-ID: <1304536770-27199-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The vmbus driver dependes on ACPI and PCI subsystems. Change
Kconfig to reflect this.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/staging/hv/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/hv/Kconfig b/drivers/staging/hv/Kconfig
index 76f0756..d8c119c 100644
--- a/drivers/staging/hv/Kconfig
+++ b/drivers/staging/hv/Kconfig
@@ -1,6 +1,6 @@
 config HYPERV
 	tristate "Microsoft Hyper-V client drivers"
-	depends on X86 && m
+	depends on X86 && ACPI && m
 	default n
 	help
 	  Select this option to run Linux as a Hyper-V client operating
-- 
1.7.4.1
