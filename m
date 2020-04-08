From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH 31/34] iommu/exynos: Create iommu_device in struct
 exynos_iommu_owner
Date: Wed, 8 Apr 2020 14:23:16 +0200
Message-ID: <449e7f16-e719-9617-ec92-63b82c0bc33f@samsung.com>
References: <20200407183742.4344-1-joro@8bytes.org>
        <CGME20200407184501eucas1p25407bc96e4345df406cf6ba061ae6a82@eucas1p2.samsung.com>
        <20200407183742.4344-32-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200407183742.4344-32-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi Joerg,

On 07.04.2020 20:37, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>
> The 'struct exynos_iommu_owner' is an umbrella for multiple SYSMMU
> instances attached to one master. As such all these instances are
> handled the same, they are all configured with the same iommu_domain,
> for example.
>
> The IOMMU core code expects each device to have only one IOMMU
> attached, so create the IOMMU-device for the umbrella instead of each
> hardware SYSMMU.
>
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>   drivers/iommu/exynos-iommu.c | 96 +++++++++++++++++++++++++++---------
>   1 file changed, 73 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 186ff5cc975c..86ecccbf0438 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -235,6 +235,8 @@ struct exynos_iommu_owner {
>   	struct list_head controllers;	/* list of sysmmu_drvdata.owner_node */
>   	struct iommu_domain *domain;	/* domain this device is attached */
>   	struct mutex rpm_lock;		/* for runtime pm of all sysmmus */
> +
> +	struct iommu_device iommu;	/* IOMMU core handle */
>   };
>   
>   /*
> @@ -274,8 +276,6 @@ struct sysmmu_drvdata {
>   	struct list_head owner_node;	/* node for owner controllers list */
>   	phys_addr_t pgtable;		/* assigned page table structure */
>   	unsigned int version;		/* our version */
> -
> -	struct iommu_device iommu;	/* IOMMU core handle */
>   };
>   
>   static struct exynos_iommu_domain *to_exynos_domain(struct iommu_domain *dom)
> @@ -625,18 +625,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>   	data->sysmmu = dev;
>   	spin_lock_init(&data->lock);
>   
> -	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
> -				     dev_name(data->sysmmu));
> -	if (ret)
> -		return ret;
> -
> -	iommu_device_set_ops(&data->iommu, &exynos_iommu_ops);
> -	iommu_device_set_fwnode(&data->iommu, &dev->of_node->fwnode);

The iommu_device_set_fwnode() call is lost during this conversion, what breaks driver operation. Most of the above IOMMU fw calls you have moved to xlate function. I've checked briefly but it looks that there is a chicken-egg problem here. The owner structure is allocated and initialized from of_xlate(), which won't be called without linking the problem iommu structure with the fwnode first, what might be done only in sysmmu_probe(). I will check how to handle this in a different way.

> -
> -	ret = iommu_device_register(&data->iommu);
> -	if (ret)
> -		return ret;
> -
>   	platform_set_drvdata(pdev, data);
>   
>   	__sysmmu_get_version(data);
> @@ -1261,6 +1249,8 @@ static int exynos_iommu_add_device(struct device *dev)
>   	}
>   	iommu_group_put(group);
>   
> +	iommu_device_link(&owner->iommu, dev);
> +
>   	return 0;
>   }
>   
> @@ -1282,18 +1272,82 @@ static void exynos_iommu_remove_device(struct device *dev)
>   			iommu_group_put(group);
>   		}
>   	}
> +	iommu_device_unlink(&owner->iommu, dev);
>   	iommu_group_remove_device(dev);
>   
>   	list_for_each_entry(data, &owner->controllers, owner_node)
>   		device_link_del(data->link);
>   }
>   
> +static int exynos_iommu_device_init(struct exynos_iommu_owner *owner)
> +{
> +	static u32 counter = 0;
> +	int ret;
> +
> +	/*
> +	 * Create a virtual IOMMU device. In reality it is an umbrella for a
> +	 * number of SYSMMU platform devices, but that also means that any
> +	 * master can have more than one real IOMMU device. This drivers handles
> +	 * all the real devices for one master synchronously, so they appear as
> +	 * one anyway.
> +	 */
> +	ret = iommu_device_sysfs_add(&owner->iommu, NULL, NULL,
> +				     "sysmmu-owner-%d", counter++);
> +	if (ret)
> +		return ret;
> +
> +	iommu_device_set_ops(&owner->iommu, &exynos_iommu_ops);
> +
> +	return 0;
> +}
> +
> +static void exynos_iommu_device_remove(struct exynos_iommu_owner *owner)
> +{
> +	iommu_device_set_ops(&owner->iommu, NULL);
> +	iommu_device_sysfs_remove(&owner->iommu);
> +}
> +
> +static int exynos_owner_init(struct device *dev)
> +{
> +	struct exynos_iommu_owner *owner = dev->archdata.iommu;
> +	int ret;
> +
> +	if (owner)
> +		return 0;
> +
> +	owner = kzalloc(sizeof(*owner), GFP_KERNEL);
> +	if (!owner)
> +		return -ENOMEM;
> +
> +	ret = exynos_iommu_device_init(owner);
> +	if (ret)
> +		goto out_free_owner;
> +
> +	ret = iommu_device_register(&owner->iommu);
> +	if (ret)
> +		goto out_remove_iommu_device;
> +
> +	INIT_LIST_HEAD(&owner->controllers);
> +	mutex_init(&owner->rpm_lock);
> +	dev->archdata.iommu = owner;
> +
> +	return 0;
> +
> +out_remove_iommu_device:
> +	exynos_iommu_device_remove(owner);
> +out_free_owner:
> +	kfree(owner);
> +
> +	return ret;
> +}
> +
>   static int exynos_iommu_of_xlate(struct device *dev,
>   				 struct of_phandle_args *spec)
>   {
> -	struct exynos_iommu_owner *owner = dev->archdata.iommu;
>   	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
>   	struct sysmmu_drvdata *data, *entry;
> +	struct exynos_iommu_owner *owner;
> +	int ret;
>   
>   	if (!sysmmu)
>   		return -ENODEV;
> @@ -1302,15 +1356,11 @@ static int exynos_iommu_of_xlate(struct device *dev,
>   	if (!data)
>   		return -ENODEV;
>   
> -	if (!owner) {
> -		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
> -		if (!owner)
> -			return -ENOMEM;
> +	ret = exynos_owner_init(dev);
> +	if (ret)
> +		return ret;
>   
> -		INIT_LIST_HEAD(&owner->controllers);
> -		mutex_init(&owner->rpm_lock);
> -		dev->archdata.iommu = owner;
> -	}
> +	owner = dev->archdata.iommu;
>   
>   	list_for_each_entry(entry, &owner->controllers, owner_node)
>   		if (entry == data)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
