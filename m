From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv3 02/13] qemu: capability bits in pci save/restore
Date: Fri, 5 Jun 2009 13:23:07 +0300
Message-ID: <20090605102307.GC26770__9895.29146249897$1244197631$gmane$org@redhat.com>
References: <cover.1244192535.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1244192535.git.mst@redhat.com>
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

Add support for capability bits in save/restore for pci.
These will be used for MSI, where the capability might
be present or not as requested by user, which does not
map well into a single version number.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci.c |   14 ++++++++++++--
 hw/pci.h |    4 ++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/pci.c b/hw/pci.c
index 235191d..361d741 100644
--- a/hw/pci.c
+++ b/hw/pci.c
@@ -127,12 +127,15 @@ int pci_bus_num(PCIBus *s)
 
 void pci_device_save(PCIDevice *s, QEMUFile *f)
 {
+    int version = s->cap_present ? 3 : 2;
     int i;
 
-    qemu_put_be32(f, 2); /* PCI device version */
+    qemu_put_be32(f, version); /* PCI device version */
     qemu_put_buffer(f, s->config, 256);
     for (i = 0; i < 4; i++)
         qemu_put_be32(f, s->irq_state[i]);
+    if (version >= 3)
+        qemu_put_be32(f, s->cap_present);
 }
 
 int pci_device_load(PCIDevice *s, QEMUFile *f)
@@ -141,7 +144,7 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
     int i;
 
     version_id = qemu_get_be32(f);
-    if (version_id > 2)
+    if (version_id > 3)
         return -EINVAL;
     qemu_get_buffer(f, s->config, 256);
     pci_update_mappings(s);
@@ -149,6 +152,13 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
     if (version_id >= 2)
         for (i = 0; i < 4; i ++)
             s->irq_state[i] = qemu_get_be32(f);
+    if (version_id >= 3)
+        s->cap_present = qemu_get_be32(f);
+    else
+        s->cap_present = 0;
+
+    if (s->cap_present & ~s->cap_supported)
+        return -EINVAL;
 
     return 0;
 }
diff --git a/hw/pci.h b/hw/pci.h
index d0db402..6f0803f 100644
--- a/hw/pci.h
+++ b/hw/pci.h
@@ -178,6 +178,10 @@ struct PCIDevice {
 
     /* Current IRQ levels.  Used internally by the generic PCI code.  */
     int irq_state[4];
+
+    /* Capability bits for save/load */
+    uint32_t cap_supported;
+    uint32_t cap_present;
 };
 
 PCIDevice *pci_register_device(PCIBus *bus, const char *name,
-- 
1.6.3.1.56.g79e1.dirty
