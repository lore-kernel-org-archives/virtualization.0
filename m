From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 05/13] qemu: MSI-X support functions
Date: Wed, 10 Jun 2009 12:58:35 +0300
Message-ID: <20090610095835.GF6844__45693.087767768$1244628213$gmane$org@redhat.com>
References: <cover.1244192535.git.mst@redhat.com>
	<20090605102331.GF26770@redhat.com>
	<20090609172627.GA19375@poweredge.glommer>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090609172627.GA19375@poweredge.glommer>
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

On Tue, Jun 09, 2009 at 02:26:27PM -0300, Glauber Costa wrote:
> On Fri, Jun 05, 2009 at 01:23:31PM +0300, Michael S. Tsirkin wrote:
> > Add functions implementing MSI-X support. First user will be virtio-pci.
> > Note that platform must set a flag to declare MSI supported.
> > For PC this will be set by APIC.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  Makefile.target |    2 +-
> >  hw/msix.c       |  423 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  hw/msix.h       |   35 +++++
> >  hw/pci.h        |   20 +++
> >  4 files changed, 479 insertions(+), 1 deletions(-)
> >  create mode 100644 hw/msix.c
> >  create mode 100644 hw/msix.h
> > 
> > diff --git a/Makefile.target b/Makefile.target
> > index 664a1e3..87b2859 100644
> > --- a/Makefile.target
> > +++ b/Makefile.target
> > @@ -486,7 +486,7 @@ endif #CONFIG_BSD_USER
> >  ifndef CONFIG_USER_ONLY
> >  
> >  OBJS=vl.o osdep.o monitor.o pci.o loader.o isa_mmio.o machine.o \
> > -     gdbstub.o gdbstub-xml.o
> > +     gdbstub.o gdbstub-xml.o msix.o
> >  # virtio has to be here due to weird dependency between PCI and virtio-net.
> >  # need to fix this properly
> >  OBJS+=virtio-blk.o virtio-balloon.o virtio-net.o virtio-console.o
> > diff --git a/hw/msix.c b/hw/msix.c
> > new file mode 100644
> > index 0000000..1b5aec8
> > --- /dev/null
> > +++ b/hw/msix.c
> > @@ -0,0 +1,423 @@
> > +/*
> > + * MSI-X device support
> > + *
> > + * This module includes support for MSI-X in pci devices.
> > + *
> > + * Author: Michael S. Tsirkin <mst@redhat.com>
> > + *
> > + *  Copyright (c) 2009, Red Hat Inc, Michael S. Tsirkin (mst@redhat.com)
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2.  See
> > + * the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "hw.h"
> > +#include "msix.h"
> > +#include "pci.h"
> > +
> > +/* Declaration from linux/pci_regs.h */
> > +#define  PCI_CAP_ID_MSIX 0x11 /* MSI-X */
> > +#define  PCI_MSIX_FLAGS 2     /* Table at lower 11 bits */
> > +#define  PCI_MSIX_FLAGS_QSIZE	0x7FF
> > +#define  PCI_MSIX_FLAGS_ENABLE	(1 << 15)
> > +#define  PCI_MSIX_FLAGS_BIRMASK	(7 << 0)
> > +
> > +/* MSI-X capability structure */
> > +#define MSIX_TABLE_OFFSET 4
> > +#define MSIX_PBA_OFFSET 8
> > +#define MSIX_CAP_LENGTH 12
> > +
> > +/* MSI enable bit is in byte 1 in FLAGS register */
> > +#define MSIX_ENABLE_OFFSET (PCI_MSIX_FLAGS + 1)
> > +#define MSIX_ENABLE_MASK (PCI_MSIX_FLAGS_ENABLE >> 8)
> > +
> > +/* MSI-X table format */
> > +#define MSIX_MSG_ADDR 0
> > +#define MSIX_MSG_UPPER_ADDR 4
> > +#define MSIX_MSG_DATA 8
> > +#define MSIX_VECTOR_CTRL 12
> > +#define MSIX_ENTRY_SIZE 16
> > +#define MSIX_VECTOR_MASK 0x1
> > +
> > +/* How much space does an MSIX table need. */
> > +/* The spec requires giving the table structure
> > + * a 4K aligned region all by itself. Align it to
> > + * target pages so that drivers can do passthrough
> > + * on the rest of the region. */
> > +#define MSIX_PAGE_SIZE TARGET_PAGE_ALIGN(0x1000)
> > +/* Reserve second half of the page for pending bits */
> > +#define MSIX_PAGE_PENDING (MSIX_PAGE_SIZE / 2)
> > +#define MSIX_MAX_ENTRIES 32
> > +
> > +
> > +#ifdef MSIX_DEBUG
> > +#define DEBUG(fmt, ...)                                       \
> > +    do {                                                      \
> > +      fprintf(stderr, "%s: " fmt, __func__ , __VA_ARGS__);    \
> > +    } while (0)
> > +#else
> > +#define DEBUG(fmt, ...) do { } while(0)
> > +#endif
> > +
> > +/* Flag to globally disable MSI-X support */
> > +int msix_disable;
> > +
> > +/* Flag for interrupt controller to declare MSI-X support */
> > +int msix_supported;
> maybe better to make it static,

