From: Amit Shah <amit.shah@qumranet.com>
Subject: [PATCH 1/2] KVM/userspace: Support for assigning PCI devices to guest
Date: Fri, 27 Jun 2008 15:58:39 +0300
Message-ID: <1214571520-20814-2-git-send-email-amit.shah@qumranet.com>
References: <1214571520-20814-1-git-send-email-amit.shah@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1214571520-20814-1-git-send-email-amit.shah@qumranet.com>
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

From: Or Sagi <ors@tutis.com>
From: Nir Peleg <nir@tutis.com>
From: Amit Shah <amit.shah@qumranet.com>
From: Glauber de Oliveira Costa <gcosta@redhat.com>

We can assign a device from the host machine to a guest. The
original code comes from Neocleus.

A new command-line option, -pcidevice is added.
For example, to invoke it for an Ethernet device sitting at
PCI bus:dev.fn 04:08.0 with host IRQ 18, use this:

        -pcidevice Ethernet/04:08.0

The host ethernet driver is to be removed before doing the
passthrough. If not, the device assignment fails but the
guest continues without the assignment.

If kvm uses the in-kernel irqchip, interrupts are routed to the
guest via the kvm module (accompanied kernel changes are necessary).

If -no-kvm-irqchip is used, the 'irqhook' module, available
separately, is to be used for interrupt injection into the guest. In
this case, an extra parameter, -<intr-number> is to be appended to
the above-mentioned pcidevice parameter.

Signed-off-by: Amit Shah <amit.shah@qumranet.com>
---
 libkvm/libkvm-x86.c       |    9 +-
 libkvm/libkvm.h           |   16 ++
 qemu/Makefile.target      |    1 +
 qemu/hw/isa.h             |    2 +
 qemu/hw/pc.c              |    9 +
 qemu/hw/pci-passthrough.c |  594 +++++++++++++++++++++++++++++++++++++++++++++
 qemu/hw/pci-passthrough.h |   93 +++++++
 qemu/hw/pci.c             |   12 +
 qemu/hw/pci.h             |    1 +
 qemu/hw/piix_pci.c        |   19 ++
 qemu/vl.c                 |   17 ++
 11 files changed, 772 insertions(+), 1 deletions(-)
 create mode 100644 qemu/hw/pci-passthrough.c
 create mode 100644 qemu/hw/pci-passthrough.h

diff --git a/libkvm/libkvm-x86.c b/libkvm/libkvm-x86.c
index ea97bdd..0c4cdbe 100644
--- a/libkvm/libkvm-x86.c
+++ b/libkvm/libkvm-x86.c
@@ -126,6 +126,14 @@ static int kvm_init_tss(kvm_context_t kvm)
 	return 0;
 }
 
+#ifdef KVM_CAP_PCI_PASSTHROUGH
+int kvm_update_pci_pt_device(kvm_context_t kvm,
+			     struct kvm_pci_passthrough_dev *pci_pt_dev)
+{
+	return ioctl(kvm->vm_fd, KVM_UPDATE_PCI_PT_DEV, pci_pt_dev);
+}
+#endif
+
 int kvm_arch_create_default_phys_mem(kvm_context_t kvm,
 				       unsigned long phys_mem_bytes,
 				       void **vm_mem)
@@ -435,7 +443,6 @@ void kvm_show_code(kvm_context_t kvm, int vcpu)
 	fprintf(stderr, "code:%s\n", code_str);
 }
 
-
 /*
  * Returns available msr list.  User must free.
  */
diff --git a/libkvm/libkvm.h b/libkvm/libkvm.h
index ad6e26a..ccb086f 100644
--- a/libkvm/libkvm.h
+++ b/libkvm/libkvm.h
@@ -12,6 +12,7 @@
 #endif
 
 #include <linux/kvm.h>
+#include <linux/kvm_para.h>
 
 #include <signal.h>
 
@@ -639,4 +640,19 @@ int kvm_enable_vapic(kvm_context_t kvm, int vcpu, uint64_t vapic);
 
 #endif
 
+#ifdef KVM_CAP_PCI_PASSTHROUGH
+/*!
+ * \brief Notifies host kernel about changes to a PCI device assigned to guest
+ *
+ * Used for PCI device assignment, this function notifies the host
+ * kernel about the assigning of the physical PCI device and the guest
+ * PCI parameters or updates to the PCI config space from the guest
+ * (mainly the device irq)
+ *
+ * \param kvm Pointer to the current kvm_context
+ * \param pci_pt_dev Parameters like irq, PCI bus, devfn number, etc
+ */
+int kvm_update_pci_pt_device(kvm_context_t kvm,
+			     struct kvm_pci_passthrough_dev *pci_pt_dev);
+#endif
 #endif
