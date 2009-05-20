From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] qemu: msi irq allocation api
Date: Wed, 20 May 2009 19:21:30 +0300
Message-ID: <20090520162130.GA22109__22386.8005014539$1242836715$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, Anthony Liguori <anthony@codemon>
List-Id: virtualization@lists.linuxfoundation.org

define api for allocating/setting up msi-x irqs, and for updating them
with msi-x vector information, supply implementation in ioapic. Please
comment on this API: I intend to port my msi-x patch to work on top of
it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/apic.c     |    1 -
 hw/ioapic.c   |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/irq.c      |   10 ++++++++
 hw/irq.h      |    5 ++++
 hw/pc.c       |    1 +
 hw/pc.h       |    2 +
 hw/pci.c      |    2 +
 hw/pci.h      |   10 ++++++++
 qemu-common.h |    1 +
 9 files changed, 96 insertions(+), 1 deletions(-)

diff --git a/hw/apic.c b/hw/apic.c
index d63d74b..2d2de69 100644
--- a/hw/apic.c
+++ b/hw/apic.c
@@ -929,4 +929,3 @@ int apic_init(CPUState *env)
     local_apics[s->id] = s;
     return 0;
 }
-
diff --git a/hw/ioapic.c b/hw/ioapic.c
index 317c2c2..5a99c46 100644
--- a/hw/ioapic.c
+++ b/hw/ioapic.c
@@ -23,6 +23,7 @@
 
 #include "hw.h"
 #include "pc.h"
+#include "pci.h"
 #include "qemu-timer.h"
 #include "host-utils.h"
 
@@ -43,6 +44,16 @@
 #define IOAPIC_DM_SIPI			0x5
 #define IOAPIC_DM_EXTINT		0x7
 
