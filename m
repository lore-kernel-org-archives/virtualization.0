From: Amit Shah <amit.shah@qumranet.com>
Subject: [PATCH 2/2] KVM: Handle interrupts for PCI passthrough devices
Date: Thu, 10 Apr 2008 11:48:53 +0300
Message-ID: <1207817334-31775-3-git-send-email-amit.shah__43313.7041902684$1207817829$gmane$org@qumranet.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
	<1207817334-31775-2-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1207817334-31775-2-git-send-email-amit.shah@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: chrisw@redhat.com, allen.m.kay@intel.com, gcosta@redhat.com, virtualization@lists.linux-foundation.org, BENAMI@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Passthrough devices are host machine PCI devices which have
been handed off to the guest. Handle interrupts from these
devices and route them to the appropriate guest irq lines.
The userspace provides us with the necessary information
via the ioctls.

The guest IRQ numbers can change dynamically, so we have an
additional ioctl that keeps track of those changes in userspace
and notifies us whenever that happens.

It is expected the kernel driver for the passthrough device
is removed before passing it on to the guest.

Signed-off-by: Amit Shah <amit.shah@qumranet.com>
---
 arch/x86/kvm/lapic.c       |    2 +
 arch/x86/kvm/x86.c         |  191 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-x86/kvm_host.h |   15 ++++
 include/asm-x86/kvm_para.h |   15 +++-
 include/linux/kvm.h        |    4 +
 5 files changed, 226 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 31280df..d8df755 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -450,6 +450,8 @@ static void apic_set_eoi(struct kvm_lapic *apic)
 
 	if (apic_test_and_clear_vector(vector, apic->regs + APIC_TMR))
 		kvm_ioapic_update_eoi(apic->vcpu->kvm, vector);
+
+	kvm_pci_pt_ack_irq(apic->vcpu->kvm, vector);
 }
 
 static void apic_send_ipi(struct kvm_lapic *apic)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c7ad235..908dd1e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -21,6 +21,7 @@
 #include "tss.h"
 
 #include <linux/clocksource.h>
+#include <linux/interrupt.h>
 #include <linux/kvm.h>
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
@@ -94,6 +95,170 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ NULL }
 };
 
