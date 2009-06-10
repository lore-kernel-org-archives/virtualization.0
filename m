From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 08/13] qemu: add support for resizing
	regions
Date: Wed, 10 Jun 2009 13:46:17 +0300
Message-ID: <20090610104617.GJ6844__32080.9550154538$1244630992$gmane$org@redhat.com>
References: <cover.1244192535.git.mst@redhat.com>
	<20090605102355.GI26770@redhat.com>
	<20090609173621.GC19375@poweredge.glommer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090609173621.GC19375@poweredge.glommer>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber Costa <glommer@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jun 09, 2009 at 02:36:21PM -0300, Glauber Costa wrote:
> On Fri, Jun 05, 2009 at 01:23:55PM +0300, Michael S. Tsirkin wrote:
> > Make it possible to resize PCI regions.  This will be used by virtio
> > with MSI-X, where the region size depends on whether MSI-X is enabled,
> > and can change across load/save.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/pci.c |   54 ++++++++++++++++++++++++++++++++++++------------------
> >  hw/pci.h |    3 +++
> >  2 files changed, 39 insertions(+), 18 deletions(-)
> > 
> > diff --git a/hw/pci.c b/hw/pci.c
> > index ed011b5..042a216 100644
> > --- a/hw/pci.c
> > +++ b/hw/pci.c
> > @@ -392,6 +392,41 @@ void pci_register_io_region(PCIDevice *pci_dev, int region_num,
> >      *(uint32_t *)(pci_dev->wmask + addr) = cpu_to_le32(wmask);
> >  }
> >  
> > +static void pci_unmap_region(PCIDevice *d, PCIIORegion *r)
> > +{
> > +    if (r->addr == -1)
> > +        return;
> > +    if (r->type & PCI_ADDRESS_SPACE_IO) {
> > +        int class;
> > +        /* NOTE: specific hack for IDE in PC case:
> > +           only one byte must be mapped. */
> > +        class = pci_get_word(d->config + PCI_CLASS_DEVICE);
> > +        if (class == 0x0101 && r->size == 4) {
> > +            isa_unassign_ioport(r->addr + 2, 1);
> > +        } else {
> > +            isa_unassign_ioport(r->addr, r->size);
> > +        }
> > +    } else {
> > +        cpu_register_physical_memory(pci_to_cpu_addr(r->addr),
> > +                                     r->size,
> > +                                     IO_MEM_UNASSIGNED);
> > +        qemu_unregister_coalesced_mmio(r->addr, r->size);
> > +    }
> > +}
> > +
> this is a good cleanup...
> 
> > +void pci_resize_io_region(PCIDevice *pci_dev, int region_num,
> > +                          uint32_t size)
> > +{
> > +
> > +    PCIIORegion *r = &pci_dev->io_regions[region_num];
> > +    if (r->size == size)
> > +        return;
> > +    r->size = size;
> > +    pci_unmap_region(pci_dev, r);
> > +    r->addr = -1;
> > +    pci_update_mappings(pci_dev);
> > +}
> > +
> but the only user of this one seem to be commented out, and later removed.
> Why is this needed?
> 

This was the missing bit:

Set correct size for msi-x memory region when loading the device.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

diff --git a/hw/virtio-pci.c b/hw/virtio-pci.c
index 589fbb1..f657364 100644
--- a/hw/virtio-pci.c
+++ b/hw/virtio-pci.c
@@ -133,6 +133,8 @@ static int virtio_pci_load_config(void * opaque, QEMUFile *f)
         return ret;
     if (msix_present(&proxy->pci_dev))
         qemu_get_be16s(f, &proxy->vdev->config_vector);
+
+    pci_resize_io_region(&proxy->pci_dev, 1, msix_bar_size(&proxy->pci_dev));
     return 0;
 }
 

-- 
MST
