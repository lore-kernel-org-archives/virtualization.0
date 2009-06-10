From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/11] qemu: MSI-X support functions
Date: Wed, 10 Jun 2009 17:25:08 +0300
Message-ID: <20090610142508.GA28409__8069.57011013782$1244644139$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<200906100019.59981.paul@codesourcery.com>
	<20090610094604.GD6844@redhat.com>
	<200906101507.39823.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906101507.39823.paul@codesourcery.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paul Brook <paul@codesourcery.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jun 10, 2009 at 03:07:34PM +0100, Paul Brook wrote:
> > > > Note that platform must set a flag to declare MSI supported.
> > > > For PC this will be set by APIC.
> > >
> > > This sounds wrong. The device shouldn't know or care whether the system
> > > has a MSI capable interrupt controller. That's for the guest OS to figure
> > > out.
> >
> > You are right of course. In theory there's nothing that breaks if I
> > set this flag to on, on all platforms. OTOH if qemu emulates some
> > controller incorrectly, guest might misdetect MSI support in the
> > controller, and things will break horribly.
> >
> > It seems safer to have a flag that can be enabled by people
> > that know about a specific platform.
> 
> No. The solution is to fix whatever is broken.

That's easy enough then. Patch below.

> 
> If we really need to avoid MSI-X capable devices then that should be done 
> explicity per-device. i.e. you have a different virtio-net device that does 
> not use MSI-X.
> 
> Paul

Why should it be done per-device?

--->

Don't add an option for platforms to disable MSI-X in all devices.
Paul Brook will find and fix all platforms that have broken MSI-X
emulation.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/hw/apic.c b/hw/apic.c
index ed03a36..9d44061 100644
--- a/hw/apic.c
+++ b/hw/apic.c
@@ -945,7 +945,6 @@ int apic_init(CPUState *env)
     s->cpu_env = env;
 
     apic_reset(s);
-    msix_supported = 1;
 
     /* XXX: mapping more APICs at the same memory location */
     if (apic_io_memory == 0) {
diff --git a/hw/msix.c b/hw/msix.c
index ce4e6ba..16efb27 100644
--- a/hw/msix.c
+++ b/hw/msix.c
@@ -62,9 +62,6 @@
 /* Flag to globally disable MSI-X support */
 int msix_disable;
 
-/* Flag for interrupt controller to declare MSI-X support */
-int msix_supported;
-
 /* Add MSI-X capability to the config space for the device. */
 /* Given a bar and its size, add MSI-X table on top of it
  * and fill MSI-X capability in the config space.
@@ -232,10 +229,7 @@ void msix_mmio_map(PCIDevice *d, int region_num,
 int msix_init(struct PCIDevice *dev, unsigned short nentries,
               unsigned bar_nr, unsigned bar_size)
 {
-    int ret = -ENOMEM;
-    /* Nothing to do if MSI is not supported by interrupt controller */
-    if (!msix_supported)
-        return -ENOTTY;
+    int ret;
 
     if (nentries > MSIX_MAX_ENTRIES)
         return -EINVAL;
diff --git a/hw/msix.h b/hw/msix.h
index 79e84a3..2fcadd3 100644
--- a/hw/msix.h
+++ b/hw/msix.h
@@ -30,6 +30,5 @@ void msix_notify(PCIDevice *dev, unsigned vector);
 void msix_reset(PCIDevice *dev);
 
 extern int msix_disable;
-extern int msix_supported;
 
 #endif
-- 
MST
