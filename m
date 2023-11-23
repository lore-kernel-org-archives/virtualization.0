Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5D33CD4
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ffSoGnfe"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 027EA82034
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 14:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 027EA82034
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ffSoGnfe
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id feHNcdi11zU9
	for <virtualization@lists.linux-foundation.org>;
	Thu, 23 Nov 2023 14:34:04 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B66A08202B
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 14:34:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B66A08202B
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id C26CC66073C1;
	Thu, 23 Nov 2023 14:34:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700750041;
	bh=0htDXOoHws9YajSN0MLwoGGtFzWUK1XbFgD/bJEmUqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ffSoGnfeRA1ZwtUrV0MFluPgDHqyg9okeZML6jRLjZVQ6HPo+Ux0C1si80ux6G/ky
	 gFM4Xq5b+ttu1ugqkfRAR2zGXC5qNvVGgHc9ZUINkl3C4ZmABGcebKg8Y1jgBuF4Ro
	 BL/airH4lA0AC7oRbltwhHpTXKU7CQcW3D3+kdWpDL6pRCKcEDQFjVAACz/A1LtbSE
	 NVGLjMYBG4jFpHf4KBQzVkaDE3/Vc0HRax1UXp/p0gDwiw5FMHGWp+KLLwRNWzcWDB
	 bh690EjUAnLWwQ8i5JyZ1OQ5dPDkTNOSkaodbmIMd/lLt0vUTgWX4+iMnpQxHjJq0v
	 R5zNaunLgu8hA==
Date: Thu, 23 Nov 2023 15:33:57 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price
 <steven.price@arm.com>, Emma Anholt <emma@anholt.net>, Melissa Wen
 <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 15/26] drm/panfrost: Explicitly get and put
 drm-shmem pages
Message-ID: <20231123153357.39a79813@collabora.com>
In-Reply-To: <14113ca6-79af-e857-d9ee-b8cf7572abd5@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-16-dmitry.osipenko@collabora.com>
	<20231110115354.356c87f7@collabora.com>
	<26890ba7-5e19-df0c-fce0-26af58e66266@collabora.com>
	<20231123100557.05a49343@collabora.com>
	<14113ca6-79af-e857-d9ee-b8cf7572abd5@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 15:24:32 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 11/23/23 12:05, Boris Brezillon wrote:
> > On Thu, 23 Nov 2023 01:04:56 +0300
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> >   
> >> On 11/10/23 13:53, Boris Brezillon wrote:  
> >>> Hm, there was no drm_gem_shmem_get_pages_sgt() call here, why
> >>> should we add a drm_gem_shmem_get_pages()? What we should do
> >>> instead is add a drm_gem_shmem_get_pages() for each
> >>> drm_gem_shmem_get_pages_sgt() we have in the driver (in
> >>> panfrost_mmu_map()), and add drm_gem_shmem_put_pages() calls
> >>> where they are missing (panfrost_mmu_unmap()).
> >>>     
> >>>> +		if (err)
> >>>> +			goto err_free;
> >>>> +	}
> >>>> +
> >>>>  	return bo;
> >>>> +
> >>>> +err_free:
> >>>> +	drm_gem_shmem_free(&bo->base);
> >>>> +
> >>>> +	return ERR_PTR(err);
> >>>>  }
> >>>>  
> >>>>  struct drm_gem_object *
> >>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> >>>> b/drivers/gpu/drm/panfrost/panfrost_mmu.c index
> >>>> 770dab1942c2..ac145a98377b 100644 ---
> >>>> a/drivers/gpu/drm/panfrost/panfrost_mmu.c +++
> >>>> b/drivers/gpu/drm/panfrost/panfrost_mmu.c @@ -504,7 +504,7 @@
> >>>> static int panfrost_mmu_map_fault_addr(struct panfrost_device
> >>>> *pfdev, int as, if (IS_ERR(pages[i])) { ret = PTR_ERR(pages[i]);
> >>>>  			pages[i] = NULL;
> >>>> -			goto err_pages;
> >>>> +			goto err_unlock;
> >>>>  		}
> >>>>  	}
> >>>>  
> >>>> @@ -512,7 +512,7 @@ static int
> >>>> panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int
> >>>> as, ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
> >>>> NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL); if (ret)
> >>>> -		goto err_pages;
> >>>> +		goto err_unlock;    
> >>> Feels like the panfrost_gem_mapping object should hold a ref on
> >>> the BO pages, not the BO itself, because, ultimately, the user of
> >>> the BO is the GPU. This matches what I was saying about moving
> >>> get/put_pages() to panfrost_mmu_map/unmap(): everytime a
> >>> panfrost_gem_mapping becomes active, to want to take a pages ref,
> >>> every time it becomes inactive, you should release the pages ref.
> >>>    
> >>
> >> The panfrost_mmu_unmap() is also used by shrinker when BO is
> >> purged. I'm unhappy with how icky it all becomes if unmap is made
> >> to put pages.  
> > 
> > Why, that's exactly what's supposed to happen. If you mmu_unmap(),
> > that means you no longer need the pages ref you got.  
> 
> The drm_gem_shmem_purge() frees the pages. If mmu_unmap() frees pages
> too, then it becomes odd for drm_gem_shmem_purge() that it needs to
> free pages that were already freed.

Hm, I didn't consider the mmu_unmap() call in the eviction path.

> 
> >> Previously map() was implicitly allocating pages with get_sgt()
> >> and then pages were implicitly released by drm_gem_shmem_free(). A
> >> non-heap BO is mapped when it's created by Panfrost, hence the
> >> actual lifetime of pages is kept unchanged by this patch.  
> > 
> > But the whole point of making it explicit is to control when pages
> > are needed or not, isn't it. The fact we mmu_map() the BO at open
> > time, and keep it mapped until it's not longer referenced is an
> > implementation choice, and I don't think having pages_put() in
> > mmu_unmap() changes that.  
> 
> Previously, when the last mmu_unmap() was done, the pages were not
> released.
> 
> If you'll make unmap to put pages, then you can't map BO again
> because pages are released by the last put() of unmap.

Well, you could, if panfrost_gem_mapping_get() was not only
returning an existing mapping, but was also creating one when none
exist. But you're right, it messes up with the shmem shrinker and also
changes the way we are doing things now.

> In order to
> keep the old pages allocation logic unchanged, the pages must be
> referenced while BO is alive, not while mapping is alive.

Correct.

> 
> Technically, the code can be changed to put pages on unmap. This
> requires adding special quirk to drm_gem_shmem_purge() and then for
> Panfrost pages should have the same lifetime as BO, hence why bother?

No, we certainly don't want to do that.
