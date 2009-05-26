From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] qemu: add routines to manage PCI
	capabilities
Date: Tue, 26 May 2009 12:22:06 +0300
Message-ID: <20090526092206.GB8588__31191.3118385293$1243329966$gmane$org@redhat.com>
References: <cover.1243253205.git.mst@redhat.com>
	<20090525122520.GD5046@redhat.com>
	<20090526084926.GI13076%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090526084926.GI13076%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, May 26, 2009 at 05:49:26PM +0900, Isaku Yamahata wrote:
> On Mon, May 25, 2009 at 03:25:20PM +0300, Michael S. Tsirkin wrote:
> > Add routines to manage PCI capability list. First user will be MSI-X.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/pci.c |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
> >  hw/pci.h |   18 +++++++++++-
> >  2 files changed, 106 insertions(+), 10 deletions(-)
> > 
> > diff --git a/hw/pci.c b/hw/pci.c
> > index 5dcfb4e..6bc3819 100644
> > --- a/hw/pci.c
> > +++ b/hw/pci.c
> > @@ -130,12 +130,13 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> >      int version = s->cap_present ? 3 : 2;
> >      int i;
> >  
> > -    qemu_put_be32(f, version); /* PCI device version */
> > +    /* PCI device version and capabilities */
> > +    qemu_put_be32(f, version);
> > +    if (version >= 3)
> > +        qemu_put_be32(f, s->cap_present);
> >      qemu_put_buffer(f, s->config, 256);
> >      for (i = 0; i < 4; i++)
> >          qemu_put_be32(f, s->irq_state[i]);
> > -    if (version >= 3)
> > -        qemu_put_be32(f, s->cap_present);
> >  }
> >  
> >  int pci_device_load(PCIDevice *s, QEMUFile *f)
> > @@ -146,12 +147,6 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
> >      version_id = qemu_get_be32(f);
> >      if (version_id > 3)
> >          return -EINVAL;
> > -    qemu_get_buffer(f, s->config, 256);
> > -    pci_update_mappings(s);
> > -
> > -    if (version_id >= 2)
> > -        for (i = 0; i < 4; i ++)
> > -            s->irq_state[i] = qemu_get_be32(f);
> >      if (version_id >= 3)
> >          s->cap_present = qemu_get_be32(f);
> >      else
> > @@ -160,6 +155,18 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
> >      if (s->cap_present & ~s->cap_supported)
> >          return -EINVAL;
> >  
> > +    qemu_get_buffer(f, s->config, 256);
> > +    pci_update_mappings(s);
> > +
> > +    if (version_id >= 2)
> > +        for (i = 0; i < 4; i ++)
> > +            s->irq_state[i] = qemu_get_be32(f);
> > +    /* Clear mask and used bits for capabilities.
> > +       Must be restored separately, since capabilities can
> > +       be placed anywhere in config space. */
> > +    memset(s->used, 0, PCI_CONFIG_SPACE_SIZE);
> > +    for (i = PCI_CONFIG_HEADER_SIZE; i < PCI_CONFIG_SPACE_SIZE; ++i)
> > +        s->mask[i] = 0xff;
> >      return 0;
> >  }
> >  
> > @@ -870,3 +877,76 @@ PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
> >  
> >      return (PCIDevice *)dev;
> >  }
> > +
> > +static int pci_find_space(PCIDevice *pdev, uint8_t size)
> > +{
> > +    int offset = PCI_CONFIG_HEADER_SIZE;
> > +    int i;
> > +    for (i = PCI_CONFIG_HEADER_SIZE; i < PCI_CONFIG_SPACE_SIZE; ++i)
> > +        if (pdev->used[i])
> > +            offset = i + 1;
> > +        else if (i - offset + 1 == size)
> > +            return offset;
> > +    return 0;
> > +}
> > +
> > +static uint8_t pci_find_capability_list(PCIDevice *pdev, uint8_t cap_id,
> > +                                        uint8_t *prev_p)
> > +{
> > +    uint8_t next, prev;
> > +
> > +    if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST))
> > +        return 0;
> > +
> > +    for (prev = PCI_CAPABILITY_LIST; (next = pdev->config[prev]);
> > +         prev = next + PCI_CAP_LIST_NEXT)
> > +        if (pdev->config[next + PCI_CAP_LIST_ID] != cap_id)
> 
> typo? ==


Fixed. Thanks.

