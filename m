From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 2/3] PCI: Add DMA configuration for virtual platforms
Date: Mon, 17 Feb 2020 10:12:22 +0100
Message-ID: <20200217091222.GB1650092@myrica>
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-3-jean-philippe@linaro.org>
 <393cce27-dbed-f075-2a67-9882bed801e7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <393cce27-dbed-f075-2a67-9882bed801e7@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, kevin.tian@intel.com, mst@redhat.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, bhelgaas@google.com, jasowang@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Feb 14, 2020 at 05:03:16PM +0000, Robin Murphy wrote:
> On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> > Hardware platforms usually describe the IOMMU topology using either
> > device-tree pointers or vendor-specific ACPI tables.  For virtual
> > platforms that don't provide a device-tree, the virtio-iommu device
> > contains a description of the endpoints it manages.  That information
> > allows us to probe endpoints after the IOMMU is probed (possibly as late
> > as userspace modprobe), provided it is discovered early enough.
> > 
> > Add a hook to pci_dma_configure(), which returns -EPROBE_DEFER if the
> > endpoint is managed by a vIOMMU that will be loaded later, or 0 in any
> > other case to avoid disturbing the normal DMA configuration methods.
> > When CONFIG_VIRTIO_IOMMU_TOPOLOGY isn't selected, the call to
> > virt_dma_configure() is compiled out.
> > 
> > As long as the information is consistent, platforms can provide both a
> > device-tree and a built-in topology, and the IOMMU infrastructure is
> > able to deal with multiple DMA configuration methods.
> 
> Urgh, it's already been established[1] that having IOMMU setup tied to DMA
> configuration at driver probe time is not just conceptually wrong but
> actually broken, so the concept here worries me a bit. In a world where
> of_iommu_configure() and friends are being called much earlier around
> iommu_probe_device() time, how badly will this fall apart?

If present the DT configuration should take precedence over this built-in
method, so the earlier it is called the better. virt_dma_configure()
currently gives up if the device already has iommu_ops (well, still calls
setup_dma_ops() which is safe enough, but I think I'll change that to have
virt_iommu_setup() return NULL if iommu_ops are present).

I don't have the full picture of the changes you intend for
{of,acpi}_iommu_configure(), do you think checking the validity of
dev->iommu_fwspec will remain sufficient to have both methods coexist?

Thanks,
Jean
