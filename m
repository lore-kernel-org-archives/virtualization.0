From: Glauber Costa <glommer@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 03/13] qemu: add routines to manage PCI
	capabilities
Date: Tue, 9 Jun 2009 14:11:14 -0300
Message-ID: <20090609171114.GS11966__41530.6768416942$1244586413$gmane$org@poweredge.glommer>
References: <cover.1244192535.git.mst@redhat.com>
	<20090605102315.GD26770@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090605102315.GD26770@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jun 05, 2009 at 01:23:15PM +0300, Michael S. Tsirkin wrote:
> Add routines to manage PCI capability list. First user will be MSI-X.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/pci.c |   98 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
>  hw/pci.h |   18 +++++++++++-
>  2 files changed, 106 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/pci.c b/hw/pci.c
> index 361d741..ed011b5 100644
> --- a/hw/pci.c
> +++ b/hw/pci.c
> @@ -130,12 +130,13 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
>      int version = s->cap_present ? 3 : 2;
>      int i;
>  
> -    qemu_put_be32(f, version); /* PCI device version */
> +    /* PCI device version and capabilities */
> +    qemu_put_be32(f, version);
> +    if (version >= 3)
> +        qemu_put_be32(f, s->cap_present);
>      qemu_put_buffer(f, s->config, 256);
>      for (i = 0; i < 4; i++)
>          qemu_put_be32(f, s->irq_state[i]);
> -    if (version >= 3)
> -        qemu_put_be32(f, s->cap_present);
>  }
What is it doing here?
You should just do it right in the first patch, instead of doing in
one way there, and fixing here.

>  
>  int pci_device_load(PCIDevice *s, QEMUFile *f)
> @@ -146,12 +147,6 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
>      version_id = qemu_get_be32(f);
>      if (version_id > 3)
>          return -EINVAL;
> -    qemu_get_buffer(f, s->config, 256);
> -    pci_update_mappings(s);
> -
> -    if (version_id >= 2)
> -        for (i = 0; i < 4; i ++)
> -            s->irq_state[i] = qemu_get_be32(f);
>      if (version_id >= 3)
>          s->cap_present = qemu_get_be32(f);
>      else
ditto.

> @@ -160,6 +155,18 @@ int pci_device_load(PCIDevice *s, QEMUFile *f)
>      if (s->cap_present & ~s->cap_supported)
>          return -EINVAL;
>  
> +    qemu_get_buffer(f, s->config, 256);
> +    pci_update_mappings(s);
> +
> +    if (version_id >= 2)
> +        for (i = 0; i < 4; i ++)
> +            s->irq_state[i] = qemu_get_be32(f);
> +    /* Clear wmask and used bits for capabilities.
> +       Must be restored separately, since capabilities can
> +       be placed anywhere in config space. */
> +    memset(s->used, 0, PCI_CONFIG_SPACE_SIZE);
> +    for (i = PCI_CONFIG_HEADER_SIZE; i < PCI_CONFIG_SPACE_SIZE; ++i)
> +        s->wmask[i] = 0xff;
>      return 0;
>  }
Sorry, I don't exactly understand it. Although it can be anywhere, what do we actually
lose by keeping it at the same place in config space?

>  
> @@ -870,3 +877,76 @@ PCIDevice *pci_create_simple(PCIBus *bus, int devfn, const char *name)
>  
>      return (PCIDevice *)dev;
>  }
> +
> +static int pci_find_space(PCIDevice *pdev, uint8_t size)
> +{
> +    int offset = PCI_CONFIG_HEADER_SIZE;
> +    int i;
> +    for (i = PCI_CONFIG_HEADER_SIZE; i < PCI_CONFIG_SPACE_SIZE; ++i)
> +        if (pdev->used[i])
> +            offset = i + 1;
> +        else if (i - offset + 1 == size)
> +            return offset;
> +    return 0;
> +}
> +
> +static uint8_t pci_find_capability_list(PCIDevice *pdev, uint8_t cap_id,
> +                                        uint8_t *prev_p)
> +{
> +    uint8_t next, prev;
> +
> +    if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST))
> +        return 0;
> +
> +    for (prev = PCI_CAPABILITY_LIST; (next = pdev->config[prev]);
> +         prev = next + PCI_CAP_LIST_NEXT)
> +        if (pdev->config[next + PCI_CAP_LIST_ID] == cap_id)
> +            break;
> +
> +    *prev_p = prev;
> +    return next;
> +}
I'd prefer to do:
	if (prev_p)
		*prev_p = prev;
so we don't have to always pass a prev_p pointer. You have yourself a user
where you don't need it in this very patch.

