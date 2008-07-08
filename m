From: Ben-Ami Yassour <benami@il.ibm.com>
Subject: Re: [PATCH 2/4] KVM: Introduce a callback routine for IOAPIC ack
	handling
Date: Tue, 08 Jul 2008 13:34:43 +0300
Message-ID: <1215513283.31546.133.camel@cluwyn.haifa.ibm.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>
	 <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>
	 <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>
	 <4871EB36.5030003@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4871EB36.5030003@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Amit Shah <amit.shah@qumranet.com>, kvm@vger.kernel.org, Muli Ben-Yehuda <muli@il.ibm.com>, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2008-07-07 at 13:08 +0300, Avi Kivity wrote:
> Amit Shah wrote:
> > This will be useful for acking irqs of assigned devices
> >
> >   
> 
> And also for improving time drift tracking.
> 
> Please make this more generic by having a list of callbacks.  There 
> could also be just one list, rather than one for the ioapic and one for 
> the pic as implemented now.
> 
> It may also make sense to filter the irq number before calling the 
> callback rather than relying on the callback to ignore uninteresting irqs.
> 
Avi,

Did you mean something like the patch below?
How should we protect list accesses, should it be a new lock or an existing one?

Regards,
Ben

From 102013bdd75e8141027e461ae5834138f561a3c3 Mon Sep 17 00:00:00 2001
From: Ben-Ami Yassour <benami@il.ibm.com>
Date: Tue, 8 Jul 2008 13:30:01 +0300
Subject: [PATCH] KVM: interrupt ack notifier list

API to get notification when a guest acks an interrupt.

Signed-off-by: Ben-Ami Yassour <benami@il.ibm.com>
---
 arch/x86/kvm/i8259.c       |    4 ++-
 arch/x86/kvm/irq.c         |    2 +-
 arch/x86/kvm/irq.h         |    2 +-
 arch/x86/kvm/x86.c         |   84 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-x86/kvm_host.h |   10 +++++
 5 files changed, 99 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index 5857f59..9160343 100644
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
@@ -178,6 +179,7 @@ int kvm_pic_read_irq(struct kvm_pic *s)
 		irq = 7;
 		intno = s->pics[0].irq_base + irq;
 	}
+	notify_interrupt_ack(kvm, irq);
 	pic_update_irq(s);
 
 	return intno;
diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 76d736b..cf29c02 100644
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
index 2a15be2..7657654 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -65,7 +65,7 @@ struct kvm_pic {
 
 struct kvm_pic *kvm_create_pic(struct kvm *kvm);
 void kvm_pic_set_irq(void *opaque, int irq, int level);
-int kvm_pic_read_irq(struct kvm_pic *s);
+int kvm_pic_read_irq(struct kvm *kvm);
 void kvm_pic_update_irq(struct kvm_pic *s);
 
 static inline struct kvm_pic *pic_irqchip(struct kvm *kvm)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5a83c3b..6d33f00 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -199,6 +199,88 @@ static void __queue_exception(struct kvm_vcpu *vcpu)
 				     vcpu->arch.exception.error_code);
 }
 
