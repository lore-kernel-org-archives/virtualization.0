From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 1/1] Drivers: hv: Change the hex constant to a decimal constant
Date: Wed, 18 Jul 2012 15:57:25 -0700
Message-ID: <1342652245-931-1-git-send-email-kys@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org, olaf@aepfle.de, apw@canonical.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

The hex constant chosen for HV_LINUX_GUEST_ID_HI was offensive, update to use
the decimal equivalent instead.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/hv/hyperv_vmbus.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index b9426a6..0614ff3 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -411,7 +411,7 @@ enum {
 #define HV_PRESENT_BIT			0x80000000
 
 #define HV_LINUX_GUEST_ID_LO		0x00000000
-#define HV_LINUX_GUEST_ID_HI		0xB16B00B5
+#define HV_LINUX_GUEST_ID_HI		2976579765
 #define HV_LINUX_GUEST_ID		(((u64)HV_LINUX_GUEST_ID_HI << 32) | \
 					   HV_LINUX_GUEST_ID_LO)
 
-- 
1.7.4.1
