From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 3/7] PCI: OF: Allow endpoints to bypass the iommu
Date: Mon, 15 Oct 2018 12:32:51 +0100
Message-ID: <33bd48e9-a061-e97d-ff00-daf5097b8e1f__14355.394364293$1539603060$gmane$org@arm.com>
References: <20181012145917.6840-1-jean-philippe.brucker@arm.com>
	<20181012145917.6840-4-jean-philippe.brucker@arm.com>
	<20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181012194158.GX5906@bhelgaas-glaptop.roam.corp.google.com>
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
To: Bjorn Helgaas <helgaas@kernel.org>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: mark.rutland@arm.com, peter.maydell@linaro.org, tnowicki@caviumnetworks.com, devicetree@vger.kernel.org, marc.zyngier@arm.com, linux-pci@vger.kernel.org, mst@redhat.com, will.deacon@arm.com, virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org, robh+dt@kernel.orgnd@arm.com, kvmarm@lists.cs.columbia.edu
List-Id: virtualization@lists.linuxfoundation.org

On 12/10/18 20:41, Bjorn Helgaas wrote:
> s/iommu/IOMMU/ in subject
> 
> On Fri, Oct 12, 2018 at 03:59:13PM +0100, Jean-Philippe Brucker wrote:
>> Using the iommu-map binding, endpoints in a given PCI domain can be
>> managed by different IOMMUs. Some virtual machines may allow a subset of
>> endpoints to bypass the IOMMU. In some case the IOMMU itself is presented
> 
> s/case/cases/
> 
>> as a PCI endpoint (e.g. AMD IOMMU and virtio-iommu). Currently, when a
>> PCI root complex has an iommu-map property, the driver requires all
>> endpoints to be described by the property. Allow the iommu-map property to
>> have gaps.
> 
> I'm not an IOMMU or virtio expert, so it's not obvious to me why it is
> safe to allow devices to bypass the IOMMU.  Does this mean a typo in
> iommu-map could inadvertently allow devices to bypass it?  Should we
> indicate something in dmesg (and/or sysfs) about devices that bypass
> it?

It's not really "allow devices to bypass the IOMMU" so much as "allow DT 
to describe devices which the IOMMU doesn't translate". It's a bit of an 
edge case for not-really-PCI devices, but FWIW I can certainly think of 
several ways to build real hardware like that. As for inadvertent errors 
leaving out IDs which *should* be in the map, that really depends on the 
IOMMU/driver implementation - e.g. SMMUv2 with arm-smmu.disable_bypass=0 
would treat the device as untranslated, whereas SMMUv3 would always 
generate a fault upon any transaction due to no valid stream table entry 
being programmed (not even a bypass one).

I reckon it's a sufficiently unusual case that keeping some sort of 
message probably is worthwhile (at pr_info rather than pr_err) in case 
someone does hit it by mistake.

>> Relaxing of_pci_map_rid also allows the msi-map property to have gaps,

At worst, I suppose we could always add yet another parameter for each 
caller to choose whether a missing entry is considered an error or not.

Robin.

> s/of_pci_map_rid/of_pci_map_rid()/
> 
>> which is invalid since MSIs always reach an MSI controller. Thankfully
>> Linux will error out later, when attempting to find an MSI domain for the
>> device.
> 
> Not clear to me what "error out" means here.  In a userspace program,
> I would infer that the program exits with an error message, but I
> doubt you mean that Linux exits.
> 
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>>   drivers/pci/of.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index 1836b8ddf292..2f5015bdb256 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -451,9 +451,10 @@ int of_pci_map_rid(struct device_node *np, u32 rid,
>>   		return 0;
>>   	}
>>   
>> -	pr_err("%pOF: Invalid %s translation - no match for rid 0x%x on %pOF\n",
>> -		np, map_name, rid, target && *target ? *target : NULL);
>> -	return -EFAULT;
>> +	/* Bypasses translation */
>> +	if (id_out)
>> +		*id_out = rid;
>> +	return 0;
>>   }
>>   
>>   #if IS_ENABLED(CONFIG_OF_IRQ)
>> -- 
>> 2.19.1
>>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
