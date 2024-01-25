Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755701CFB6
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 09:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706174946; cv=none; b=CilrFWKVSxsRjgozVrlzQPoqXYXTjwafyCJqRYv7ekHnPvHOgPec3mn4IYujFx5Ms7vmNwXIWu5qcZo4E8RqICzWUMHY1L5TxPcIakKQFnJBqoJN9TOvOH+nYynqeZYsHQDWj6Pa5YNMSmXWG/Aph68l8umgyW69at5zpyXutU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706174946; c=relaxed/simple;
	bh=MuHOFFDvhunWa09yCKieBQeofTJm5hUil4z2V5RP7/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iukdC+ECIxia2lI3KLJvQsz+uYzCb2ulEA2eMeYVGS7cQCAkGAu5vK/Ck50gnkKpV5teHtJeHhNry7ffA3k+MNar/iZCUG00Jpa1hzHrUAVr7q0lHJMmcMKub5Wow7rmDzf8Gz2a8VyvGJTpo4Ix7TKb77ael/K8EFpUsgYq9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NrDb1FaB; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NrDb1FaB"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D935E43545
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 09:29:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D935E43545
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=NrDb1FaB
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QvvYIofHeFs6
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 09:29:04 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C379A42F4E
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 09:29:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C379A42F4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706174941;
	bh=MuHOFFDvhunWa09yCKieBQeofTJm5hUil4z2V5RP7/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NrDb1FaBaq13ye++Lhg9rKsUJUXv0CRes27oB17iSRjJI+f260kZqghxxIZiHPzKF
	 yG6w09yncfIcrwFhoeCGYZ/UGRPOvZj+BlKCoxh0Kbrzd/cMl51zO7QWS4loE7xDkx
	 R8JmJ/OZjwElQbafLdkoQovcnyaDjPRBNW5oDS+E7/hS0AKI10hMKA1rvqLulArOiC
	 /gg8mIL23r6i4JVwuVbbfG5bPGMGvlO5PRxPX3vXd/g/7vPtHw838An9VQnD8DfxH8
	 vXnkf3u1PESFA9piBvV8wC2PNTy0r3VVjSEBCViVMZWseP6/oklRc8Ydq8iLOdBE1v
	 tbEsIRBp4/X9w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E09AB378000B;
	Thu, 25 Jan 2024 09:29:00 +0000 (UTC)
Date: Thu, 25 Jan 2024 10:28:59 +0100
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
Subject: Re: [PATCH v19 24/30] drm/shmem-helper: Optimize unlocked
 get_pages_sgt()
Message-ID: <20240125102859.6d8a864f@collabora.com>
In-Reply-To: <20240105184624.508603-25-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-25-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:18 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> SGT isn't refcounted. Once SGT pointer has been obtained, it remains the
> same for both locked and unlocked get_pages_sgt(). Return cached SGT
> directly without taking a potentially expensive lock.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

but I'm wondering if we should have made this change directly in
'drm/shmem-helper: Change sgt allocation policy'.

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 8fd7851c088b..e6e6e693ab95 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -962,6 +962,18 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
>  	    drm_WARN_ON(obj->dev, drm_gem_shmem_is_purgeable(shmem)))
>  		return ERR_PTR(-EBUSY);
>  
> +	/*
> +	 * Drivers that use shrinker should take into account that shrinker
> +	 * may relocate BO, thus invalidating the returned SGT pointer.
> +	 * Such drivers should pin GEM while they use SGT.
> +	 *
> +	 * Drivers that don't use shrinker should take into account that
> +	 * SGT is released together with the GEM pages. Pages should be kept
> +	 * alive while SGT is used.
> +	 */
> +	if (shmem->sgt)
> +		return shmem->sgt;
> +
>  	ret = dma_resv_lock_interruptible(shmem->base.resv, NULL);
>  	if (ret)
>  		return ERR_PTR(ret);

