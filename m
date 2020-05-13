From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH for QEMU v2] hw/vfio: Add VMD Passthrough Quirk
Date: Wed, 13 May 2020 13:55:08 -0600
Message-ID: <20200513135508.162809da@x1.home>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
        <20200511190129.9313-2-jonathan.derrick@intel.com>
        <20200511165927.27b41d65@w520.home>
        <91c6795937035d6ad72cb78c7997ba8168f643c5.camel@intel.com>
        <20200513115540.59a2f57d@w520.home>
        <bd733dccd9cf67c50e757845332e6f8b95719776.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <bd733dccd9cf67c50e757845332e6f8b95719776.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "hch@lst.de" <hch@lst.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "helgaas@kernel.org" <helgaas@kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 13 May 2020 19:26:34 +0000
"Derrick, Jonathan" <jonathan.derrick@intel.com> wrote:

> On Wed, 2020-05-13 at 11:55 -0600, Alex Williamson wrote:
> > On Wed, 13 May 2020 00:35:47 +0000
> > "Derrick, Jonathan" <jonathan.derrick@intel.com> wrote:
> >   
> > > Hi Alex,
> > > 
> > >   
> [snip]
> 
> > 
> > Thanks for the confirmation.  The approach seems ok, but a subtle
> > side-effect of MemoryRegion quirks is that we're going to trap the
> > entire PAGE_SIZE range overlapping the quirk out to QEMU on guest
> > access.  The two registers at 0x2000 might be reserved for this
> > purpose, but is there anything else that could be performance sensitive
> > anywhere in that page?  If so, it might be less transparent, but more
> > efficient to invent a new quirk making use of config space (ex. adding
> > an emulated vendor capability somewhere known to be unused on the
> > device).  Thanks,
> > 
> > Alex  
> 
> Seems like that could be a problem if we're running with huge pages and
> overlapping msix tables.

FWIW, MSI-X tables are already getting trapped into QEMU for emulation.
We have a mechanism via x-msix-relocation=<OffAutoPCIBAR> in QEMU to
deal with that when it becomes a problem by emulating the MSI-X
structures in MMIO space that doesn't overlap with the actual device
(ie. virtually resizing or adding BARs).  The issue is what else can be
in that 4K page or will this device be supported on archs where the
system page size is >4K more so than huge pages (as in hugetlbfs or
transparent huge pages).  Thanks,

Alex
