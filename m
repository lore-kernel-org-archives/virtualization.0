From: Amit Shah <amit.shah@qumranet.com>
Subject: [PATCH 1/1] QEMU/KVM: Support for PCI Passthrough
Date: Thu, 10 Apr 2008 11:48:54 +0300
Message-ID: <1207817334-31775-4-git-send-email-amit.shah__30547.9030045264$1207817939$gmane$org@qumranet.com>
References: <1207817334-31775-1-git-send-email-amit.shah@qumranet.com>
	<1207817334-31775-2-git-send-email-amit.shah@qumranet.com>
	<1207817334-31775-3-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1207817334-31775-3-git-send-email-amit.shah@qumranet.com>
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

We can assign a device from the host machine to a guest.

A new command-line option, -pcidevice is added.
For example, to invoke it for an Ethernet device sitting at
PCI bus:dev.fn 04:08.0 with host IRQ 18, use this:

-pcidevice Ethernet/04:08.0-18

The host ethernet driver is to be removed before doing the passthrough.

If kvm uses the in-kernel irqchip, interrupts are routed to
the guest via the kvm module (accompanied kernel changes are necessar).
If -no-kvm-irqchip is used, the 'irqhook' module, also included here,
is to be used.

Signed-off-by: Amit Shah <amit.shah@qumranet.com>
---
 Makefile                  |   10 +-
 irqhook/Kbuild            |    3 +
 irqhook/Makefile          |   25 ++
 irqhook/irqhook_main.c    |  215 ++++++++++++++
 kernel/Makefile           |    4 +
 libkvm/libkvm-x86.c       |   14 +-
 libkvm/libkvm.h           |   24 ++
 qemu/Makefile.target      |    1 +
 qemu/hw/apic.c            |    2 +
 qemu/hw/isa.h             |    2 +
 qemu/hw/pc.c              |    4 +
 qemu/hw/pci-passthrough.c |  677 +++++++++++++++++++++++++++++++++++++++++++++
 qemu/hw/pci-passthrough.h |  102 +++++++
 qemu/hw/pci.c             |   11 +
 qemu/hw/pci.h             |    1 +
 qemu/hw/piix_pci.c        |   19 ++
 qemu/vl.c                 |   16 +
 tools/pci_barsize.c       |   53 ++++
 tools/pci_mmio.c          |   82 ++++++
 19 files changed, 1260 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 76c149a..1a98c0b 100644
--- a/Makefile
+++ b/Makefile
@@ -5,16 +5,16 @@ DESTDIR=
 
 rpmrelease = devel
 
-.PHONY: kernel user libkvm qemu bios vgabios extboot clean libfdt
+.PHONY: kernel irqhook user libkvm qemu bios vgabios extboot clean libfdt
 
 all: libkvm qemu
 ifneq '$(filter $(ARCH), x86_64 i386 ia64)' ''
