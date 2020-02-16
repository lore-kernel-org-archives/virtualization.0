From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 3/3] iommu/virtio: Enable x86 support
Date: Sun, 16 Feb 2020 04:50:33 -0500
Message-ID: <20200216045006-mutt-send-email-mst@kernel.org>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-4-jean-philippe@linaro.org>
 <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <311a1885-c619-3c8d-29dd-14fbfbf74898@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, kevin.tian@intel.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com, jasowang@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 14, 2020 at 04:57:11PM +0000, Robin Murphy wrote:
> On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > With the built-in topology description in place, x86 platforms can now
> > use the virtio-iommu.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   drivers/iommu/Kconfig | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 068d4e0e3541..adcbda44d473 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -508,8 +508,9 @@ config HYPERV_IOMMU
> >   config VIRTIO_IOMMU
> >   	bool "Virtio IOMMU driver"
> >   	depends on VIRTIO=y
> > -	depends on ARM64
> > +	depends on (ARM64 || X86)
> >   	select IOMMU_API
> > +	select IOMMU_DMA
> 
> Can that have an "if X86" for clarity? AIUI it's not necessary for
> virtio-iommu itself (and really shouldn't be), but is merely to satisfy the
> x86 arch code's expectation that IOMMU drivers bring their own DMA ops,
> right?
> 
> Robin.

In fact does not this work on any platform now?

> >   	select INTERVAL_TREE
> >   	help
> >   	  Para-virtualised IOMMU driver with virtio.
> > 