diff --git a/qemu/Makefile.target b/qemu/Makefile.target
index 77b2301..432011f 100644
--- a/qemu/Makefile.target
+++ b/qemu/Makefile.target
@@ -602,6 +602,7 @@ OBJS+= ide.o pckbd.o ps2.o vga.o $(SOUND_HW) dma.o
 OBJS+= fdc.o mc146818rtc.o serial.o i8259.o i8254.o pcspk.o pc.o
 OBJS+= cirrus_vga.o apic.o parallel.o acpi.o piix_pci.o
 OBJS+= usb-uhci.o vmmouse.o vmport.o vmware_vga.o extboot.o
+OBJS+= pci-passthrough.o
 ifeq ($(USE_KVM_PIT), 1)
 OBJS+= i8254-kvm.o
 endif
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
index 6334c76..0b0606a 100644
--- a/qemu/hw/pc.c
+++ b/qemu/hw/pc.c
@@ -32,6 +32,7 @@
 #include "smbus.h"
 #include "boards.h"
 #include "console.h"
+#include "pci-passthrough.h"
 
 #include "qemu-kvm.h"
 
@@ -995,6 +996,14 @@ static void pc_init1(ram_addr_t ram_size, int vga_ram_size,
         }
     }
 
+    /* Initialize pass-through */
+    if (pci_enabled) {
+        int r = -1;
+        do {
+            pt_init_device(pci_bus, &r);
+	} while (r >= 0);
+    }
+
     rtc_state = rtc_init(0x70, i8259[8]);
 
     qemu_register_boot_set(pc_boot_set, rtc_state);
