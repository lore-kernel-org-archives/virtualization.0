From: Amit Shah <amit.shah@qumranet.com>
Subject: [PATCH 4/4] KVM: Handle device assignment to guests
Date: Fri, 27 Jun 2008 15:55:05 +0300
Message-ID: <1214571305-20701-5-git-send-email-amit.shah@qumranet.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>
 <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>
 <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>
 <1214571305-20701-4-git-send-email-amit.shah@qumranet.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1214571305-20701-4-git-send-email-amit.shah@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org
Cc: muli@il.ibm.com, benami@il.ibm.com, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, avi@qumranet.com, virtualization@lists.osdl.org, Amit Shah <amit.shah@qumranet.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Amit Shah <amit.shah@qumranet.com>
From: Ben-Ami Yassour <benami@il.ibm.com>
From: Han, Weidong <weidong.han@intel.com>

This patch adds support for handling PCI devices that are assigned to the
guest ("PCI passthrough").

The device to be assigned to the guest is registered in the host kernel and
interrupt delivery is handled. If a device is already assigned, or the device
driver for it is still loaded on the host, the device assignment is failed by
conveying a -EBUSY reply to the userspace.

Devices that share their interrupt line are not supported at the moment.

By itself, this patch will not make devices work within the guest. There has
to be some mechanism of translating guest DMA addresses into machine addresses.
This support comes from one of three approaches:

1. If you have recent Intel hardware with VT-d support, you can use the patches
in

    git.kernel.org/pub/scm/linux/kernel/git/amit/kvm.git vtd
    git.kernel.org/pub/scm/linux/kernel/git/amit/kvm-userspace.git vtd

These patches are for the host kernel.

2. For paravirtualised Linux guests, you can use the patches in

    git.kernel.org/pub/scm/linux/kernel/git/amit/kvm.git pvdma
    git.kernel.org/pub/scm/linux/kernel/git/amit/kvm-userspace.git pvdma

This kernel tree has patches for host as well as guest kernels.

3. 1-1 mapping of guest in host address space

The patches to do this are available on the kvm / lkml list archives:

    http://thread.gmane.org/gmane.comp.emulators.kvm.devel/18722/focus=18753

Signed-off-by: Amit Shah <amit.shah@qumranet.com>
---
 arch/x86/kvm/x86.c         |  293 ++++++++++++++++++++++++++++++++++++++++++++
 include/asm-x86/kvm_host.h |   38 ++++++
 include/asm-x86/kvm_para.h |   16 +++-
 include/linux/kvm.h        |    3 +
 virt/kvm/ioapic.c          |   12 ++-
 5 files changed, 359 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0fbc032..bef3706 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4,10 +4,12 @@
  * derived from drivers/kvm/kvm_main.c
  *
  * Copyright (C) 2006 Qumranet, Inc.
+ * Copyright (C) 2008 Qumranet, Inc.
  *
  * Authors:
  *   Avi Kivity   <avi@qumranet.com>
  *   Yaniv Kamay  <yaniv@qumranet.com>
+ *   Amit Shah    <amit.shah@qumranet.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2.  See
  * the COPYING file in the top-level directory.
@@ -21,8 +23,10 @@
 #include "tss.h"
 
 #include <linux/clocksource.h>
+#include <linux/interrupt.h>
 #include <linux/kvm.h>
 #include <linux/fs.h>
+#include <linux/pci.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/mman.h>
@@ -95,6 +99,282 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{ NULL }
 };
 
