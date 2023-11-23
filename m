Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E73824A07
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fBIewKcI"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD12682056
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 12:24:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD12682056
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fBIewKcI
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wACRFdXBM1Wh
	for <virtualization@lists.linux-foundation.org>;
	Thu, 23 Nov 2023 12:24:41 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 90D8882055
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 12:24:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90D8882055
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B0146601710;
	Thu, 23 Nov 2023 12:24:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700742278;
	bh=8M7OgbZSaIpWXuFVFIaRp2fTZ+ArHXOEMptApVN8sP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fBIewKcIjj7pTwC8CWI+0K7YHnwVm/ZASFAZ9yCOQByK4uLaIkwcEbbzoN0cLfXUl
	 LbIDWE3X6Il9UCtKHQOFOdSoVKeeMMB1Ftlb+enJA2D5pUZ3qRr1BJzqZzp+Yc0ZpL
	 soqBQu21vXXRXi5yEmWoP07R11qTZqz8/b7O1ZAS7aRLz1ZXCR4s+LApnc+o1x1zbB
	 i3Df6i6JzyvU0BW9qg+fcTgiZAeP5iFxoqrZYAI86EXVwz/HouNZzTqqqVJi2Fdqqi
	 FbZeXAilAZyiOeEB+QUSkXerGTCc1KPzFjKYE9AIyF/aQG2qj98YepEbMRCt38h8Jr
	 endofMupZFq3w==
Message-ID: <14113ca6-79af-e857-d9ee-b8cf7572abd5@collabora.com>
Date: Thu, 23 Nov 2023 15:24:32 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v18 15/26] drm/panfrost: Explicitly get and put drm-shmem
 pages
Content-Language: en-US
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-16-dmitry.osipenko@collabora.com>
 <20231110115354.356c87f7@collabora.com>
 <26890ba7-5e19-df0c-fce0-26af58e66266@collabora.com>
 <20231123100557.05a49343@collabora.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231123100557.05a49343@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/23 12:05, Boris Brezillon wrote:
> On Thu, 23 Nov 2023 01:04:56 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> On 11/10/23 13:53, Boris Brezillon wrote:
>>> Hm, there was no drm_gem_shmem_get_pages_sgt() call here, why should we
>>> add a drm_gem_shmem_get_pages()? What we should do instead is add a
>>> drm_gem_shmem_get_pages() for each drm_gem_shmem_get_pages_sgt() we
>>> have in the driver (in panfrost_mmu_map()), and add
>>> drm_gem_shmem_put_pages() calls where they are missing
>>> (panfrost_mmu_unmap()).
>>>   
>>>> +		if (err)
>>>> +			goto err_free;
>>>> +	}
>>>> +
>>>>  	return bo;
>>>> +
>>>> +err_free:
>>>> +	drm_gem_shmem_free(&bo->base);
>>>> +
>>>> +	return ERR_PTR(err);
>>>>  }
>>>>  
>>>>  struct drm_gem_object *
>>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>>>> index 770dab1942c2..ac145a98377b 100644
>>>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>>>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>>>> @@ -504,7 +504,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>>>>  		if (IS_ERR(pages[i])) {
>>>>  			ret = PTR_ERR(pages[i]);
>>>>  			pages[i] = NULL;
>>>> -			goto err_pages;
>>>> +			goto err_unlock;
>>>>  		}
>>>>  	}
>>>>  
>>>> @@ -512,7 +512,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>>>>  	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
>>>>  					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
>>>>  	if (ret)
>>>> -		goto err_pages;
>>>> +		goto err_unlock;  
>>> Feels like the panfrost_gem_mapping object should hold a ref on the BO
>>> pages, not the BO itself, because, ultimately, the user of the BO is
>>> the GPU. This matches what I was saying about moving get/put_pages() to
>>> panfrost_mmu_map/unmap(): everytime a panfrost_gem_mapping becomes
>>> active, to want to take a pages ref, every time it becomes inactive,
>>> you should release the pages ref.  
>>
>> The panfrost_mmu_unmap() is also used by shrinker when BO is purged. I'm
>> unhappy with how icky it all becomes if unmap is made to put pages.
> 
> Why, that's exactly what's supposed to happen. If you mmu_unmap(), that
> means you no longer need the pages ref you got.

The drm_gem_shmem_purge() frees the pages. If mmu_unmap() frees pages too, then it becomes odd for drm_gem_shmem_purge() that it needs to free pages that were already freed.

