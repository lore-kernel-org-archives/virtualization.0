From: Amit Shah <amit.shah@qumranet.com>
Subject: [PATCH 2/2] KVM: PCIPT: irqhook module for interrupt injection into
	guests with
Date: Fri, 27 Jun 2008 15:58:40 +0300
Message-ID: <1214571520-20814-3-git-send-email-amit.shah@qumranet.com>
References: <1214571520-20814-1-git-send-email-amit.shah@qumranet.com>
	<1214571520-20814-2-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1214571520-20814-2-git-send-email-amit.shah@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org
Cc: chrisw@redhat.com, allen.m.kay@intel.com, virtualization@lists.osdl.org, benami@il.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

From: Nir Peleg <nir@tutis.com>
From: Or Sagi <ors@tutis.com>

When using the --no-kvm-irqchip option, this irqhook module injects
interrupts into the guests for assigned devices.

This module is not well-supported and only exists for debugging and
for legacy / non-x86 support.

Signed-off-by: Amit Shah <amit.shah@qumranet.com>
---
 Makefile                  |   10 ++-
 irqhook/Kbuild            |    3 +
 irqhook/Makefile          |   25 +++++
 irqhook/irqhook_main.c    |  215 +++++++++++++++++++++++++++++++++++++++++++++
 qemu/hw/apic.c            |    4 +
 qemu/hw/pci-passthrough.c |  171 ++++++++++++++++++++++++++++++++++--
 qemu/hw/pci-passthrough.h |    1 +
 qemu/vl.c                 |    4 +-
 8 files changed, 421 insertions(+), 12 deletions(-)
 create mode 100644 irqhook/Kbuild
 create mode 100644 irqhook/Makefile
 create mode 100644 irqhook/irqhook_main.c

diff --git a/Makefile b/Makefile
index 48a8dff..d4246fd 100644
--- a/Makefile
+++ b/Makefile
@@ -7,16 +7,16 @@ rpmrelease = devel
 
 sane-arch = $(subst i386,x86,$(subst x86_64,x86,$(ARCH)))
 
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
@@ -77,6 +77,7 @@ install-rpm:
 
 install:
 	$(kcmd)make -C kernel DESTDIR="$(DESTDIR)" install
+	$(kcmd)make -C irqhook DESTDIR="$(DESTDIR)" install
 	make -C libkvm DESTDIR="$(DESTDIR)" install
 	make -C qemu DESTDIR="$(DESTDIR)" install
 
@@ -97,6 +98,7 @@ srpm:
 	tar czf $(RPMTOPDIR)/SOURCES/user.tar.gz user
 	tar czf $(RPMTOPDIR)/SOURCES/libkvm.tar.gz libkvm
 	tar czf $(RPMTOPDIR)/SOURCES/kernel.tar.gz kernel
+	tar czf $(RPMTOPDIR)/SOURCES/irqhook.tar.gz irqhook
 	tar czf $(RPMTOPDIR)/SOURCES/scripts.tar.gz scripts
 	tar czf $(RPMTOPDIR)/SOURCES/extboot.tar.gz extboot
 	cp Makefile configure kvm_stat $(RPMTOPDIR)/SOURCES
@@ -104,7 +106,7 @@ srpm:
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
diff --git a/qemu/hw/apic.c b/qemu/hw/apic.c
index 4ebf1ff..7d45385 100644
--- a/qemu/hw/apic.c
+++ b/qemu/hw/apic.c
@@ -23,6 +23,8 @@
 
 #include "qemu-kvm.h"
 
+#include "pci-passthrough.h"
+
 //#define DEBUG_APIC
 //#define DEBUG_IOAPIC
 
@@ -389,6 +391,7 @@ static void apic_eoi(APICState *s)
     /* XXX: send the EOI packet to the APIC bus to allow the I/O APIC to
             set the remote IRR bit for level triggered interrupts. */
     apic_update_irq(s);
+    pt_ack_mirq(isrv);
 }
 
 static void apic_get_delivery_bitmask(uint32_t *deliver_bitmask,
@@ -1144,6 +1147,7 @@ static void ioapic_mem_writel(void *opaque, target_phys_addr_t addr, uint32_t va
                     } else {
                         s->ioredtbl[index] &= ~0xffffffffULL;
                         s->ioredtbl[index] |= val;
+                        pt_set_vector(index, (val << 24) >> 24);
                     }
                     ioapic_service(s);
                 }