+DEFINE_RWLOCK(kvm_pci_pt_lock);
+
+/*
+ * Used to find a registered host PCI device (a "passthrough" device)
+ * during ioctls, interrupts or EOI
+ */
+struct kvm_pci_pt_dev_list *
+kvm_find_pci_pt_dev(struct list_head *head,
+		struct kvm_pci_pt_info *pt_pci_info, int irq, int source)
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
+		case KVM_PT_SOURCE_UPDATE:
+			if ((match->pt_dev.host.busnr == pt_pci_info->busnr) &&
+			    (match->pt_dev.host.devfn == pt_pci_info->devfn))
+				return match;
+			break;
+		}
+	}
+	return NULL;
+}
+
+static DECLARE_BITMAP(pt_irq_handled, NR_IRQS);
+
+static void kvm_pci_pt_work_fn(struct work_struct *work)
+{
+	struct kvm_pci_pt_dev_list *match;
+	struct kvm_pci_pt_work *int_work;
+	int source;
+	unsigned long flags;
+	int guest_irq;
+	int host_irq;
+
+	int_work = container_of(work, struct kvm_pci_pt_work, work);
+
+	source = int_work->source ? KVM_PT_SOURCE_IRQ_ACK : KVM_PT_SOURCE_IRQ;
+
+	/* This is taken to safely inject irq inside the guest. When
+	 * the interrupt injection (or the ioapic code) uses a
+	 * finer-grained lock, update this
+	 */
+	mutex_lock(&int_work->kvm->lock);
+	read_lock_irqsave(&kvm_pci_pt_lock, flags);
+	match = kvm_find_pci_pt_dev(&int_work->kvm->arch.pci_pt_dev_head, NULL,
+				    int_work->irq, source);
+	if (!match) {
+		printk(KERN_ERR "%s: no matching device assigned to guest "
+		       "found for irq %d, source = %d!\n",
+		       __func__, int_work->irq, int_work->source);
+		read_unlock_irqrestore(&kvm_pci_pt_lock, flags);
+		goto out;
+	}
+	guest_irq = match->pt_dev.guest.irq;
+	host_irq = match->pt_dev.host.irq;
+	read_unlock_irqrestore(&kvm_pci_pt_lock, flags);
+
+	if (source == KVM_PT_SOURCE_IRQ)
+		kvm_set_irq(int_work->kvm, guest_irq, 1);
+	else {
+		kvm_set_irq(int_work->kvm, int_work->irq, 0);
+		enable_irq(host_irq);
+	}
+out:
+	mutex_unlock(&int_work->kvm->lock);
+	kvm_put_kvm(int_work->kvm);
+}
+
+/* FIXME: Implement the OR logic needed to make shared interrupts on
+ * this line behave properly
+ */
+static irqreturn_t kvm_pci_pt_dev_intr(int irq, void *dev_id)
+{
+	struct kvm *kvm = (struct kvm *) dev_id;
+	struct kvm_pci_pt_dev_list *pci_pt_dev;
+
+	if (!test_bit(irq, pt_irq_handled))
+		return IRQ_NONE;
+
+	read_lock(&kvm_pci_pt_lock);
+	pci_pt_dev = kvm_find_pci_pt_dev(&kvm->arch.pci_pt_dev_head, NULL,
+					 irq, KVM_PT_SOURCE_IRQ);
+	if (!pci_pt_dev) {
+		read_unlock(&kvm_pci_pt_lock);
+		return IRQ_NONE;
+	}
+
+	pci_pt_dev->pt_dev.int_work.irq = irq;
+	pci_pt_dev->pt_dev.int_work.kvm = kvm;
+	pci_pt_dev->pt_dev.int_work.source = 0;
+
+	kvm_get_kvm(kvm);
+	schedule_work(&pci_pt_dev->pt_dev.int_work.work);
+	read_unlock(&kvm_pci_pt_lock);
+
+	disable_irq_nosync(irq);
+	return IRQ_HANDLED;
+}
+
+/* Ack the irq line for a passthrough device */
+static void kvm_pci_pt_ack_irq(void *opaque, int irq)
+{
+	struct kvm *kvm = opaque;
+	struct kvm_pci_pt_dev_list *pci_pt_dev;
+	unsigned long flags;
+
+	if (irq == -1)
+		return;
+
+	read_lock_irqsave(&kvm_pci_pt_lock, flags);
+	pci_pt_dev = kvm_find_pci_pt_dev(&kvm->arch.pci_pt_dev_head, NULL, irq,
+					 KVM_PT_SOURCE_IRQ_ACK);
+	if (!pci_pt_dev) {
+		read_unlock_irqrestore(&kvm_pci_pt_lock, flags);
+		return;
+	}
+	pci_pt_dev->pt_dev.ack_work.irq = irq;
+	pci_pt_dev->pt_dev.ack_work.kvm = kvm;
+	pci_pt_dev->pt_dev.ack_work.source = 1;
+
+	kvm_get_kvm(kvm);
+	schedule_work(&pci_pt_dev->pt_dev.ack_work.work);
+	read_unlock_irqrestore(&kvm_pci_pt_lock, flags);
+}
+
+static int kvm_vm_ioctl_pci_pt_dev(struct kvm *kvm,
+				   struct kvm_pci_passthrough_dev *pci_pt_dev)
+{
+	int r = 0;
+	struct kvm_pci_pt_dev_list *match;
+	unsigned long flags;
+	struct pci_dev *dev;
+
+	write_lock_irqsave(&kvm_pci_pt_lock, flags);
+
+	/* Check if this is a request to update the irq of the device
+	 * in the guest (BIOS/ kernels can dynamically reprogram irq
+	 * numbers).  This also protects us from adding the same
+	 * device twice.
+	 */
+	match = kvm_find_pci_pt_dev(&kvm->arch.pci_pt_dev_head,
+				    &pci_pt_dev->host, 0, KVM_PT_SOURCE_UPDATE);
+	if (match) {
+		match->pt_dev.guest.irq = pci_pt_dev->guest.irq;
+		write_unlock_irqrestore(&kvm_pci_pt_lock, flags);
+		goto out;
+	}
+	write_unlock_irqrestore(&kvm_pci_pt_lock, flags);
+
+	match = kzalloc(sizeof(struct kvm_pci_pt_dev_list), GFP_KERNEL);
+	if (match == NULL) {
+		printk(KERN_INFO "%s: Couldn't allocate memory\n",
+		       __func__);
+		r = -ENOMEM;
+		goto out;
+	}
+	dev = pci_get_bus_and_slot(pci_pt_dev->host.busnr,
+				   pci_pt_dev->host.devfn);
+	if (!dev) {
+		printk(KERN_INFO "%s: host device not found\n", __func__);
+		r = -EINVAL;
+		goto out_free;
+	}
+	if (pci_enable_device(dev)) {
+		printk(KERN_INFO "%s: Could not enable PCI device\n", __func__);
+		r = -EBUSY;
+		goto out_put;
+	}
+	r = pci_request_regions(dev, "kvm_pt_device");
+	if (r) {
+		printk(KERN_INFO "%s: Could not get access to device regions\n",
+		       __func__);
+		goto out_put;
+	}
+	match->pt_dev.guest.busnr = pci_pt_dev->guest.busnr;
+	match->pt_dev.guest.devfn = pci_pt_dev->guest.devfn;
+	match->pt_dev.host.busnr  = pci_pt_dev->host.busnr;
+	match->pt_dev.host.devfn  = pci_pt_dev->host.devfn;
+	match->pt_dev.dev         = dev;
+
+	if (irqchip_in_kernel(kvm)) {
+		/* Even though this is PCI, we don't want to use shared
+		 * interrupts. Sharing host devices with guest-assigned devices
+		 * on the same interrupt line is not a happy situation: there
+		 * are going to be long delays in accepting, acking, etc.
+		 */
+		if (request_irq(dev->irq, kvm_pci_pt_dev_intr, 0,
+				"kvm_pt_device", (void *)kvm)) {
+			printk(KERN_INFO "%s: couldn't allocate irq for pv "
+			       "device\n", __func__);
+			r = -EIO;
+			goto out_put;
+		}
+		match->pt_dev.guest.irq = pci_pt_dev->guest.irq;
+		match->pt_dev.host.irq  = dev->irq;
+		if (kvm->arch.vioapic)
+			kvm->arch.vioapic->ack_notifier = kvm_pci_pt_ack_irq;
+		if (kvm->arch.vpic)
+			kvm->arch.vpic->ack_notifier = kvm_pci_pt_ack_irq;
+	}
+	write_lock_irqsave(&kvm_pci_pt_lock, flags);
+
+	INIT_WORK(&match->pt_dev.int_work.work, kvm_pci_pt_work_fn);
+	INIT_WORK(&match->pt_dev.ack_work.work, kvm_pci_pt_work_fn);
+
+	list_add(&match->list, &kvm->arch.pci_pt_dev_head);
+
+	if (irqchip_in_kernel(kvm))
+		set_bit(dev->irq, pt_irq_handled);
+	write_unlock_irqrestore(&kvm_pci_pt_lock, flags);
+out:
+	return r;
+out_put:
+	pci_dev_put(dev);
+out_free:
+	kfree(match);
+	goto out;
+}
+
+static void kvm_free_pci_passthrough(struct kvm *kvm)
+{
+	struct list_head *ptr, *ptr2;
+	struct kvm_pci_pt_dev_list *pci_pt_dev;
+	unsigned long flags;
+
+	write_lock_irqsave(&kvm_pci_pt_lock, flags);
+	list_for_each_safe(ptr, ptr2, &kvm->arch.pci_pt_dev_head) {
+		pci_pt_dev = list_entry(ptr, struct kvm_pci_pt_dev_list, list);
+		if (cancel_work_sync(&pci_pt_dev->pt_dev.int_work.work))
+			/* We had pending work. That means we will have to take
+			 * care of kvm_put_kvm.
+			 */
+			kvm_put_kvm(kvm);
+
+		if (cancel_work_sync(&pci_pt_dev->pt_dev.ack_work.work))
+			/* We had pending work. That means we will have to take
+			 * care of kvm_put_kvm.
+			 */
+			kvm_put_kvm(kvm);
+	}
+
+	list_for_each_safe(ptr, ptr2, &kvm->arch.pci_pt_dev_head) {
+		pci_pt_dev = list_entry(ptr, struct kvm_pci_pt_dev_list, list);
+
+		if (irqchip_in_kernel(kvm) && pci_pt_dev->pt_dev.host.irq)
+			free_irq(pci_pt_dev->pt_dev.host.irq, kvm);
+		/* Search for this device got us a refcount */
+		pci_dev_put(pci_pt_dev->pt_dev.dev);
+		pci_release_regions(pci_pt_dev->pt_dev.dev);
+		pci_disable_device(pci_pt_dev->pt_dev.dev);
+
+		list_del(&pci_pt_dev->list);
+		kfree(pci_pt_dev);
+	}
+	write_unlock_irqrestore(&kvm_pci_pt_lock, flags);
+}
 
 unsigned long segment_base(u16 selector)
 {
@@ -1743,6 +2023,17 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = 0;
 		break;
 	}
