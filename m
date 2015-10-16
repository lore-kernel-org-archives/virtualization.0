From: "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 2/9] kvm/eventfd: factor out kvm_notify_acked_gsi()
Date: Fri, 16 Oct 2015 10:07:46 +0300
Message-ID: <1444979273-6587-3-git-send-email-den__11752.9703923084$1444979319$gmane$org@openvz.org>
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

Factor out kvm_notify_acked_gsi() helper to iterate over EOI listeners
and notify those matching the given gsi.

It will be reused in the upcoming Hyper-V SynIC implementation.

Signed-off-by: Andrey Smetanin <asmetanin@virtuozzo.com>
Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Gleb Natapov <gleb@kernel.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/eventfd.c       | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 9596a2f..b66861c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -829,6 +829,7 @@ int kvm_set_irq_inatomic(struct kvm *kvm, int irq_source_id, u32 irq, int level)
 int kvm_set_msi(struct kvm_kernel_irq_routing_entry *irq_entry, struct kvm *kvm,
 		int irq_source_id, int level, bool line_status);
 bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned pin);
+void kvm_notify_acked_gsi(struct kvm *kvm, int gsi);
 void kvm_notify_acked_irq(struct kvm *kvm, unsigned irqchip, unsigned pin);
 void kvm_register_irq_ack_notifier(struct kvm *kvm,
 				   struct kvm_irq_ack_notifier *kian);
diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 518421e..f6b986a 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -451,9 +451,18 @@ bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned pin)
 }
 EXPORT_SYMBOL_GPL(kvm_irq_has_notifier);
 
-void kvm_notify_acked_irq(struct kvm *kvm, unsigned irqchip, unsigned pin)
+void kvm_notify_acked_gsi(struct kvm *kvm, int gsi)
 {
 	struct kvm_irq_ack_notifier *kian;
+
+	hlist_for_each_entry_rcu(kian, &kvm->irq_ack_notifier_list,
+				 link)
+		if (kian->gsi == gsi)
+			kian->irq_acked(kian);
+}
+
+void kvm_notify_acked_irq(struct kvm *kvm, unsigned irqchip, unsigned pin)
+{
 	int gsi, idx;
 
 	trace_kvm_ack_irq(irqchip, pin);
@@ -461,10 +470,7 @@ void kvm_notify_acked_irq(struct kvm *kvm, unsigned irqchip, unsigned pin)
 	idx = srcu_read_lock(&kvm->irq_srcu);
 	gsi = kvm_irq_map_chip_pin(kvm, irqchip, pin);
 	if (gsi != -1)
-		hlist_for_each_entry_rcu(kian, &kvm->irq_ack_notifier_list,
-					 link)
-			if (kian->gsi == gsi)
-				kian->irq_acked(kian);
+		kvm_notify_acked_gsi(kvm, gsi);
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 }
 
-- 
2.1.4
