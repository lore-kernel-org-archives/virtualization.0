Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FC835884
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 12:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184292; cv=none; b=MzxvKf39DJFrYFewKDQ/eo8HNuj2NlsnoNmgIopyT8X+3IKozurHQyt+ff2xhPAN7WL5E9ez0HWuF+FZ/KpE5/MJoLAvQq0jxuaiBG37dO+cx/zUSULfhzoRA//n9L/teeJhq+e89QIkzb01w/u92WRVjAbOr6Ic+pcVi47d5q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184292; c=relaxed/simple;
	bh=8sTLlfRLG1bLpm/xwyAPsioSxNa/NVfF9kum8TH3Cnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dR7IBQdWx9kdIPCYXmYE66qqO6E5oDCSk3z+P4H1xtWaF/Ya5QQGASt2bTGe14wuLWVZpmQvxnJszX5H6zPcgoLuVGr/EqJWDw9CBuXHO6cdTNHuSEFkATj5P8ye/fViaSvXkjzQG2ROtbNvqCq2tZiuI9S0jg8Ypa1jro162+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dSTgrFVZ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dSTgrFVZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E5C26824CE
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 12:04:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E5C26824CE
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=dSTgrFVZ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29K4MjgE8r93
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 12:04:50 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1881982325
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 12:04:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1881982325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706184288;
	bh=8sTLlfRLG1bLpm/xwyAPsioSxNa/NVfF9kum8TH3Cnk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dSTgrFVZ9Mgn6xrnSplLE02RSuySI6ta/n6N5lSsDjUqu8PCR05/4WwDn+SSX54PR
	 ZJgpm5bqzcKILySJzL62P7ZSqdsqvvifoqfRTdV3cUWNLuGvmYwnE1EAzy7yZiI8DM
	 P7uJrhzg7fE2E/TqqrvleB4TY2Dz/8TWYPBEsqnmWvfsWAO/3utjsWpcBR3absxtp1
	 bEJmcRs8tKkYfGmdjm/OQtplxKA8pmSpfcf0g4KuzZW3cMmoP5Q00Vq0GuG73vzYwV
	 pSHir30+r5Pzo1xFslRlF/4dwsL1SjaUOmkSd5pOutZiWPIOw8qPeCxyf9Pn9maKki
	 OpAB+HS6B7Kvw==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F26E637820AF;
	Thu, 25 Jan 2024 12:04:44 +0000 (UTC)
Message-ID: <1cf2b45f-d41b-4b2c-80c8-0b78203f4467@collabora.com>
Date: Thu, 25 Jan 2024 15:04:41 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 30/30] drm/panfrost: Switch to generic memory shrinker
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-31-dmitry.osipenko@collabora.com>
 <20240125104932.478fa5bd@collabora.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240125104932.478fa5bd@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 12:49, Boris Brezillon wrote:
> On Fri,  5 Jan 2024 21:46:24 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
>> @@ -328,6 +328,7 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>>  	struct panfrost_device *pfdev = to_panfrost_device(obj->dev);
>>  	struct sg_table *sgt;
>>  	int prot = IOMMU_READ | IOMMU_WRITE;
>> +	int ret = 0;
>>  
>>  	if (WARN_ON(mapping->active))
>>  		return 0;
>> @@ -335,15 +336,32 @@ int panfrost_mmu_map(struct panfrost_gem_mapping *mapping)
>>  	if (bo->noexec)
>>  		prot |= IOMMU_NOEXEC;
>>  
>> +	if (!obj->import_attach) {
>> +		/*
>> +		 * Don't allow shrinker to move pages while pages are mapped.
>> +		 * It's fine to move pages afterwards because shrinker will
>> +		 * take care of unmapping pages during eviction.
>> +		 */
> 
> That's not exactly what this shmem_pin() is about, is it? I think it's
> here to meet the drm_gem_shmem_get_pages_sgt() rule stating that pages
> must be pinned while the sgt returned by drm_gem_shmem_get_pages_sgt()
> is manipulated. You actually unpin the GEM just after the mmu_map_sg()
> call, which means pages could very well be reclaimed while the MMU
> still has a mapping referencing those physical pages. And that's fine,
> because what's supposed to protect against that is the fence we
> register to the GEM resv at job submission time.

The comment indeed needs to be improved, thanks.

s/are mapped/in process of mapping creation/

-- 
Best regards,
Dmitry