+	case KVM_UPDATE_PCI_PT_DEV: {
+		struct kvm_pci_passthrough_dev pci_pt_dev;
+
+		r = -EFAULT;
+		if (copy_from_user(&pci_pt_dev, argp, sizeof pci_pt_dev))
+			goto out;
+		r = kvm_vm_ioctl_pci_pt_dev(kvm, &pci_pt_dev);
+		if (r)
+			goto out;
+		break;
+	}
 	case KVM_GET_PIT: {
 		struct kvm_pit_state ps;
 		r = -EFAULT;
@@ -3938,6 +4229,7 @@ struct  kvm *kvm_arch_create_vm(void)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
+	INIT_LIST_HEAD(&kvm->arch.pci_pt_dev_head);
 
 	return kvm;
 }
@@ -3970,6 +4262,7 @@ static void kvm_free_vcpus(struct kvm *kvm)
 
 void kvm_arch_destroy_vm(struct kvm *kvm)
 {
+	kvm_free_pci_passthrough(kvm);
 	kvm_free_pit(kvm);
 	kfree(kvm->arch.vpic);
 	kfree(kvm->arch.vioapic);
diff --git a/include/asm-x86/kvm_host.h b/include/asm-x86/kvm_host.h
index c64d124..c969120 100644
--- a/include/asm-x86/kvm_host.h
+++ b/include/asm-x86/kvm_host.h
@@ -83,6 +83,7 @@
 #define KVM_NR_VAR_MTRR 8
 
 extern spinlock_t kvm_lock;
+extern rwlock_t kvm_pci_pt_lock;
 extern struct list_head vm_list;
 
 struct kvm_vcpu;
@@ -302,6 +303,38 @@ struct kvm_mem_alias {
 	gfn_t target_gfn;
 };
 
+/* Some definitions for devices assigned to the guest by the host */
+#define KVM_PT_SOURCE_IRQ	1
+#define KVM_PT_SOURCE_IRQ_ACK	2
+#define KVM_PT_SOURCE_UPDATE	3
+
+/* For assigned devices, we schedule work in the system workqueue to
+ * inject interrupts into the guest when an interrupt occurs on the
+ * physical device and also when the guest acks the interrupt.
+ */
+struct kvm_pci_pt_work {
+	struct work_struct work;
+	struct kvm *kvm;
+	int irq;
+	bool source;
+};
+
+struct kvm_pci_passthrough_dev_kernel {
+	struct kvm_pci_pt_info guest;
+	struct kvm_pci_pt_info host;
+	struct kvm_pci_pt_work int_work;
+	struct kvm_pci_pt_work ack_work;
+	struct pci_dev *dev;
+};
+
+/* This list is to store the guest bus:device:function-irq and host
+ * bus:device:function-irq mapping for assigned devices.
+ */
+struct kvm_pci_pt_dev_list {
+	struct list_head list;
+	struct kvm_pci_passthrough_dev_kernel pt_dev;
+};
+
 struct kvm_arch{
 	int naliases;
 	struct kvm_mem_alias aliases[KVM_ALIAS_SLOTS];
@@ -314,6 +347,7 @@ struct kvm_arch{
 	 * Hash table of struct kvm_mmu_page.
 	 */
 	struct list_head active_mmu_pages;
+	struct list_head pci_pt_dev_head;
 	struct kvm_pic *vpic;
 	struct kvm_ioapic *vioapic;
 	struct kvm_pit *vpit;
@@ -560,6 +594,10 @@ void kvm_enable_tdp(void);
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 int complete_pio(struct kvm_vcpu *vcpu);
 
+struct kvm_pci_pt_dev_list *
+kvm_find_pci_pt_dev(struct list_head *head,
+		    struct kvm_pci_pt_info *pt_pci_info, int irq, int source);
+
 static inline struct kvm_mmu_page *page_header(hpa_t shadow_page)
 {
 	struct page *page = pfn_to_page(shadow_page >> PAGE_SHIFT);
diff --git a/include/asm-x86/kvm_para.h b/include/asm-x86/kvm_para.h
index bfd9900..1bed3f3 100644
--- a/include/asm-x86/kvm_para.h
+++ b/include/asm-x86/kvm_para.h
@@ -137,6 +137,20 @@ static inline unsigned int kvm_arch_para_features(void)
 	return cpuid_eax(KVM_CPUID_FEATURES);
 }
 
-#endif
+#endif /* KERNEL */
 
+/* Stores information for identifying host PCI devices assigned to the
+ * guest: this is used in the host kernel and in the userspace.
+ */
+struct kvm_pci_pt_info {
+	unsigned char busnr;
+	unsigned int devfn;
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
index 0ea064c..d700bac 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -371,6 +371,7 @@ struct kvm_trace_rec {
 #define KVM_CAP_PV_MMU 13
 #define KVM_CAP_MP_STATE 14
 #define KVM_CAP_COALESCED_MMIO 15
+#define KVM_CAP_PCI_PASSTHROUGH 16
 
 /*
  * ioctls for VM fds
@@ -400,6 +401,8 @@ struct kvm_trace_rec {
 			_IOW(KVMIO,  0x67, struct kvm_coalesced_mmio_zone)
 #define KVM_UNREGISTER_COALESCED_MMIO \
 			_IOW(KVMIO,  0x68, struct kvm_coalesced_mmio_zone)
+#define KVM_UPDATE_PCI_PT_DEV	  _IOR(KVMIO, 0x69, \
+				       struct kvm_pci_passthrough_dev)
 
 /*
  * ioctls for vcpu fds
diff --git a/virt/kvm/ioapic.c b/virt/kvm/ioapic.c
index 6d99a35..c580d59 100644
--- a/virt/kvm/ioapic.c
+++ b/virt/kvm/ioapic.c
@@ -288,13 +288,21 @@ void kvm_ioapic_set_irq(struct kvm_ioapic *ioapic, int irq, int level)
 static void __kvm_ioapic_update_eoi(struct kvm_ioapic *ioapic, int gsi)
 {
 	union ioapic_redir_entry *ent;
+	struct kvm_pci_pt_dev_list *match;
+	unsigned long flags;
 
 	ent = &ioapic->redirtbl[gsi];
 	ASSERT(ent->fields.trig_mode == IOAPIC_LEVEL_TRIG);
 
 	ent->fields.remote_irr = 0;
-	if (!ent->fields.mask && (ioapic->irr & (1 << gsi)))
-		ioapic_deliver(ioapic, gsi);
+
+	read_lock_irqsave(&kvm_pci_pt_lock, flags);
+	match = kvm_find_pci_pt_dev(&ioapic->kvm->arch.pci_pt_dev_head, NULL,
+				    gsi, KVM_PT_SOURCE_IRQ_ACK);
+	read_unlock_irqrestore(&kvm_pci_pt_lock, flags);
+	if (!match)
+		if (!ent->fields.mask && (ioapic->irr & (1 << gsi)))
+			ioapic_deliver(ioapic, gsi);
 
 	if (ioapic->ack_notifier)
 		ioapic->ack_notifier(ioapic->kvm, gsi);
-- 
1.5.4.3

