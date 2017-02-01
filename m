From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] virtio: Try to untangle DMA coherency
Date: Wed, 1 Feb 2017 18:27:09 +0000
Message-ID: <20170201182659.GM8177@arm.com>
References: <8a6494f6409c20b4609cd6bdcdd751f68b5c0564.1485951731.git.robin.murphy@arm.com>
	<20170201195732-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20170201195732-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com, virtualization@lists.linux-foundation.org, robh+dt@kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Feb 01, 2017 at 08:09:21PM +0200, Michael S. Tsirkin wrote:
> On Wed, Feb 01, 2017 at 12:25:57PM +0000, Robin Murphy wrote:
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 7e38ed79c3fc..961af25b385c 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/virtio_ring.h>
> >  #include <linux/virtio_config.h>
> >  #include <linux/device.h>
> > +#include <linux/property.h>
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> >  #include <linux/hrtimer.h>
> > @@ -160,10 +161,14 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
> >  		return true;
> >  
> >  	/*
> > -	 * On ARM-based machines, the DMA ops will do the right thing,
> > -	 * so always use them with legacy devices.
> > +	 * On ARM-based machines, the coherent DMA ops will do the right
> > +	 * thing, so always use them with legacy devices. However, using
> > +	 * non-coherent DMA when the host *is* actually coherent, but has
> > +	 * forgotten to tell us, is going to break badly; since this situation
> > +	 * already exists in the wild, maintain the old behaviour there.
> >  	 */
> > -	if (IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
> > +	if ((IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64)) &&
> > +	    device_get_dma_attr(&vdev->dev) == DEV_DMA_COHERENT)
> >  		return !virtio_has_feature(vdev, VIRTIO_F_VERSION_1);
> >  
> >  	return false;
> 
> This is exactly what I feared.

Yes, sorry about this. It works fine for virtio-pci (where "dma-coherent"
is used) and it also works on the fastmodel if you disable cache-modelling
(which is needed to make the thing run at a usable pace) so we didn't spot
this in testing.

> Could we identify fastboot and do the special dance just for it?

[assuming you mean fastmodel instead of fastboot]

> I'd like to do that instead. It's fastboot doing the unreasonable thing
> here and deviating from what every other legacy device without exception
> did for years. If this means fastboot will need to update to virtio 1,
> all the better.

The problem still exists with virtio 1, unless we require that the
"dma-coherent" property is set/unset correctly when VIRTIO_F_IOMMU_PLATFORM
is advertised by the device (which is what I suggested in my reply).

We can't detect the fastmodel, but we could implicitly treat virtio-mmio
devices as cache-coherent regardless of the "dma-coherent" flag. I already
prototyped this, but I suspect the devicetree people will push back (and
there's a similar patch needed for ACPI).

See below. Do you prefer this approach?

Will

--->8

From f6ad4e331c26e7ba53132c8cc74e26f782391570 Mon Sep 17 00:00:00 2001
From: Will Deacon <will.deacon@arm.com>
Date: Mon, 30 Jan 2017 17:28:31 +0000
Subject: [PATCH] of/address: Allow devices to report DMA coherency based on
 compatible string

Some devices (e.g. virtio-mmio) are implicitly cache coherent with respect
to DMA operations and therefore do not mandate the use of "dma-coherent"
in their devicetree bindings. In order to ensure that these devices work
correctly when using the DMA API, we need to treat them specially in
of_dma_is_coherent by identifying them as unconditionally coherent.

This patch adds a static, table-based search against the compatible
string for the device in of_dma_is_coherent before walking the
hierarchy looking for "dma-coherent". This allows existing virtio-mmio
devices (e.g. those emulated by QEMU) to function correctly when placed
behind an IOMMU that requires use of the DMA ops to map the vring.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 drivers/of/address.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 02b2903fe9d2..af29b115b8aa 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -891,19 +891,47 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 }
 EXPORT_SYMBOL_GPL(of_dma_get_range);
 
+/*
+ * DMA from some device types is always cache-coherent, and in some unfortunate
+ * cases the "dma-coherent" property is not used.
+ */
+static const char *of_device_dma_coherent_tbl[] = {
+	/*
+	 * Virtio MMIO devices are assumed to be cache-coherent when accessing
+	 * main memory. Neither QEMU nor kvmtool emit "dma-coherent" properties
+	 * for their generated virtio MMIO device nodes, and the binding
+	 * documentation doesn't mention them either. When using the DMA API
+	 * (e.g. because there is an IOMMU in the system), we must report true
+	 * here to avoid lockups where writes to the vring via a non-coherent
+	 * mapping are not made visible to the device emulation.
+	 */
+	"virtio,mmio",
+	NULL,
+};
+
 /**
  * of_dma_is_coherent - Check if device is coherent
  * @np:	device node
  *
  * It returns true if "dma-coherent" property was found
- * for this device in DT.
+ * for this device in DT or the device is statically known to be
+ * coherent.
  */
 bool of_dma_is_coherent(struct device_node *np)
 {
 	struct device_node *node = of_node_get(np);
 
+	/*
+	 * Check for implicit DMA coherence first, since we don't want
+	 * to inherit this.
+	 */
+	if (of_device_compatible_match(np, of_device_dma_coherent_tbl)) {
+		of_node_put(node);
+		return true;
+	}
+
 	while (node) {
-		if (of_property_read_bool(node, "dma-coherent")) {
+		if (of_property_read_bool(node, "dma-coherent")){
 			of_node_put(node);
 			return true;
 		}
-- 
2.1.4
