From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC] virtio-iommu version 0.5
Date: Wed, 25 Oct 2017 13:05:33 +0100
Message-ID: <b35e1825-a5c2-e8b3-081c-2f23ac2d627f__6699.49337975613$1508933135$gmane$org@arm.com>
References: <20171023093241.20113-1-jean-philippe.brucker@arm.com>
	<20171024062704.GA23141@virtx40>
	<b878c366-6e43-aacc-c7f6-cabb3f91211e@arm.com>
	<20171024165859.GA24369@virtx40> <20171025070704.GA10689@virtx40>
	<6e5c3a23-9e00-1936-f80c-085faf42c420@arm.com>
	<20171025110548.GA20548@virtx40>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171025110548.GA20548@virtx40>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linu Cherian <linu.cherian@cavium.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "ashok.raj@intel.com" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, "Jayachandran.Nair@cavium.com" <Jayachandran.Nair@cavium.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "sunil.goutham@cavium.com" <sunil.goutham@cavium.com>, Linu Cherian <linuc.decode@gmail.com>, Robin Murphy <Robin.Murphy@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 25/10/17 12:05, Linu Cherian wrote:
>>> Also does this solution intend to cover the page table sharing of non SVM 
>>> cases. For example, if we need to share the IOMMU page table for 
>>> a device used in guest kernel, so that map/unmap gets directly handled by the guest
>>> and only TLB invalidates happens through a virtio-iommu channel.
>>
>> Yes for non-SVM in SMMuv3, you still have a context table but with a
>> single descriptor, so the interface stays the same. 
> 
> So for non SVM case, 
> guest virtio-iommu driver will program the context descriptor such a way that,
> ASID is not in shared set(ASET = 1b) and hence Physical IOMMU TLB invalidates would get triggered 
> from software for every viommu_unmap(in guest kernel) through Qemu(using vfio ioctls) ? 

That's right. viommu_unmap will send an INVALIDATE request on the virtio
request queue, forwarded to the driver via a VFIO ioctl.

> And for SVM case, ASID would be in shared set and explicit TLB invalidates 
> are not required from software ?

Yes, although that's only true for integrated devices (non-PCI). On PCI,
devices will have an ATC (a device IOTLB), in which case we still have to
send an invalidation request through virtio and then VFIO, so that the
SMMU driver sends an CMD_ATC_INV.

Thanks,
Jean
