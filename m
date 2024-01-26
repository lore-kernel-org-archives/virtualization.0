Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462E9208C0
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 18:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292758; cv=none; b=S++IzGiqjeyp0mbk1ekOpAA469g4/aZAjSmiWl+c/8oi9h/tD3xmgti+6AWZbAcsdhhkjOHsSoqtjazIZ0HaOBJfr5+LHpobkTsI56zfXYUT+syItrXN/MfTcRL94COgTfwYiHLYrjCQRNx1h5toh2CBUCNofNC73WLuDxwYJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292758; c=relaxed/simple;
	bh=JDNIvZuMGsH6s984qiL/y1FXodR70awLtoCBhq6levQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgBbyyZe9qyVJIocTsYgaeuKDPtXTf2Zl0LLW0n12gljUsmQBMz1B61Wv0Kr39Ju/65TKrHkqrdpJTAIPIdFcqQFmf/x0HJOrJlBivCGBKkMh6OuXcv9cB0zXapk0UkzWu3U1EAnKxyzH3hTcLaiW4V9/48EpVIXQ4tJUfvCUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=z2Mcdipo; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="z2Mcdipo"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ACF2F84383
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 18:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ACF2F84383
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=z2Mcdipo
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MSWZw8weCgez
	for <virtualization@lists.linux-foundation.org>;
	Fri, 26 Jan 2024 18:12:35 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 80A4184382
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 18:12:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 80A4184382
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706292752;
	bh=JDNIvZuMGsH6s984qiL/y1FXodR70awLtoCBhq6levQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=z2Mcdipo1S1x+3LnuallCP+ps+hfIolUneIOMhEuL0j5VKCpnQeAAe8SHcmwZQIqC
	 TIbPXqcZorydPCbzKAdc62baRjreH8vAXWA+6K4nZw132svW/vsZWqOxBj6+dJ4lsP
	 /VNcDqhT8EDuYSEW6LcrYPH6yh3fNXzpvS8oNeOiU+MhdyNGRu+9AY51izH5Z0Zekc
	 BqmHfGEpSP7iWDlhbA636AVY3RKpsCeuTZ4hQdUFhbenRh+sLaQ0xNv5/o6IwotJIk
	 LO5JiC6EQZ49jFoY87NDuVKVoCMjnMmTJlnpfzmhJXKV/TNuWx5nCIWV315YbXTAoo
	 86XAstgCeIBXQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E055237813DA;
	Fri, 26 Jan 2024 18:12:31 +0000 (UTC)
Date: Fri, 26 Jan 2024 19:12:30 +0100
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
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
Message-ID: <20240126191230.0ee6f99f@collabora.com>
In-Reply-To: <fab38fed-635c-4dbe-aa13-dcdf8f267988@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-23-dmitry.osipenko@collabora.com>
	<20240125111946.797a1e1e@collabora.com>
	<f4870543-e7f8-4ee6-924a-68ec7c25b293@collabora.com>
	<20240126105537.67b1613e@collabora.com>
	<fab38fed-635c-4dbe-aa13-dcdf8f267988@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jan 2024 19:27:49 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 1/26/24 12:55, Boris Brezillon wrote:
> > On Fri, 26 Jan 2024 00:56:47 +0300
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> >   
> >> On 1/25/24 13:19, Boris Brezillon wrote:  
> >>> On Fri,  5 Jan 2024 21:46:16 +0300
> >>> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> >>>     
> >>>> +static bool drm_gem_shmem_is_evictable(struct drm_gem_shmem_object *shmem)
> >>>> +{
> >>>> +	return (shmem->madv >= 0) && shmem->base.funcs->evict &&
> >>>> +		refcount_read(&shmem->pages_use_count) &&
> >>>> +		!refcount_read(&shmem->pages_pin_count) &&
> >>>> +		!shmem->base.dma_buf && !shmem->base.import_attach &&
> >>>> +		!shmem->evicted;    
> >>>
> >>> Are we missing
> >>>
> >>>                 && dma_resv_test_signaled(shmem->base.resv,
> >>> 					  DMA_RESV_USAGE_BOOKKEEP)
> >>>
> >>> to make sure the GPU is done using the BO?
> >>> The same applies to drm_gem_shmem_is_purgeable() BTW.
> >>>
> >>> If you don't want to do this test here, we need a way to let drivers
> >>> provide a custom is_{evictable,purgeable}() test.
> >>>
> >>> I guess we should also expose drm_gem_shmem_shrinker_update_lru_locked()
> >>> to let drivers move the GEMs that were used most recently (those
> >>> referenced by a GPU job) at the end of the evictable LRU.    
> >>
> >> We have the signaled-check in the common drm_gem_evict() helper:
> >>
> >> https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/gpu/drm/drm_gem.c#L1496  
> > 
> > Ah, indeed. I'll need DMA_RESV_USAGE_BOOKKEEP instead of
> > DMA_RESV_USAGE_READ in panthor, but I can add it in the driver specific  
> > ->evict() hook (though that means calling dma_resv_test_signaled()  
> > twice, which is not great, oh well).  
> 
> Maybe we should change drm_gem_evict() to use BOOKKEEP. The
> test_signaled(BOOKKEEP) should be a "stronger" check than
> test_signaled(READ)?

It is, just wondering if some users have a good reason to want
READ here.

> 
> > The problem about the evictable LRU remains though: we need a way to let
> > drivers put their BOs at the end of the list when the BO has been used
> > by the GPU, don't we?  
> 
> If BO is use, then it won't be evicted, while idling BOs will be
> evicted. Hence, the used BOs will be naturally moved down the LRU list
> each time shrinker is invoked.
> 

That only do the trick if the BOs being used most often are busy when
the shrinker kicks in though. Let's take this scenario:


BO 1					BO 2					shinker

					busy
					idle (first-pos-in-evictable-LRU)

busy
idle (second-pos-in-evictable-LRU)

					busy
					idle

					busy
					idle

					busy
					idle

										find a BO to evict
										pick BO 2

					busy (swapin)
					idle

If the LRU had been updated at each busy event, BO 1 should have
been picked for eviction. But we evicted the BO that was first
recorded idle instead of the one that was least recently
recorded busy.