diff --git a/qemu/hw/pci-passthrough.c b/qemu/hw/pci-passthrough.c
new file mode 100644
index 0000000..250d7ef
--- /dev/null
+++ b/qemu/hw/pci-passthrough.c
@@ -0,0 +1,594 @@
+/*
+ * Copyright (c) 2007, Neocleus Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
+ * Place - Suite 330, Boston, MA 02111-1307 USA.
+ *
+ *
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
+/* From linux/ioport.h */
+#define IORESOURCE_IO		0x00000100	/* Resource type */
+#define IORESOURCE_MEM		0x00000200
+#define IORESOURCE_IRQ		0x00000400
+#define IORESOURCE_DMA		0x00000800
+#define IORESOURCE_PREFETCH	0x00001000	/* No side effects */
+
+#include "pci-passthrough.h"
+#include "irq.h"
+
+#include "qemu-kvm.h"
+#include <linux/kvm_para.h>
+extern FILE *logfile;
+
+//#define PT_DEBUG
+
+#ifdef PT_DEBUG
+#define DEBUG(fmt, args...) fprintf(stderr, "%s: " fmt, __func__ , ## args)
+#else
+#define DEBUG(fmt, args...)
+#endif
+
+#define pt_mmio_write(suffix, type)					\
+static void pt_mmio_write##suffix(void *opaque, target_phys_addr_t e_phys, \
+				uint32_t value)				\
+{									\
+	pt_region_t *r_access = (pt_region_t *)opaque;			\
+	void *r_virt = (uint8_t *)r_access->r_virtbase +		\
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
+pt_mmio_write(b, uint8_t)
+pt_mmio_write(w, uint16_t)
+pt_mmio_write(l, uint32_t)
+
+#define pt_mmio_read(suffix, type)					\
+static uint32_t pt_mmio_read##suffix(void *opaque, target_phys_addr_t e_phys) \
+{									\
+	pt_region_t *r_access = (pt_region_t *)opaque;			\
+	void *r_virt = (uint8_t *)r_access->r_virtbase +		\
+			(e_phys - r_access->e_physbase);		\
+	uint32_t value = (uint32_t) (*(type *) r_virt);			\
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
+pt_mmio_read(b, uint8_t)
+pt_mmio_read(w, uint16_t)
+pt_mmio_read(l, uint32_t)
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
+#define pt_ioport_write(suffix)						\
+static void pt_ioport_write##suffix(void *opaque, uint32_t addr, uint32_t value) \
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
+static uint32_t pt_ioport_read##suffix(void *opaque, uint32_t addr)	\
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
+	return value;							\
+}
+
+pt_ioport_read(b)
+pt_ioport_read(w)
+pt_ioport_read(l)
+
+static void pt_iomem_map(PCIDevice *d, int region_num,
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
+static void pt_ioport_map(PCIDevice *pci_dev, int region_num,
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
+static void pt_pci_write_config(PCIDevice *d, uint32_t address, uint32_t val,
+				int len)
+{
+	int fd, r;
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
+		/* used for update-mappings (BAR emulation) */
+		pci_default_write_config(d, address, val, len);
+		return;
+	}
+
+	DEBUG("NON BAR (%x.%x): address=%04x val=0x%08x len=%d\n",
+	      ((d->devfn >> 3) & 0x1F), (d->devfn & 0x7), (uint16_t) address,
+	      val, len);
+	fd = ((pt_dev_t *)d)->real_device.config_fd;
+	lseek(fd, address, SEEK_SET);
+again:
+	r = write(fd, &val, len);
+	if (r < 0) {
+		if (errno == EINTR || errno == EAGAIN)
+			goto again;
+		fprintf(stderr, "%s: write failed, errno = %d\n", __func__,
+			errno);
+	}
+}
+
+static uint32_t pt_pci_read_config(PCIDevice *d, uint32_t address, int len)
+{
+	uint32_t val = 0;
+	int fd, r;
+
+	if ((address >= 0x10 && address <= 0x24) || address == 0x34 ||
+	    address == 0x3c || address == 0x3d) {
+		val = pci_default_read_config(d, address, len);
+		DEBUG("(%x.%x): address=%04x val=0x%08x len=%d\n",
+		      (d->devfn >> 3) & 0x1F, (d->devfn & 0x7), address, val,
+		      len);
+		return val;
+	}
+
+	/* vga specific, remove later */
+	if (address == 0xFC)
+		goto do_log;
+
+	fd = ((pt_dev_t *)d)->real_device.config_fd;
+	lseek(fd, address, SEEK_SET);
+again:
+	r = read(fd, &val, len);
+	if (r < 0) {
+		if (errno == EINTR || errno == EAGAIN)
+			goto again;
+		fprintf(stderr, "%s: read failed, errno = %d\n", __func__,
+			errno);
+	}
+
+do_log:
+	DEBUG("(%x.%x): address=%04x val=0x%08x len=%d\n",
+	      (d->devfn >> 3) & 0x1F, (d->devfn & 0x7), address, val, len);
+
+	/* kill the special capabilities */
+	if (address == 4 && len == 4)
+		val &= ~0x100000;
+	else if (address == 6)
+		val &= ~0x10;
+
+	return val;
+}
+
+static int pt_register_regions(pci_region_t *io_regions,
+			       unsigned long regions_num, pt_dev_t *pci_dev)
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
+				fprintf(stderr, "Error: Couldn't mmap 0x%x!\n",
+					(uint32_t) (cur_region->base_addr));
+				return -1;
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
+		/* not relevant for port io */
+		pci_dev->v_addrs[i].memory_index = 0;
+	}
+
+	/* success */
+	return 0;
+
+}
+
+static int pt_get_real_device(pt_dev_t *pci_dev, uint8_t r_bus, uint8_t r_dev,
+			      uint8_t r_func)
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
+		fprintf(stderr, "%s: %m\n", name);
+		return 1;
+	}
+	dev->config_fd = fd;
+again:
+	r = read(fd, pci_dev->dev.config, sizeof pci_dev->dev.config);
+	if (r < 0) {
+		if (errno == EINTR || errno == EAGAIN)
+			goto again;
+		fprintf(stderr, "%s: read failed, errno = %d\n", __func__,
+			errno);
+	}
+
+	strcpy(name, dir);
+	strcat(name, "resource");
+	if ((f = fopen(name, "r")) == NULL) {
+		fprintf(stderr, "%s: %m\n", name);
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
+				continue;		/* probably ROM */
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
+static pt_dev_t *register_real_device(PCIBus *e_bus, const char *e_dev_name,
+				      int e_devfn, uint8_t r_bus, uint8_t r_dev,
+				      uint8_t r_func)
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
+		fprintf(stderr, "register_real_device: Error: Couldn't "
+			"register real device %s\n", e_dev_name);
+		return NULL;
+	}
+	if (pt_get_real_device(pci_dev, r_bus, r_dev, r_func)) {
+		fprintf(stderr, "register_real_device: Error: Couldn't get "
+			"real device (%s)!\n", e_dev_name);
+		return NULL;
+	}
+
+	/* handle real device's MMIO/PIO BARs */
+	if (pt_register_regions(pci_dev->real_device.regions,
+				pci_dev->real_device.region_number, pci_dev))
+		return NULL;
+
+	/* handle interrupt routing */
+	e_device = (pci_dev->dev.devfn >> 3) & 0x1f;
+	e_intx = pci_dev->dev.config[0x3d] - 1;
+	pci_dev->intpin = e_intx;
+	pci_dev->run = 0;
+	pci_dev->girq = 0;
+	pci_dev->h_busnr = r_bus;
+	pci_dev->h_devfn = PCI_DEVFN(r_dev, r_func);
+
+#ifdef KVM_CAP_PCI_PASSTHROUGH
+	if (kvm_enabled()) {
+		struct kvm_pci_passthrough_dev pci_pt_dev;
+
+		memset(&pci_pt_dev, 0, sizeof(pci_pt_dev));
+		pci_pt_dev.guest.busnr = pci_bus_num(e_bus);
+		pci_pt_dev.guest.devfn = PCI_DEVFN(e_device, r_func);
+		pci_pt_dev.host.busnr  = pci_dev->h_busnr;
+		pci_pt_dev.host.devfn  = pci_dev->h_devfn;
+
+		/* We'll set the value of the guest irq as and when
+		 * the piix config gets updated. See pci_pt_update_irq.
+		 * The host irq field never gets used anyway
+		 */
+
+		rc = kvm_update_pci_pt_device(kvm_context, &pci_pt_dev);
+		if (rc < 0) {
+			fprintf(stderr, "Could not notify kernel about "
+				"passthrough device\n");
+			perror("pt-ioctl");
+			return NULL;
+		}
+	}
+#endif
+
+	fprintf(logfile, "Registered host PCI device %02x:%02x.%1x "
+		"as guest device %02x:%02x.%1x\n",
+		r_bus, r_dev, r_func,
+		pci_bus_num(e_bus), e_device, r_func);
+
+	return pci_dev;
+}
+
+#define	MAX_PTDEVS 4
+struct {
+	char name[128];
+	int bus;
+	int dev;
+	int func;
+	pt_dev_t *ptdev;
+} ptdevs[MAX_PTDEVS];
+
+int nptdevs;
+extern int piix_get_irq(int);
+
+#ifdef KVM_CAP_PCI_PASSTHROUGH
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
+			memset(&pci_pt_dev, 0, sizeof(pci_pt_dev));
+			pci_pt_dev.guest.irq = irq;
+			pci_pt_dev.host.busnr = pt_dev->h_busnr;
+			pci_pt_dev.host.devfn = pt_dev->h_devfn;
+			r = kvm_update_pci_pt_device(kvm_context, &pci_pt_dev);
+			if (r < 0) {
+				perror("pci_pt_update_irq");
+				continue;
+			}
+			pt_dev->girq = irq;
+		}
+	}
+}
+#endif
+
+int pt_init_system(void)
+{
+	/* Do we have any devices to be assigned? */
+	if (nptdevs == 0)
+		return -1;
+
+	iopl(3);
+
+	return 0;
+}
+
+int pt_init_device(PCIBus *bus, int *index)
+{
+	pt_dev_t *dev = NULL;
+	int i, ret = 0;
+
+	if (*index == -1) {
+		if (pt_init_system() < 0)
+			return -1;
+
+		*index = nptdevs - 1;
+	}
+	i = *index;
+
+	dev = register_real_device(bus, ptdevs[i].name, -1,
+				   ptdevs[i].bus, ptdevs[i].dev,
+				   ptdevs[i].func);
+	if (dev == NULL) {
+		fprintf(stderr, "Error: Couldn't register device %s\n",
+			ptdevs[i].name);
+		ret = -1;
+	}
+	ptdevs[i].ptdev = dev;
+
+	--*index;
+	return ret;
+}
+
+void add_pci_passthrough_device(const char *arg)
+{
+	/* name/bus:dev.func */
+	char *cp, *cp1;
+
+	if (nptdevs >= MAX_PTDEVS) {
+		fprintf(stderr, "Too many passthrough devices (max %d)\n",
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
+	if (*cp1 != 0)
+		goto bad;
+
+	nptdevs++;
+	return;
+bad:
+	fprintf(stderr, "passthrough arg (%s) not in the form of "
+		"name/bus:dev.func\n", arg);
+}
diff --git a/qemu/hw/pci-passthrough.h b/qemu/hw/pci-passthrough.h
new file mode 100644
index 0000000..60df017
--- /dev/null
+++ b/qemu/hw/pci-passthrough.h
@@ -0,0 +1,93 @@
+/*
+ * Copyright (c) 2007, Neocleus Corporation.
+ * Copyright (c) 2007, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
+ * Place - Suite 330, Boston, MA 02111-1307 USA.
+ *
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
+#define PT_DEBUG_PIO	(0x01)
+#define PT_DEBUG_MMIO	(0x02)
+
+/* From include/linux/pci.h in the kernel sources */
+#define PCI_DEVFN(slot,func)	((((slot) & 0x1f) << 3) | ((func) & 0x07))
+
+typedef uint32_t pciaddr_t;
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
+	uint8_t bus, dev, func;	/* Bus inside domain, device and function */
+	int irq;		/* IRQ number */
+	uint16_t region_number;	/* number of active regions */
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
+	int girq;
+	char sirq[4];
+	unsigned char h_busnr;
+	unsigned int h_devfn;
+	int bound;
+} pt_dev_t;
+
+/* Initialization functions */
+int pt_init_device(PCIBus *bus, int *index);
+void add_pci_passthrough_device(const char *arg);
+void pt_set_vector(int irq, int vector);
+void pt_ack_mirq(int vector);
+
+#define logfile stderr
+
+#endif				/* __PCI_PASSTHROUGH_H__ */
diff --git a/qemu/hw/pci.c b/qemu/hw/pci.c
index 92683d1..ff21b83 100644
--- a/qemu/hw/pci.c
+++ b/qemu/hw/pci.c
@@ -50,6 +50,7 @@ struct PCIBus {
 
 static void pci_update_mappings(PCIDevice *d);
 static void pci_set_irq(void *opaque, int irq_num, int level);
+void pci_pt_update_irq(PCIDevice *d);
 
 target_phys_addr_t pci_mem_base;
 static int pci_irq_index;
@@ -453,6 +454,12 @@ void pci_default_write_config(PCIDevice *d,
         val >>= 8;
     }
 
+#ifdef KVM_CAP_PCI_PASSTHROUGH
+    if (kvm_enabled() && qemu_kvm_irqchip_in_kernel() &&
+	address >= 0x60 && address <= 0x63)
+	pci_pt_update_irq(d);
+#endif
+
     end = address + len;
     if (end > PCI_COMMAND && address < (PCI_COMMAND + 2)) {
         /* if the command register is modified, we must modify the mappings */
@@ -555,6 +562,11 @@ static void pci_set_irq(void *opaque, int irq_num, int level)
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
index 90cb3a6..112381a 100644
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
index 3032eaf..4946e9a 100644
--- a/qemu/vl.c
+++ b/qemu/vl.c
@@ -37,6 +37,7 @@
 #include "qemu-char.h"
 #include "block.h"
 #include "audio/audio.h"
+#include "hw/pci-passthrough.h"
 #include "migration.h"
 #include "qemu-kvm.h"
 
@@ -7786,6 +7787,11 @@ static void help(int exitcode)
 #endif
 	   "-no-kvm-irqchip disable KVM kernel mode PIC/IOAPIC/LAPIC\n"
 	   "-no-kvm-pit	    disable KVM kernel mode PIT\n"
+#if defined(TARGET_I386) || defined(TARGET_X86_64)
+	   "-pcidevice name/bus:dev.func\n"
+	   "                expose a PCI device to the guest OS.\n"
+	   "                'name' is just used for debug logs.\n"
+#endif
 #endif
 #ifdef TARGET_I386
            "-std-vga        simulate a standard VGA card with VESA Bochs Extensions\n"
@@ -7909,6 +7915,9 @@ enum {
     QEMU_OPTION_no_kvm,
     QEMU_OPTION_no_kvm_irqchip,
     QEMU_OPTION_no_kvm_pit,
+#if defined(TARGET_I386) || defined(TARGET_X86_64)
+    QEMU_OPTION_pcidevice,
+#endif
     QEMU_OPTION_no_reboot,
     QEMU_OPTION_no_shutdown,
     QEMU_OPTION_show_cursor,
@@ -7997,6 +8006,9 @@ const QEMUOption qemu_options[] = {
 #endif
     { "no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip },
     { "no-kvm-pit", 0, QEMU_OPTION_no_kvm_pit },
+#if defined(TARGET_I386) || defined(TARGET_X86_64)
+    { "pcidevice", HAS_ARG, QEMU_OPTION_pcidevice },
+#endif
 #endif
 #if defined(TARGET_PPC) || defined(TARGET_SPARC)
     { "g", 1, QEMU_OPTION_g },
@@ -8909,6 +8921,11 @@ int main(int argc, char **argv)
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
-- 
1.5.4.3