-    all: $(if $(WANT_MODULE), kernel) user
+    all: $(if $(WANT_MODULE), kernel irqhook) user
 endif
 
 kcmd = $(if $(WANT_MODULE),,@\#)
 
-qemu kernel user libkvm:
+qemu kernel user irqhook libkvm:
 	$(MAKE) -C $@
 
 qemu: libkvm
@@ -66,6 +66,7 @@ install-rpm:
 
 install:
 	$(kcmd)make -C kernel DESTDIR="$(DESTDIR)" install
+	$(kcmd)make -C irqhook DESTDIR="$(DESTDIR)" install
 	make -C libkvm DESTDIR="$(DESTDIR)" install
 	make -C qemu DESTDIR="$(DESTDIR)" install
 
@@ -86,6 +87,7 @@ srpm:
 	tar czf $(RPMTOPDIR)/SOURCES/user.tar.gz user
 	tar czf $(RPMTOPDIR)/SOURCES/libkvm.tar.gz libkvm
 	tar czf $(RPMTOPDIR)/SOURCES/kernel.tar.gz kernel
+	tar czf $(RPMTOPDIR)/SOURCES/irqhook.tar.gz irqhook
 	tar czf $(RPMTOPDIR)/SOURCES/scripts.tar.gz scripts
 	tar czf $(RPMTOPDIR)/SOURCES/extboot.tar.gz extboot
 	cp Makefile configure kvm_stat $(RPMTOPDIR)/SOURCES
@@ -93,7 +95,7 @@ srpm:
 	$(RM) $(tmpspec)
 
 clean:
-	for i in $(if $(WANT_MODULE), kernel) user libkvm qemu libfdt; do \
+	for i in $(if $(WANT_MODULE), kernel irqhook) user libkvm qemu libfdt; do \
 		make -C $$i clean; \
 	done
 
diff --git a/irqhook/Kbuild b/irqhook/Kbuild
new file mode 100644
index 0000000..9af75a4
--- /dev/null
+++ b/irqhook/Kbuild
@@ -0,0 +1,3 @@
+EXTRA_CFLAGS := -I$(src)/include
+obj-m := irqhook.o
+irqhook-objs := irqhook_main.o
diff --git a/irqhook/Makefile b/irqhook/Makefile
new file mode 100644
index 0000000..3b1d851
--- /dev/null
+++ b/irqhook/Makefile
@@ -0,0 +1,25 @@
+include ../config.mak
+
+KVERREL = $(patsubst /lib/modules/%/build,%,$(KERNELDIR))
+
+DESTDIR=
+
+INSTALLDIR = $(patsubst %/build,%/extra,$(KERNELDIR))
+
+rpmrelease = devel
+
+LINUX = ../linux-2.6
+
+all::
+	$(MAKE) -C $(KERNELDIR) M=`pwd` "$$@"
+
+#sync:
+#	rsync --exclude='*.mod.c' "$(LINUX)"/drivers/irqhook/*.[ch] .
+
+install:
+	mkdir -p $(DESTDIR)/$(INSTALLDIR)
+	cp *.ko $(DESTDIR)/$(INSTALLDIR)
+	/sbin/depmod -a
+
+clean:
+	$(MAKE) -C $(KERNELDIR) M=`pwd` $@
diff --git a/irqhook/irqhook_main.c b/irqhook/irqhook_main.c
new file mode 100644
index 0000000..0f93d17
--- /dev/null
+++ b/irqhook/irqhook_main.c
@@ -0,0 +1,215 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/bitmap.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/miscdevice.h>
+#include <linux/pci.h>
+
+#include <asm/uaccess.h>
+
+#define irqh_VERSION "0.0.1"
+#define irqh_MODULE_NAME "irqhook"
+#define irqh_DRIVER_NAME   irqh_MODULE_NAME " HW IRQ hook " irqh_VERSION
+
+// based on earlier proprietary Tutis code; this modified version goes under GPL
+MODULE_AUTHOR("Nir Peleg - Tutis");
+MODULE_DESCRIPTION("IRQ hook driver");
+MODULE_LICENSE("GPL");
+
+//#define irqh_DEBUG /* define to enable copious debugging info */
+
+#ifdef irqh_DEBUG
+#define DPRINTK(fmt, args...) printk("<1>" "%s: " fmt, __FUNCTION__ , ## args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#define ERROR(fmt, args...) printk("<1>" "%s: " fmt, __FUNCTION__ , ## args)
+
+static spinlock_t irqh_lock;
+static wait_queue_head_t irqh_proc_list;
+
+static DECLARE_BITMAP(pending, NR_IRQS);
+static DECLARE_BITMAP(handled, NR_IRQS);
+
+#define irqh_on(which, bit)	test_bit(bit, which)
+#define irqh_set(which, bit)	set_bit(bit, which)
+#define irqh_clear(which, bit)	clear_bit(bit, which)
+#define irqh_ffs(which)		find_first_bit(which, NR_IRQS)
+
+static irqreturn_t
+irqh_interrupt(int irq, void *p)
+{
+	unsigned long flags;
+
+	DPRINTK("interrupt: %d\n", irq);
+	if (!irqh_on(handled, irq))
+		return IRQ_HANDLED;
+	spin_lock_irqsave(&irqh_lock, flags);
+	irqh_set(pending, irq);
+	wake_up_interruptible(&irqh_proc_list);
+	spin_unlock_irqrestore(&irqh_lock, flags);
+	disable_irq_nosync(irq);
+	return IRQ_HANDLED;
+}
+
+static ssize_t
+irqh_dev_write(struct file *fp, const char *buf, size_t size, loff_t *offp)
+{
+	int n, device, func, devfn;
+	char arg[32], *cp, *cp1;
+	struct pci_dev *pdp = 0;
+
+	DPRINTK("ENTER\n");
+	if ((fp->f_mode & FMODE_WRITE) == 0 || size > sizeof arg)
+		return -EINVAL;
+
+	if (size >= sizeof arg || copy_from_user(arg, buf, size))
+		return -EFAULT;
+	arg[size] = 0;
+	cp = arg + (arg[0] == '+' || arg[0] == '-');
+	n = simple_strtol(cp, &cp1, 0);
+	if (*cp1 == ':') {
+		device = simple_strtol(cp1+1, &cp1, 0);
+		func = simple_strtol(cp1+1, NULL, 0);
+		DPRINTK("PCI dev %d:%d.%d\n", n, device, func);
+		devfn = PCI_DEVFN(device, func);
+		for_each_pci_dev(pdp) {
+			if (pdp->bus->number == n && pdp->devfn == devfn) {
+				n = pdp->irq;
+				goto found;
+			}
+		}
+		ERROR("PCI device not found\n");
+		return -ENOENT;
+	}
+    found:
+	DPRINTK("IRQ %d\n", n);
+	if (arg[0] == '+') {
+		if (pdp) {
+			if (pci_enable_device(pdp))
+				ERROR("device not enabled\n");
+			if ((unsigned)(n = pdp->irq) >= NR_IRQS) {
+				ERROR("device has invalid IRQ set\n");
+				return -EINVAL;
+			}
+		}
+		if (irqh_on(handled, n))
+			return -EBUSY;
+		if (request_irq(n, irqh_interrupt, IRQF_SHARED, irqh_MODULE_NAME, (void *)irqh_interrupt)) {
+			ERROR("request_irq failed\n");
+			return -EIO;
+		}
+		printk("Bound machine irq %d\n", n);
+		irqh_set(handled, n);
+		goto done;
+	}
+	if ((unsigned)n >= NR_IRQS)
+		return -EINVAL;
+	if (arg[0] == '-') {
+		if (pdp)
+			pci_disable_device(pdp);
+		free_irq(n, (void *)irqh_interrupt);
+		irqh_clear(handled, n);
+	} else
+		enable_irq(n);
+
+    done:
+	DPRINTK("DONE\n");
+	return size;
+}
+
+static ssize_t
+irqh_dev_read(struct file *fp, char *buf, size_t size, loff_t *offp)
+{
+	char b[20];
+	int m = -ERESTARTSYS, n;
+
+	DECLARE_WAITQUEUE(wait, current);
+
+	DPRINTK("ENTER\n");
+	if ((fp->f_mode & FMODE_READ) == 0)
+		return -EINVAL;
+	spin_lock_irq(&irqh_lock);
+	while (!signal_pending(current)) {
+		if ((n = irqh_ffs(pending)) < NR_IRQS) {
+			if ((m = sprintf(b, "%d", n) + 1) > size)
+				m = size;
+			if (copy_to_user(buf, b, m))
+				m = -EFAULT;
+			else
+				irqh_clear(pending, n);
+			break;
+		}
+		if (fp->f_flags & O_NONBLOCK) {
+			m = -EWOULDBLOCK;
+			break;
+		}
+		add_wait_queue(&irqh_proc_list, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_unlock_irq(&irqh_lock);
+		schedule();
+		spin_lock_irq(&irqh_lock);
+		current->state = TASK_RUNNING;
+		remove_wait_queue(&irqh_proc_list, &wait);
+	}
+	spin_unlock_irq(&irqh_lock);
+	return m;
+}
+
+static struct file_operations irqh_chrdev_ops = {
+	owner:		THIS_MODULE,
+	read:		irqh_dev_read,
+	write:		irqh_dev_write,
+};
+
+#define	irqh_MISCDEV_MINOR	MISC_DYNAMIC_MINOR
+
+static struct miscdevice irqh_miscdev = {
+	irqh_MISCDEV_MINOR,
+	irqh_MODULE_NAME,
+	&irqh_chrdev_ops,
+};
+
+static int __init
+irqh_init(void)
+{
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	if ((rc = misc_register(&irqh_miscdev))) {
+		printk(KERN_ERR irqh_MODULE_NAME ": " "cannot register misc device\n");
+		DPRINTK("EXIT, returning %d\n", rc);
+		return rc;
+	}
+
+	printk(KERN_INFO irqh_DRIVER_NAME " loaded\n");
+
+	init_waitqueue_head(&irqh_proc_list);
+	spin_lock_init(&irqh_lock);
+
+	DPRINTK("EXIT, returning 0\n");
+	return 0;
+}
+
+static void __exit
+irqh_cleanup(void)
+{
+	int n;
+
+	DPRINTK("ENTER\n");
+	
+	while ((n = irqh_ffs(handled)) < NR_IRQS) {
+		irqh_clear(handled, n);
+		free_irq(n, (void *)irqh_interrupt);
+	}
+	misc_deregister (&irqh_miscdev);
+
+	DPRINTK("EXIT\n");
+}
+
+module_init (irqh_init);
+module_exit (irqh_cleanup);
diff --git a/kernel/Makefile b/kernel/Makefile
index fb053eb..c594c67 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -38,6 +38,8 @@ sync:
              "$(LINUX)"/virt/kvm/./*.[ch] \
 	     "$(LINUX)"/./include/linux/kvm*.h \
 	     "$(LINUX)"/./include/asm-x86/kvm*.h \
+	     "$(LINUX)"/./include/linux/ioport.h \
+	     "$(LINUX)"/./include/linux/compiler.h \
              tmp/
 	mkdir -p include/linux include/asm-x86
 	ln -s asm-x86 include/asm
@@ -47,6 +49,8 @@ sync:
 	$(call unifdef, include/linux/kvm_para.h)
 	$(call unifdef, include/asm-x86/kvm.h)
 	$(call unifdef, include/asm-x86/kvm_para.h)
+	$(call unifdef, include/linux/ioport.h)
+	$(call unifdef, include/linux/compiler.h)
 	$(call hack, include/linux/kvm.h)
 	$(call hack, kvm_main.c)
 	$(call hack, mmu.c)
diff --git a/libkvm/libkvm-x86.c b/libkvm/libkvm-x86.c
index 6dba91d..25e95f2 100644
--- a/libkvm/libkvm-x86.c
+++ b/libkvm/libkvm-x86.c
@@ -12,6 +12,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <stdlib.h>
+#include <linux/kvm_para.h>
 
 int kvm_alloc_kernel_memory(kvm_context_t kvm, unsigned long memory,
 								void **vm_mem)
@@ -126,6 +127,18 @@ static int kvm_init_tss(kvm_context_t kvm)
 	return 0;
 }
 
+int kvm_assign_pci_pt_device(kvm_context_t kvm,
+			     struct kvm_pci_passthrough_dev *pci_pt_dev)
+{
+	return ioctl(kvm->vm_fd, KVM_ASSIGN_PCI_PT_DEV, pci_pt_dev);
+}
+
+int kvm_update_pci_pt_guest_irq(kvm_context_t kvm,
+				struct kvm_pci_passthrough_dev *pci_pt_dev)
+{
+	return ioctl(kvm->vm_fd, KVM_UPDATE_PCI_PT_IRQ, pci_pt_dev);
+}
+
 int kvm_arch_create_default_phys_mem(kvm_context_t kvm,
 				       unsigned long phys_mem_bytes,
 				       void **vm_mem)
@@ -430,7 +443,6 @@ void kvm_show_code(kvm_context_t kvm, int vcpu)
 	fprintf(stderr, "code:%s\n", code_str);
 }
 
-
 /*
  * Returns available msr list.  User must free.
  */
diff --git a/libkvm/libkvm.h b/libkvm/libkvm.h
index 29584d9..afc9381 100644
--- a/libkvm/libkvm.h
+++ b/libkvm/libkvm.h
@@ -12,6 +12,7 @@
 #endif
 
 #include <linux/kvm.h>
+#include <linux/kvm_para.h>
 
 #include <signal.h>
 
@@ -599,4 +600,27 @@ int kvm_enable_vapic(kvm_context_t kvm, int vcpu, uint64_t vapic);
 
 #endif
 
+/*!
+ * \brief Notifies host kernel about assigning a PCI device to the guest
+ *
+ * Used for PCI passthrough, this function notifies the host kernel
+ * about the assigning of the physical PCI device and the guest
+ * PCI parameters
+ *
+ * \param kvm Pointer to the current kvm_context
+ * \param pci_pt_dev Parameters like irq, PCI bus, devfn number, etc
+ */
+int kvm_assign_pci_pt_device(kvm_context_t kvm,
+			     struct kvm_pci_passthrough_dev *pci_pt_dev);
+
+/*!
+ * \brief Notifies host kernel about update to IRQ information for a
+ * passthrough-ed PCI device
+ *
+ * \param kvm Pointer to the current kvm_context
+ * \param pci_pt_dev Contains machine irq number and updated guest irq number
+ */
+int kvm_update_pci_pt_guest_irq(kvm_context_t kvm,
+				struct kvm_pci_passthrough_dev *pci_pt_dev);
+
 #endif
diff --git a/qemu/Makefile.target b/qemu/Makefile.target
index 2fc2988..cd5b557 100644
--- a/qemu/Makefile.target
+++ b/qemu/Makefile.target
@@ -592,6 +592,7 @@ OBJS+= ide.o pckbd.o ps2.o vga.o $(SOUND_HW) dma.o
 OBJS+= fdc.o mc146818rtc.o serial.o i8259.o i8254.o pcspk.o pc.o
 OBJS+= cirrus_vga.o apic.o parallel.o acpi.o piix_pci.o
 OBJS+= usb-uhci.o vmmouse.o vmport.o vmware_vga.o extboot.o
+OBJS+= pci-passthrough.o
 ifeq ($(USE_KVM_PIT), 1)
 OBJS+= i8254-kvm.o
 endif
diff --git a/qemu/hw/apic.c b/qemu/hw/apic.c
index 4102493..c7c7da9 100644
--- a/qemu/hw/apic.c
+++ b/qemu/hw/apic.c
@@ -349,6 +349,7 @@ static void apic_eoi(APICState *s)
     /* XXX: send the EOI packet to the APIC bus to allow the I/O APIC to
             set the remote IRR bit for level triggered interrupts. */
     apic_update_irq(s);
+    pt_ack_mirq(isrv);
 }
 
 static void apic_get_delivery_bitmask(uint32_t *deliver_bitmask,
@@ -1111,6 +1112,7 @@ static void ioapic_mem_writel(void *opaque, target_phys_addr_t addr, uint32_t va
                     } else {
                         s->ioredtbl[index] &= ~0xffffffffULL;
                         s->ioredtbl[index] |= val;
+                        pt_set_vector(index, (val << 24) >> 24);
                     }
                     ioapic_service(s);
                 }
diff --git a/qemu/hw/isa.h b/qemu/hw/isa.h
index 89b3004..c720f5e 100644
--- a/qemu/hw/isa.h
+++ b/qemu/hw/isa.h
@@ -1,5 +1,7 @@
 /* ISA bus */
 
+#include "hw.h"
+
 extern target_phys_addr_t isa_mem_base;
 
 int register_ioport_read(int start, int length, int size,
diff --git a/qemu/hw/pc.c b/qemu/hw/pc.c
index 859d7db..f2e20cb 100644
--- a/qemu/hw/pc.c
+++ b/qemu/hw/pc.c
@@ -31,6 +31,7 @@
 #include "net.h"
 #include "smbus.h"
 #include "boards.h"
+#include "pci-passthrough.h"
 
 #include "qemu-kvm.h"
 
@@ -975,6 +976,9 @@ static void pc_init1(ram_addr_t ram_size, int vga_ram_size,
         }
     }
 
+    /* Initialize pass-through */
+    pt_init(pci_bus);
+
     rtc_state = rtc_init(0x70, i8259[8]);
 
     register_ioport_read(0x92, 1, 1, ioport92_read, NULL);
diff --git a/qemu/hw/pci-passthrough.c b/qemu/hw/pci-passthrough.c
new file mode 100644
index 0000000..7ffcc7b
--- /dev/null
+++ b/qemu/hw/pci-passthrough.c
@@ -0,0 +1,677 @@
+/*
+ *  Pass a PCI device from the host to a guest VM.
+ *
+ *  Adapted for KVM by Qumranet.
+ *
+ *  Copyright (c) 2007, Neocleus, Alex Novik (alex@neocleus.com)
+ *  Copyright (c) 2007, Neocleus, Guy Zana (guy@neocleus.com)
+ *  Copyright (C) 2008, Qumranet, Amit Shah (amit.shah@qumranet.com)
+ */
+#include <stdio.h>
+#include <pthread.h>
+#include <sys/io.h>
+#include <sys/ioctl.h>
+#include <linux/types.h>
+
+typedef __u64 resource_size_t;
+#define __deprecated 
+#include <linux/ioport.h>
+
+#include "pci-passthrough.h"
+#include "irq.h"
+
+#include "qemu-kvm.h"
+#include <linux/kvm_para.h>
+extern kvm_context_t kvm_context;
+extern FILE *logfile;
+
+CPUReadMemoryFunc *pt_mmio_read_cb[3] = {
+	pt_mmio_readb,
+	pt_mmio_readw,
+	pt_mmio_readl
+};
+
+CPUWriteMemoryFunc *pt_mmio_write_cb[3] = {
+	pt_mmio_writeb,
+	pt_mmio_writew,
+	pt_mmio_writel
+};
+
+//#define PT_DEBUG
+
+#ifdef PT_DEBUG
+#define DEBUG(fmt, args...) fprintf(stderr, "%s: " fmt, __FUNCTION__ , ## args)
+#else
+#define DEBUG(fmt, args...)
+#endif
+
+#define pt_mmio_write(suffix, type)					\
+void pt_mmio_write##suffix(void *opaque, target_phys_addr_t e_phys,	\
+				uint32_t value)				\
+{									\
+	pt_region_t *r_access = (pt_region_t *)opaque;			\
+	void *r_virt = (u8 *)r_access->r_virtbase + 			\
+			(e_phys - r_access->e_physbase);		\
+	if (r_access->debug & PT_DEBUG_MMIO) {				\
+		fprintf(logfile, "pt_mmio_write" #suffix		\
+			": e_physbase=%p e_phys=%p r_virt=%p value=%08x\n", \
+			(void *)r_access->e_physbase, (void *)e_phys,	\
+			r_virt, value);					\
+	}								\
+	*(type *)r_virt = (type)value;					\
+}
+
+pt_mmio_write(b, u8)
+pt_mmio_write(w, u16)
+pt_mmio_write(l, u32)
+
+#define pt_mmio_read(suffix, type)					\
+uint32_t pt_mmio_read##suffix(void *opaque, target_phys_addr_t e_phys)	\
+{									\
+	pt_region_t *r_access = (pt_region_t *)opaque;			\
+	void *r_virt = (u8 *)r_access->r_virtbase + 			\
+			(e_phys - r_access->e_physbase);		\
+	uint32_t value = (u32) (*(type *) r_virt);			\
+	if (r_access->debug & PT_DEBUG_MMIO) {				\
+		fprintf(logfile,					\
+			"pt_mmio_read" #suffix ": e_physbase=%p "	\
+			"e_phys=%p r_virt=%p value=%08x\n",		\
+			(void *)r_access->e_physbase,			\
+			(void *)e_phys, r_virt, value);			\
+	}								\
+	return value;							\
+}
+
+pt_mmio_read(b, u8)
+pt_mmio_read(w, u16)
+pt_mmio_read(l, u32)
+
+#define pt_ioport_write(suffix)						\
+void pt_ioport_write##suffix(void *opaque, uint32_t addr, uint32_t value) \
+{									\
+	pt_region_t *r_access = (pt_region_t *)opaque;			\
+	uint32_t r_pio = (unsigned long)r_access->r_virtbase		\
+			 + (addr - r_access->e_physbase);		\
+	if (r_access->debug & PT_DEBUG_PIO) {				\
+		fprintf(logfile, "pt_ioport_write" #suffix 		\
+			": r_pio=%08x e_physbase=%08x"			\
+			" r_virtbase=%08lx value=%08x\n", 		\
+			r_pio, (int)r_access->e_physbase,		\
+			(unsigned long)r_access->r_virtbase, value);	\
+	}								\
+	out##suffix(value, r_pio);					\
+}
+
+pt_ioport_write(b)
+pt_ioport_write(w)
+pt_ioport_write(l)
+
+#define pt_ioport_read(suffix)						\
+uint32_t pt_ioport_read##suffix(void *opaque, uint32_t addr)		\
+{									\
+	pt_region_t *r_access = (pt_region_t *)opaque;			\
+	uint32_t r_pio = (addr - r_access->e_physbase)			\
+			+ (unsigned long)r_access->r_virtbase;		\
+	uint32_t value = in##suffix(r_pio);				\
+	if (r_access->debug & PT_DEBUG_PIO) {				\
+		fprintf(logfile, "pt_ioport_read" #suffix 		\
+			": r_pio=%08x e_physbase=%08x r_virtbase=%08lx "\
+			"value=%08x\n", 				\
+			r_pio, (int)r_access->e_physbase, 		\
+			(unsigned long)r_access->r_virtbase, value);	\
+	}								\
+	return (value);							\
+}
+
+pt_ioport_read(b)
+pt_ioport_read(w)
+pt_ioport_read(l)
+
+static void pt_iomem_map(PCIDevice * d, int region_num,
+			 uint32_t e_phys, uint32_t e_size, int type)
+{
+	pt_dev_t *r_dev = (pt_dev_t *) d;
+
+	r_dev->v_addrs[region_num].e_physbase = e_phys;
+
+	DEBUG("e_phys=%08x r_virt=%p type=%d len=%08x region_num=%d \n",
+	      e_phys, r_dev->v_addrs[region_num].r_virtbase, type, e_size,
+	      region_num);
+
+	cpu_register_physical_memory(e_phys,
+				     r_dev->dev.io_regions[region_num].size,
+				     r_dev->v_addrs[region_num].memory_index);
+}
+
+
+static void pt_ioport_map(PCIDevice * pci_dev, int region_num,
+			  uint32_t addr, uint32_t size, int type)
+{
+	pt_dev_t *r_dev = (pt_dev_t *) pci_dev;
+	int i;
+	uint32_t ((*rf[])(void *, uint32_t)) =  { pt_ioport_readb,
+						  pt_ioport_readw,
+						  pt_ioport_readl
+						};
+	void ((*wf[])(void *, uint32_t, uint32_t)) = { pt_ioport_writeb,
+						       pt_ioport_writew,
+						       pt_ioport_writel
+						     };
+
+	r_dev->v_addrs[region_num].e_physbase = addr;
+	DEBUG("pt_ioport_map: address=0x%x type=0x%x len=%d"
+	      "region_num=%d \n", addr, type, size, region_num);
+
+	for (i = 0; i < 3; i++) {
+		register_ioport_write(addr, size, 1<<i, wf[i],
+				      (void *) (r_dev->v_addrs + region_num));
+		register_ioport_read(addr, size, 1<<i, rf[i],
+				     (void *) (r_dev->v_addrs + region_num));
+	}
+}
+
+static void pt_pci_write_config(PCIDevice * d, uint32_t address, uint32_t val,
+				int len)
+{
+	int fd;
+
+	DEBUG("(%x.%x): address=%04x val=0x%08x len=%d\n",
+	      ((d->devfn >> 3) & 0x1F), (d->devfn & 0x7), (uint16_t) address,
+	      val, len);
+
+	if (address == 0x4)
+		pci_default_write_config(d, address, val, len);
+
+	if ((address >= 0x10 && address <= 0x24) || address == 0x34 ||
+	    address == 0x3c || address == 0x3d) {
+	  /* used for update-mappings (BAR emulation) */
+		pci_default_write_config(d, address, val, len);
+		return;
+	}
+
+	DEBUG("NON BAR (%x.%x): address=%04x val=0x%08x len=%d\n",
+	      ((d->devfn >> 3) & 0x1F), (d->devfn & 0x7), (uint16_t) address,
+	      val, len);
+	fd = ((pt_dev_t *)d)->real_device.config_fd;
+	lseek(fd, address, SEEK_SET);
+	write(fd, &val, len);
+}
+
+static uint32_t pt_pci_read_config(PCIDevice *d, uint32_t address, int len)
+{
+	uint32_t val = 0;
+	int fd;
+
+	if ((address >= 0x10 && address <= 0x24) || address == 0x34 ||
+	    address == 0x3c || address == 0x3d) {
+		val = pci_default_read_config(d, address, len);
+		DEBUG("(%x.%x): address=%04x val=0x%08x len=%d\n",
+		      (d->devfn >> 3) & 0x1F, (d->devfn & 0x7), address, val,
+		      len);
+		return (val);
+	}
+
+	/* vga specific, remove later */
+	if (address == 0xFC)
+		goto do_log;
+
+	fd = ((pt_dev_t *)d)->real_device.config_fd;
+	lseek(fd, address, SEEK_SET);
+	read(fd, &val, len);
+
+      do_log:
+	DEBUG("(%x.%x): address=%04x val=0x%08x len=%d\n",
+	      (d->devfn >> 3) & 0x1F, (d->devfn & 0x7), address, val, len);
+
+	/* kill the special capabilities */
+	if (address == 4 && len == 4)
+		val &= ~0x100000;
+	else if (address == 6)
+		val &= ~0x10;
+
+	return (val);
+}
+
+
+static int pt_register_regions(pci_region_t * io_regions,
+			       unsigned long regions_num, pt_dev_t * pci_dev)
+{
+	uint32_t i;
+	pci_region_t *cur_region = io_regions;
+
+	for (i = 0; i < regions_num; i++, cur_region++) {
+		if (!cur_region->valid)
+			continue;
+#ifdef PT_DEBUG
+		pci_dev->v_addrs[i].debug |= PT_DEBUG_MMIO | PT_DEBUG_PIO;
+#endif
+		pci_dev->v_addrs[i].num = i;
+
+		/* handle memory io regions */
+		if (cur_region->type & IORESOURCE_MEM) {
+			int t = cur_region->type & IORESOURCE_PREFETCH
+			  ? PCI_ADDRESS_SPACE_MEM_PREFETCH 
+			  : PCI_ADDRESS_SPACE_MEM;
+
+			/* map physical memory */
+			pci_dev->v_addrs[i].e_physbase = cur_region->base_addr;
+			pci_dev->v_addrs[i].r_virtbase =
+			  mmap(NULL, (cur_region->size + 0xFFF) & 0xFFFFF000,
+			       PROT_WRITE | PROT_READ, MAP_SHARED,
+			       cur_region->resource_fd, (off_t) 0);
+
+			if ((void *) -1 == pci_dev->v_addrs[i].r_virtbase) {
+				fprintf(logfile, "Error: Couldn't mmap 0x%x!\n",
+					(uint32_t) (cur_region->base_addr));
+				return (-1);
+			}
+
+			/* add offset */
+			pci_dev->v_addrs[i].r_virtbase +=
+			  (cur_region->base_addr & 0xFFF);
+
+			pci_register_io_region((PCIDevice *) pci_dev, i,
+					       cur_region->size, t,
+					       pt_iomem_map);
+
+			pci_dev->v_addrs[i].memory_index =
+			    cpu_register_io_memory(0, pt_mmio_read_cb,
+						   pt_mmio_write_cb,
+						   (void *) &(pci_dev->v_addrs[i]));
+
+			continue;
+		}
+		/* handle port io regions */
+
+		pci_register_io_region((PCIDevice *) pci_dev, i,
+				       cur_region->size, PCI_ADDRESS_SPACE_IO,
+				       pt_ioport_map);
+
+		pci_dev->v_addrs[i].e_physbase = cur_region->base_addr;
+		pci_dev->v_addrs[i].r_virtbase = (void *)(long)cur_region->base_addr;
+		pci_dev->v_addrs[i].memory_index = 0;	// not relevant for port io
+	}
+
+	/* success */
+	return (0);
+
+}
+
+static int
+pt_get_real_device(pt_dev_t *pci_dev, uint8_t r_bus, uint8_t r_dev,
+		   uint8_t r_func)
+{
+	char dir[128], name[128], comp[16];
+	int fd, r = 0;
+	FILE *f;
+	unsigned long long start, end, size, flags;
+	pci_region_t *rp;
+	pci_dev_t *dev = &pci_dev->real_device;
+
+	dev->region_number = 0;
+
+	sprintf(dir, "/sys/bus/pci/devices/0000:%02x:%02x.%x/",
+		r_bus, r_dev, r_func);
+	strcpy(name, dir);
+	strcat(name, "config");
+	if ((fd = open(name, O_RDWR)) == -1) {
+		fprintf(logfile, "%s: %m\n", name);
+		return 1;
+	}
+	dev->config_fd = fd;
+	read(fd, pci_dev->dev.config, sizeof pci_dev->dev.config);
+
+	strcpy(name, dir);
+	strcat(name, "resource");
+	if ((f = fopen(name, "r")) == NULL) {
+		fprintf(logfile, "%s: %m\n", name);
+		return 1;
+	}
+
+	for (r = 0; fscanf(f, "%lli %lli %lli\n", &start, &end, &flags) == 3;
+	     r++) {
+		rp = dev->regions + r;
+		rp->valid = 0;
+		size = end - start + 1;
+		flags &= IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH;
+		if (size == 0 || (flags & ~IORESOURCE_PREFETCH) == 0)
+			continue;
+		if (flags & IORESOURCE_MEM) {
+			flags &= ~IORESOURCE_IO;
+			sprintf(comp, "resource%d", r);
+			strcpy(name, dir);
+			strcat(name, comp);
+			if ((fd = open(name, O_RDWR)) == -1)
+				continue;		// probably ROM
+			rp->resource_fd = fd;
+		} else
+			flags &= ~IORESOURCE_PREFETCH;
+
+		rp->type = flags;
+		rp->valid = 1;
+		rp->base_addr = start;
+		rp->size = size;
+		DEBUG("region %d size %d start 0x%x type %d "
+		      "resource_fd %d\n", r, rp->size, start, rp->type,
+		      rp->resource_fd);
+	}
+	fclose(f);
+	
+	dev->region_number = r;
+	return 0;
+}
+
+static int pt_bind_mirq(int bus, int dev, int fn);
+
+static pt_dev_t *register_real_device(PCIBus * e_bus, const char *e_dev_name,
+				      int e_devfn, uint8_t r_bus, uint8_t r_dev,
+				      uint8_t r_func, uint32_t machine_irq)
+{
+	int rc;
+	pt_dev_t *pci_dev;
+	uint8_t e_device, e_intx;
+
+	DEBUG("register_real_device: Registering real physical "
+	      "device %s (devfn=0x%x)\n", e_dev_name, e_devfn);
+
+	pci_dev = (pt_dev_t *) pci_register_device(e_bus, e_dev_name,
+						   sizeof(pt_dev_t), e_devfn,
+						   pt_pci_read_config,
+						   pt_pci_write_config);
+
+	if (NULL == pci_dev) {
+		fprintf(logfile, "register_real_device: Error: Couldn't "
+			"register real device %s\n", e_dev_name);
+		return (NULL);
+	}
+	if (pt_get_real_device(pci_dev, r_bus, r_dev, r_func)) {
+		fprintf(logfile, "register_real_device: Error: Couldn't get "
+			"real device (%s)!\n", e_dev_name);
+		return NULL;
+	}
+
+	/* handle real device's MMIO/PIO BARs */
+	if (pt_register_regions(pci_dev->real_device.regions,
+				pci_dev->real_device.region_number, pci_dev))
+		return (NULL);
+
+	/* handle interrupt routing */
+	e_device = (pci_dev->dev.devfn >> 3) & 0x1f;
+	e_intx = pci_dev->dev.config[0x3d] - 1;
+	pci_dev->intpin = e_intx;
+	pci_dev->run = 0;
+	pci_dev->mirq = machine_irq;
+	pci_dev->girq = 0;
+
+	/* bind machine_irq to device */
+	if (machine_irq && !qemu_kvm_irqchip_in_kernel()) {
+		DEBUG(logfile, "Binding mirq %u to device=0x%x intpin=0x%x\n",
+			machine_irq, e_device, pci_dev->intpin);
+		rc = pt_bind_mirq(r_bus, r_dev, r_func);
+		if (rc) {
+			fprintf(logfile, "pt_bind %d failed rc=%d\n",
+				pci_dev->mirq, rc);
+			return NULL;
+		}
+		sprintf(pci_dev->sirq, "%d", pci_dev->mirq);
+	}
+
+	if (kvm_enabled() && qemu_kvm_irqchip_in_kernel()) {
+		struct kvm_pci_passthrough_dev pci_pt_dev;
+
+		/* We'll set the value of the guest irq as and when
+		 * the piix config gets updated. See pci_pt_update_irq
+		 */
+		pci_pt_dev.guest.irq = 0;
+		pci_pt_dev.host.irq = machine_irq;
+
+		rc = kvm_assign_pci_pt_device(kvm_context, &pci_pt_dev);
+		if (rc == -1) {
+			fprintf(stderr, "Could not notify kernel about "
+				"passthrough device\n");
+			perror("pt-ioctl");
+			return NULL;
+		}
+	}
+
+	fprintf(logfile, "Registered host PCI device %02x:%02x.%1x-%u "
+		"as guest device %02x:%02x.%1x\n",
+		r_bus, r_dev, r_func, machine_irq,
+		pci_bus_num(e_bus), e_device, r_func);
+
+	return (pci_dev);
+}
+
+#define	MAX_PTDEVS 4
+struct {
+	char name[128];
+	int bus;
+	int dev;
+	int func;
+	int irq;
+	pt_dev_t *ptdev;
+} ptdevs[MAX_PTDEVS];
+
+int nptdevs;
+extern int piix_get_irq(int);
+
+/* The pci config space got updated. Check if irq numbers have changed
+ * for our devices
+ */
+void pci_pt_update_irq(PCIDevice *d)
+{
+	int i, irq, r;
+	pt_dev_t *pt_dev;
+
+	for (i = 0; i < nptdevs; i++) {
+		pt_dev = ptdevs[i].ptdev;
+		if (pt_dev == NULL)
+			continue;
+
+		irq = pci_map_irq(&pt_dev->dev, pt_dev->intpin);
+		irq = piix_get_irq(irq);
+		if (irq != pt_dev->girq) {
+			struct kvm_pci_passthrough_dev pci_pt_dev;
+
+			pci_pt_dev.guest.irq = irq;
+			pci_pt_dev.host.irq = pt_dev->mirq;
+			r = kvm_update_pci_pt_guest_irq(kvm_context,
+							&pci_pt_dev);
+			if (r == -1) {
+				perror("pci_pt_update_irq");
+				continue;
+			}
+			pt_dev->girq = irq;
+		}
+	}
+}
+
+static QEMUBH *ptbh;
+static int irqfd;
+static pt_dev_t **apicv[0xfe]; //0x10 - 0xfe according to intel IOAPIC spec
+#define IRQHOOK_DEV "/dev/irqhook"
+static pthread_t irqthread;
+
+static void *pt_irq(void *arg)
+{
+	char buf[20];
+	int irq;
+	int i;
+	pt_dev_t *dev;
+	sigset_t signals;
+
+	sigfillset(&signals);
+	sigprocmask(SIG_BLOCK, &signals, NULL);
+
+	if (!irqfd) {
+		fprintf(stderr, "pt_irq: irqfd %d, exiting\n", irqfd);
+		exit(-1);
+	}
+
+	for (;;) {
+		if (read(irqfd, buf, 20) == -1) {
+			if (errno == EINTR)
+				continue;
+			perror("irq read");
+			break;
+		}
+
+		irq = atoi(buf);
+		DEBUG("read irq %d\n", irq);
+		if (!irq) continue;
+		
+		for (i = 0; i < nptdevs; i++)
+			if ((dev = ptdevs[i].ptdev) && dev->mirq == irq)
+				dev->run = 1;
+		qemu_bh_schedule(ptbh);
+	}
+	return NULL;
+}
+
+static void pt_bh(void *p)
+{
+	int i;
+	pt_dev_t *dev;
+	for (i = 0; i < nptdevs; i++)
+		if ((dev = ptdevs[i].ptdev) && dev->run) {
+			qemu_set_irq(dev->dev.irq[dev->intpin], 1);
+			dev->run = 0;
+			if (cpu_single_env)
+				cpu_interrupt(cpu_single_env, CPU_INTERRUPT_EXIT);
+		}
+}
+
+int pt_init(PCIBus * bus)
+{
+	pt_dev_t *dev = NULL;
+	int i, ret = 0;
+
+	iopl(3);
+
+	if (kvm_enabled() && !qemu_kvm_irqchip_in_kernel()) {
+		if (!(ptbh = qemu_bh_new(pt_bh, 0))) {
+			fprintf(logfile, "Couldn't register PT callback\n");
+			return -1;
+		}
+
+		if (!(irqfd = open(IRQHOOK_DEV, O_RDWR))) {
+			fprintf(logfile, "Couldn't open PT irqhook dev, make "
+				"sure the irqhook module is loaded\n");
+			return -1;
+		}
+	}
+
+	for (i = 0; i < nptdevs; i++) {
+		dev = register_real_device(bus, ptdevs[i].name, -1,
+					   ptdevs[i].bus, ptdevs[i].dev,
+					   ptdevs[i].func, ptdevs[i].irq);
+
+		if (dev == NULL) {
+			fprintf(logfile, "Error: Couldn't register device %s\n",
+				ptdevs[i].name);
+			ret = -1;
+		}
+		ptdevs[i].ptdev = dev;
+	}
+
+	if (kvm_enabled() && !qemu_kvm_irqchip_in_kernel())
+		if (pthread_create(&irqthread, 0, pt_irq, dev)) {
+			fprintf(logfile, "Couldn't create IRQ thread\n");
+			return -1;
+		}
+
+	/* success */
+	return (ret);
+}
+
+void add_pci_passthrough_device(const char *arg)
+{
+	/* name/bus:dev.func-intr */
+	char *cp, *cp1;
+
+	if (nptdevs >= MAX_PTDEVS) {
+		fprintf(logfile, "Too many passthrough devices (max %d)\n",
+			MAX_PTDEVS);
+		return;
+	}
+	strcpy(ptdevs[nptdevs].name, arg);
+	cp = strchr(ptdevs[nptdevs].name, '/');
+	if (cp == NULL)
+		goto bad;
+	*cp++ = 0;
+
+	ptdevs[nptdevs].bus = strtoul(cp, &cp1, 16);
+	if (*cp1 != ':')
+		goto bad;
+	cp = cp1 + 1;
+
+	ptdevs[nptdevs].dev = strtoul(cp, &cp1, 16);
+	if (*cp1 != '.')
+		goto bad;
+	cp = cp1 + 1;
+
+	ptdevs[nptdevs].func = strtoul(cp, &cp1, 16);
+	if (*cp1 != '-')
+		goto bad;
+	cp = cp1 + 1;
+
+	ptdevs[nptdevs].irq = strtoul(cp, &cp1, 0);
+	if (*cp1 != 0)
+		goto bad;
+
+	nptdevs++;
+	return;
+    bad:
+	fprintf(logfile, "passthrough arg (%s) not in the form of "
+		"name/bus:dev.func-intr\n", arg);
+}
+
+void pt_ack_mirq(int vector)
+{
+	pt_dev_t **p = apicv[vector];
+	if (!p) return;
+
+	for (; *p; *p++) {
+		write(irqfd, (*p)->sirq, strlen((*p)->sirq));
+		qemu_set_irq((*p)->dev.irq[(*p)->intpin], 0);
+	}
+}
+
+static int pt_bind_mirq(int bus, int dev, int fn)
+{
+	char s[64];
+	sprintf(s, "+%d:%d.%d", bus, dev, fn);
+	if (write(irqfd, s, strlen(s)) != strlen(s)) {
+		perror("pt_bind_mirq");
+		fprintf(logfile, "Make sure the irqhook module is loaded\n");
+		exit(-1);
+	}
+	return 0;
+}
+
+int piix3_get_pin(int pic_irq);
+
+void pt_set_vector(int irq, int vector)
+{
+	int i, j;
+	int pin = piix3_get_pin(irq);
+	pt_dev_t *pt, **p;
+
+	DEBUG("irq %d vector %d\n", irq, vector);
+	if (vector > 0xfe) return;
+	for (i = 0; i < nptdevs; i++) {
+		pt = ptdevs[i].ptdev;
+		if (!pt || pt->bound)
+			continue;
+		if (pci_map_irq(&pt->dev, pt->intpin) == pin) {
+			for (j = 1, p = apicv[vector]; p; j++, *p++)
+				;
+			apicv[vector] = realloc(apicv[vector], j * sizeof pt);
+			p = &apicv[vector][j];
+			*(p-1) = pt;
+			*p = 0;
+			pt->bound = 1;
+		}
+	}
+	DEBUG("done\n");
+}
diff --git a/qemu/hw/pci-passthrough.h b/qemu/hw/pci-passthrough.h
new file mode 100644
index 0000000..012014a
--- /dev/null
+++ b/qemu/hw/pci-passthrough.h
@@ -0,0 +1,102 @@
+/*
+ *  Data structures for storing PCI state
+ *
+ *  Adapted to kvm by Qumranet
+ *
+ *  Copyright (c) 2007, Neocleus, Alex Novik (alex@neocleus.com)
+ *  Copyright (c) 2007, Neocleus, Guy Zana (guy@neocleus.com)
+ *  Copyright (C) 2008, Qumranet, Amit Shah (amit.shah@qumranet.com)
+ */
+
+#ifndef __PCI_PASSTHROUGH_H__
+#define __PCI_PASSTHROUGH_H__
+
+#include <sys/mman.h>
+#include "qemu-common.h"
+#include "pci.h"
+#include <linux/types.h>
+
+typedef __u8 u8;
+typedef __u16 u16;
+typedef __u32 u32;
+typedef __u64 u64;
+
+#define PT_DEBUG_PIO	(0x01)
+#define PT_DEBUG_MMIO	(0x02)
+
+/* From include/linux/pci.h in the kernel sources */
+#define PCI_DEVFN(slot,func)	((((slot) & 0x1f) << 3) | ((func) & 0x07))
+
+typedef u32 pciaddr_t;
+
+#define MAX_IO_REGIONS			(6)
+
+typedef struct pci_region_s {
+	int type;	/* Memory or port I/O */
+	int valid;
+	pciaddr_t base_addr;
+	pciaddr_t size;		/* size of the region */
+	int resource_fd;
+} pci_region_t;
+
+typedef struct pci_dev_s {
+	u8 bus, dev, func;	/* Bus inside domain, device and function */
+	int irq;		/* IRQ number */
+	u16 region_number;	/* number of active regions */
+
+	/* Port I/O or MMIO Regions */
+	pci_region_t regions[MAX_IO_REGIONS];
+	int config_fd;
+} pci_dev_t;
+
+typedef struct pt_region_s {
+	target_phys_addr_t e_physbase;
+	uint32_t memory_index;
+	void *r_virtbase;	/* mmapped access address */
+	int num;		/* our index within v_addrs[] */
+	uint32_t debug;
+} pt_region_t;
+
+typedef struct pt_dev_s {
+	PCIDevice dev;
+	int intpin;
+	uint8_t debug_flags;
+	pt_region_t v_addrs[PCI_NUM_REGIONS];
+	pci_dev_t real_device;
+	int run;
+	int mirq;
+	int girq;
+	char sirq[4];
+	int bound;
+} pt_dev_t;
+
+/* MMIO access functions */
+uint32_t pt_mmio_readb(void *opaque, target_phys_addr_t e_phys);
+uint32_t pt_mmio_readw(void *opaque, target_phys_addr_t e_phys);
+uint32_t pt_mmio_readl(void *opaque, target_phys_addr_t e_phys);
+void pt_mmio_writeb(void *opaque, target_phys_addr_t e_phys, uint32_t value);
+void pt_mmio_writew(void *opaque, target_phys_addr_t e_phys, uint32_t value);
+void pt_mmio_writel(void *opaque, target_phys_addr_t e_phys, uint32_t value);
+
+/* PIO access functions */
+uint32_t pt_ioport_readb(void *opaque, uint32_t addr);
+uint32_t pt_ioport_readw(void *opaque, uint32_t addr);
+uint32_t pt_ioport_readl(void *opaque, uint32_t addr);
+void pt_ioport_writeb(void *opaque, uint32_t addr, uint32_t value);
+void pt_ioport_writew(void *opaque, uint32_t addr, uint32_t value);
+void pt_ioport_writel(void *opaque, uint32_t addr, uint32_t value);
+
+/* Registration functions */
+int register_pt_pio_region(uint32_t pio_start, uint32_t length,
+			   uint8_t do_logging);
+int register_pt_mmio_region(uint32_t mmio_addr, uint32_t length,
+			    uint8_t do_logging);
+
+/* Initialization functions */
+int pt_init(PCIBus * bus);
+void add_pci_passthrough_device(const char *arg);
+void pt_set_vector(int irq, int vector);
+
+#define logfile stderr
+
+#endif				/* __PCI_PASSTHROUGH_H__ */
diff --git a/qemu/hw/pci.c b/qemu/hw/pci.c
index b8f4fbb..1937408 100644
--- a/qemu/hw/pci.c
+++ b/qemu/hw/pci.c
@@ -26,6 +26,7 @@
 #include "console.h"
 #include "net.h"
 #include "pc.h"
