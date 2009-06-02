From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 06/13] qemu: add flag to disable MSI-X by default
Date: Tue, 2 Jun 2009 18:02:37 +0300
Message-ID: <20090602150237.GG6554__38114.7443470128$1243955973$gmane$org@redhat.com>
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

Add global flag to disable MSI-X by default.  This is useful primarily
to make images loadable by older qemu (without msix).  Even when MSI-X
is disabled by flag, you can still load images that have MSI-X enabled.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/msix.c       |    3 +++
 qemu-options.hx |    2 ++
 vl.c            |    3 +++
 3 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/hw/msix.c b/hw/msix.c
index 4db2fc1..970a8ca 100644
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
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 87af798..fd041a4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -1575,3 +1575,5 @@ DEF("semihosting", 0, QEMU_OPTION_semihosting,
 DEF("old-param", 0, QEMU_OPTION_old_param,
     "-old-param      old param mode\n")
 #endif
+DEF("disable-msix", 0, QEMU_OPTION_disable_msix,
+    "-disable-msix disable msix support for PCI devices (enabled by default)\n")
diff --git a/vl.c b/vl.c
index 2c1f0e0..2757d4f 100644
--- a/vl.c
+++ b/vl.c
@@ -134,6 +134,7 @@ int main(int argc, char **argv)
 #include "hw/usb.h"
 #include "hw/pcmcia.h"
 #include "hw/pc.h"
+#include "hw/msix.h"
 #include "hw/audiodev.h"
 #include "hw/isa.h"
 #include "hw/baum.h"
@@ -5557,6 +5558,8 @@ int main(int argc, char **argv, char **envp)
                 xen_mode = XEN_ATTACH;
                 break;
 #endif
+            case QEMU_OPTION_disable_msix:
+                msix_disable = 1;
             }
         }
     }
-- 
1.6.3.1.56.g79e1.dirty
