Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AE61CA9A
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177993; cv=none; b=INUCKGHSxQwIuGQ85l2fApZvC0EQbW9VrjBOGPA0FAVrqqDb6k57Qm+DIlOkZKsXQBZl6chaozQKMD+Ww253iWNi74ThI5j8uYiiT4MyRnaoZBj3H4kNEW4YLC3y82BvdtOVzhzrwLP52CtanEXjY/sq12b8nSxtKD3/tMTEzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177993; c=relaxed/simple;
	bh=SNTqFndHS7fusbc/JoJL6VmM5mMHU74c/gZCl49dXII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8dyP018e3Vqc03kyJBoGX8il1Ymyg1IwipO7TShBDb/odYDUO2AvUlpynguIDc/GXGkexkQ6mSZbKvJSbl5buGg95mmwUcfd+jAgtp0ktl7xnv887iLT6vHMe1SiXOJ/s2jpt6xfjXVIEZ1IBPZ8SDH0flL3RbBQq+SVheczDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=crzCrYot; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="crzCrYot"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0E60A8177C
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 10:19:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E60A8177C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=crzCrYot
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hZNHaOKcsb3l
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 10:19:51 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3A91481586
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 10:19:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3A91481586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706177988;
	bh=SNTqFndHS7fusbc/JoJL6VmM5mMHU74c/gZCl49dXII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=crzCrYotEFR6vHCVGwVhc8KCpzfBEpAGjgrKWvRQ8thXlbUnvSjkuRRNucJZMkYO3
	 zpqJs3oi/mRonlfMsnR8WglzPGURtXrGnD/c/EYZ1qzVEvXG5SWZ+3mf0fypx2lfQL
	 L3YMzd1en2ZEJrPhSPIYcmV60/0CrIV3BaDFTOyvRlZGDTWAZan6sjhww3Gi5+rw2s
	 2U+wIVvsDuFaCAgxTFLxMryEeh3XIyFe/HQpQAcOv69BfzfzdalaQ1yFWDlugbiSn2
	 qnEmc23s7Q2UktOoh6Hqknk3+8RnVzZLFTFb7lAWGInDP7jaaTmNsmXeVf2H8/RTZN
	 QjpJHe786N2vw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 657083780FC7;
	Thu, 25 Jan 2024 10:19:47 +0000 (UTC)
Date: Thu, 25 Jan 2024 11:19:46 +0100
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
Message-ID: <20240125111946.797a1e1e@collabora.com>
In-Reply-To: <20240105184624.508603-23-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-23-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:16 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> +static bool drm_gem_shmem_is_evictable(struct drm_gem_shmem_object *shmem)
> +{
> +	return (shmem->madv >= 0) && shmem->base.funcs->evict &&
> +		refcount_read(&shmem->pages_use_count) &&
> +		!refcount_read(&shmem->pages_pin_count) &&
> +		!shmem->base.dma_buf && !shmem->base.import_attach &&
> +		!shmem->evicted;

Are we missing

                && dma_resv_test_signaled(shmem->base.resv,
					  DMA_RESV_USAGE_BOOKKEEP)

to make sure the GPU is done using the BO?
The same applies to drm_gem_shmem_is_purgeable() BTW.

If you don't want to do this test here, we need a way to let drivers
provide a custom is_{evictable,purgeable}() test.

I guess we should also expose drm_gem_shmem_shrinker_update_lru_locked()
to let drivers move the GEMs that were used most recently (those
referenced by a GPU job) at the end of the evictable LRU.

> +}
> +
