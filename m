From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 31/34] iommu/exynos: Create iommu_device in struct
 exynos_iommu_owner
Date: Wed, 8 Apr 2020 16:23:05 +0200
Message-ID: <f59b0bb3-8c08-9cc9-bb1a-e69b7b226f60@samsung.com>
References: <20200407183742.4344-1-joro@8bytes.org>
        <CGME20200407184501eucas1p25407bc96e4345df406cf6ba061ae6a82@eucas1p2.samsung.com>
        <20200407183742.4344-32-joro@8bytes.org>
        <449e7f16-e719-9617-ec92-63b82c0bc33f@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <449e7f16-e719-9617-ec92-63b82c0bc33f-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi again,

On 08.04.2020 14:23, Marek Szyprowski wrote:
> Hi Joerg,
>
> On 07.04.2020 20:37, Joerg Roedel wrote:
>> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>>
>> The 'struct exynos_iommu_owner' is an umbrella for multiple SYSMMU
>> instances attached to one master. As such all these instances are
>> handled the same, they are all configured with the same iommu_domain,
>> for example.
>>
>> The IOMMU core code expects each device to have only one IOMMU
>> attached, so create the IOMMU-device for the umbrella instead of each
>> hardware SYSMMU.
>>
>> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>> ---
>>   drivers/iommu/exynos-iommu.c | 96 +++++++++++++++++++++++++++---------
>>   1 file changed, 73 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index 186ff5cc975c..86ecccbf0438 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -235,6 +235,8 @@ struct exynos_iommu_owner {
>>       struct list_head controllers;    /* list of 
>> sysmmu_drvdata.owner_node */
>>       struct iommu_domain *domain;    /* domain this device is 
>> attached */
>>       struct mutex rpm_lock;        /* for runtime pm of all sysmmus */
>> +
>> +    struct iommu_device iommu;    /* IOMMU core handle */
>>   };
>>     /*
>> @@ -274,8 +276,6 @@ struct sysmmu_drvdata {
>>       struct list_head owner_node;    /* node for owner controllers 
>> list */
>>       phys_addr_t pgtable;        /* assigned page table structure */
>>       unsigned int version;        /* our version */
>> -
>> -    struct iommu_device iommu;    /* IOMMU core handle */
>>   };
>>     static struct exynos_iommu_domain *to_exynos_domain(struct 
>> iommu_domain *dom)
>> @@ -625,18 +625,6 @@ static int exynos_sysmmu_probe(struct 
>> platform_device *pdev)
>>       data->sysmmu = dev;
>>       spin_lock_init(&data->lock);
>>   -    ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
>> -                     dev_name(data->sysmmu));
>> -    if (ret)
>> -        return ret;
>> -
>> -    iommu_device_set_ops(&data->iommu, &exynos_iommu_ops);
>> -    iommu_device_set_fwnode(&data->iommu, &dev->of_node->fwnode);
>
> The iommu_device_set_fwnode() call is lost during this conversion, 
> what breaks driver operation. Most of the above IOMMU fw calls you 
> have moved to xlate function. I've checked briefly but it looks that 
> there is a chicken-egg problem here. The owner structure is allocated 
> and initialized from of_xlate(), which won't be called without linking 
> the problem iommu structure with the fwnode first, what might be done 
> only in sysmmu_probe(). I will check how to handle this in a different 
> way.

I've played with this a bit and it looks that won't be easy to make it 
working on ARM 32bit.

I need a place to initialize properly all the structures for the given 
master (IOMMU client device, the one which performs DMA operations).

I tried to move all the initialization from xlate() to device_probe(), 
but such approach doesn't work.

On ARM32bit exynos_iommu_device_probe() is called by the device core and 
IOMMU framework very early, before the Exynos SYSMMU platform devices 
(controllers) are probed yet. Even iommu class is not yet initialized 
that time, so returning anything successful from it causes following 
NULL ptr dereference:

Unable to handle kernel NULL pointer dereference at virtual address 0000004c
...

(__iommu_probe_device) from [<c055b334>] (iommu_probe_device+0x18/0x114)
(iommu_probe_device) from [<c055b4ac>] (iommu_bus_notifier+0x7c/0x94)
(iommu_bus_notifier) from [<c014e8ec>] (notifier_call_chain+0x44/0x84)
(notifier_call_chain) from [<c014e9ec>] 
(__blocking_notifier_call_chain+0x48/0x60)
(__blocking_notifier_call_chain) from [<c014ea1c>] 
(blocking_notifier_call_chain+0x18/0x20)
(blocking_notifier_call_chain) from [<c05c8d1c>] (device_add+0x3e8/0x704)
(device_add) from [<c07bafc4>] (of_platform_device_create_pdata+0x90/0xc4)
(of_platform_device_create_pdata) from [<c07bb138>] 
(of_platform_bus_create+0x134/0x48c)
(of_platform_bus_create) from [<c07bb1a4>] 
(of_platform_bus_create+0x1a0/0x48c)
(of_platform_bus_create) from [<c07bb63c>] (of_platform_populate+0x84/0x114)
(of_platform_populate) from [<c1125e9c>] 
(of_platform_default_populate_init+0x90/0xac)
(of_platform_default_populate_init) from [<c010326c>] 
(do_one_initcall+0x80/0x42c)
(do_one_initcall) from [<c1101074>] (kernel_init_freeable+0x15c/0x208)
(kernel_init_freeable) from [<c0afdde0>] (kernel_init+0x8/0x118)
(kernel_init) from [<c01010b4>] (ret_from_fork+0x14/0x20)

I've tried returning ERR_PTR(-EPROBE_DEFER) from device_probe(), but I 
doesn't work there. Some more changes in the framework are needed...

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
