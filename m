From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFC] virtio-iommu version 0.4
Date: Mon, 14 Aug 2017 10:38:51 +0100
Message-ID: <1770ca04-0deb-a3d4-c63e-82054e8a584c__14436.7972309285$1502703404$gmane$org@arm.com>
References: <20170804181927.12148-1-jean-philippe.brucker@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D7173C@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D7173C@SHSMSX101.ccr.corp.intel.com>
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
To: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>, "mst@redhat.com" <mst@redhat.com>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 14/08/17 09:27, Tian, Kevin wrote:
>> * First, since the IOMMU is paravirtualized, the device can expose some
>>   properties of the physical topology to the guest, and let it allocate
>>   resources more efficiently. For example, when the virtio-iommu manages
>>   both physical and emulated endpoints, with different underlying IOMMUs,
>>   we now have a way to describe multiple page and block granularities,
>>   instead of forcing the guest to use the most restricted one for all
>>   endpoints. This will most likely be in v0.5.
> 
> emulated IOMMU has similar requirement, e.g. available PASID bits,
> address widths, etc. which may break guest usage if not aligned to
> physical limitation. Suppose we can introduce a general interface
> through VFIO for all vIOMMU incarnations. 

A nice location for this kind of info would be sysfs, as discussed in the
SVM virtualization thread [1]. Properties of an IOMMU could be described
in /sys/class/iommu/<dev>. Properties of a PCI device are available in its
PASID/PRI capabilities. For platform devices we'll have to look at DT and
ACPI properties in /sys/firmware.

>> * Then on top of that, a major improvement will describe hardware
>>   acceleration features available to the guest. There is what I call "Page
>>   Table Handover" (or simply, from the host POV, "Nested"), the ability
>>   for the guest to manipulate its own page tables instead of sending
>>   MAP/UNMAP requests to the host. This, along with IO Page Fault
>>   reporting, will also permit SVM virtualization on different platforms.
> 
> what's your planned cadence for future versions? :-)

Hard to say, it depends on a number of things. I have various other tasks
eating up my bandwidth at the moment and I may have to considerably rework
this version depending on the feedback it gets. Ideally, I would like to
get the base driver merged and a proposal for hardware acceleration out by
the end of the year, but I obviously can't make any guarantee.

Thanks,
Jean

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg05731.html
