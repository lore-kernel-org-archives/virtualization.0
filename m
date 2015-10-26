From: Andrey Smetanin <asmetanin@virtuozzo.com>
Subject: [PATCH 1/7] standard-headers/x86: add Hyper-V SynIC constants
Date: Mon, 26 Oct 2015 12:50:54 +0300
Message-ID: <1445853060-24201-2-git-send-email-asmetanin__33010.1682142869$1446420819$gmane$org@virtuozzo.com>
References: <1445853060-24201-1-git-send-email-asmetanin@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1445853060-24201-1-git-send-email-asmetanin@virtuozzo.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, virtualization@lists.linux-foundation.org, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Vitaly Kuznetsov <vkuznets@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Roman Kagan <rkagan@virtuozzo.com>
CC: Denis V. Lunev <den@openvz.org>
CC: kvm@vger.kernel.org
CC: virtualization@lists.linux-foundation.org

---
 include/standard-headers/asm-x86/hyperv.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/standard-headers/asm-x86/hyperv.h b/include/standard-headers/asm-x86/hyperv.h
index c37c14e..f9780f1 100644
--- a/include/standard-headers/asm-x86/hyperv.h
+++ b/include/standard-headers/asm-x86/hyperv.h
@@ -257,4 +257,16 @@ typedef struct _HV_REFERENCE_TSC_PAGE {
 	int64_t tsc_offset;
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
-- 
2.4.3
