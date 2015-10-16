From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 5/9] kvm/irqchip: kvm_arch_irq_routing_update renaming split
Date: Fri, 16 Oct 2015 10:07:49 +0300
Message-ID: <1444979273-6587-6-git-send-email-den__3224.72186894647$1444979358$gmane$org@openvz.org>
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

Actually kvm_arch_irq_routing_update() should be
kvm_arch_post_irq_routing_update() as it's called at the end
of irq routing update.

This renaming frees kvm_arch_irq_routing_update function name.
kvm_arch_irq_routing_update() weak function which will be used
to update mappings for arch-specific irq routing entries
(in particular, the upcoming Hyper-V synthetic interrupts).

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/irq_comm.c  | 2 +-
 include/linux/kvm_host.h | 5 +++--
 virt/kvm/irqchip.c       | 7 ++++++-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
index c892289..6f922c2 100644
--- a/arch/x86/kvm/irq_comm.c
+++ b/arch/x86/kvm/irq_comm.c
@@ -364,7 +364,7 @@ int kvm_setup_empty_irq_routing(struct kvm *kvm)
 	return kvm_set_irq_routing(kvm, empty_routing, 0, 0);
 }
 
-void kvm_arch_irq_routing_update(struct kvm *kvm)
+void kvm_arch_post_irq_routing_update(struct kvm *kvm)
 {
 	if (ioapic_in_kernel(kvm) || !irqchip_in_kernel(kvm))
 		return;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index eba9cae..c742e79 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -473,12 +473,12 @@ void vcpu_put(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_HAVE_IOAPIC
 void kvm_vcpu_request_scan_ioapic(struct kvm *kvm);
-void kvm_arch_irq_routing_update(struct kvm *kvm);
+void kvm_arch_post_irq_routing_update(struct kvm *kvm);
 #else
 static inline void kvm_vcpu_request_scan_ioapic(struct kvm *kvm)
 {
 }
-static inline void kvm_arch_irq_routing_update(struct kvm *kvm)
+static inline void kvm_arch_post_irq_routing_update(struct kvm *kvm)
 {
 }
 #endif
@@ -1080,6 +1080,7 @@ static inline void kvm_irq_routing_update(struct kvm *kvm)
 {
 }
 #endif
+void kvm_arch_irq_routing_update(struct kvm *kvm);
 
 static inline int kvm_ioeventfd(struct kvm *kvm, struct kvm_ioeventfd *args)
 {
diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index f0b08a2..fe84e1a 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -166,6 +166,10 @@ out:
 	return r;
 }
 
+void __attribute__((weak)) kvm_arch_irq_routing_update(struct kvm *kvm)
+{
+}
+
 int kvm_set_irq_routing(struct kvm *kvm,
 			const struct kvm_irq_routing_entry *ue,
 			unsigned nr,
@@ -219,9 +223,10 @@ int kvm_set_irq_routing(struct kvm *kvm,
 	old = kvm->irq_routing;
 	rcu_assign_pointer(kvm->irq_routing, new);
 	kvm_irq_routing_update(kvm);
+	kvm_arch_irq_routing_update(kvm);
 	mutex_unlock(&kvm->irq_lock);
 
-	kvm_arch_irq_routing_update(kvm);
+	kvm_arch_post_irq_routing_update(kvm);
 
 	synchronize_srcu_expedited(&kvm->irq_srcu);
 
-- 
2.1.4