+#include "qemu-kvm.h"
 
 //#define DEBUG_PCI
 
@@ -49,6 +50,7 @@ struct PCIBus {
 
 static void pci_update_mappings(PCIDevice *d);
 static void pci_set_irq(void *opaque, int irq_num, int level);
+void pci_pt_update_irq(PCIDevice *d);
 
 target_phys_addr_t pci_mem_base;
 static int pci_irq_index;
@@ -449,6 +451,10 @@ void pci_default_write_config(PCIDevice *d,
         val >>= 8;
     }
 
+    if (kvm_enabled() && qemu_kvm_irqchip_in_kernel() &&
+	address >= 0x60 && address <= 0x63)
+	pci_pt_update_irq(d);
+
     end = address + len;
     if (end > PCI_COMMAND && address < (PCI_COMMAND + 2)) {
         /* if the command register is modified, we must modify the mappings */
@@ -551,6 +557,11 @@ static void pci_set_irq(void *opaque, int irq_num, int level)
     bus->set_irq(bus->irq_opaque, irq_num, bus->irq_count[irq_num] != 0);
 }
 
+int pci_map_irq(PCIDevice *pci_dev, int pin)
+{
+	return pci_dev->bus->map_irq(pci_dev, pin);
+}
+
 /***********************************************************/
 /* monitor info on PCI */
 
diff --git a/qemu/hw/pci.h b/qemu/hw/pci.h
index 60e4094..e11fbbf 100644
--- a/qemu/hw/pci.h
+++ b/qemu/hw/pci.h
@@ -81,6 +81,7 @@ void pci_register_io_region(PCIDevice *pci_dev, int region_num,
                             uint32_t size, int type,
                             PCIMapIORegionFunc *map_func);
 
+int pci_map_irq(PCIDevice *pci_dev, int pin);
 uint32_t pci_default_read_config(PCIDevice *d,
                                  uint32_t address, int len);
 void pci_default_write_config(PCIDevice *d,
diff --git a/qemu/hw/piix_pci.c b/qemu/hw/piix_pci.c
index a1e04d4..01adbeb 100644
--- a/qemu/hw/piix_pci.c
+++ b/qemu/hw/piix_pci.c
@@ -237,6 +237,25 @@ static void piix3_set_irq(qemu_irq *pic, int irq_num, int level)
     }
 }
 
