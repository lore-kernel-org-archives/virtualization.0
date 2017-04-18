From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC 2/3] virtio-iommu: device probing and operations
Date: Tue, 18 Apr 2017 19:45:54 +0100
Message-ID: <34166633-f4d5-21d5-20db-9091243ccd84__43964.8392530673$1492541036$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407191747.26618-3-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190CADECE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190CADECE@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "cdall@linaro.org" <cdall@linaro.org>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, "will.deacon@arm.com" <will.deacon@arm.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On 18/04/17 11:26, Tian, Kevin wrote:
>> From: Jean-Philippe Brucker
>> Sent: Saturday, April 8, 2017 3:18 AM
>>
> [...]
>>   II. Feature bits
>>   ================
>>
>> VIRTIO_IOMMU_F_INPUT_RANGE (0)
>>  Available range of virtual addresses is described in input_range
> 
> Usually only the maximum supported address bits are important. 
> Curious do you see such situation where low end of the address 
> space is not usable (since you have both start/end defined later)?

A start address would allow to provide something resembling a GART to the
guest: an IOMMU with one address space (ioasid_bits=0) and a small IOVA
aperture. I'm not sure how useful that would be in practice.

On a related note, the virtio-iommu itself doesn't provide a
per-address-space aperture as it stands. For example, attaching a device
to an address space might restrict the available IOVA range for the whole
AS if that device cannot write to high memory (above 32-bit). If the guest
attempts to map an IOVA outside this window into the device's address
space, it should expect the MAP request to fail. And when attaching, if
the address space already has mappings outside this window, then ATTACH
should fail.

This too seems to be something that ought to be communicated by firmware,
but bits are missing (I can't find anything equivalent to DT's dma-ranges
for PCI root bridges in ACPI tables, for example). In addition VFIO
doesn't communicate any DMA mask for devices, and doesn't check them
itself. I guess that the host could find out the DMA mask of devices one
way or another, but it is tricky to enforce, so I didn't make this a hard
requirement. Although I should probably add a few words about it.

> [...]
>>   1. Attach device
>>   ----------------
>>
>> struct virtio_iommu_req_attach {
>> 	le32	address_space;
>> 	le32	device;
>> 	le32	flags/reserved;
>> };
>>
>> Attach a device to an address space. 'address_space' is an identifier
>> unique to the guest. If the address space doesn't exist in the IOMMU
> 
> Based on your description this address space ID is per operation right?
> MAP/UNMAP and page-table sharing should have different ID spaces...

I think it's simpler if we keep a single IOASID space per virtio-iommu
device, because the maximum number of address spaces (described by
ioasid_bits) might be a restriction of the pIOMMU. For page-table sharing
you still need to define which devices will share a page directory using
ATTACH requests, though that interface is not set in stone.

>> device, it is created. 'device' is an identifier unique to the IOMMU. The
>> host communicates unique device ID to the guest during boot. The method
>> used to communicate this ID is outside the scope of this specification,
>> but the following rules must apply:
>>
>> * The device ID is unique from the IOMMU point of view. Multiple devices
>>   whose DMA transactions are not translated by the same IOMMU may have
>> the
>>   same device ID. Devices whose DMA transactions may be translated by the
>>   same IOMMU must have different device IDs.
>>
>> * Sometimes the host cannot completely isolate two devices from each
>>   others. For example on a legacy PCI bus, devices can snoop DMA
>>   transactions from their neighbours. In this case, the host must
>>   communicate to the guest that it cannot isolate these devices from each
>>   others. The method used to communicate this is outside the scope of this
>>   specification. The IOMMU device must ensure that devices that cannot be
> 
> "IOMMU device" -> "IOMMU driver"

Indeed

Thanks!
Jean-Philippe

>>   isolated by the host have the same address spaces.
