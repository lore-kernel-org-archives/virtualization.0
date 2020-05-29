From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Date: Fri, 29 May 2020 17:18:24 +0100
Message-ID: <20200529161824.GA17642@e121166-lin.cambridge.arm.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
 <20200528030240.16024-3-jonathan.derrick@intel.com>
 <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
 <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc: "hch@lst.de" <hch@lst.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "helgaas@kernel.org" <helgaas@kernel.org>, "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, May 29, 2020 at 03:53:37PM +0000, Derrick, Jonathan wrote:
> On Fri, 2020-05-29 at 11:33 +0100, Lorenzo Pieralisi wrote:
> > On Wed, May 27, 2020 at 11:02:39PM -0400, Jon Derrick wrote:
> > > Versions of VMD with the Host Physical Address shadow register use this
> > > register to calculate the bus address offset needed to do guest
> > > passthrough of the domain. This register shadows the Host Physical
> > > Address registers including the resource type bits. After calculating
> > > the offset, the extra resource type bits lead to the VMD resources being
> > > over-provisioned at the front and under-provisioned at the back.
> > > 
> > > Example:
> > > pci 10000:80:02.0: reg 0x10: [mem 0xf801fffc-0xf803fffb 64bit]
> > > 
> > > Expected:
> > > pci 10000:80:02.0: reg 0x10: [mem 0xf8020000-0xf803ffff 64bit]
> > > 
> > > If other devices are mapped in the over-provisioned front, it could lead
> > > to resource conflict issues with VMD or those devices.
> > > 
> > > Fixes: a1a30170138c9 ("PCI: vmd: Fix shadow offsets to reflect spec changes")
> > > Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> > > ---
> > >  drivers/pci/controller/vmd.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > Hi Jon,
> > 
> > it looks like I can take this patch for v5.8 whereas patch 2 depends
> > on the QEMU changes acceptance and should probably wait.
> > 
> > Please let me know your thoughts asap and I will try to at least
> > squeeze this patch in.
> > 
> > Lorenzo
> 
> Hi Lorenzo,
> 
> This is fine. Please take Patch 1.
> Patch 2 is harmless without the QEMU changes, but may always need a
> different approach.

Pulled patch 1 into pci/vmd, thanks.

Lorenzo