> +
> +/* Reserve space and add capability to the linked list in pci config space */
> +int pci_add_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
> +{
> +    uint8_t offset = pci_find_space(pdev, size);
> +    uint8_t *config = pdev->config + offset;
> +    if (!offset)
> +        return -ENOSPC;
> +    config[PCI_CAP_LIST_ID] = cap_id;
> +    config[PCI_CAP_LIST_NEXT] = pdev->config[PCI_CAPABILITY_LIST];
> +    pdev->config[PCI_CAPABILITY_LIST] = offset;
> +    pdev->config[PCI_STATUS] |= PCI_STATUS_CAP_LIST;
> +    memset(pdev->used + offset, 0xFF, size);
> +    /* Make capability read-only by default */
> +    memset(pdev->wmask + offset, 0, size);
> +    return offset;
> +}
> +
> +/* Unlink capability from the pci config space. */
> +void pci_del_capability(PCIDevice *pdev, uint8_t cap_id, uint8_t size)
> +{
> +    uint8_t prev, offset = pci_find_capability_list(pdev, cap_id, &prev);
> +    if (!offset)
> +        return;
> +    pdev->config[prev] = pdev->config[offset + PCI_CAP_LIST_NEXT];
> +    /* Make capability writeable again */
> +    memset(pdev->wmask + offset, 0xff, size);
> +    memset(pdev->used + offset, 0, size);
> +
> +    if (!pdev->config[PCI_CAPABILITY_LIST])
> +        pdev->config[PCI_STATUS] &= ~PCI_STATUS_CAP_LIST;
> +}
> +
> +/* Reserve space for capability at a known offset (to call after load). */
> +void pci_reserve_capability(PCIDevice *pdev, uint8_t offset, uint8_t size)
> +{
> +    memset(pdev->used + offset, 0xff, size);
> +}
> +
> +uint8_t pci_find_capability(PCIDevice *pdev, uint8_t cap_id)
> +{
> +    uint8_t prev;
> +    return pci_find_capability_list(pdev, cap_id, &prev);
> +}
> diff --git a/hw/pci.h b/hw/pci.h
> index 6f0803f..4838c59 100644
> --- a/hw/pci.h
> +++ b/hw/pci.h
> @@ -123,6 +123,10 @@ typedef struct PCIIORegion {
>  #define PCI_MIN_GNT		0x3e	/* 8 bits */
>  #define PCI_MAX_LAT		0x3f	/* 8 bits */
>  
> +/* Capability lists */
> +#define PCI_CAP_LIST_ID		0	/* Capability ID */
> +#define PCI_CAP_LIST_NEXT	1	/* Next capability in the list */
> +
>  #define PCI_REVISION            0x08    /* obsolete, use PCI_REVISION_ID */
>  #define PCI_SUBVENDOR_ID        0x2c    /* obsolete, use PCI_SUBSYSTEM_VENDOR_ID */
>  #define PCI_SUBDEVICE_ID        0x2e    /* obsolete, use PCI_SUBSYSTEM_ID */
> @@ -130,7 +134,7 @@ typedef struct PCIIORegion {
>  /* Bits in the PCI Status Register (PCI 2.3 spec) */
>  #define PCI_STATUS_RESERVED1	0x007
>  #define PCI_STATUS_INT_STATUS	0x008
> -#define PCI_STATUS_CAPABILITIES	0x010
> +#define PCI_STATUS_CAP_LIST	0x010
>  #define PCI_STATUS_66MHZ	0x020
>  #define PCI_STATUS_RESERVED2	0x040
>  #define PCI_STATUS_FAST_BACK	0x080
> @@ -160,6 +164,9 @@ struct PCIDevice {
>      /* Used to implement R/W bytes */
>      uint8_t wmask[PCI_CONFIG_SPACE_SIZE];
>  
> +    /* Used to allocate config space for capabilities. */
> +    uint8_t used[PCI_CONFIG_SPACE_SIZE];
> +
>      /* the following fields are read only */
>      PCIBus *bus;
>      int devfn;
> @@ -194,6 +201,15 @@ void pci_register_io_region(PCIDevice *pci_dev, int region_num,
>                              uint32_t size, int type,
>                              PCIMapIORegionFunc *map_func);
>  
> +int pci_add_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
> +
> +void pci_del_capability(PCIDevice *pci_dev, uint8_t cap_id, uint8_t cap_size);
> +
> +void pci_reserve_capability(PCIDevice *pci_dev, uint8_t offset, uint8_t size);
> +
> +uint8_t pci_find_capability(PCIDevice *pci_dev, uint8_t cap_id);
> +
> +
>  uint32_t pci_default_read_config(PCIDevice *d,
>                                   uint32_t address, int len);
>  void pci_default_write_config(PCIDevice *d,
> -- 
> 1.6.3.1.56.g79e1.dirty
> 
> 
> 
