From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 4/4] vfio: Allow type-1 IOMMU instantiation with a
	virtio-iommu
Date: Wed, 14 Feb 2018 15:35:05 +0000
Message-ID: <9f98aa85-3160-e285-cacd-2f429c58a775__49870.862279977$1518622412$gmane$org@arm.com>
References: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
	<20180214145340.1223-5-jean-philippe.brucker@arm.com>
	<20180214082639.54556efb@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180214082639.54556efb@w520.home>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: virtio-dev@lists.oasis-open.org, jayachandran.nair@cavium.com, lorenzo.pieralisi@arm.com, tnowicki@caviumnetworks.com, kvm@vger.kernel.org, mst@redhat.com, joro@8bytes.org, will.deacon@arm.com, virtualization@lists.linux-foundation.org, marc.zyngier@arm.com, iommu@lists.linux-foundation.org, jintack@cs.columbia.edu, eric.auger@redhat.com, kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On 14/02/18 15:26, Alex Williamson wrote:
> On Wed, 14 Feb 2018 14:53:40 +0000
> Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:
> 
>> When enabling both VFIO and VIRTIO_IOMMU modules, automatically select
>> VFIO_IOMMU_TYPE1 as well.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>>   drivers/vfio/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
>> index c84333eb5eb5..65a1e691110c 100644
>> --- a/drivers/vfio/Kconfig
>> +++ b/drivers/vfio/Kconfig
>> @@ -21,7 +21,7 @@ config VFIO_VIRQFD
>>   menuconfig VFIO
>>   	tristate "VFIO Non-Privileged userspace driver framework"
>>   	depends on IOMMU_API
>> -	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3)
>> +	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3 || VIRTIO_IOMMU)
>>   	select ANON_INODES
>>   	help
>>   	  VFIO provides a framework for secure userspace device drivers.
> 
> Why are we basing this on specific IOMMU drivers in the first place?
> Only ARM is doing that.  Shouldn't IOMMU_API only be enabled for ARM
> targets that support it and therefore we can forget about the specific
> IOMMU drivers?  Thanks,

Makes sense - the majority of ARM systems (and mobile/embedded ARM64 
ones) making use of IOMMU_API won't actually support VFIO, but it can't 
hurt to allow them to select the type 1 driver regardless. Especially as 
multiplatform configs are liable to be pulling in the SMMU driver(s) anyway.

Robin.