+/*
+ * Used to find a registered host PCI device (a "passthrough" device)
+ * during interrupts or EOI
+ */
+static struct kvm_pci_pt_dev_list *
+find_pci_pt_dev(struct list_head *head,
+		struct kvm_pci_pt_info *pv_pci_info, int irq, int source)
+{
+	struct list_head *ptr;
+	struct kvm_pci_pt_dev_list *match;
+
+	list_for_each(ptr, head) {
+		match = list_entry(ptr, struct kvm_pci_pt_dev_list, list);
+
+		switch (source) {
+		case KVM_PT_SOURCE_IRQ:
+			/*
+			 * Used to find a registered host device
+			 * during interrupt context on host
+			 */
+			if (match->pt_dev.host.irq == irq)
+				return match;
+			break;
+		case KVM_PT_SOURCE_IRQ_ACK:
+			/*
+			 * Used to find a registered host device when
+			 * the guest acks an interrupt
+			 */
+			if (match->pt_dev.guest.irq == irq)
+				return match;
+			break;
+		}
+	}
+	return NULL;
+}
+
+static DECLARE_BITMAP(pt_irq_pending, NR_IRQS);
+static DECLARE_BITMAP(pt_irq_handled, NR_IRQS);
+
+/* FIXME: Implement the OR logic needed to make shared interrupts on
+ * this line behave properly
+ */
+static irqreturn_t
+kvm_pci_pt_dev_intr(int irq, void *dev_id)
+{
+	struct kvm_pci_pt_dev_list *match;
+	struct kvm *kvm = (struct kvm *) dev_id;
+
+	if (!test_bit(irq, pt_irq_handled))
+		return IRQ_NONE;
+
+	if (test_bit(irq, pt_irq_pending))
+		return IRQ_HANDLED;
+
+	match = find_pci_pt_dev(&kvm->arch.pci_pt_dev_head, NULL,
+				irq, KVM_PT_SOURCE_IRQ);
+	if (!match)
+		return IRQ_NONE;
+
+	/* Not possible to detect if the guest uses the PIC or the
+	 * IOAPIC.  So set the bit in both. The guest will ignore
+	 * writes to the unused one.
+	 */
+	kvm_ioapic_set_irq(kvm->arch.vioapic, match->pt_dev.guest.irq, 1);
+	kvm_pic_set_irq(pic_irqchip(kvm), match->pt_dev.guest.irq, 1);
+	set_bit(irq, pt_irq_pending);
+	return IRQ_HANDLED;
+}
+
+/* Ack the irq line for a passthrough device */
+void
+kvm_pci_pt_ack_irq(struct kvm *kvm, int vector)
+{
+	int irq;
+	struct kvm_pci_pt_dev_list *match;
+
+	irq = get_eoi_gsi(kvm->arch.vioapic, vector);
+	match = find_pci_pt_dev(&kvm->arch.pci_pt_dev_head, NULL,
+				irq, KVM_PT_SOURCE_IRQ_ACK);
+	if (!match)
+		return;
+	if (test_bit(match->pt_dev.host.irq, pt_irq_pending)) {
+		kvm_ioapic_set_irq(kvm->arch.vioapic, irq, 0);
+		kvm_pic_set_irq(pic_irqchip(kvm), irq, 0);
+		clear_bit(match->pt_dev.host.irq, pt_irq_pending);
+	}
+}
+
+static int
+kvm_vm_ioctl_pci_pt_dev(struct kvm *kvm,
+			struct kvm_pci_passthrough_dev *pci_pt_dev)
+{
+	int r = 0;
+	struct kvm_pci_pt_dev_list *match;
+
+	if (irqchip_in_kernel(kvm)) {
+		/* Has this been added already? */
+		if (find_pci_pt_dev(&kvm->arch.pci_pt_dev_head,
+				    NULL, pci_pt_dev->host.irq,
+				    KVM_PT_SOURCE_IRQ))
+			goto out;
+
+		match = kzalloc(sizeof(struct kvm_pci_pt_dev_list), GFP_KERNEL);
+		if (match == NULL) {
+			printk(KERN_INFO "%s: Couldn't allocate memory\n",
+			       __FUNCTION__);
+			r = -ENOMEM;
+			goto out;
+		}
+
+		match->pt_dev.guest.irq   = pci_pt_dev->guest.irq;
+		match->pt_dev.host.irq    = pci_pt_dev->host.irq;
+
+		if (request_irq(pci_pt_dev->host.irq, kvm_pci_pt_dev_intr,
+				IRQF_SHARED, "kvm_pv_device", (void *)kvm)) {
+			printk(KERN_INFO "%s: couldn't allocate irq for pv "
+			       "device\n", __FUNCTION__);
+			r = -EIO;
+			goto out_free;
+		}
+		set_bit(pci_pt_dev->host.irq, pt_irq_handled);
+		list_add(&match->list, &kvm->arch.pci_pt_dev_head);
+	}
+ out:
+	return r;
+ out_free:
+	kfree(match);
+	goto out;
+}
+
+static int
+kvm_vm_ioctl_pci_pt_irq(struct kvm *kvm,
+			struct kvm_pci_passthrough_dev *pci_pt_dev)
+{
+	int r = 0;
+	struct kvm_pci_pt_dev_list *match;
+
+	match = find_pci_pt_dev(&kvm->arch.pci_pt_dev_head, NULL,
+				pci_pt_dev->host.irq, KVM_PT_SOURCE_IRQ);
+
+	if (!match) {
+		r = -EINVAL;
+		goto out;
+	}
+
+	match->pt_dev.guest.irq = pci_pt_dev->guest.irq;
+ out:
+	return r;
+}
+
+static void kvm_free_pci_passthrough(struct kvm *kvm)
+{
+	struct list_head *ptr, *ptr2;
+	struct kvm_pci_pt_dev_list *pci_pt_dev;
+
+	list_for_each_safe(ptr, ptr2, &kvm->arch.pci_pt_dev_head) {
+		pci_pt_dev = list_entry(ptr, struct kvm_pci_pt_dev_list, list);
+
+		if (irqchip_in_kernel(kvm) && pci_pt_dev->pt_dev.host.irq)
+			free_irq(pci_pt_dev->pt_dev.host.irq, kvm);
+
+		list_del(&pci_pt_dev->list);
+	}
+}
 
 unsigned long segment_base(u16 selector)
 {
@@ -1671,6 +1836,30 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
+	case KVM_ASSIGN_PCI_PT_DEV: {
+		struct kvm_pci_passthrough_dev pci_pt_dev;
+
+		r = -EFAULT;
+		if (copy_from_user(&pci_pt_dev, argp, sizeof pci_pt_dev))
+			goto out;
+
+		r = kvm_vm_ioctl_pci_pt_dev(kvm, &pci_pt_dev);
+		if (r)
+			goto out;
+		break;
+	}
+	case KVM_UPDATE_PCI_PT_IRQ: {
+		struct kvm_pci_passthrough_dev pci_pt_dev;
+
+		r = -EFAULT;
+		if (copy_from_user(&pci_pt_dev, argp, sizeof pci_pt_dev))
+			goto out;
+
+		r = kvm_vm_ioctl_pci_pt_irq(kvm, &pci_pt_dev);
+		if (r)
+			goto out;
+		break;
+	}
 	case KVM_GET_PIT: {
 		struct kvm_pit_state ps;
 		r = -EFAULT;
@@ -3816,6 +4005,7 @@ struct  kvm *kvm_arch_create_vm(void)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
+	INIT_LIST_HEAD(&kvm->arch.pci_pt_dev_head);
 
 	return kvm;
 }
@@ -3848,6 +4038,7 @@ static void kvm_free_vcpus(struct kvm *kvm)
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
+	kvm_free_pci_passthrough(kvm);
 	kvm_free_pit(kvm);
 	kfree(kvm->arch.vpic);
 	kfree(kvm->arch.vioapic);
diff --git a/include/asm-x86/kvm_host.h b/include/asm-x86/kvm_host.h
index 781fc87..c4eb804 100644
--- a/include/asm-x86/kvm_host.h
+++ b/include/asm-x86/kvm_host.h
@@ -296,6 +296,18 @@ struct kvm_mem_alias {
 	gfn_t target_gfn;
 };
 
+/* Some definitions for passthrough'ed devices */
+#define KVM_PT_SOURCE_IRQ	1
+#define KVM_PT_SOURCE_IRQ_ACK	2
+
+/* This list is to store the guest bus:device:function and host
+ * bus:device:function mapping for passthrough'ed devices.
+ */
+struct kvm_pci_pt_dev_list {
+	struct list_head list;
+	struct kvm_pci_passthrough_dev pt_dev;
+};
+
 struct kvm_arch{
 	int naliases;
 	struct kvm_mem_alias aliases[KVM_ALIAS_SLOTS];
@@ -308,6 +320,7 @@ struct kvm_arch{
 	 * Hash table of struct kvm_mmu_page.
 	 */
 	struct list_head active_mmu_pages;
+	struct list_head pci_pt_dev_head;
 	struct kvm_pic *vpic;
 	struct kvm_ioapic *vioapic;
 	struct kvm_pit *vpit;
@@ -445,6 +458,8 @@ void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned int kvm_nr_mmu_pages);
 
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 
+void kvm_pci_pt_ack_irq(struct kvm *kvm, int vector);
+
 int emulator_write_phys(struct kvm_vcpu *vcpu, gpa_t gpa,
 			  const void *val, int bytes);
 int kvm_pv_mmu_op(struct kvm_vcpu *vcpu, unsigned long bytes,
diff --git a/include/asm-x86/kvm_para.h b/include/asm-x86/kvm_para.h
index 5098459..09529cb 100644
--- a/include/asm-x86/kvm_para.h
+++ b/include/asm-x86/kvm_para.h
@@ -155,6 +155,19 @@ static inline unsigned int kvm_arch_para_features(void)
 	return cpuid_eax(KVM_CPUID_FEATURES);
 }
 
-#endif
+#endif /* KERNEL */
 
+/* Stores information for identifying host PCI devices
+ * "passedthrough'ed" to the guest: this is used in the host kernel
+ * and in the userspace.
+ */
+struct kvm_pci_pt_info {
+	__u32 irq;
+};
+
+/* Mapping between host and guest PCI device */
+struct kvm_pci_passthrough_dev {
+	struct kvm_pci_pt_info guest;
+	struct kvm_pci_pt_info host;
+};
 #endif
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 37b963e..710b5d7 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -304,6 +304,10 @@ struct kvm_s390_interrupt {
 #define KVM_CREATE_PIT		  _IO(KVMIO,  0x64)
 #define KVM_GET_PIT		  _IOWR(KVMIO, 0x65, struct kvm_pit_state)
 #define KVM_SET_PIT		  _IOR(KVMIO,  0x66, struct kvm_pit_state)
+#define KVM_ASSIGN_PCI_PT_DEV	  _IOR(KVMIO, 0x67, \
+				       struct kvm_pci_passthrough_dev)
+#define KVM_UPDATE_PCI_PT_IRQ	  _IOR(KVMIO, 0x68, \
+				       struct kvm_pci_passthrough_dev)
 
 /*
  * ioctls for vcpu fds
-- 
1.4.4.2
