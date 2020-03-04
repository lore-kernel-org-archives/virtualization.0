From: Jacob Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Wed, 4 Mar 2020 07:48:54 -0800
Message-ID: <20200304074854.3ea958a1@jacob-XPS-13-9365>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
        <20200228172537.377327-2-jean-philippe@linaro.org>
        <20200302161611.GD7829@8bytes.org>
        <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
        <20200303130155.GA13185@8bytes.org>
        <20200303084753-mutt-send-email-mst@kernel.org>
        <20200303155318.GA3954@8bytes.org>
        <20200303105523-mutt-send-email-mst@kernel.org>
        <20200304133707.GB4177@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20200304133707.GB4177@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, kevin.tian@intel.com, linux-pci@vger.kernel.org, jasowang@redhat.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, sebastien.boeuf@intel.com, bhelgaas@google.com, robin.murphy@arm.com, jacob.jun.pan@intel.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 4 Mar 2020 14:37:08 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> Hi Michael,
> 
> On Tue, Mar 03, 2020 at 11:09:41AM -0500, Michael S. Tsirkin wrote:
> > No. It's coded into the hardware. Which might even be practical
> > for bare-metal (e.g. on-board flash), but is very practical
> > when the device is part of a hypervisor.  
> 
> If its that way on PPC, than fine for them. But since this is
> enablement for x86, it should follow the x86 platform best practices,
> and that means describing hardware through ACPI.
> 
> > This "hardware" is actually part of hypervisor so there's no
> > reason it can't be completely self-descriptive. It's specified
> > by the same entity as the "firmware".  
> 
> That is just an implementation detail. Yes, QEMU emulates the hardware
> and builds the ACPI tables. But it could also be implemented in a way
> where the ACPI tables are build by guest firmware.
> 
> > I don't see why it would be much faster. The interface isn't that
> > different from command queues of VTD.  
> 
> VirtIO IOMMU doesn't need to build page-tables that the hypervisor
> then has to shadow, which makes things much faster. If you emulate
> one of the other IOMMUs (VT-d or AMD-Vi) the code has to shadow the
> full page-table at once when device passthrough is used. VirtIO-IOMMU
> doesn't need that, and that makes it much faster and efficient.
> 
For emulated VT-d IOMMU, GIOVA can also be build as first level page
tables then pass to the host IOMMU to bind. There is no need to shadow
in this case, pIOMMU will do nested translation and walk guest page
tables.

> > Making ACPI meet the goals of embedded projects such as kata
> > containers would be a gigantic task with huge stability
> > implications.  By comparison this 400-line parser is well contained
> > and does the job.  I didn't yet see compelling reasons not to merge
> > this, but I'll be interested to see some more specific concerns.  
> 
> An ACPI table parse wouldn't need more lines of code. For embedded
> systems there is still the DT way of describing things.
> 
I thought we have the universal device properties to abstract DT and
ACPI (via _DSD). Is that an option?

> Regards,
> 
> 	Joerg
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