+/* Intel APIC constants: from include/asm/msidef.h */
+#define MSI_DATA_VECTOR_SHIFT		0
+#define MSI_DATA_VECTOR_MASK		0x000000ff
+#define MSI_DATA_DELIVERY_MODE_SHIFT	8
+#define MSI_ADDR_DEST_MODE_SHIFT	2
+#define MSI_DATA_TRIGGER_SHIFT		15
+#define MSI_ADDR_DEST_ID_SHIFT		12
+#define	MSI_ADDR_DEST_ID_MASK		0x00ffff0
+#define MSI_DATA_LEVEL_SHIFT		14
+
 struct IOAPICState {
     uint8_t id;
     uint8_t ioregsel;
@@ -51,6 +62,11 @@ struct IOAPICState {
     uint64_t ioredtbl[IOAPIC_NUM_PINS];
 };
 
+struct msi_state {
+    uint64_t addr;
+    uint32_t data;
+};
+
 static void ioapic_service(IOAPICState *s)
 {
     uint8_t i;
@@ -259,3 +275,52 @@ IOAPICState *ioapic_init(void)
 
     return s;
 }
+
+/* MSI/MSI-X support */
+static void ioapic_send_msi(void *opaque, int irq, int level)
+{
+    struct msi_state *state = opaque;
+    uint8_t dest = (state[irq].addr & MSI_ADDR_DEST_ID_MASK)
+        >> MSI_ADDR_DEST_ID_SHIFT;
+    uint8_t vector = ((state[irq].addr >> 32) & MSI_DATA_VECTOR_MASK)
+        >> MSI_DATA_VECTOR_SHIFT;
+    uint8_t dest_mode = (state[irq].addr >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
+    uint8_t trigger_mode = (state[irq].data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
+    uint8_t delivery = (state[irq].data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 0x7;
+    apic_deliver_irq(dest, dest_mode, delivery, vector, 0, trigger_mode);
+}
+
+static qemu_irq *ioapic_allocate_msi(int nentries)
+{
+    struct msi_state *state = qemu_mallocz(nentries * sizeof *state);
+    qemu_irq *irqs;
+    if (!state)
+        return NULL;
+    irqs = qemu_allocate_irqs(ioapic_send_msi, state, nentries);
+    if (!irqs)
+        qemu_free(state);
+    return irqs;
+}
+
+static void ioapic_free_msi(qemu_irq *irq)
+{
+    qemu_free(qemu_irq_get_opaque(irq[0]));
+    qemu_free_irqs(irq);
+}
+
+static int ioapic_update_msi(qemu_irq irq, uint64_t addr, uint32_t data,
+                             int masked)
+{
+    struct msi_state *state = qemu_irq_get_opaque(irq);
+    int vector = qemu_irq_get_vector(irq);
+    state[vector].addr = addr;
+    state[vector].data = data;
+    return 0;
+}
+
+struct pci_msi_ops ioapic_msi_ops = {
+    .allocate = ioapic_allocate_msi,
+    .update = ioapic_update_msi,
+    .free = ioapic_free_msi,
+};
+
diff --git a/hw/irq.c b/hw/irq.c
index 7703f62..9180381 100644
--- a/hw/irq.c
+++ b/hw/irq.c
@@ -75,3 +75,13 @@ qemu_irq qemu_irq_invert(qemu_irq irq)
     qemu_irq_raise(irq);
     return qemu_allocate_irqs(qemu_notirq, irq, 1)[0];
 }
+
+void *qemu_irq_get_opaque(qemu_irq irq)
+{
+    return irq->opaque;
+}
+
+int qemu_irq_get_vector(qemu_irq irq)
+{
+    return irq->n;
+}
diff --git a/hw/irq.h b/hw/irq.h
index 5daae44..0e3144d 100644
--- a/hw/irq.h
+++ b/hw/irq.h
@@ -32,4 +32,9 @@ void qemu_free_irqs(qemu_irq *s);
 /* Returns a new IRQ with opposite polarity.  */
 qemu_irq qemu_irq_invert(qemu_irq irq);
 
+/* Get the pointer stored in the irq. */
+void *qemu_irq_get_opaque(qemu_irq irq);
+
+/* Get vector stored in the irq */
+int qemu_irq_get_vector(qemu_irq irq);
 #endif
diff --git a/hw/pc.c b/hw/pc.c
index 61f6e7b..1b287c3 100644
--- a/hw/pc.c
+++ b/hw/pc.c
@@ -962,6 +962,7 @@ static void pc_init1(ram_addr_t ram_size, int vga_ram_size,
     if (pci_enabled) {
         pci_bus = i440fx_init(&i440fx_state, i8259);
         piix3_devfn = piix3_init(pci_bus, -1);
+        pci_msi_ops = &ioapic_msi_ops;
     } else {
         pci_bus = NULL;
     }
diff --git a/hw/pc.h b/hw/pc.h
index 50e6c39..2013aa9 100644
--- a/hw/pc.h
+++ b/hw/pc.h
@@ -55,6 +55,8 @@ void ioapic_set_irq(void *opaque, int vector, int level);
 void apic_reset_irq_delivered(void);
 int apic_get_irq_delivered(void);
 
+extern struct pci_msi_ops ioapic_msi_ops;
+
 /* i8254.c */
 
 #define PIT_FREQ 1193182
diff --git a/hw/pci.c b/hw/pci.c
index b8186f6..cd453c9 100644
--- a/hw/pci.c
+++ b/hw/pci.c
@@ -57,6 +57,8 @@ static uint16_t pci_default_sub_device_id = PCI_SUBDEVICE_ID_QEMU;
 static int pci_irq_index;
 static PCIBus *first_bus;
 
+struct pci_msi_ops *pci_msi_ops;
+
 static void pcibus_save(QEMUFile *f, void *opaque)
 {
     PCIBus *bus = (PCIBus *)opaque;
diff --git a/hw/pci.h b/hw/pci.h
index a629e60..8883f08 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -280,4 +280,14 @@ PCIBus *pci_apb_init(target_phys_addr_t special_base,
 PCIBus *sh_pci_register_bus(pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                             qemu_irq *pic, int devfn_min, int nirq);
 
+/* MSI/MSI-X */
+
+struct pci_msi_ops {
+    qemu_irq *(*allocate)(int nentries);
+    int (*update)(qemu_irq, uint64_t addr, uint32_t data, int masked);
+    void (*free)(qemu_irq *);
+};
+
+extern struct pci_msi_ops *pci_msi_ops;
+
 #endif
diff --git a/qemu-common.h b/qemu-common.h
index c90c3e3..d5a1112 100644
--- a/qemu-common.h
+++ b/qemu-common.h
@@ -178,6 +178,7 @@ typedef struct PCIDevice PCIDevice;
 typedef struct SerialState SerialState;
 typedef struct IRQState *qemu_irq;
 struct pcmcia_card_s;
+struct pci_msi_ops;
 
 /* CPU save/load.  */
 void cpu_save(QEMUFile *f, void *opaque);
-- 
1.6.3.1.56.g79e1.dirty
