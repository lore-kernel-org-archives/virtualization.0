From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv5 06/13] qemu: add flag to disable MSI-X by default
Date: Thu, 18 Jun 2009 16:14:09 +0300
Message-ID: <20090618131409.GG19092__3923.50876140899$1245331916$gmane$org@redhat.com>
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

Add global flag to disable MSI-X by default.  This is useful primarily
to make images loadable by older qemu (without msix).  Even when MSI-X
is disabled by flag, you can still load images that have MSI-X enabled.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/msix.c       |    5 ++++-
 qemu-options.hx |    2 ++
 vl.c            |    3 +++
 3 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/hw/msix.c b/hw/msix.c
index a448eab..cc62a83 100644
--- a/hw/msix.c
+++ b/hw/msix.c
@@ -122,6 +122,9 @@ void msix_write_config(PCIDevice *dev, uint32_t addr,
                        uint32_t val, int len)
 {
     unsigned enable_pos = dev->msix_cap + MSIX_ENABLE_OFFSET;
+    if (!(dev->cap_present & QEMU_PCI_CAP_MSIX))
+        return;
+
     if (addr + len <= enable_pos || addr > enable_pos)
         return;
 
@@ -242,7 +245,7 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
 
     dev->msix_table_page = qemu_mallocz(MSIX_PAGE_SIZE);
 
-    dev->msix_mmio_index = cpu_register_io_memory(0, msix_mmio_read,
+    dev->msix_mmio_index = cpu_register_io_memory(msix_mmio_read,
                                                   msix_mmio_write, dev);
     if (dev->msix_mmio_index == -1) {
         ret = -EBUSY;
diff --git a/qemu-options.hx b/qemu-options.hx
index 9d5e05a..aa02615 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1584,3 +1584,5 @@ DEF("semihosting", 0, QEMU_OPTION_semihosting,
 DEF("old-param", 0, QEMU_OPTION_old_param,
     "-old-param      old param mode\n")
 #endif
+DEF("disable-msix", 0, QEMU_OPTION_disable_msix,
+    "-disable-msix disable msix support for PCI devices (enabled by default)\n")
diff --git a/vl.c b/vl.c
index 3242c23..f7c67bb 100644
--- a/vl.c
+++ b/vl.c
@@ -135,6 +135,7 @@ int main(int argc, char **argv)
 #include "hw/usb.h"
 #include "hw/pcmcia.h"
 #include "hw/pc.h"
+#include "hw/msix.h"
 #include "hw/audiodev.h"
 #include "hw/isa.h"
 #include "hw/baum.h"
@@ -5699,6 +5700,8 @@ int main(int argc, char **argv, char **envp)
                 xen_mode = XEN_ATTACH;
                 break;
 #endif
+            case QEMU_OPTION_disable_msix:
+                msix_disable = 1;
             }
         }
     }
-- 
1.6.2.2