diff --git a/qemu/hw/pci-passthrough.c b/qemu/hw/pci-passthrough.c
index 250d7ef..1cf1d0f 100644
--- a/qemu/hw/pci-passthrough.c
+++ b/qemu/hw/pci-passthrough.c
@@ -398,9 +398,11 @@ again:
 	return 0;
 }
 
+static int pt_bind_mirq(int bus, int dev, int fn);
+
 static pt_dev_t *register_real_device(PCIBus *e_bus, const char *e_dev_name,
 				      int e_devfn, uint8_t r_bus, uint8_t r_dev,
-				      uint8_t r_func)
+				      uint8_t r_func, uint32_t machine_irq)
 {
 	int rc;
 	pt_dev_t *pci_dev;
@@ -435,10 +437,24 @@ static pt_dev_t *register_real_device(PCIBus *e_bus, const char *e_dev_name,
 	e_intx = pci_dev->dev.config[0x3d] - 1;
 	pci_dev->intpin = e_intx;
 	pci_dev->run = 0;
+	pci_dev->mirq = machine_irq;
 	pci_dev->girq = 0;
 	pci_dev->h_busnr = r_bus;
 	pci_dev->h_devfn = PCI_DEVFN(r_dev, r_func);
 
+	/* bind machine_irq to device */
+	if (machine_irq && (!kvm_enabled() || !qemu_kvm_irqchip_in_kernel())) {
+		DEBUG(logfile, "Binding mirq %u to device=0x%x intpin=0x%x\n",
+			machine_irq, e_device, pci_dev->intpin);
+		rc = pt_bind_mirq(r_bus, r_dev, r_func);
+		if (rc) {
+			fprintf(stderr, "pt_bind %d failed rc=%d\n",
+				pci_dev->mirq, rc);
+			return NULL;
+		}
+		sprintf(pci_dev->sirq, "%d", pci_dev->mirq);
+	}
+
 #ifdef KVM_CAP_PCI_PASSTHROUGH
 	if (kvm_enabled()) {
 		struct kvm_pci_passthrough_dev pci_pt_dev;
@@ -464,9 +480,9 @@ static pt_dev_t *register_real_device(PCIBus *e_bus, const char *e_dev_name,
 	}
 #endif
 
-	fprintf(logfile, "Registered host PCI device %02x:%02x.%1x "
+	fprintf(logfile, "Registered host PCI device %02x:%02x.%1x-%u "
 		"as guest device %02x:%02x.%1x\n",
-		r_bus, r_dev, r_func,
+		r_bus, r_dev, r_func, machine_irq,
 		pci_bus_num(e_bus), e_device, r_func);
 
 	return pci_dev;
@@ -478,6 +494,7 @@ struct {
 	int bus;
 	int dev;
 	int func;
+	int irq;
 	pt_dev_t *ptdev;
 } ptdevs[MAX_PTDEVS];
 
@@ -518,6 +535,62 @@ void pci_pt_update_irq(PCIDevice *d)
 }
 #endif
 
+static QEMUBH *ptbh;
+static int irqfd;
+static pt_dev_t **apicv[0xfe]; /* 0x10 - 0xfe according to intel IOAPIC spec */
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
+		if (!irq)
+			continue;
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
 int pt_init_system(void)
 {
 	/* Do we have any devices to be assigned? */
@@ -526,6 +599,17 @@ int pt_init_system(void)
 
 	iopl(3);
 
+	if (!kvm_enabled() || !qemu_kvm_irqchip_in_kernel()) {
+		if (!(ptbh = qemu_bh_new(pt_bh, 0))) {
+			fprintf(stderr, "Couldn't register PT callback\n");
+			return -1;
+		}
+		if (!(irqfd = open(IRQHOOK_DEV, O_RDWR))) {
+			fprintf(stderr, "Couldn't open PT irqhook dev, make "
+				"sure the irqhook module is loaded\n");
+			return -1;
+		}
+	}
 	return 0;
 }
 
@@ -544,7 +628,7 @@ int pt_init_device(PCIBus *bus, int *index)
 
 	dev = register_real_device(bus, ptdevs[i].name, -1,
 				   ptdevs[i].bus, ptdevs[i].dev,
-				   ptdevs[i].func);
+				   ptdevs[i].func, ptdevs[i].irq);
 	if (dev == NULL) {
 		fprintf(stderr, "Error: Couldn't register device %s\n",
 			ptdevs[i].name);
@@ -552,13 +636,23 @@ int pt_init_device(PCIBus *bus, int *index)
 	}
 	ptdevs[i].ptdev = dev;
 
+	if (!*index && kvm_enabled() && !qemu_kvm_irqchip_in_kernel()) {
+		if (ptdevs[i].irq == 0) {
+			fprintf(stderr, "Please specify the irq for the device\n");
+			return -1;
+		}
+		if (pthread_create(&irqthread, 0, pt_irq, dev)) {
+			fprintf(stderr, "Couldn't create IRQ thread\n");
+			return -1;
+		}
+	}
 	--*index;
 	return ret;
 }
 
 void add_pci_passthrough_device(const char *arg)
 {
-	/* name/bus:dev.func */
+	/* name/bus:dev.func-intr */
 	char *cp, *cp1;
 
 	if (nptdevs >= MAX_PTDEVS) {
@@ -583,12 +677,75 @@ void add_pci_passthrough_device(const char *arg)
 	cp = cp1 + 1;
 
 	ptdevs[nptdevs].func = strtoul(cp, &cp1, 16);
-	if (*cp1 != 0)
+
+	/* In case of irqchip_in_kernel, we don't want the next param */
+	if (*cp1 == 0) {
+		ptdevs[nptdevs].irq = 0;
+		goto skip_irq;
+	}
+	if (*cp1 != '-')
 		goto bad;
+	cp = cp1 + 1;
 
+	ptdevs[nptdevs].irq = strtoul(cp, &cp1, 0);
+	if (*cp1 != 0)
+		goto bad;
+skip_irq:
 	nptdevs++;
 	return;
 bad:
 	fprintf(stderr, "passthrough arg (%s) not in the form of "
-		"name/bus:dev.func\n", arg);
+		"name/bus:dev.func-intr\n", arg);
+}
+
+void pt_ack_mirq(int vector)
+{
+	pt_dev_t **p = apicv[vector];
+	if (!p)
+		return;
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
+		fprintf(stderr, "Make sure the irqhook module is loaded\n");
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
+	if (vector > 0xfe)
+		return;
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
 }
diff --git a/qemu/hw/pci-passthrough.h b/qemu/hw/pci-passthrough.h
index 60df017..cd63482 100644
--- a/qemu/hw/pci-passthrough.h
+++ b/qemu/hw/pci-passthrough.h
@@ -75,6 +75,7 @@ typedef struct pt_dev_s {
 	pt_region_t v_addrs[PCI_NUM_REGIONS];
 	pci_dev_t real_device;
 	int run;
+	int mirq;
 	int girq;
 	char sirq[4];
 	unsigned char h_busnr;
diff --git a/qemu/vl.c b/qemu/vl.c
index 4946e9a..33decf5 100644
--- a/qemu/vl.c
+++ b/qemu/vl.c
@@ -7788,9 +7788,11 @@ static void help(int exitcode)
 	   "-no-kvm-irqchip disable KVM kernel mode PIC/IOAPIC/LAPIC\n"
 	   "-no-kvm-pit	    disable KVM kernel mode PIT\n"
 #if defined(TARGET_I386) || defined(TARGET_X86_64)
-	   "-pcidevice name/bus:dev.func\n"
+	   "-pcidevice name/bus:dev.func[-intr] \n"
 	   "                expose a PCI device to the guest OS.\n"
 	   "                'name' is just used for debug logs.\n"
+	   "                [-intr] is the interrupt (from the lspci -v output),\n"
+	   "                in case you use the irqhook module for interrupt routing.\n"
 #endif
 #endif
 #ifdef TARGET_I386
-- 
1.5.4.3
