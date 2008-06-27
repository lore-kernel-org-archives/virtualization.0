From: Amit Shah <amit.shah@qumranet.com>
Subject: [PATCH 3/4] KVM: Introduce a callback routine for PIC ack handling
Date: Fri, 27 Jun 2008 15:55:04 +0300
Message-ID: <1214571305-20701-4-git-send-email-amit.shah@qumranet.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>
 <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>
 <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: muli@il.ibm.com, benami@il.ibm.com, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, avi@qumranet.com, virtualization@lists.osdl.org, Amit Shah <amit.shah@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

This is useful for acking irqs of assigned devices

Signed-off-by: Amit Shah <amit.shah@qumranet.com>
---
 arch/x86/kvm/i8259.c |    6 +++++-
 arch/x86/kvm/irq.c   |    2 +-
 arch/x86/kvm/irq.h   |    3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index 5857f59..3ba5e5c 100644
--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -151,9 +151,10 @@ static inline void pic_intack(struct kvm_kpic_state *s, int irq)
 		s->irr &= ~(1 << irq);
 }
 
-int kvm_pic_read_irq(struct kvm_pic *s)
+int kvm_pic_read_irq(struct kvm *kvm)
 {
 	int irq, irq2, intno;
+	struct kvm_pic *s = pic_irqchip(kvm);
 
 	irq = pic_get_irq(&s->pics[0]);
 	if (irq >= 0) {
@@ -178,6 +179,9 @@ int kvm_pic_read_irq(struct kvm_pic *s)
 		irq = 7;
 		intno = s->pics[0].irq_base + irq;
 	}
+	if (kvm->arch.vpic->ack_notifier)
+		kvm->arch.vpic->ack_notifier(kvm, irq);
+
 	pic_update_irq(s);
 
 	return intno;
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 0d9e552..3529620 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -72,7 +72,7 @@ int kvm_cpu_get_interrupt(struct kvm_vcpu *v)
 		if (kvm_apic_accept_pic_intr(v)) {
 			s = pic_irqchip(v->kvm);
 			s->output = 0;		/* PIC */
-			vector = kvm_pic_read_irq(s);
+			vector = kvm_pic_read_irq(v->kvm);
 		}
 	}
 	return vector;
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index ba4e3bf..bef9127 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -61,11 +61,12 @@ struct kvm_pic {
 	void *irq_request_opaque;
 	int output;		/* intr from master PIC */
 	struct kvm_io_device dev;
+	void (*ack_notifier)(void *opaque, int irq);
 };
 
 struct kvm_pic *kvm_create_pic(struct kvm *kvm);
 void kvm_pic_set_irq(void *opaque, int irq, int level);
-int kvm_pic_read_irq(struct kvm_pic *s);
+int kvm_pic_read_irq(struct kvm *kvm);
 void kvm_pic_update_irq(struct kvm_pic *s);
 
 static inline struct kvm_pic *pic_irqchip(struct kvm *kvm)
-- 
1.5.4.3

