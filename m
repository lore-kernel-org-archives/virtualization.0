Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F6AC2BA4C
	for <virtualization@archiver.kernel.org>; Wed, 26 Jan 2022 17:00:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7873041650;
	Wed, 26 Jan 2022 17:00:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OSf4L8qtiIuz; Wed, 26 Jan 2022 17:00:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C7C7A41663;
	Wed, 26 Jan 2022 17:00:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45E60C007B;
	Wed, 26 Jan 2022 17:00:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81BD2C002D;
 Wed, 26 Jan 2022 17:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 703EC83E40;
 Wed, 26 Jan 2022 17:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WZFjY-Tv9fq3; Wed, 26 Jan 2022 17:00:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2519E83E31;
 Wed, 26 Jan 2022 17:00:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F9ACD6E;
 Wed, 26 Jan 2022 09:00:30 -0800 (PST)
Received: from [10.57.68.47] (unknown [10.57.68.47])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F033F7D8;
 Wed, 26 Jan 2022 09:00:28 -0800 (PST)
Message-ID: <ee4593b8-cdf6-935a-0eaf-48a8bfeae912@arm.com>
Date: Wed, 26 Jan 2022 17:00:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] iommu/iova: Separate out rcache init
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org,
 mst@redhat.com, jasowang@redhat.com
References: <1643205319-51669-1-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1643205319-51669-1-git-send-email-john.garry@huawei.com>
Cc: xieyongji@bytedance.com, iommu@lists.linux-foundation.org,
 linuxarm@huawei.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On 2022-01-26 13:55, John Garry wrote:
> Currently the rcache structures are allocated for all IOVA domains, even if
> they do not use "fast" alloc+free interface. This is wasteful of memory.
> 
> In addition, fails in init_iova_rcaches() are not handled safely, which is
> less than ideal.
> 
> Make "fast" users call a separate rcache init explicitly, which includes
> error checking.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Mangled patch? (no "---" separator here)

