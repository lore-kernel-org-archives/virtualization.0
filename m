Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB01E536
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706264315; cv=none; b=srGkblzWpzvCViCAysHt/vY7Mjyvn9A7T1SHDNeXBeWLBZrLHgBlzr2ofk2kP1QmZSkM9JIIXMZoK9oKe4Q9dz6aKIwOYY3itpUZ92W64CkUwWZxRXWWKe6QlcG7GEWW4STUQlweXDIVFz6A9w7XS753ZPXbsI3f0S+CpsEv8g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706264315; c=relaxed/simple;
	bh=hqYTK0EsC3o/io3T1zeWVHK+9pLIv8eop9reCP1H12I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExWa2ZpeU98QR8YYyM6fqMTDDfJxmGwSuIbjQZQj/JBdpLoFXm2rg/Olck1kRFgp9paqlDnImKexccveAf1sp/BjsBgtYR9RmsEsZL6zVfZvAAM8ZyBt3xIFQVygpEJus791JnIKUjmCkX44PYyGy5lS8FW4zHYr1PHS24uzGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ionVzzYU; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ionVzzYU"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1E3284482
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 10:18:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1E3284482
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ionVzzYU
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cp2oNGtk4-9n
	for <virtualization@lists.linux-foundation.org>;
	Fri, 26 Jan 2024 10:18:33 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 037B983E7E
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 10:18:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 037B983E7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706264310;
	bh=hqYTK0EsC3o/io3T1zeWVHK+9pLIv8eop9reCP1H12I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ionVzzYUVohq/prvhL2Jplfp6RkWMX6N92pnga5WmXEKfX3WWE3wisdops+KV3ifp
	 Uy5+PNmkF5un43C8farXeu6d+mw/XXMFTa98cPOyEm3NUm+NQKX+R0usEfm+yjMQH7
	 khbw3xEeIDeVPaZKmrCynwWqSZpQ8Oc02kg3PrHM1X2oQ8dpeIENT27v27zWpVX2i/
	 WQroAxJl0yGuCyjeLxf+oFMJh6VulBj4FrURTI1vV2T8AWII+/P76KkX9I5zEaC6P4
	 zYwV4SGEyo23NTgEBHBcWqv359YkS3edA2waZUh4Gg+h+o2W0wxJH43MTurEDDpU2u
	 SOvR1OO9/OPJw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 420D63782072;
	Fri, 26 Jan 2024 10:18:29 +0000 (UTC)
Date: Fri, 26 Jan 2024 11:18:27 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie
 <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Qiang Yu
 <yuq825@gmail.com>, Steven Price <steven.price@arm.com>, Emma Anholt
 <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 09/30] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Message-ID: <20240126111827.70f8726c@collabora.com>
In-Reply-To: <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
 <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
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

On Thu, 25 Jan 2024 18:24:04 +0100
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
> > Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
> > lock if pages_use_count is non-zero, leveraging from atomicity of the
> > refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
> > 
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > index cacf0f8c42e2..1c032513abf1 100644
> > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
> >  }
> >  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
> >  
> > +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> > +{
> > +	int ret;  
> 
> Just random drive-by comment: a might_lock annotation here might be good,
> or people could hit some really interesting bugs that are rather hard to
> reproduce ...

Actually, being able to acquire a ref in a dma-signalling path on an
object we know for sure already has refcount >= 1 (because we previously
acquired a ref in a path where dma_resv_lock() was allowed), was the
primary reason I suggested moving to this atomic-refcount approach.

In the meantime, drm_gpuvm has evolved in a way that allows me to not
take the ref in the dma-signalling path (the gpuvm_bo object now holds
the ref, and it's acquired/released outside the dma-signalling path).

Not saying we shouldn't add this might_lock(), but others might have
good reasons to have this function called in a path where locking
is not allowed.
