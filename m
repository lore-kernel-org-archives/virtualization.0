From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Tue, 3 Mar 2020 11:09:41 -0500
Message-ID: <20200303105523-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
 <20200303084753-mutt-send-email-mst@kernel.org>
 <20200303155318.GA3954@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200303155318.GA3954@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Auger Eric <eric.auger@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 03, 2020 at 04:53:19PM +0100, Joerg Roedel wrote:
> On Tue, Mar 03, 2020 at 09:00:05AM -0500, Michael S. Tsirkin wrote:
> > Not necessarily. E.g. some power systems have neither.
> > There are also systems looking to bypass ACPI e.g. for boot speed.
> 
> If there is no firmware layer between the hardware and the OS the
> necessary information the OS needs to run on the hardware is probably
> hard-coded into the kernel?

No. It's coded into the hardware. Which might even be practical
for bare-metal (e.g. on-board flash), but is very practical
when the device is part of a hypervisor.

> In that case the same can be done with
> virtio-iommu tolopology.
> 
> > That sentence doesn't really answer the question, does it?
> 
> To be more elaborate, putting this information into config space is a
> layering violation. Hardware is never completly self-descriptive


This "hardware" is actually part of hypervisor so there's no
reason it can't be completely self-descriptive. It's specified
by the same entity as the "firmware".


> and
> that is why there is the firmware which provides the information about
> the hardware to the OS in a generic way.
>
> > Frankly with platform specific interfaces like ACPI, virtio-iommu is
> > much less compelling.  Describing topology as part of the device in a
> > way that is first, portable, and second, is a good fit for hypervisors,
> > is to me one of the main reasons virtio-iommu makes sense at all.
> 
> Virtio-IOMMU makes sense in the first place because it is much faster
> than emulating one of the hardware IOMMUs.

I don't see why it would be much faster. The interface isn't that
different from command queues of VTD.

> And an ACPI table is also
> portable to all ACPI platforms, same with device-tree.
> 
> Regards,
> 
> 	Joerg

Making ACPI meet the goals of embedded projects such as kata containers
would be a gigantic task with huge stability implications.  By
comparison this 400-line parser is well contained and does the job.  I
didn't yet see compelling reasons not to merge this, but I'll be
interested to see some more specific concerns.


-- 
MST
