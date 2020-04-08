From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 17/34] iommu/arm-smmu: Store device instead of group
 in arm_smmu_s2cr
Date: Wed, 8 Apr 2020 16:07:33 +0100
Message-ID: <f8b541c2-9271-fc48-dde6-166a2ed6679f@arm.com>
References: <20200407183742.4344-1-joro@8bytes.org>
 <20200407183742.4344-18-joro@8bytes.org>
 <98c10a41-d223-e375-9742-b6471c3dc33c@arm.com>
 <20200408143707.GK3103@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200408143707.GK3103-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-GB
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

On 2020-04-08 3:37 pm, Joerg Roedel wrote:
> Hi Robin,
> 
> thanks for looking into this.
> 
> On Wed, Apr 08, 2020 at 01:09:40PM +0100, Robin Murphy wrote:
>> For a hot-pluggable bus where logical devices may share Stream IDs (like
>> fsl-mc), this could happen:
>>
>>    create device A
>>    iommu_probe_device(A)
>>      iommu_device_group(A) -> alloc group X
>>    create device B
>>    iommu_probe_device(B)
>>      iommu_device_group(A) -> lookup returns group X
>>    ...
>>    iommu_remove_device(A)
>>    delete device A
>>    create device C
>>    iommu_probe_device(C)
>>      iommu_device_group(C) -> use-after-free of A
>>
>> Preserving the logical behaviour here would probably look *something* like
>> the mangled diff below, but I haven't thought it through 100%.
> 
> Yeah, I think you are right. How about just moving the loop which sets
> s2crs[idx].group to arm_smmu_device_group()? In that case I can drop
> this patch and leave the group pointer in place.

Isn't that exactly what I suggested? :)

I don't recall for sure, but knowing me, that bit of group bookkeeping 
is only where it currently is because it cheekily saves iterating the 
IDs a second time. I don't think there's any technical reason.

Robin.