It's not read-only either.

> and provide msi_state() returning -1 for disabled,
> 0 for supported, etc... 

Matter of taste, I prefer a set of binary flags rather than yet another enum:
msix_disable is controlled by user, msix_supported is a safety valve
for non-PC platforms. It's easier to keep them separate IMO.

> > +
> > +/* Add MSI-X capability to the config space for the device. */
> > +/* Given a bar and its size, add MSI-X table on top of it
> > + * and fill MSI-X capability in the config space.
> > + * Original bar size must be a power of 2 or 0.
> > + * New bar size is returned. */
> > +static int msix_add_config(struct PCIDevice *pdev, unsigned short nentries,
> > +                           unsigned bar_nr, unsigned bar_size)
> > +{
> > +    int config_offset;
> > +    uint8_t *config;
> > +    uint32_t new_size;
> > +
> > +    if (nentries < 1 || nentries > PCI_MSIX_FLAGS_QSIZE + 1)
> > +        return -EINVAL;
> > +    if (bar_size > 0x80000000)
> > +        return -ENOSPC;
> > +
> > +    /* Add space for MSI-X structures */
> > +    if (!bar_size)
> > +        new_size = MSIX_PAGE_SIZE;
> > +    else if (bar_size < MSIX_PAGE_SIZE) {
> > +        bar_size = MSIX_PAGE_SIZE;
> > +        new_size = MSIX_PAGE_SIZE * 2;
> > +    } else
> > +        new_size = bar_size * 2;
> > +
> > +    pdev->msix_bar_size = new_size;
> > +    config_offset = pci_add_capability(pdev, PCI_CAP_ID_MSIX, MSIX_CAP_LENGTH);
> > +    if (config_offset < 0)
> > +        return config_offset;
> > +    config = pdev->config + config_offset;
> > +
> > +    pci_set_word(config + PCI_MSIX_FLAGS, nentries - 1);
> > +    /* Table on top of BAR */
> > +    pci_set_long(config + MSIX_TABLE_OFFSET, bar_size | bar_nr);
> > +    /* Pending bits on top of that */
> > +    pci_set_long(config + MSIX_PBA_OFFSET, (bar_size + MSIX_PAGE_PENDING) |
> > +                 bar_nr);
> > +    pdev->msix_cap = config_offset;
> > +    /* Make flags bit writeable. */
> > +    pdev->wmask[config_offset + MSIX_ENABLE_OFFSET] |= MSIX_ENABLE_MASK;
> > +    return 0;
> > +}
> > +
> 
> > +
> > +/* Initialize the MSI-X structures. Note: if MSI-X is supported, BAR size is
> > + * modified, it should be retrieved with msix_bar_size. */
> > +int msix_init(struct PCIDevice *dev, unsigned short nentries,
> > +              unsigned bar_nr, unsigned bar_size)
> > +{
> > +    int ret = -ENOMEM;
> > +    /* Nothing to do if MSI is not supported by interrupt controller */
> > +    if (!msix_supported)
> > +        return -ENOTTY;
> > +
> > +    if (nentries > MSIX_MAX_ENTRIES)
> > +        return -EINVAL;
> > +
> > +    dev->msix_entry_used = qemu_mallocz(MSIX_MAX_ENTRIES *
> > +                                        sizeof *dev->msix_entry_used);
> > +    if (!dev->msix_entry_used)
> > +        goto err_used;
> no need to check. oom_checker will kill qemu if it fails.
> 
> > +
> > +    dev->msix_table_page = qemu_mallocz(MSIX_PAGE_SIZE);
> > +    if (!dev->msix_table_page)
> > +        goto err_page;
> ditto.
> 

Good point.

-- 
MST
