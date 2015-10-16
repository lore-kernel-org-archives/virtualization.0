From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 3/9] kvm/eventfd: add arch-specific set_irq
Date: Fri, 16 Oct 2015 10:07:47 +0300
Message-ID: <1444979273-6587-4-git-send-email-den__44552.7786775076$1444979338$gmane$org@openvz.org>
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

Allow for arch-specific interrupt types to be set.  For that, add
kvm_arch_set_irq() which takes interrupt type-specific action if it
recognizes the interrupt type given, and -EWOULDBLOCK otherwise.

The default implementation always returns -EWOULDBLOCK.

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h |  4 ++++
 virt/kvm/eventfd.c       | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index b66861c..eba9cae 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -828,6 +828,10 @@ int kvm_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
 int kvm_set_irq_inatomic(struct kvm *kvm, int irq_source_id, u32 irq, int level);
 int kvm_set_msi(struct kvm_kernel_irq_routing_entry *irq_entry, struct kvm *kvm,
 		int irq_source_id, int level, bool line_status);
+
+int kvm_arch_set_irq(struct kvm_kernel_irq_routing_entry *irq, struct kvm *kvm,
+		     int irq_source_id, int level, bool line_status);
+
 bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned pin);
 void kvm_notify_acked_gsi(struct kvm *kvm, int gsi);
 void kvm_notify_acked_irq(struct kvm *kvm, unsigned irqchip, unsigned pin);
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index f6b986a..e29fd26 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -171,6 +171,15 @@ irqfd_deactivate(struct kvm_kernel_irqfd *irqfd)
 	queue_work(irqfd_cleanup_wq, &irqfd->shutdown);
 }
 
+int __attribute__((weak)) kvm_arch_set_irq(
+				struct kvm_kernel_irq_routing_entry *irq,
+				struct kvm *kvm, int irq_source_id,
+				int level,
+				bool line_status)
+{
+	return -EWOULDBLOCK;
+}
+
 /*
  * Called with wqh->lock held and interrupts disabled
  */
@@ -195,7 +204,9 @@ irqfd_wakeup(wait_queue_t *wait, unsigned mode, int sync, void *key)
 		if (irq.type == KVM_IRQ_ROUTING_MSI)
 			kvm_set_msi(&irq, kvm, KVM_USERSPACE_IRQ_SOURCE_ID, 1,
 					false);
-		else
+		else if (kvm_arch_set_irq(&irq, kvm,
+					  KVM_USERSPACE_IRQ_SOURCE_ID, 1,
+					  false) == -EWOULDBLOCK)
 			schedule_work(&irqfd->inject);
 		srcu_read_unlock(&kvm->irq_srcu, idx);
 	}
-- 
2.1.4
