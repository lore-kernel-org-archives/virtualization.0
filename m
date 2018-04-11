From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 2/4] iommu/virtio: Add probe request
Date: Wed, 11 Apr 2018 19:33:59 +0100
Message-ID: <c6ae66ca-ddaf-09f6-cfee-87f4b99a7e8f__365.202062721615$1523471537$gmane$org@arm.com>
References: <20180214145340.1223-1-jean-philippe.brucker@arm.com>
	<20180214145340.1223-3-jean-philippe.brucker@arm.com>
	<8156517f-74b1-2923-2838-402f09a5c488@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8156517f-74b1-2923-2838-402f09a5c488@arm.com>
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
To: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>
Cc: "jayachandran.nair@cavium.com" <jayachandran.nair@cavium.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "tnowicki@caviumnetworks.com" <tnowicki@caviumnetworks.com>, "mst@redhat.com" <mst@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, "jintack@cs.columbia.edu" <jintack@cs.columbia.edu>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "joro@8bytes.org" <joro@8bytes.org>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On 23/03/18 15:00, Robin Murphy wrote:
[...]
>> +	/*
>> +	 * Treat unknown subtype as RESERVED, but urge users to update their
>> +	 * driver.
>> +	 */
>> +	if (mem->subtype != VIRTIO_IOMMU_RESV_MEM_T_RESERVED &&
>> +	    mem->subtype != VIRTIO_IOMMU_RESV_MEM_T_MSI)
>> +		pr_warn("unknown resv mem subtype 0x%x\n", mem->subtype);
> 
> Might as well avoid the extra comparisons by incorporating this into the 
> switch statement, i.e.:
> 
> 	default:
> 		dev_warn(vdev->viommu_dev->dev, ...);
> 		/* Fallthrough */
> 	case VIRTIO_IOMMU_RESV_MEM_T_RESERVED:
> 		...
> 
> (dev_warn is generally preferable to pr_warn when feasible)

Alright, that's nicer

[...]
>>   	/*
>>   	 * Last step creates a default domain and attaches to it. Everything
>>   	 * must be ready.
>> @@ -735,7 +849,19 @@ static int viommu_add_device(struct device *dev)
>>   
>>   static void viommu_remove_device(struct device *dev)
>>   {
>> -	kfree(dev->iommu_fwspec->iommu_priv);
>> +	struct viommu_endpoint *vdev;
>> +	struct iommu_resv_region *entry, *next;
>> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>> +
>> +	if (!fwspec || fwspec->ops != &viommu_ops)
>> +		return;
> 
> Oh good :) I guess that was just a patch-splitting issue. The group 
> thing still applies, though.

Ok

Thanks,
Jean
