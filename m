From: Andrey Smetanin <asmetanin@virtuozzo.com>
Subject: [PATCH 3/7] linux-headers/kvm: add Hyper-V SynIC irq routing type and
	struct
Date: Mon, 26 Oct 2015 12:50:56 +0300
Message-ID: <1445853060-24201-4-git-send-email-asmetanin__45371.6804077432$1446420839$gmane$org@virtuozzo.com>
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
 linux-headers/linux/kvm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index dcc410e..0bff588 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -831,6 +831,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_GUEST_DEBUG_HW_WPS 120
 #define KVM_CAP_SPLIT_IRQCHIP 121
 #define KVM_CAP_IOEVENTFD_ANY_LENGTH 122
+#define KVM_CAP_HYPERV_SYNIC 123
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -854,10 +855,16 @@ struct kvm_irq_routing_s390_adapter {
 	__u32 adapter_id;
 };
 
+struct kvm_irq_routing_hv_sint {
+	__u32 vcpu;
+	__u32 sint;
+};
+
 /* gsi routing entry types */
 #define KVM_IRQ_ROUTING_IRQCHIP 1
 #define KVM_IRQ_ROUTING_MSI 2
 #define KVM_IRQ_ROUTING_S390_ADAPTER 3
+#define KVM_IRQ_ROUTING_HV_SINT 4
 
 struct kvm_irq_routing_entry {
 	__u32 gsi;
@@ -868,6 +875,7 @@ struct kvm_irq_routing_entry {
 		struct kvm_irq_routing_irqchip irqchip;
 		struct kvm_irq_routing_msi msi;
 		struct kvm_irq_routing_s390_adapter adapter;
+		struct kvm_irq_routing_hv_sint hv_sint;
 		__u32 pad[8];
 	} u;
 };
-- 
2.4.3
