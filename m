From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Tue, 3 Mar 2020 09:00:05 -0500
Message-ID: <20200303084753-mutt-send-email-mst@kernel.org>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
 <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
 <20200303130155.GA13185@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200303130155.GA13185@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Auger Eric <eric.auger@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, bhelgaas@google.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Mar 03, 2020 at 02:01:56PM +0100, Joerg Roedel wrote:
> Hi Eric,
> 
> On Tue, Mar 03, 2020 at 11:19:20AM +0100, Auger Eric wrote:
> > Michael has pushed this solution (putting the "configuration in the PCI
> > config space"), I think for those main reasons:
> > - ACPI may not be supported on some archs/hyps
> 
> But on those there is device-tree, right?

Not necessarily. E.g. some power systems have neither.
There are also systems looking to bypass ACPI e.g. for boot speed.


> > - the virtio-iommu is a PCIe device so binding should not need ACPI
> > description
> 
> The other x86 IOMMUs are PCI devices too and they definitly need a ACPI
> table to be configured.
> 
> > Another issue with ACPI integration is we have different flavours of
> > tables that exist: IORT, DMAR, IVRS
> 
> An integration with IORT might be the best, but if it is not possible
> ther can be a new table-type for Virtio-iommu. That would still follow
> platform best practices.
> 
> > x86 ACPI integration was suggested with IORT. But it seems ARM is
> > reluctant to extend IORT to support para-virtualized IOMMU. So the VIOT
> > was proposed as a different atternative in "[RFC 00/13] virtio-iommu on
> > non-devicetree platforms"
> > (https://patchwork.kernel.org/cover/11257727/). Proposing a table that
> > may be used by different vendors seems to be a challenging issue here.
> 
> Yeah, if I am reading that right this proposes a one-fits-all solution.
> That is not needed as the other x86 IOMMUs already have their tables
> defined and implemented. There is no need to change anything there.
> 
> > So even if the above solution does not look perfect, it looked a
> > sensible compromise given the above arguments. Please could you explain
> > what are the most compelling arguments against it?
> 
> It is a hack and should be avoided if at all possible.

That sentence doesn't really answer the question, does it?

> And defining an
> own ACPI table type seems very much possible.

Frankly with platform specific interfaces like ACPI, virtio-iommu is
much less compelling.  Describing topology as part of the device in a
way that is first, portable, and second, is a good fit for hypervisors,
is to me one of the main reasons virtio-iommu makes sense at all.

> 
> Regards,
> 
> 	Joerg