> > +            break;
> > +
> > +    *prev_p = prev;
> > +    return next;
> > +}
> > +
> > +/* Reserve space and add capability to the linked list in pci config space */
> > +int pci_add_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
> > +{
> > +    uint8_t offset = pci_find_space(pdev, size);
> > +    uint8_t *config = pdev->config + offset;
> > +    if (!offset)
> > +        return -ENOSPC;
> > +    config[PCI_CAP_LIST_ID] = cap_id;
> > +    config[PCI_CAP_LIST_NEXT] = pdev->config[PCI_CAPABILITY_LIST];
> > +    pdev->config[PCI_CAPABILITY_LIST] = offset;
> > +    pdev->config[PCI_STATUS] |= PCI_STATUS_CAP_LIST;
> > +    memset(pdev->used + offset, 0xFF, size);
> > +    /* Make capability read-only by default */
> > +    memset(pdev->mask + offset, 0, size);
> > +    return offset;
> > +}
> > +
> > +/* Unlink capability from the pci config space. */
> > +void pci_del_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
> > +{
> > +    uint8_t prev, offset = pci_find_capability_list(pdev, cap_id, &prev);
> > +    if (!offset)
> > +        return;
> > +    pdev->config[prev] = pdev->config[offset + PCI_CAP_LIST_NEXT];
> > +    /* Make capability writeable again */
> > +    memset(pdev->mask + offset, 0xff, size);
> > +    memset(pdev->used + offset, 0, size);
> > +
> > +    if (!pdev->config[PCI_CAPABILITY_LIST])
> > +        pdev->config[PCI_STATUS] &= ~PCI_STATUS_CAP_LIST;
> > +}
> > +
> > +/* Reserve space for capability at a known offset (to call after load). */
> > +void pci_reserve_capability(PCIDevice *pdev, uint8_t offset, uint8_t size)
> > +{
> > +    memset(pdev->used + offset, 0xff, size);
> > +}
> > +
> > +uint8_t pci_find_capability(PCIDevice *pdev, uint8_t cap_id)
> > +{
> > +    uint8_t prev;
> > +    return pci_find_capability_list(pdev, cap_id, &prev);
> > +}
> > diff --git a/hw/pci.h b/hw/pci.h
> > index 9139504..40137c6 100644
> > --- a/hw/pci.h
> > +++ b/hw/pci.h
> > @@ -123,6 +123,10 @@ typedef struct PCIIORegion {
> >  #define PCI_MIN_GNT		0x3e	/* 8 bits */
> >  #define PCI_MAX_LAT		0x3f	/* 8 bits */
> >  
> > +/* Capability lists */
> > +#define PCI_CAP_LIST_ID		0	/* Capability ID */
> > +#define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
> > +
> >  #define PCI_REVISION            0x08    /* obsolete, use PCI_REVISION_ID */
> >  #define PCI_SUBVENDOR_ID        0x2c    /* obsolete, use PCI_SUBSYSTEM_VENDOR_ID */
> >  #define PCI_SUBDEVICE_ID        0x2e    /* obsolete, use PCI_SUBSYSTEM_ID */
> > @@ -130,7 +134,7 @@ typedef struct PCIIORegion {
> >  /* Bits in the PCI Status Register (PCI 2.3 spec) */
> >  #define PCI_STATUS_RESERVED1	0x007
> >  #define PCI_STATUS_INT_STATUS	0x008
> > -#define PCI_STATUS_CAPABILITIES	0x010
> > +#define PCI_STATUS_CAP_LIST	0x010
> >  #define PCI_STATUS_66MHZ	0x020
> >  #define PCI_STATUS_RESERVED2	0x040
> >  #define PCI_STATUS_FAST_BACK	0x080
> > @@ -160,6 +164,9 @@ struct PCIDevice {
> >      /* Used to implement R/W bytes */
> >      uint8_t mask[PCI_CONFIG_SPACE_SIZE];
> >  
> > +    /* Used to allocate config space for capabilities. */
> > +    uint8_t used[PCI_CONFIG_SPACE_SIZE];
> > +
> 
> bitmap?

Could be a bitmap. But byte for byte is much easier to code for.
compare
	used[offset] = 1
with
	used[offset / 8] = (1 << (offset & 0x7));

> Or will be used for other purpose?

We could thinkably mark separate bits as used/unused.
It's not useful for capabilities which are always byte
aligned, but who knows ...

> >      /* the following fields are read only */
> >      PCIBus *bus;
> >      int devfn;
> > @@ -194,6 +201,15 @@ void pci_register_io_region(PCIDevice *pci_dev, int region_num,
> >                              uint32_t size, int type,
> >                              PCIMapIORegionFunc *map_func);
> >  
> > +int pci_add_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
> > +
> > +void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
> > +
> > +void pci_reserve_capability(PCIDevice *pci_dev, uint8_t offset, uint8_t size);
> > +
> > +uint8_t pci_find_capability(PCIDevice *pci_dev, uint8_t cap_id);
> > +
> > +
> >  uint32_t pci_default_read_config(PCIDevice *d,
> >                                   uint32_t address, int len);
> >  void pci_default_write_config(PCIDevice *d,
> 
> -- 
> yamahata
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
MST
