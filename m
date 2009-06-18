From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv5 01/13] qemu: make default_write_config use mask table
Date: Thu, 18 Jun 2009 16:12:50 +0300
Message-ID: <20090618131250.GB19092__11636.55650239$1245331266$gmane$org@redhat.com>
References: <cover.1245330293.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1245330293.git.mst@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>, qemu-devel@nongnu.org, Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Rusty Russell <rusty@rustcor>
List-Id: virtualization@lists.linuxfoundation.org

Change much of hw/pci to use symbolic constants and a table-driven
design: add a mask table with writable bits set and readonly bits unset.
Detect change by comparing original and new registers.

This makes it easy to support capabilities where read-only/writeable
bit layout differs between devices, depending on capabilities present.

As a result, writing a single byte in BAR registers now works as
it should. Writing to upper limit registers in the bridge
also works as it should. Code is also shorter.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci.c |  145 ++++++++++++-------------------------------------------------
 hw/pci.h |   18 +++++++-
 2 files changed, 46 insertions(+), 117 deletions(-)

diff --git a/hw/pci.c b/hw/pci.c
index 0a738db..840986f 100644
--- a/hw/pci.c
+++ b/hw/pci.c
@@ -238,6 +238,17 @@ int pci_assign_devaddr(const char *addr, int *domp, int *busp, unsigned *slotp)
     return pci_parse_devaddr(devaddr, domp, busp, slotp);
 }
 
+static void pci_init_mask(PCIDevice *dev)
+{
+    int i;
+    dev->wmask[PCI_CACHE_LINE_SIZE] = 0xff;
+    dev->wmask[PCI_INTERRUPT_LINE] = 0xff;
+    dev->wmask[PCI_COMMAND] = PCI_COMMAND_IO | PCI_COMMAND_MEMORY
+                              | PCI_COMMAND_MASTER;
+    for (i = PCI_CONFIG_HEADER_SIZE; i < PCI_CONFIG_SPACE_SIZE; ++i)
+        dev->wmask[i] = 0xff;
+}
+
 /* -1 for devfn means auto assign */
 static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
                                          const char *name, int devfn,
@@ -257,6 +268,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
     memset(pci_dev->irq_state, 0, sizeof(pci_dev->irq_state));
     pci_set_default_subsystem_id(pci_dev);
+    pci_init_mask(pci_dev);
 
     if (!config_read)
         config_read = pci_default_read_config;