Overall this looks great, just a few comments further down...

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 3a46f2cc9e5d..dd066d990809 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -525,6 +525,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>   	unsigned long order, base_pfn;
>   	struct iova_domain *iovad;
> +	int ret;
>   
>   	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
>   		return -EINVAL;
> @@ -559,6 +560,9 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	}
>   
>   	init_iova_domain(iovad, 1UL << order, base_pfn);
> +	ret = iova_domain_init_rcaches(iovad);
> +	if (ret)
> +		return ret;
>   
>   	/* If the FQ fails we can simply fall back to strict mode */
>   	if (domain->type == IOMMU_DOMAIN_DMA_FQ && iommu_dma_init_fq(domain))
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b28c9435b898..d3adc6ea5710 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -15,13 +15,14 @@
>   /* The anchor node sits above the top of the usable address space */
>   #define IOVA_ANCHOR	~0UL
>   
> +#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
> +
>   static bool iova_rcache_insert(struct iova_domain *iovad,
>   			       unsigned long pfn,
>   			       unsigned long size);
>   static unsigned long iova_rcache_get(struct iova_domain *iovad,
>   				     unsigned long size,
>   				     unsigned long limit_pfn);
> -static void init_iova_rcaches(struct iova_domain *iovad);
>   static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
>   static void free_iova_rcaches(struct iova_domain *iovad);
>   
> @@ -64,8 +65,6 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>   	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
>   	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
>   	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
> -	cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD, &iovad->cpuhp_dead);
> -	init_iova_rcaches(iovad);
>   }
>   EXPORT_SYMBOL_GPL(init_iova_domain);
>   
> @@ -497,9 +496,9 @@ void put_iova_domain(struct iova_domain *iovad)
>   {
>   	struct iova *iova, *tmp;
>   
> -	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> -					    &iovad->cpuhp_dead);
> -	free_iova_rcaches(iovad);
> +	if (iovad->rcaches)
> +		iova_domain_free_rcaches(iovad);
> +
>   	rbtree_postorder_for_each_entry_safe(iova, tmp, &iovad->rbroot, node)
>   		free_iova_mem(iova);
>   }
> @@ -608,6 +607,7 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>    */
>   
>   #define IOVA_MAG_SIZE 128
> +#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
>   
>   struct iova_magazine {
>   	unsigned long size;
> @@ -620,6 +620,13 @@ struct iova_cpu_rcache {
>   	struct iova_magazine *prev;
>   };
>   
> +struct iova_rcache {
> +	spinlock_t lock;
> +	unsigned long depot_size;
> +	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
> +	struct iova_cpu_rcache __percpu *cpu_rcaches;
> +};
> +
>   static struct iova_magazine *iova_magazine_alloc(gfp_t flags)
>   {
>   	return kzalloc(sizeof(struct iova_magazine), flags);
> @@ -693,28 +700,62 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>   	mag->pfns[mag->size++] = pfn;
>   }
>   
> -static void init_iova_rcaches(struct iova_domain *iovad)
> +int iova_domain_init_rcaches(struct iova_domain *iovad)
>   {
> -	struct iova_cpu_rcache *cpu_rcache;
> -	struct iova_rcache *rcache;
>   	unsigned int cpu;
> -	int i;
> +	int i, ret;
> +
> +	iovad->rcaches = kcalloc(IOVA_RANGE_CACHE_MAX_SIZE,
> +				 sizeof(struct iova_rcache),
> +				 GFP_KERNEL);
> +	if (!iovad->rcaches)
> +		return -ENOMEM;
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +		struct iova_cpu_rcache *cpu_rcache;
> +		struct iova_rcache *rcache;
> +
>   		rcache = &iovad->rcaches[i];
>   		spin_lock_init(&rcache->lock);
>   		rcache->depot_size = 0;
> -		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache), cache_line_size());
> -		if (WARN_ON(!rcache->cpu_rcaches))
> -			continue;
> +		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
> +						     cache_line_size());
> +		if (!rcache->cpu_rcaches) {
> +			ret = -ENOMEM;
> +			goto out_err;
> +		}
>   		for_each_possible_cpu(cpu) {
>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
> +
>   			spin_lock_init(&cpu_rcache->lock);
>   			cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
>   			cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
> +			if (!cpu_rcache->loaded || !cpu_rcache->prev) {
> +				ret = -ENOMEM;
> +				goto out_err;
> +			}
>   		}
>   	}
> +
> +	ret = cpuhp_state_add_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> +					       &iovad->cpuhp_dead);
> +	if (ret)
> +		goto out_err;
> +	return 0;
> +
> +out_err:
> +	free_iova_rcaches(iovad);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iova_domain_init_rcaches);
> +
> +void iova_domain_free_rcaches(struct iova_domain *iovad)
> +{
> +	cpuhp_state_remove_instance_nocalls(CPUHP_IOMMU_IOVA_DEAD,
> +					    &iovad->cpuhp_dead);
> +	free_iova_rcaches(iovad);
>   }
> +EXPORT_SYMBOL_GPL(iova_domain_free_rcaches);

I think we should continue to expect external callers to clean up with 
put_iova_domain(). If they aren't doing that already they have a bug 
(albeit minor), and we don't want to give the impression that it's OK to 
free the caches at any point *other* than tearing down the whole 
iova_domain, since the implementation really wouldn't expect that.

