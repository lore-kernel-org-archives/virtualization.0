Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762FB1AACD
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169777; cv=none; b=u/sLlDbSPtEUK4t2TzPLAi+n/KTBzY/VVstbD5rP6AnT5Gcf7wG4n5zMCQ35HRD2CqQ3jjVfBYOEGGoX74GVQ9A7Kghh+eQf8KmfbEn8IPxIW5+1IjU9Bzm8Nhxic4zbAPCgz6le9Q6F2VLFeWV8rx5zTvidpMpYt60qlJ2wLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169777; c=relaxed/simple;
	bh=KjWB9RCuIPpmEs3LKhKafBGiLd5pPNJQhI+Vkrsfhqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVgAX+gBhTezGLHYT2W20PfaekSURncAKGV2ou5NYmJurcb8w7sXVeTvurM0C8QDDu1TLy/9gDK6hvMJTe/wUNodcELzXcRQ5dwMZ509hoU4fq/kwI1ytocZkEej5cpJQ7abZILw01s4SfAyNBNcp/9tAM/1xGnF2YErkPYRls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SDYER/GQ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SDYER/GQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E774040328
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:02:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E774040328
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=SDYER/GQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EllhFvzQg_du
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 08:02:55 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FD79402DE
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:02:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2FD79402DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706169771;
	bh=KjWB9RCuIPpmEs3LKhKafBGiLd5pPNJQhI+Vkrsfhqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDYER/GQtO7GxHnYozVA17JhDttmQFnSL1vR+asI6U58wi16Yh10w0v0ecFTQCIvp
	 nwAMz7eNLo+8tYXVeHr4JYp1Tc2JCqPIrunyrRd4lB7Kh9oVXtW2MfAf59g51J4qRJ
	 Y1L4QgTNFxUu2+qjNglCzdN2fMqOHSaFZdeSRCM+O9T5zOydqF6eyedyPPg+tCnl5N
	 Cn9i38v3IWQ3+NAgbfOuS2HqmLVEBe0BCGIfn+tDXqip/zPWTuECDXnJiFeWNO9ZPY
	 PCygTJM7f9ewAlCXJdM9qLuabjB3g9oN9ALtq9a6S929QIhqXoiKIAIjrvHOs+nuhG
	 kR0mWitbgaEjg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AEEC937820C2;
	Thu, 25 Jan 2024 08:02:50 +0000 (UTC)
Date: Thu, 25 Jan 2024 09:02:49 +0100
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
Subject: Re: [PATCH v19 15/30] drm/shmem-helper: Avoid lockdep warning when
 pages are released
Message-ID: <20240125090249.5f05959d@collabora.com>
In-Reply-To: <20240105184624.508603-16-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-16-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:09 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> All drivers will be moved to get/put pages explicitly and then the last
> put_pages() will be invoked during gem_free() time by some drivers.
> We can't touch reservation lock when GEM is freed because that will cause
> a spurious warning from lockdep when shrinker support will be added.
> Lockdep doesn't know that fs_reclaim isn't functioning for a freed object,
> and thus, can't deadlock. Release pages directly without taking reservation
> lock if GEM is freed and its refcount is zero.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index f5ed64f78648..c7357110ca76 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -242,6 +242,22 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem)
>  	if (refcount_dec_not_one(&shmem->pages_use_count))
>  		return;
>  
> +	/*
> +	 * Destroying the object is a special case because acquiring
> +	 * the obj lock can cause a locking order inversion between
> +	 * reservation_ww_class_mutex and fs_reclaim.
> +	 *
> +	 * This deadlock is not actually possible, because no one should
> +	 * be already holding the lock when GEM is released.  Unfortunately
> +	 * lockdep is not aware of this detail.  So when the refcount drops
> +	 * to zero, we pretend it is already locked.
> +	 */
> +	if (!kref_read(&shmem->base.refcount)) {
> +		if (refcount_dec_and_test(&shmem->pages_use_count))
> +			drm_gem_shmem_free_pages(shmem);
> +		return;
> +	}
> +
>  	dma_resv_lock(shmem->base.resv, NULL);
>  	drm_gem_shmem_put_pages_locked(shmem);
>  	dma_resv_unlock(shmem->base.resv);