+void notify_interrupt_ack(struct kvm *kvm, int irq)
+{
+	struct list_head *ptr;
+	struct interrupt_ack_notifier *notifier;
+
+	list_for_each(ptr, &kvm->arch.interrupt_ack_notifier) {
+		notifier = list_entry(ptr, struct interrupt_ack_notifier, list);
+		if (irq == notifier->irq)
+			notifier->callback(notifier->opaque, irq);
+	}
+}
+
+static int
+register_interrupt_ack_notifier(struct kvm *kvm,
+				int irq,
+				void (*callback)(void *opaque, int irq),
+				void *opaque)
+{
+	struct interrupt_ack_notifier *notifier;
+	
+	notifier = kzalloc(sizeof(struct interrupt_ack_notifier), GFP_KERNEL);
+	if (notifier == NULL) {
+		printk(KERN_INFO "%s: Couldn't allocate memory\n", __func__);
+		return -ENOMEM;
+	}
+	
+	notifier->callback = callback;
+	notifier->opaque = opaque;
+	notifier->irq = irq;
+	list_add(&notifier->list, &kvm->arch.interrupt_ack_notifier);
+
+	return 0;
+}
+
+static struct interrupt_ack_notifier *
+find_interrupt_ack_notifier(struct kvm *kvm,
+			    int irq,
+			    void (*callback)(void *opaque, int irq),
+			    void *opaque)
+{
+	struct list_head *ptr;
+	struct interrupt_ack_notifier *notifier;
+
+	list_for_each(ptr, &kvm->arch.interrupt_ack_notifier) {
+		notifier = list_entry(ptr, struct interrupt_ack_notifier, list);
+		if ((irq == notifier->irq) &&
+		    (callback == notifier->callback) &&
+		    (opaque == notifier->opaque)) {
+			return notifier;
+		}
+	}
+	return NULL;
+}
+
+static void
+unregister_interrupt_ack_notifier(struct kvm *kvm,
+					     int irq,
+					     void (*callback)(void *opaque, int irq),
+					     void *opaque)
+{
+	struct interrupt_ack_notifier *notifier;
+
+	notifier = find_interrupt_ack_notifier(kvm, irq, callback, opaque);
+	if (notifier) {
+		list_del(&notifier->list);
+		kfree(notifier);
+	}
+}
+
+static void free_interrupt_ack_notifier_list(struct kvm *kvm)
+{
+	struct list_head *ptr, *ptr2;
+	struct interrupt_ack_notifier *notifier;
+
+	list_for_each_safe(ptr, ptr2, &kvm->arch.interrupt_ack_notifier) {
+		notifier = list_entry(ptr,
+				      struct interrupt_ack_notifier, list);
+		list_del(&notifier->list);
+		kfree(notifier);
+	}
+}
+
 /*
  * Load the pae pdptrs.  Return true is they are all valid.
  */
@@ -3946,6 +4028,7 @@ struct  kvm *kvm_arch_create_vm(void)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
+	INIT_LIST_HEAD(&kvm->arch.interrupt_ack_notifier);
 
 	return kvm;
 }
@@ -3981,6 +4064,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	kvm_free_pit(kvm);
 	kfree(kvm->arch.vpic);
 	kfree(kvm->arch.vioapic);
+	free_interrupt_ack_notifier_list(kvm);
 	kvm_free_vcpus(kvm);
 	kvm_free_physmem(kvm);
 	if (kvm->arch.apic_access_page)
diff --git a/include/asm-x86/kvm_host.h b/include/asm-x86/kvm_host.h
index 9391e57..fe35b15 100644
--- a/include/asm-x86/kvm_host.h
+++ b/include/asm-x86/kvm_host.h
@@ -302,6 +302,13 @@ struct kvm_vcpu_arch {
 	u64 mtrr[0x100];
 };
 
+struct interrupt_ack_notifier {
+	struct list_head list;
+	int irq;
+	void (*callback)(void *opaque, int irq);
+	void *opaque;
+};
+
 struct kvm_mem_alias {
 	gfn_t base_gfn;
 	unsigned long npages;
@@ -339,6 +346,7 @@ struct kvm_arch{
 	struct dmar_domain *intel_iommu_domain;
 	struct kvm_pic *vpic;
 	struct kvm_ioapic *vioapic;
+	struct list_head interrupt_ack_notifier;	
 	struct kvm_pit *vpit;
 
 	int round_robin_prev_vcpu;
@@ -582,6 +590,8 @@ void kvm_enable_tdp(void);
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 int complete_pio(struct kvm_vcpu *vcpu);
 
+void notify_interrupt_ack(struct kvm *kvm, int irq);
+
 static inline struct kvm_mmu_page *page_header(hpa_t shadow_page)
 {
 	struct page *page = pfn_to_page(shadow_page >> PAGE_SHIFT);
-- 
1.5.5.1