>   /*
>    * Try inserting IOVA range starting with 'iova_pfn' into 'rcache', and
> @@ -831,7 +872,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
>   {
>   	unsigned int log_size = order_base_2(size);
>   
> -	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
> +	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE || !iovad->rcaches)
>   		return 0;
>   
>   	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
> @@ -849,6 +890,8 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   
>   	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>   		rcache = &iovad->rcaches[i];
> +		if (!rcache->cpu_rcaches)
> +			break;
>   		for_each_possible_cpu(cpu) {
>   			cpu_rcache = per_cpu_ptr(rcache->cpu_rcaches, cpu);
>   			iova_magazine_free(cpu_rcache->loaded);
> @@ -858,6 +901,9 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   		for (j = 0; j < rcache->depot_size; ++j)
>   			iova_magazine_free(rcache->depot[j]);
>   	}
> +
> +	kfree(iovad->rcaches);
> +	iovad->rcaches = NULL;
>   }
>   
>   /*
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 2b1143f11d8f..87ec9f8015f1 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -480,6 +480,7 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
>   	struct file *file;
>   	struct vduse_bounce_map *map;
>   	unsigned long pfn, bounce_pfns;
> +	int ret;
>   
>   	bounce_pfns = PAGE_ALIGN(bounce_size) >> PAGE_SHIFT;
>   	if (iova_limit <= bounce_size)
> @@ -513,10 +514,20 @@ vduse_domain_create(unsigned long iova_limit, size_t bounce_size)
>   	spin_lock_init(&domain->iotlb_lock);
>   	init_iova_domain(&domain->stream_iovad,
>   			PAGE_SIZE, IOVA_START_PFN);
> +	ret = iova_domain_init_rcaches(&domain->stream_iovad);
> +	if (ret)
> +		goto err_iovad_stream;
>   	init_iova_domain(&domain->consistent_iovad,
>   			PAGE_SIZE, bounce_pfns);
> +	ret = iova_domain_init_rcaches(&domain->consistent_iovad);
> +	if (ret)
> +		goto err_iovad_consistent;
>   
>   	return domain;
> +err_iovad_consistent:
> +	iova_domain_free_rcaches(&domain->stream_iovad);
> +err_iovad_stream:
> +	fput(file);
>   err_file:
>   	vfree(domain->bounce_maps);
>   err_map:
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index cea79cb9f26c..f91679680ee4 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -21,18 +21,8 @@ struct iova {
>   	unsigned long	pfn_lo; /* Lowest allocated pfn */
>   };
>   
> -struct iova_magazine;
> -struct iova_cpu_rcache;
>   
> -#define IOVA_RANGE_CACHE_MAX_SIZE 6	/* log of max cached IOVA range size (in pages) */
> -#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
> -
> -struct iova_rcache {
> -	spinlock_t lock;
> -	unsigned long depot_size;
> -	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
> -	struct iova_cpu_rcache __percpu *cpu_rcaches;
> -};
> +struct iova_rcache;
>   
>   /* holds all the iova translations for a domain */
>   struct iova_domain {
> @@ -46,7 +36,7 @@ struct iova_domain {
>   	unsigned long	max32_alloc_size; /* Size of last failed allocation */
>   	struct iova	anchor;		/* rbtree lookup anchor */
>   
> -	struct iova_rcache rcaches[IOVA_RANGE_CACHE_MAX_SIZE];	/* IOVA range caches */
> +	struct iova_rcache	*rcaches;
>   	struct hlist_node	cpuhp_dead;
>   };
>   
> @@ -102,6 +92,8 @@ struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
>   	unsigned long pfn_hi);
>   void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>   	unsigned long start_pfn);
> +int iova_domain_init_rcaches(struct iova_domain *iovad);
> +void iova_domain_free_rcaches(struct iova_domain *iovad);

As above, I vote for just forward-declaring the free routine in iova.c 
and keeping it entirely private.

>   struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn);
>   void put_iova_domain(struct iova_domain *iovad);
>   #else
> @@ -157,6 +149,15 @@ static inline void init_iova_domain(struct iova_domain *iovad,
>   {
>   }
>   
> +static inline int iova_domain_init_rcaches(struct iova_domain *iovad)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void iova_domain_free_rcaches(struct iova_domain *iovad)
> +{
> +}
> +

I'd be inclined not to add stubs at all - I think it's a reasonable 
assumption that anyone involved enough to care about rcaches has a hard 
dependency on IOMMU_IOVA already. It's certainly the case today, and I'd 
hardly want to encourage more users anyway.

Cheers,
Robin.

>   static inline struct iova *find_iova(struct iova_domain *iovad,
>   				     unsigned long pfn)
>   {
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
