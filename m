From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/virtio: Add topology description to
 virtio-iommu config space
Date: Tue, 3 Mar 2020 11:19:20 +0100
Message-ID: <9004f814-2f7c-9024-3465-6f9661b97b7a@redhat.com>
References: <20200228172537.377327-1-jean-philippe@linaro.org>
 <20200228172537.377327-2-jean-philippe@linaro.org>
 <20200302161611.GD7829@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20200302161611.GD7829@8bytes.org>
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: iommu@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, linux-pci@vger.kernel.org, bhelgaas@google.com, mst@redhat.com, jasowang@redhat.com, kevin.tian@intel.com, sebastien.boeuf@intel.com, jacob.jun.pan@intel.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi Joerg,

On 3/2/20 5:16 PM, Joerg Roedel wrote:
> On Fri, Feb 28, 2020 at 06:25:36PM +0100, Jean-Philippe Brucker wrote:
>> This solution isn't elegant nor foolproof, but is the best we can do at
>> the moment and works with existing virtio-iommu implementations. It also
>> enables an IOMMU for lightweight hypervisors that do not rely on
>> firmware methods for booting.
> 
> I appreciate the enablement on x86, but putting the conmfiguration into
> mmio-space isn't really something I want to see upstream. What is the
> problem with defining an ACPI table instead? This would also make things
> work on AARCH64 UEFI machines.
Michael has pushed this solution (putting the "configuration in the PCI
config space"), I think for those main reasons:
- ACPI may not be supported on some archs/hyps
- the virtio-iommu is a PCIe device so binding should not need ACPI
description

Another issue with ACPI integration is we have different flavours of
tables that exist: IORT, DMAR, IVRS

x86 ACPI integration was suggested with IORT. But it seems ARM is
reluctant to extend IORT to support para-virtualized IOMMU. So the VIOT
was proposed as a different atternative in "[RFC 00/13] virtio-iommu on
non-devicetree platforms"
(https://patchwork.kernel.org/cover/11257727/). Proposing a table that
may be used by different vendors seems to be a challenging issue here.

So even if the above solution does not look perfect, it looked a
sensible compromise given the above arguments. Please could you explain
what are the most compelling arguments against it?

Thanks

Eric
> 
> Regards,
> 
> 	Joerg
> 
