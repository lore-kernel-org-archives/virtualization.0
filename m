From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [RFC] virtio-iommu version 0.4
Date: Wed, 20 Sep 2017 11:37:25 +0200
Message-ID: <6d9f91df-ebb0-2ae0-a098-60a6bcd0e09b__38475.7405416623$1509079385$gmane$org@redhat.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
	<072f5a14-baae-57a9-9c5b-b93163c67075@redhat.com>
	<4543e6dc-0f36-11ad-784a-d7c07399d10f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4543e6dc-0f36-11ad-784a-d7c07399d10f@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, Robin Murphy <Robin.Murphy@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Hi Jean,
On 19/09/2017 12:47, Jean-Philippe Brucker wrote:
> Hi Eric,
> 
> On 12/09/17 18:13, Auger Eric wrote:
>> 2.6.7
>> - As I am currently integrating v0.4 in QEMU here are some other comments:
>> At the moment struct virtio_iommu_req_probe flags is missing in your
>> header. As such I understood the ACK protocol was not implemented by the
>> driver in your branch.
> 
> Uh indeed. And yet I could swear I've written that code... somewhere. I
> will add it to the batch of v0.5 changes, it shouldn't be too invasive.
> 
>> - VIRTIO_IOMMU_PROBE_PROPERTY_TYPE_MASK is VIRTIO_IOMMU_T_MASK in your
>> header too.
> 
> Yes, keeping VIRTIO_IOMMU_PROBE_PROPERTY_TYPE_MASK is probably best
> (though it is a mouthful).
> 
>> 2.6.8.2:
>> - I am really confused about what the device should report as resv
>> regions depending on the PE nature (VFIO or not VFIO)
>>
>> In other iommu drivers, the resv regions are populated by the iommu
>> driver through its get_resv_regions callback. They are usually composed
>> of an iommu specific MSI region (mapped or bypassed) and non IOMMU
>> specific (device specific) reserved regions:
>> iommu_dma_get_resv_regions(). In the case of virtio-iommu driver, those
>> are the guest reserved regions.
>>
>> First in the current virtio-iommu driver I don't see the
>> iommu_dma_get_resv_regions call. Do you agree that the virtio-iommu
>> driver should compute the non IOMMU specific MSI regions ie. this is
>> not the responsability of the virtio-iommu device.
> 
> For SW_MSI, certainly. The driver allocates a fixed IOVA region for
> mapping the MSI doorbell. But the driver has to know whether the doorbell
> region is translated or bypassed.
Sorry I was talking about *non* IOMMU specific MSI regions, typically
the regions corresponding to guest PCI host bridge windows. This is
normally computed in the iommu driver and I didn't that that in the
existing virtio-iommu driver.
> 
>> Then why is it more the job of the device to return the guest iommu
>> specific region rather than the driver itself?
> 
> The MSI region is architectural on x86 IOMMUs, but
> implementation-defined on virtio-iommu. It depends which platform the host
> is emulating. In Linux, x86 IOMMU drivers register the bypass region
> because there always is an IOAPIC on the other end, with a fixed MSI
> address. But virtio-iommu may be either behind a GIC, an APIC or some
> other IRQ chip.
> 
> The driver *could* go over all the irqchips/platforms it knows and try to
> guess if there is a fixed doorbell or if it needs to reserve an IOVA for
> them, but it would look horrible. I much prefer having a well-defined way
> of doing this, so a description from the device.

This means I must have target specific code in the virtio-iommu device
which is unusual, right? I was initially thinking you could handle that
on the driver side using a config set for ARM|ARM64. But on the other
hand you should communicate the info to the device ...

> 
>> Then I understand this is the responsability of the virtio-iommu device
>> to gather information about the host resv regions in case of VFIO EP.
>> Typically the host PCIe host bridge windows cannot be used for IOVA.
>> Also the host MSI reserved IOVA window cannot be used. Do you agree.
> 
> Yes, all regions reported in sysfs reserved_regions in the host would be
> reported as RESV_T_RESERVED by virtio-iommu.
So to summarize if the probe request is sent to an emulated device, we
should return the target specific MSI window. We can't and don't return
the non IOMMU specific guest reserved windows.

For a VFIO device, we would return all reserved regions of the group the
device belongs to. Is that correct?
> 
>> I really think the spec should clarify what exact resv regions the
>> device should return in case of VFIO device and non VFIO device.
> 
> Agreed. I will add something about RESV_T_RESERVED with the PCI bridge
> example in Implementation Notes. Do you think the MSI examples at the end
> need improvement as well? I can try to explain that RESV_MSI regions in
> virtio-iommu are only those of the emulated platform, not the HW or SW MSI
> regions from the host.

I think I would expect an explanation detailing returned reserved
regions for pure emulated devices and HW/VFIO devices.

Another unrelated remark:
- you should add a permission violation error.
- wrt the probe request ACK protocol, this looks pretty heavy as both
the driver and the device need to parse the req_probe buffer. The device
need to fill in the output buffer and then read the same info on the
input buffer. Couldn't we imagine something simpler?

Thanks

Eric
> 
> Thanks,
> Jean
> 