+int piix3_get_pin(int pic_irq)
+{
+    int i;
+    for (i = 0; i < 4; i++)
+        if (piix3_dev->config[0x60+i] == pic_irq)
+            return i;
+    return -1;
+}
+
+int piix_get_irq(int pin)
+{
+    if (piix3_dev)
+        return piix3_dev->config[0x60+pin];
+    if (piix4_dev)
+        return piix4_dev->config[0x60+pin];
+
+    return 0;
+}
+
 static void piix3_reset(PCIDevice *d)
 {
     uint8_t *pci_conf = d->config;
diff --git a/qemu/vl.c b/qemu/vl.c
index 49d9af2..35a0465 100644
--- a/qemu/vl.c
+++ b/qemu/vl.c
@@ -37,6 +37,7 @@
 #include "qemu-char.h"
 #include "block.h"
 #include "audio/audio.h"
+#include "hw/pci-passthrough.h"
 #include "migration.h"
 #include "qemu-kvm.h"
 
@@ -8176,6 +8177,10 @@ static void help(int exitcode)
 #endif
 	   "-no-kvm-irqchip disable KVM kernel mode PIC/IOAPIC/LAPIC\n"
 	   "-no-kvm-pit	    disable KVM kernel mode PIT\n"
+#if defined(TARGET_I386) || defined(TARGET_X86_64)
+	   "-pcidevice name/bus:dev.func-intr \n"
+	   "                expose a PCI device to the guest OS\n"
+#endif
 #endif
 #ifdef TARGET_I386
            "-std-vga        simulate a standard VGA card with VESA Bochs Extensions\n"
@@ -8299,6 +8304,9 @@ enum {
     QEMU_OPTION_no_kvm,
     QEMU_OPTION_no_kvm_irqchip,
     QEMU_OPTION_no_kvm_pit,
+#if defined(TARGET_I386) || defined(TARGET_X86_64)
+    QEMU_OPTION_pcidevice,
+#endif
     QEMU_OPTION_no_reboot,
     QEMU_OPTION_show_cursor,
     QEMU_OPTION_daemonize,
@@ -8386,6 +8394,9 @@ const QEMUOption qemu_options[] = {
 #endif
     { "no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip },
     { "no-kvm-pit", 0, QEMU_OPTION_no_kvm_pit },
+#if defined(TARGET_I386) || defined(TARGET_X86_64)
+    { "pcidevice", HAS_ARG, QEMU_OPTION_pcidevice },
+#endif
 #endif
 #if defined(TARGET_PPC) || defined(TARGET_SPARC)
     { "g", 1, QEMU_OPTION_g },
@@ -9336,6 +9347,11 @@ int main(int argc, char **argv)
 		kvm_pit = 0;
 		break;
 	    }
+#if defined(TARGET_I386) || defined(TARGET_X86_64)
+	    case QEMU_OPTION_pcidevice:
+		add_pci_passthrough_device(optarg);
+		break;
+#endif		
 #endif
             case QEMU_OPTION_usb:
                 usb_enabled = 1;
diff --git a/tools/pci_barsize.c b/tools/pci_barsize.c
new file mode 100644
index 0000000..dd230c9
--- /dev/null
+++ b/tools/pci_barsize.c
@@ -0,0 +1,53 @@
+#include <stdio.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdlib.h>
+
+int
+panic(char *msg)
+{
+	perror(msg);
+	exit(1);
+}
+
+int
+main(int argc, char **argv)
+{
+	unsigned l, b, sz;
+	int fd, ismem, bar = 0, offs;
+
+	if (argc < 2)
+		panic("usage: pci_barsize <file> [bar no]");
+	
+	if ((fd = open(argv[1], O_RDWR)) < 0)
+		panic("open");
+
+	if (argc > 2)
+		bar = strtoul(argv[2], 0, 0);
+	if (bar < 0 || bar > 5)
+		panic("bar range 0-5");
+
+	offs = 0x10 + bar * 4;
+	lseek(fd, offs, 0);
+	read(fd, &l, sizeof(l));
+	printf("bar %d (offs 0x%x) == %x\n", bar, offs, l);
+
+	ismem = !(l & 0x01);
+	
+	b = ~0;
+	lseek(fd, offs, 0);
+	write(fd, &b, sizeof(b));
+
+	lseek(fd, offs, 0);
+	read(fd, &b, sizeof(b));
+	sz = ~(b & (ismem ? ~0x15 : ~0x1)) + 1;
+	printf("bar %d %s size 0x%x == %ldKB (%x)\n",
+		bar, ismem ? "memory" : "IO", sz, sz / 1024, b);
+
+	lseek(fd, offs, 0);
+	write(fd, &l, sizeof(l));
+
+	return 0;
+}
diff --git a/tools/pci_mmio.c b/tools/pci_mmio.c
new file mode 100644
index 0000000..6e91571
--- /dev/null
+++ b/tools/pci_mmio.c
@@ -0,0 +1,82 @@
+#include <stdio.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+
+int
+panic(char *msg)
+{
+	perror(msg);
+	exit(1);
+}
+
+int
+main(int argc, char **argv)
+{
+	unsigned sz;
+	int fd, cnt, rsz, offs = 0;
+	void *map;
+	struct stat st;
+
+	if (argc < 2)
+		panic("usage: pci_mmio <resouce-file> [offset [count]]");
+	
+	if ((fd = open(argv[1], O_RDWR)) < 0)
+		panic("open");
+
+	if (fstat(fd, &st) < 0)
+		panic("fstat");
+	cnt = sz = st.st_size;
+
+	if (argc > 2)
+		offs = strtoul(argv[2], 0, 0);
+	if (argc > 3)
+		cnt = strtoul(argv[3], 0, 0);
+
+	if (cnt < 0 || cnt > sz)
+		panic("bad count");
+	if (offs < 0 || offs > sz)
+		panic("bad offset");
+	if (offs + cnt > sz) {
+		cnt = sz - offs;
+		fprintf(stderr, "count truncated to %d", cnt);
+	}
+	if (cnt > 4 && offs % 4)
+		panic("read bigger than 4 must be 4 bytes aligned");
+	if (cnt == 2 && offs % 2)
+		panic("2 bytes read must be 2 bytes aligned");
+	if (cnt != 1 && cnt != 2 && cnt != 4 && cnt % 4)
+		panic("counts must be 1, 2, 4 or 4*n");
+
+	fprintf(stderr, "reading %s [%d:%d]\n", argv[1], offs, offs + cnt);
+	map = mmap(NULL, sz, PROT_WRITE | PROT_READ, MAP_SHARED, fd, 0);
+
+	if (!map)
+		panic("mmap");
+
+	rsz = cnt > 4 ? 4 : cnt;
+	fprintf(stderr, "rsz: %d cnt %d\n", rsz, cnt);
+	while (cnt > 0) {
+		char buf[8];
+		switch (rsz) {
+		case 1:
+			*(char *)buf = *(char *)map + offs;
+			break;
+		case 2:
+			*(short *)buf = *(short *)map + offs/sizeof(short);
+			break;
+		case 4:
+			*(int *)buf = *(int *)map + offs/4;
+			break;
+		}
+		write(1, buf, rsz);
+
+		offs += rsz;
+		cnt -= rsz;
+	}
+	fprintf(stderr, "done\n");
+	return 0;
+}
-- 
1.4.4.2
