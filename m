Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1BC5D902
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PoLRwynF"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A7E138135E
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 22:05:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7E138135E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=PoLRwynF
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XDNC1SRRDu97
	for <virtualization@lists.linux-foundation.org>;
	Wed, 22 Nov 2023 22:05:06 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BD95B8135D
	for <virtualization@lists.linux-foundation.org>; Wed, 22 Nov 2023 22:05:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD95B8135D
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 31E596607332;
	Wed, 22 Nov 2023 22:05:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700690702;
	bh=L8JWdmRbv/qGbL8ayeiLeAZrkbkPXFdz4DgESw6b6mY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PoLRwynFFCCpJfEbuu2PfIDTr3NeSI/VBEZmk2geOCk8erfiGRjZQzDXteIWW7X2U
	 RRpdqwk63aslO0l+eOMNNjPQeAlCPXTxb7fM9AHlFal49/0eIyLAaNXPO04JMivZRt
	 O2+7kA8GOTnJvm4QFFmsn2Qk8OeFHzDP2bsbN9FZP+4+GGKpHC9cSTakDFPAfZE3Lx
	 1AX0Jg/gus++k0WwXx5PiZNLhsIKdy4hzHNXiewyvtGRK13mMbGOADhh2wxckGC843
	 1IlFYJFMk0ibNkxSUsfHJrif1TLXH2GR2MPHLRa3zr4U6XQPFlDuz8CsTs4IfT5VxZ
	 UnKN8MHEkF+0g==
Message-ID: <26890ba7-5e19-df0c-fce0-26af58e66266@collabora.com>
Date: Thu, 23 Nov 2023 01:04:56 +0300
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
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231110115354.356c87f7@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/23 13:53, Boris Brezillon wrote:
> Hm, there was no drm_gem_shmem_get_pages_sgt() call here, why should we
> add a drm_gem_shmem_get_pages()? What we should do instead is add a
> drm_gem_shmem_get_pages() for each drm_gem_shmem_get_pages_sgt() we
> have in the driver (in panfrost_mmu_map()), and add
> drm_gem_shmem_put_pages() calls where they are missing
> (panfrost_mmu_unmap()).
> 
>> +		if (err)
>> +			goto err_free;
>> +	}
>> +
>>  	return bo;
>> +
>> +err_free:
>> +	drm_gem_shmem_free(&bo->base);
>> +
>> +	return ERR_PTR(err);
>>  }
>>  
>>  struct drm_gem_object *
>> diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> index 770dab1942c2..ac145a98377b 100644
>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> @@ -504,7 +504,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>>  		if (IS_ERR(pages[i])) {
>>  			ret = PTR_ERR(pages[i]);
>>  			pages[i] = NULL;
>> -			goto err_pages;
>> +			goto err_unlock;
>>  		}
>>  	}
>>  
>> @@ -512,7 +512,7 @@ static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
>>  	ret = sg_alloc_table_from_pages(sgt, pages + page_offset,
>>  					NUM_FAULT_PAGES, 0, SZ_2M, GFP_KERNEL);
>>  	if (ret)
>> -		goto err_pages;
>> +		goto err_unlock;
> Feels like the panfrost_gem_mapping object should hold a ref on the BO
> pages, not the BO itself, because, ultimately, the user of the BO is
> the GPU. This matches what I was saying about moving get/put_pages() to
> panfrost_mmu_map/unmap(): everytime a panfrost_gem_mapping becomes
> active, to want to take a pages ref, every time it becomes inactive,
> you should release the pages ref.

The panfrost_mmu_unmap() is also used by shrinker when BO is purged. I'm
unhappy with how icky it all becomes if unmap is made to put pages.

Previously map() was implicitly allocating pages with get_sgt() and then
pages were implicitly released by drm_gem_shmem_free(). A non-heap BO is
mapped when it's created by Panfrost, hence the actual lifetime of pages
is kept unchanged by this patch. The implicit allocation is turned into
explicit one, i.e. pages are explicitly allocated before BO is mapped.

-- 
Best regards,
Dmitry