>> Previously map() was implicitly allocating pages with get_sgt() and then
>> pages were implicitly released by drm_gem_shmem_free(). A non-heap BO is
>> mapped when it's created by Panfrost, hence the actual lifetime of pages
>> is kept unchanged by this patch.
> 
> But the whole point of making it explicit is to control when pages are
> needed or not, isn't it. The fact we mmu_map() the BO at open time, and
> keep it mapped until it's not longer referenced is an implementation
> choice, and I don't think having pages_put() in mmu_unmap() changes
> that.

Previously, when the last mmu_unmap() was done, the pages were not released.

If you'll make unmap to put pages, then you can't map BO again because pages are released by the last put() of unmap. In order to keep the old pages allocation logic unchanged, the pages must be referenced while BO is alive, not while mapping is alive.

Technically, the code can be changed to put pages on unmap. This requires adding special quirk to drm_gem_shmem_purge() and then for Panfrost pages should have the same lifetime as BO, hence why bother?


diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 5ee98b6f0c94..5492610802a1 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -600,7 +600,9 @@ drm_gem_shmem_shrinker_put_pages_locked(struct drm_gem_shmem_object *shmem)
 	if (shmem->evicted)
 		return;
 
-	drm_gem_shmem_free_pages(shmem);
+	if (refcount_read(&shmem->pages_use_count))
+		drm_gem_shmem_free_pages(shmem);
+
 	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
 }
 
@@ -608,7 +610,8 @@ void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem)
 {
 	struct drm_gem_object *obj = &shmem->base;
 
-	drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
+	if (refcount_read(&shmem->pages_use_count))
+		drm_WARN_ON(obj->dev, !drm_gem_shmem_is_purgeable(shmem));
 
 	drm_gem_shmem_shrinker_put_pages_locked(shmem);
 	drm_gem_free_mmap_offset(obj);
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index a6128e32f303..499964c43a7b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -41,9 +41,6 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
 		drm_gem_shmem_put_pages(&bo->base);
 	}
 
-	if (!bo->is_heap && !obj->import_attach)
-		drm_gem_shmem_put_pages(&bo->base);
-
 	drm_gem_shmem_free(&bo->base);
 }
 
@@ -302,12 +299,6 @@ panfrost_gem_create(struct drm_device *dev, size_t size, u32 flags)
 	bo->noexec = !!(flags & PANFROST_BO_NOEXEC);
 	bo->is_heap = !!(flags & PANFROST_BO_HEAP);
 
-	if (!bo->is_heap) {
-		err = drm_gem_shmem_get_pages(shmem);
-		if (err)
-			goto err_free;
-	}
-
 	return bo;
 
 err_free:
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 01cd97011ea5..4ed4ba5df420 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -335,9 +335,13 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 		prot |= IOMMU_NOEXEC;
 
 	if (!obj->import_attach) {
-		ret = drm_gem_shmem_pin(shmem);
+		ret = drm_gem_shmem_get_pages(shmem);
 		if (ret)
 			return ret;
+
+		ret = drm_gem_shmem_pin(shmem);
+		if (ret)
+			goto put_pages;
 	}
 
 	sgt = drm_gem_shmem_get_pages_sgt(shmem);
@@ -349,9 +353,18 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
 	mmu_map_sg(pfdev, mapping->mmu, mapping->mmnode.start << PAGE_SHIFT,
 		   prot, sgt);
 	mapping->active = true;
+
+	if (!obj->import_attach)
+		drm_gem_shmem_unpin(shmem);
+
+	return 0;
+
 unpin:
 	if (!obj->import_attach)
 		drm_gem_shmem_unpin(shmem);
+put_pages:
+	if (!obj->import_attach)
+		drm_gem_shmem_put_pages(shmem);
 
 	return ret;
 }
@@ -360,6 +373,7 @@ void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)
 {
 	struct panfrost_gem_object *bo = mapping->obj;
 	struct drm_gem_object *obj = &bo->base.base;
+	struct drm_gem_shmem_object *shmem = &bo->base;
 	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
 	struct io_pgtable_ops *ops = mapping->mmu->pgtbl_ops;
 	u64 iova = mapping->mmnode.start << PAGE_SHIFT;
@@ -389,6 +403,9 @@ void panfrost_mmu_unmap(struct panfrost_gem_mapping *mapping)
 	panfrost_mmu_flush_range(pfdev, mapping->mmu,
 				 mapping->mmnode.start << PAGE_SHIFT, len);
 	mapping->active = false;
+
+	if (!bo->is_heap && !obj->import_attach)
+		drm_gem_shmem_put_pages_locked(shmem);
 }
 
 static void mmu_tlb_inv_context_s1(void *cookie)


-- 
Best regards,
Dmitry

