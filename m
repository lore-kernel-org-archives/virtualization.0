From: Andrey Smetanin <asmetanin@virtuozzo.com>
Subject: [PATCH 5/7] linux-headers/kvm: KVM_EXIT_HYPERV type and struct
Date: Mon, 26 Oct 2015 12:50:58 +0300
Message-ID: <1445853060-24201-6-git-send-email-asmetanin__42104.766253806$1446420830$gmane$org@virtuozzo.com>
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
 linux-headers/linux/kvm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 0bff588..4e20262 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -154,6 +154,20 @@ struct kvm_s390_skeys {
 	__u32 flags;
 	__u32 reserved[9];
 };
+
+struct kvm_hyperv_exit {
+#define KVM_EXIT_HYPERV_SYNIC          1
+	__u32 type;
+	union {
+		struct {
+			__u32 msr;
+			__u64 control;
+			__u64 evt_page;
+			__u64 msg_page;
+		} synic;
+	} u;
+};
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -184,6 +198,7 @@ struct kvm_s390_skeys {
 #define KVM_EXIT_SYSTEM_EVENT     24
 #define KVM_EXIT_S390_STSI        25
 #define KVM_EXIT_IOAPIC_EOI       26
+#define KVM_EXIT_HYPERV           27
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -338,6 +353,8 @@ struct kvm_run {
 		struct {
 			__u8 vector;
 		} eoi;
+		/* KVM_EXIT_HYPERV */
+		struct kvm_hyperv_exit hyperv;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
-- 
2.4.3
