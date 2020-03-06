From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH 00/14] iommu: Move iommu_fwspec out of 'struct device'
Date: Fri, 6 Mar 2020 19:04:07 +0800
Message-ID: <c1a0d107-39a2-a25d-ec41-1e5aec68c5ec@huawei.com>
References: <20200228150820.15340-1-joro@8bytes.org>
 <ea839f32-194a-29ea-57fc-22caea40b981@huawei.com>
 <20200306100955.GB50020@myrica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200306100955.GB50020@myrica>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, virtualization@lists.linux-foundation.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Linuxarm <linuxarm@huawei.com>
List-Id: virtualization@lists.linuxfoundation.org

On 2020/3/6 18:09, Jean-Philippe Brucker wrote:
> On Fri, Mar 06, 2020 at 04:39:37PM +0800, Hanjun Guo wrote:
>> Hi Joerg,
>>
>> On 2020/2/28 23:08, Joerg Roedel wrote:
>>> Hi,
>>>
>>> here is a patch-set to rename iommu_param to dev_iommu and
>>> establish it as a struct for generic per-device iommu-data.
>>> Also move the iommu_fwspec pointer from struct device into
>>> dev_iommu to have less iommu-related pointers in struct
>>> device.
>>>
>>> The bigger part of this patch-set moves the iommu_priv
>>> pointer from struct iommu_fwspec to dev_iommu, making is
>>> usable for iommu-drivers which do not use fwspecs.
>>>
>>> The changes for that were mostly straightforward, except for
>>> the arm-smmu (_not_ arm-smmu-v3) and the qcom iommu driver.
>>> Unfortunatly I don't have the hardware for those, so any
>>> testing of these drivers is greatly appreciated.
>>
>> I tested this patch set on Kunpeng 920 ARM64 server which
>> using smmu-v3 with ACPI booting, but triggered a NULL
>> pointer dereference and panic at boot:
> 
> I think that's because patch 01/14 move the fwspec access too early. In 
> 
>                 err = pci_for_each_dma_alias(to_pci_dev(dev),
>                                              iort_pci_iommu_init, &info);
> 
>                 if (!err && iort_pci_rc_supports_ats(node))
>                         dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> 
> the iommu_fwspec is only valid if iort_pci_iommu_init() initialized it
> successfully, if err == 0. The following might fix it:

Good catch :)

> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 0e981d7f3c7d..7d04424189df 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1015,7 +1015,7 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		return ops;
> 
>  	if (dev_is_pci(dev)) {
> -		struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +		struct iommu_fwspec *fwspec;
>  		struct pci_bus *bus = to_pci_dev(dev)->bus;
>  		struct iort_pci_alias_info info = { .dev = dev };
> 
> @@ -1028,7 +1028,8 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     iort_pci_iommu_init, &info);
> 
> -		if (!err && iort_pci_rc_supports_ats(node))
> +		fwspec = dev_iommu_fwspec_get(dev);
> +		if (fwspec && iort_pci_rc_supports_ats(node))
>  			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>  	} else {
>  		int i = 0;

And the panic disappeared. Joerg, please feel free to add my Tested-by
for smmu-v3 and IORT ACPI patches with above changes.

> 
> 
> Note that this use of iommu_fwspec will be removed by the ATS cleanup
> series [1], but this change should work as a temporary fix.

Yes, as your patch set will set the ats_supported flag in the
host bridge level, not per device, nice cleanup.

Thanks
Hanjun
