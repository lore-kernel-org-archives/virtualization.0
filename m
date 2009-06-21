From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCHv2 RFC] qemu/msix: remove msix_supported safety flag
Date: Sun, 21 Jun 2009 20:04:22 +0300
Message-ID: <20090621170422.GA10263__31926.9069158056$1245604694$gmane$org@redhat.com>
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
To: Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>, qemu-devel@nongnu.org, Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Rusty Russell <rusty@rustcor>
List-Id: virtualization@lists.linuxfoundation.org

Don't add an option for platforms to disable MSI-X in all devices.
Paul Brook will find and fix all platforms that have broken MSI-X
emulation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

This patch on top of my msix series v6 is a bit tongue in cheek: it
shows what can be done and Paul seems to think it's a good idea. So even
though I don't necessarily agree, I'll let others decide on it.

Changes since v1:
  rebased on top of MSIXv6.

 hw/apic.c |    1 -
 hw/msix.c |    7 -------
 hw/msix.h |    2 --
 3 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/hw/apic.c b/hw/apic.c
index 3bcab46..2ac87d1 100644
--- a/hw/apic.c
+++ b/hw/apic.c
@@ -965,7 +965,6 @@ int apic_init(CPUState *env)
     s->cpu_env = env;
 
     apic_reset(s);
-    msix_supported = 1;
 
     /* XXX: mapping more APICs at the same memory location */
     if (apic_io_memory == 0) {
diff --git a/hw/msix.c b/hw/msix.c
index 773581f..6eb51c3 100644
--- a/hw/msix.c
+++ b/hw/msix.c
@@ -59,9 +59,6 @@
 #define DEBUG(fmt, ...) do { } while(0)
 #endif
 
-/* Flag for interrupt controller to declare MSI-X support */
-int msix_supported;
-
 /* Add MSI-X capability to the config space for the device. */
 /* Given a bar and its size, add MSI-X table on top of it
  * and fill MSI-X capability in the config space.
@@ -227,10 +224,6 @@ int msix_init(struct PCIDevice *dev, unsigned short nentries,
               unsigned bar_nr, unsigned bar_size)
 {
     int ret;
-    /* Nothing to do if MSI is not supported by interrupt controller */
-    if (!msix_supported)
-        return -ENOTSUP;
-
     if (nentries > MSIX_MAX_ENTRIES)
         return -EINVAL;
 
diff --git a/hw/msix.h b/hw/msix.h
index 3427778..27f2dad 100644
--- a/hw/msix.h
+++ b/hw/msix.h
@@ -29,6 +29,4 @@ void msix_notify(PCIDevice *dev, unsigned vector);
 
 void msix_reset(PCIDevice *dev);
 
-extern int msix_supported;
-
 #endif
-- 
1.6.2.2
