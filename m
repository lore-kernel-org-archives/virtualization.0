Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7B017731
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706170224; cv=none; b=RO1V49dNOB4uv0aluF6KoBVwHnXmg0qnDF4VG73B2ToW7IQPZrxzIvTkdM+KvL5+/rv8FAn9lKaBkuvZmciE9hVzWDwU95qC4/0S26LT0yKE0PtK2LxF3Y7gAaUefGZkr6xvFpmAT3jOGyq5IgSB1AV+0dmgXkf+rsA/EzsbeLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706170224; c=relaxed/simple;
	bh=O3U1kGKwJmoScP/bAbGpguM1vg+2nAo9bdmHRguFPsw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qyvdn99d1ayYRVm5a49bhLLp9Y3csYAVQm49hgzbYgDQYiVkbQf+Gjmb0P/9n2VQzL4tVI2cSIw+P3SoUfLE+f4mgWqCYDQEwBC7NSyPoFkSVnMWFfINOf0J0cey6/Q8m6JHrpPbFgqUZoauELcYNyPMuWzdUhWokVK1n34UCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nVwhPSFR; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nVwhPSFR"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 34AC183A56
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:10:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34AC183A56
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=nVwhPSFR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sfTMmUbkVIHy
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 08:10:22 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7C94F80E90
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 08:10:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C94F80E90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706169736;
	bh=O3U1kGKwJmoScP/bAbGpguM1vg+2nAo9bdmHRguFPsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nVwhPSFRWtGZjapYQM3fa933PxX0Nh0QxWXeltwxS8c+/8z5uGYPmNTOJrlHh/vue
	 L2tiVMr00xXFG2yH59O5ArcHn4Tttz+hFCYQlJsuD6keT91/R19HjV/ECBQUSrfu3s
	 +oo5oHD5l/yAGF9Ob1TTsuTdvlBUdIaPYex1g+9j6BwkzJLTFMy3ZOZn7Q9TQ6V8rw
	 5BB/nehoXJA57E/6DHY5FXVIaO3XvoQwTLqK82IDp8dFca/aZJ/VXP1U3Wgu8/Lkvd
	 yiDZzjdlso93bKSRFyEbrT2m6tCU3FlJqF6qzsMVFzxugknNcMswFKvUWleBqJAQgJ
	 4j+3sQy9vPQow==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EDF4237820BD;
	Thu, 25 Jan 2024 08:02:14 +0000 (UTC)
Date: Thu, 25 Jan 2024 09:02:13 +0100
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
Subject: Re: [PATCH v19 13/30] drm/shmem-helper: Make
 drm_gem_shmem_get_pages() public
Message-ID: <20240125090213.5a9e0853@collabora.com>
In-Reply-To: <20240105184624.508603-14-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-14-dmitry.osipenko@collabora.com>
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

On Fri,  5 Jan 2024 21:46:07 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> We're going to move away from having implicit get_pages() done by
> get_pages_sgt() to simplify refcnt handling. Drivers will manage
> get/put_pages() by themselves. Expose the drm_gem_shmem_get_pages()
> in a public drm-shmem API.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 10 +++++++++-
>  include/drm/drm_gem_shmem_helper.h     |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 799a3c5015ad..dc416a4bce1b 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -228,7 +228,14 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>  
> -static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> +/*
> + * drm_gem_shmem_get_pages - Increase use count on the backing pages for a shmem GEM object
> + * @shmem: shmem GEM object
> + *
> + * This function Increases the use count and allocates the backing pages if
> + * use-count equals to zero.
> + */
> +int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>  {
>  	int ret;
>  
> @@ -241,6 +248,7 @@ static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages);
>  
>  static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  {
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index 18020f653d7e..6dedc0739fbc 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -110,6 +110,7 @@ struct drm_gem_shmem_object {
>  struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
>  void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
>  
> +int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem);
>  int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);

