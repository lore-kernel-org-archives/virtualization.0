From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
Date: Tue, 2 Jun 2020 07:16:22 +0800
Message-ID: <47711845-98ee-95b8-aa95-423a36ed9741@linux.intel.com>
References: <20200414131542.25608-1-joro@8bytes.org>
 <20200529221623.qc6twmpzryh7nkvb@cantor>
 <20200601104240.7f5xhz7gooqhaq4n@cantor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200601104240.7f5xhz7gooqhaq4n@cantor>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization@
Cc: baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Jerry,

On 6/1/20 6:42 PM, Jerry Snitselaar wrote:
>>
>> Hi Joerg,
>>
>> With this patchset, I have an epyc system where if I boot with
>> iommu=nopt and force a dump I will see some io page faults for a nic
>> on the system. The vmcore is harvested and the system reboots. I
>> haven't reproduced it on other systems yet, but without the patchset I
>> don't see the io page faults during the kdump.
>>
>> Regards,
>> Jerry
> 
> I just hit an issue on a separate intel based system (kdump iommu=nopt),
> where it panics in during intel_iommu_attach_device, in is_aux_domain,
> due to device_domain_info being DEFER_DEVICE_DOMAIN_INFO. That doesn't
> get set to a valid address until the domain_add_dev_info call.
> 
> Is it as simple as the following?

I guess you won't hit this issue if you use iommu/next branch of Joerg's
tree. We've changed to use a generic helper to retrieve the valid per
device iommu data or NULL (if there's no).

Best regards,
baolu

> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 29d3940847d3..f1bbeed46a4c 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5053,8 +5053,8 @@ is_aux_domain(struct device *dev, struct 
> iommu_domain *domain)
>   {
>          struct device_domain_info *info = dev->archdata.iommu;
> 
> -       return info && info->auxd_enabled &&
> -                       domain->type == IOMMU_DOMAIN_UNMANAGED;
> +       return info && info != DEFER_DEVICE_DOMAIN_INFO &&
> +               info->auxd_enabled && domain->type == 
> IOMMU_DOMAIN_UNMANAGED;
>   }
> 
>   static void auxiliary_link_device(struct dmar_domain *domain,
> 
> 
> Regards,
> Jerry