@@ -328,6 +340,7 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
 {
     PCIIORegion *r;
     uint32_t addr;
+    uint32_t wmask;
 
     if ((unsigned int)region_num >= PCI_NUM_REGIONS)
         return;
@@ -343,12 +356,17 @@ void pci_register_bar(PCIDevice *pci_dev, int region_num,
     r->size = size;
     r->type = type;
     r->map_func = map_func;
+
+    wmask = ~(size - 1);
     if (region_num == PCI_ROM_SLOT) {
         addr = 0x30;
+        /* ROM enable bit is writeable */
+        wmask |= 1;
     } else {
         addr = 0x10 + region_num * 4;
     }
     *(uint32_t *)(pci_dev->config + addr) = cpu_to_le32(type);
+    *(uint32_t *)(pci_dev->wmask + addr) = cpu_to_le32(wmask);
 }
 
 static void pci_update_mappings(PCIDevice *d)
@@ -457,118 +475,21 @@ uint32_t pci_default_read_config(PCIDevice *d,
     return val;
 }
 
-void pci_default_write_config(PCIDevice *d,
-                              uint32_t address, uint32_t val, int len)
+void pci_default_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int l)
 {
-    int can_write, i;
-    uint32_t end, addr;
-
-    if (len == 4 && ((address >= 0x10 && address < 0x10 + 4 * 6) ||
-                     (address >= 0x30 && address < 0x34))) {
-        PCIIORegion *r;
-        int reg;
+    uint8_t orig[PCI_CONFIG_SPACE_SIZE];
+    int i;
 
-        if ( address >= 0x30 ) {
-            reg = PCI_ROM_SLOT;
-        }else{
-            reg = (address - 0x10) >> 2;
-        }
-        r = &d->io_regions[reg];
-        if (r->size == 0)
-            goto default_config;
-        /* compute the stored value */
-        if (reg == PCI_ROM_SLOT) {
-            /* keep ROM enable bit */
-            val &= (~(r->size - 1)) | 1;
-        } else {
-            val &= ~(r->size - 1);
-            val |= r->type;
-        }
-        *(uint32_t *)(d->config + address) = cpu_to_le32(val);
-        pci_update_mappings(d);
-        return;
-    }
- default_config:
     /* not efficient, but simple */
-    addr = address;
-    for(i = 0; i < len; i++) {
-        /* default read/write accesses */
-        switch(d->config[0x0e]) {
-        case 0x00:
-        case 0x80:
-            switch(addr) {
-            case 0x00:
-            case 0x01:
-            case 0x02:
-            case 0x03:
-            case 0x06:
-            case 0x07:
-            case 0x08:
-            case 0x09:
-            case 0x0a:
-            case 0x0b:
-            case 0x0e:
-            case 0x10 ... 0x27: /* base */
-            case 0x2c ... 0x2f: /* read-only subsystem ID & vendor ID */
-            case 0x30 ... 0x33: /* rom */
-            case 0x3d:
-                can_write = 0;
-                break;
-            default:
-                can_write = 1;
-                break;
-            }
-            break;
-        default:
-        case 0x01:
-            switch(addr) {
-            case 0x00:
-            case 0x01:
-            case 0x02:
-            case 0x03:
-            case 0x06:
-            case 0x07:
-            case 0x08:
-            case 0x09:
-            case 0x0a:
-            case 0x0b:
-            case 0x0e:
-            case 0x2c ... 0x2f: /* read-only subsystem ID & vendor ID */
-            case 0x38 ... 0x3b: /* rom */
-            case 0x3d:
-                can_write = 0;
-                break;
-            default:
-                can_write = 1;
-                break;
-            }
-            break;
-        }
-        if (can_write) {
-            /* Mask out writes to reserved bits in registers */
-            switch (addr) {
-	    case 0x05:
-                val &= ~PCI_COMMAND_RESERVED_MASK_HI;
-                break;
-            case 0x06:
-                val &= ~PCI_STATUS_RESERVED_MASK_LO;
-                break;
-            case 0x07:
-                val &= ~PCI_STATUS_RESERVED_MASK_HI;
-                break;
-            }
-            d->config[addr] = val;
-        }
-        if (++addr > 0xff)
-        	break;
-        val >>= 8;
+    memcpy(orig, d->config, PCI_CONFIG_SPACE_SIZE);
+    for(i = 0; i < l && addr < PCI_CONFIG_SPACE_SIZE; val >>= 8, ++i, ++addr) {
+        uint8_t wmask = d->wmask[addr];
+        d->config[addr] = (d->config[addr] & ~wmask) | (val & wmask);
     }
-
-    end = address + len;
-    if (end > PCI_COMMAND && address < (PCI_COMMAND + 2)) {
-        /* if the command register is modified, we must modify the mappings */
+    if (memcmp(orig + PCI_BASE_ADDRESS_0, d->config + PCI_BASE_ADDRESS_0, 24)
+        || ((orig[PCI_COMMAND] ^ d->config[PCI_COMMAND])
+            & (PCI_COMMAND_MEMORY | PCI_COMMAND_IO)))
         pci_update_mappings(d);
-    }
 }
 
 void pci_data_write(void *opaque, uint32_t addr, uint32_t val, int len)
@@ -841,16 +762,8 @@ static void pci_bridge_write_config(PCIDevice *d,
 {
     PCIBridge *s = (PCIBridge *)d;
 
-    if (address == 0x19 || (address == 0x18 && len > 1)) {
-        if (address == 0x19)
-            s->bus->bus_num = val & 0xff;
-        else
-            s->bus->bus_num = (val >> 8) & 0xff;
-#if defined(DEBUG_PCI)
-        printf ("pci-bridge: %s: Assigned bus %d\n", d->name, s->bus->bus_num);
-#endif
-    }
     pci_default_write_config(d, address, val, len);
+    s->bus->bus_num = d->config[PCI_SECONDARY_BUS];
 }
 
 PCIBus *pci_find_bus(int bus_num)
diff --git a/hw/pci.h b/hw/pci.h
index fcca526..44aa61b 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -98,16 +98,24 @@ typedef struct PCIIORegion {
 #define PCI_COMMAND		0x04	/* 16 bits */
 #define  PCI_COMMAND_IO		0x1	/* Enable response in I/O space */
 #define  PCI_COMMAND_MEMORY	0x2	/* Enable response in Memory space */
+#define  PCI_COMMAND_MASTER	0x4	/* Enable bus master */
 #define PCI_STATUS              0x06    /* 16 bits */
 #define PCI_REVISION_ID         0x08    /* 8 bits  */
 #define PCI_CLASS_DEVICE        0x0a    /* Device class */
+#define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
+#define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
 #define PCI_HEADER_TYPE         0x0e    /* 8 bits */
 #define  PCI_HEADER_TYPE_NORMAL		0
 #define  PCI_HEADER_TYPE_BRIDGE		1
 #define  PCI_HEADER_TYPE_CARDBUS	2
 #define  PCI_HEADER_TYPE_MULTI_FUNCTION 0x80
+#define PCI_BASE_ADDRESS_0	0x10	/* 32 bits */
+#define PCI_PRIMARY_BUS		0x18	/* Primary bus number */
+#define PCI_SECONDARY_BUS	0x19	/* Secondary bus number */
+#define PCI_SEC_STATUS		0x1e	/* Secondary status register, only bit 14 used */
 #define PCI_SUBSYSTEM_VENDOR_ID 0x2c    /* 16 bits */
 #define PCI_SUBSYSTEM_ID        0x2e    /* 16 bits */
+#define PCI_CAPABILITY_LIST	0x34	/* Offset of first capability list entry */
 #define PCI_INTERRUPT_LINE	0x3c	/* 8 bits */
 #define PCI_INTERRUPT_PIN	0x3d	/* 8 bits */
 #define PCI_MIN_GNT		0x3e	/* 8 bits */
@@ -137,10 +145,18 @@ typedef struct PCIIORegion {
 
 #define PCI_COMMAND_RESERVED_MASK_HI (PCI_COMMAND_RESERVED >> 8)
 
+/* Size of the standard PCI config header */
+#define PCI_CONFIG_HEADER_SIZE 0x40
+/* Size of the standard PCI config space */
+#define PCI_CONFIG_SPACE_SIZE 0x100
+
 struct PCIDevice {
     DeviceState qdev;
     /* PCI config space */
-    uint8_t config[256];
+    uint8_t config[PCI_CONFIG_SPACE_SIZE];
+
+    /* Used to implement R/W bytes */
+    uint8_t wmask[PCI_CONFIG_SPACE_SIZE];
 
     /* the following fields are read only */
     PCIBus *bus;
-- 
1.6.2.2
