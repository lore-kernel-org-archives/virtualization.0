From: Amit Shah <amit.shah@qumranet.com>
Subject: [PATCH 1/4] KVM: Introduce kvm_set_irq to inject interrupts in guests
Date: Fri, 27 Jun 2008 15:55:02 +0300
Message-ID: <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: muli@il.ibm.com, benami@il.ibm.com, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, avi@qumranet.com, virtualization@lists.osdl.org, Amit Shah <amit.shah@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

This function injects an interrupt into the guest given the kvm struct,
the (guest) irq number and the interrupt level.

Signed-off-by: Amit Shah <amit.shah@qumranet.com>
---
 arch/x86/kvm/irq.c |   11 +++++++++++
 arch/x86/kvm/irq.h |    2 ++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 76d736b..0d9e552 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -100,3 +100,14 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcpu)
 	__kvm_migrate_apic_timer(vcpu);
 	__kvm_migrate_pit_timer(vcpu);
 }
+
+/* This should be called with the kvm->lock mutex held */
+void kvm_set_irq(struct kvm *kvm, int irq, int level)
+{
+	/* Not possible to detect if the guest uses the PIC or the
+	 * IOAPIC.  So set the bit in both. The guest will ignore
+	 * writes to the unused one.
+	 */
+	kvm_ioapic_set_irq(kvm->arch.vioapic, irq, level);
+	kvm_pic_set_irq(pic_irqchip(kvm), irq, level);
+}
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index 2a15be2..ba4e3bf 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -80,6 +80,8 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 
 void kvm_pic_reset(struct kvm_kpic_state *s);
 
+void kvm_set_irq(struct kvm *kvm, int irq, int level);
+
 void kvm_timer_intr_post(struct kvm_vcpu *vcpu, int vec);
 void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu);
 void kvm_inject_apic_timer_irqs(struct kvm_vcpu *vcpu);
-- 
1.5.4.3

