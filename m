From: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Wed, 11 Mar 2020 18:48:22 +0100
Message-ID: <20200311174822.GA96893@myrica>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7BE404@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7BE404@SHSMSX104.ccr.corp.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, "Boeuf, Sebastien" <sebastien.boeuf@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "jasowang@redhat.com" <jasowang@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 05, 2020 at 08:07:32AM +0000, Tian, Kevin wrote:
> > From: Jean-Philippe Brucker
> > Sent: Saturday, February 29, 2020 1:26 AM
> > 
> > Platforms without device-tree do not currently have a method for
> > describing the vIOMMU topology. Provide a topology description embedded
> > into the virtio device.
> > 
> > Use PCI FIXUP to probe the config space early, because we need to
> > discover the topology before any DMA configuration takes place, and the
> > virtio driver may be loaded much later. Since we discover the topology
> > description when probing the PCI hierarchy, the virtual IOMMU cannot
> > manage other platform devices discovered earlier.
> > 
> > This solution isn't elegant nor foolproof, but is the best we can do at
> 
> can you elaborate "isn't elegant nor foolproof" part? is there any other 
> limitation (beside pci fixup) along the route, when comparing it to 
> the ACPI-approach?

Yes "not elegant" in part because of the PCI fixup. Fixups are used to
work around bugs, and it seems strange to have one for a normal use-case.
We also have to copy some of the virtio infrastructure since this code
runs before module load. And we have to add a third DMA configuration
method.

I don't believe anymore that the "not foolproof" part is right. After
studying the device infrastructure a little more this solution seems less
fragile than I previously thought, but it's still a big hack, and it's
only half of the story.

This patch only handles PCI-based endpoints and viommu. On ACPI platforms,
where the virtio-mmio device is specified by an object with _HID LNRO0005,
supporting virtio-iommu on MMIO requires installing a bus notifier. There
I'd rather use an ACPI table for the topology. Platforms that don't have
ACPI such as microvm specify virtio-mmio devices on the command-line.
There devices are only created when the virtio-mmio module is loaded,
which is too late. In that case I think we need to add an early pass on
the command-line, instead of a bus notifier.

Thanks,
Jean
