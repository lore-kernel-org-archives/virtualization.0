Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334153E0F
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262944; cv=none; b=PK+gOHJ4tWdtSdLmUfXOCYzQ99ayWomY5xIYlUIWwt1lmwf7qnelnUta/jlq1vHhEuaoerLs4JqNQu4PgOhWE13QLXbCxAkKtkRi5IBbGnq9KqT46F6hHw3LdzhvZW4vvF3S4uJ9Dv3Dv7D+fO5rYQqKprvR8gOyDWHUUXWhXVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262944; c=relaxed/simple;
	bh=V+qKo2xGWbEl/REQdZEOLDpue1R1cWsvMZI3m0DZ+Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICHiNnMlnSwG6iJafXT62R5Hc0SeYULovAqjHwR9or8/9md5b7rNNziOT1Ds6r7axOAbCbXr4QqQCLpShO4vFiQDbBfUNUOrs/teuy9uRBa0ULQUkTd/urZz9F8qLRrQGQXlXMi/+BS6WmA6LA8qvSes2z8V9nHruqxjhpGPYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BVA7lLn0; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BVA7lLn0"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDA8A614FA
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 09:55:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EDA8A614FA
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=BVA7lLn0
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hXvWKu-DRKaj
	for <virtualization@lists.linux-foundation.org>;
	Fri, 26 Jan 2024 09:55:42 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E28C8614F5
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 09:55:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E28C8614F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706262939;
	bh=V+qKo2xGWbEl/REQdZEOLDpue1R1cWsvMZI3m0DZ+Ok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BVA7lLn0qtXFw55qc/2tm7gneSeI+qgjLRHzU6zr17w+7YRwbLQ5jn6PIUFPYE2gx
	 AUWOEydYvfyVLF5B0H+4DRq2h38J/zB4ChIAfFjMaPOyzmKxhFZmSmDG6AbUKLdiSj
	 2/n8kuPni4PHKWZ8/urwvQDCw/9WMt26PvTpR8smdy4qaGhkGttEPQU94OzclYYSGk
	 x5htn8vc3+2NhtXX+yE+KJxNbuIwsT5/IcSIQBtlpsakYBIayPJLTyo0FRJyMsv936
	 SK/3plYnCrr8HBdC9AkC2gDAeZ9nFvrJshaKgVBHVWe6DBADBhBNjlKZ+IGv82L+U3
	 gVfm9DanSLtSw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CB77F3782033;
	Fri, 26 Jan 2024 09:55:38 +0000 (UTC)
Date: Fri, 26 Jan 2024 10:55:37 +0100
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
Message-ID: <20240126105537.67b1613e@collabora.com>
In-Reply-To: <f4870543-e7f8-4ee6-924a-68ec7c25b293@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-23-dmitry.osipenko@collabora.com>
	<20240125111946.797a1e1e@collabora.com>
	<f4870543-e7f8-4ee6-924a-68ec7c25b293@collabora.com>
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

On Fri, 26 Jan 2024 00:56:47 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 1/25/24 13:19, Boris Brezillon wrote:
> > On Fri,  5 Jan 2024 21:46:16 +0300
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> >   
> >> +static bool drm_gem_shmem_is_evictable(struct drm_gem_shmem_object *shmem)
> >> +{
> >> +	return (shmem->madv >= 0) && shmem->base.funcs->evict &&
> >> +		refcount_read(&shmem->pages_use_count) &&
> >> +		!refcount_read(&shmem->pages_pin_count) &&
> >> +		!shmem->base.dma_buf && !shmem->base.import_attach &&
> >> +		!shmem->evicted;  
> > 
> > Are we missing
> > 
> >                 && dma_resv_test_signaled(shmem->base.resv,
> > 					  DMA_RESV_USAGE_BOOKKEEP)
> > 
> > to make sure the GPU is done using the BO?
> > The same applies to drm_gem_shmem_is_purgeable() BTW.
> > 
> > If you don't want to do this test here, we need a way to let drivers
> > provide a custom is_{evictable,purgeable}() test.
> > 
> > I guess we should also expose drm_gem_shmem_shrinker_update_lru_locked()
> > to let drivers move the GEMs that were used most recently (those
> > referenced by a GPU job) at the end of the evictable LRU.  
> 
> We have the signaled-check in the common drm_gem_evict() helper:
> 
> https://elixir.bootlin.com/linux/v6.8-rc1/source/drivers/gpu/drm/drm_gem.c#L1496

Ah, indeed. I'll need DMA_RESV_USAGE_BOOKKEEP instead of
DMA_RESV_USAGE_READ in panthor, but I can add it in the driver specific
->evict() hook (though that means calling dma_resv_test_signaled()
twice, which is not great, oh well).

The problem about the evictable LRU remains though: we need a way to let
drivers put their BOs at the end of the list when the BO has been used
by the GPU, don't we?

