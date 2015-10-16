From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 6/9] drivers/hv: share Hyper-V SynIC constants with userspace
Date: Fri, 16 Oct 2015 10:07:50 +0300
Message-ID: <1444979273-6587-7-git-send-email-den__9298.35699867017$1444979364$gmane$org@openvz.org>
References: <1444979273-6587-1-git-send-email-den@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1444979273-6587-1-git-send-email-den@openvz.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, rkagan@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, Andrey Smetanin <asmetanin@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Andrey Smetanin <asmetanin@virtuozzo.com>

Moved Hyper-V synic contants from guest Hyper-V drivers private
header into x86 arch uapi Hyper-V header.

Added Hyper-V synic msr's flags into x86 arch uapi Hyper-V header.

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/uapi/asm/hyperv.h | 12 ++++++++++++
 drivers/hv/hyperv_vmbus.h          |  5 -----
 include/linux/hyperv.h             |  1 +
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/uapi/asm/hyperv.h b/arch/x86/include/uapi/asm/hyperv.h
index 2677a0a..040d408 100644
--- a/arch/x86/include/uapi/asm/hyperv.h
+++ b/arch/x86/include/uapi/asm/hyperv.h
@@ -257,4 +257,16 @@ typedef struct _HV_REFERENCE_TSC_PAGE {
 	__s64 tsc_offset;
 } HV_REFERENCE_TSC_PAGE, *PHV_REFERENCE_TSC_PAGE;
 
+/* Define the number of synthetic interrupt sources. */
+#define HV_SYNIC_SINT_COUNT		(16)
+/* Define the expected SynIC version. */
+#define HV_SYNIC_VERSION_1		(0x1)
+
+#define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SINT_MASKED		(1ULL << 16)
+#define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
+#define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
+
 #endif
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 3d70e36..3782636 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -63,9 +63,6 @@ enum hv_cpuid_function {
 /* Define version of the synthetic interrupt controller. */
 #define HV_SYNIC_VERSION		(1)
 
-/* Define the expected SynIC version. */
-#define HV_SYNIC_VERSION_1		(0x1)
-
 /* Define synthetic interrupt controller message constants. */
 #define HV_MESSAGE_SIZE			(256)
 #define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
@@ -105,8 +102,6 @@ enum hv_message_type {
 	HVMSG_X64_LEGACY_FP_ERROR		= 0x80010005
 };
 
-/* Define the number of synthetic interrupt sources. */
-#define HV_SYNIC_SINT_COUNT		(16)
 #define HV_SYNIC_STIMER_COUNT		(4)
 
 /* Define invalid partition identifier. */
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 54733d5..8fdc17b 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -26,6 +26,7 @@
 #define _HYPERV_H
 
 #include <uapi/linux/hyperv.h>
+#include <uapi/asm/hyperv.h>
 
 #include <linux/types.h>
 #include <linux/scatterlist.h>
-- 
2.1.4
