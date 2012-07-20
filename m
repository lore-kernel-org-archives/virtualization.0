From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH] drivers: hv: use Linux version in guest ID
Date: Fri, 20 Jul 2012 10:03:08 +0200
Message-ID: <1342771388-24389-1-git-send-email-bjorn@mork.no>
References: <87fw8mlv7e.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87fw8mlv7e.fsf@nemi.mork.no>
Sender: linux-kernel-owner@vger.kernel.org
To: KY Srinivasan <kys@microsoft.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Paolo Bonzini <pbonzini@redhat.com>, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
List-Id: virtualization@lists.linuxfoundation.org

Use OS version number in the guest ID as recommended by Microsoft

Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
So how about something like this?  Yes, I know including
linux/version.h often is unwanted, but the spec does
recommend using the actual OS version in the guest ID

Yes, this will be offensive again when Linux is at=20
version 181.0, but we might have found a better solution by
then :-)


 drivers/hv/hyperv_vmbus.h |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index b9426a6..cc0c3f0 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -29,6 +29,7 @@
 #include <asm/sync_bitops.h>
 #include <linux/atomic.h>
 #include <linux/hyperv.h>
+#include <linux/version.h>
=20
 /*
  * The below CPUID leaves are present if VersionAndFeatures.Hypervisor=
Present
@@ -410,10 +411,21 @@ enum {
=20
 #define HV_PRESENT_BIT			0x80000000
=20
-#define HV_LINUX_GUEST_ID_LO		0x00000000
-#define HV_LINUX_GUEST_ID_HI		0xB16B00B5
-#define HV_LINUX_GUEST_ID		(((u64)HV_LINUX_GUEST_ID_HI << 32) | \
-					   HV_LINUX_GUEST_ID_LO)
+/* Linux vendor ID allocated by Microsoft */
+#define HV_LINUX_GUEST_ID_VENDOR	0xB16B
+
+/* Creating a guest ID conforming to the encoding recommended by
+ * Microsoft, with variant and build fixed to 0
+ *
+ *   63:48 - Vendor ID
+ *   47:40 - OS Variant
+ *   39:32 - Major Version
+ *   31:24 - Minor Version
+ *   23:16 - Service Version
+ *   15:0  - Build Number
+ */
+#define HV_LINUX_GUEST_ID		((u64)HV_LINUX_GUEST_ID_VENDOR << 48 | \
+					 (u64)LINUX_VERSION_CODE << 16)
=20
 #define HV_CPU_POWER_MANAGEMENT		(1 << 0)
 #define HV_RECOMMENDATIONS_MAX		4
--=20
1.7.10.4
