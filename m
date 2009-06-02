From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 07/13] qemu: minimal MSI/MSI-X implementation for PC
Date: Tue, 2 Jun 2009 18:02:43 +0300
Message-ID: <20090602150243.GH6554__3161.96213611892$1243955786$gmane$org@redhat.com>
References: <cover.1243954694.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1243954694.git.mst@redhat.com>
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

Implement MSI support in APIC. Note that MSI and MMIO APIC registers
are at the same memory location, but actually not on the global bus: MSI
is on PCI bus, APIC is connected directly to the CPU. We map them on the
global bus at the same address which happens to work because MSI
registers are reserved in APIC MMIO and vice versa.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/apic.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/hw/apic.c b/hw/apic.c
index 8c8b2de..d831709 100644
--- a/hw/apic.c
+++ b/hw/apic.c
@@ -19,6 +19,8 @@
  */
 #include "hw.h"
 #include "pc.h"
+#include "pci.h"
+#include "msix.h"
 #include "qemu-timer.h"
 #include "host-utils.h"
 
@@ -63,6 +65,19 @@
 #define MAX_APICS 255
 #define MAX_APIC_WORDS 8
 
+/* Intel APIC constants: from include/asm/msidef.h */
+#define MSI_DATA_VECTOR_SHIFT		0
+#define MSI_DATA_VECTOR_MASK		0x000000ff
+#define MSI_DATA_DELIVERY_MODE_SHIFT	8
+#define MSI_DATA_TRIGGER_SHIFT		15
+#define MSI_DATA_LEVEL_SHIFT		14
+#define MSI_ADDR_DEST_MODE_SHIFT	2
+#define MSI_ADDR_DEST_ID_SHIFT		12
+#define	MSI_ADDR_DEST_ID_MASK		0x00ffff0
+
+#define MSI_ADDR_BASE                   0xfee00000
+#define MSI_ADDR_SIZE                   0x100000
+
 typedef struct APICState {
     CPUState *cpu_env;
     uint32_t apicbase;
@@ -86,6 +101,13 @@ typedef struct APICState {
     QEMUTimer *timer;
 } APICState;
 
+struct msi_state {
+    uint64_t addr;
+    uint32_t data;
+    int mask;
+    int pending;
+};
+
 static int apic_io_memory;
 static APICState *local_apics[MAX_APICS + 1];
 static int last_apic_id = 0;
@@ -712,11 +734,31 @@ static uint32_t apic_mem_readl(void *opaque, target_phys_addr_t addr)
     return val;
 }
 
+static void apic_send_msi(target_phys_addr_t addr, uint32 data)
+{
+    uint8_t dest = (addr & MSI_ADDR_DEST_ID_MASK) >> MSI_ADDR_DEST_ID_SHIFT;
+    uint8_t vector = (data & MSI_DATA_VECTOR_MASK) >> MSI_DATA_VECTOR_SHIFT;
+    uint8_t dest_mode = (addr >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
+    uint8_t trigger_mode = (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
+    uint8_t delivery = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 0x7;
+    /* XXX: Ignore redirection hint. */
+    apic_deliver_irq(dest, dest_mode, delivery, vector, 0, trigger_mode);
+}
+
 static void apic_mem_writel(void *opaque, target_phys_addr_t addr, uint32_t val)
 {
     CPUState *env;
     APICState *s;
-    int index;
+    int index = (addr >> 4) & 0xff;
+    if (addr > 0xfff || !index) {
+        /* MSI and MMIO APIC are at the same memory location,
+         * but actually not on the global bus: MSI is on PCI bus
+         * APIC is connected directly to the CPU.
+         * Mapping them on the global bus happens to work because
+         * MSI registers are reserved in APIC MMIO and vice versa. */
+        apic_send_msi(addr, val);
+        return;
+    }
 
     env = cpu_single_env;
     if (!env)
@@ -727,7 +769,6 @@ static void apic_mem_writel(void *opaque, target_phys_addr_t addr, uint32_t val)
     printf("APIC write: %08x = %08x\n", (uint32_t)addr, val);
 #endif
 
-    index = (addr >> 4) & 0xff;
     switch(index) {
     case 0x02:
         s->id = (val >> 24);
@@ -911,6 +952,7 @@ int apic_init(CPUState *env)
     s->cpu_env = env;
 
     apic_reset(s);
+    msix_supported = 1;
 
     /* XXX: mapping more APICs at the same memory location */
     if (apic_io_memory == 0) {
@@ -918,7 +960,8 @@ int apic_init(CPUState *env)
            on the global memory bus. */
         apic_io_memory = cpu_register_io_memory(0, apic_mem_read,
                                                 apic_mem_write, NULL);
-        cpu_register_physical_memory(s->apicbase & ~0xfff, 0x1000,
+        /* XXX: what if the base changes? */
+        cpu_register_physical_memory(MSI_ADDR_BASE, MSI_ADDR_SIZE,
                                      apic_io_memory);
     }
     s->timer = qemu_new_timer(vm_clock, apic_timer, s);
@@ -929,4 +972,3 @@ int apic_init(CPUState *env)
     local_apics[s->id] = s;
     return 0;
 }
-
-- 
1.6.3.1.56.g79e1.dirty
