Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD061CF92
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 11:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ewNPCOKr"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9BB946151F
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 11:21:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BB946151F
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ewNPCOKr
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DR4l9akwlCOw
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 11:21:06 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1BC6C60AE5
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 11:21:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1BC6C60AE5
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 442C066073AD;
	Fri, 24 Nov 2023 11:21:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700824864;
	bh=OZpGtMQbmVQunCfJrLeAe542D7ZOanapr4svoI3JwA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ewNPCOKrH1GyEL3hqBPY48UMHQ+Sz5zv9mFwIXjamzLJRDlRzqQmMrHwqq1B1VVHK
	 i9QkoYQDRL9GKu1XX5/XXtzp8tfBUrQ4Q05xvBz/fN9VrJdNDVQY3iNZYg6FFiY3J/
	 Q0ZoUcQ6/xMfEbebVoTz+Zr9bX15038jTZiixL3GpkqwvV3u9436gdA9YnYqkYkMzG
	 l8Fga9KtCvkB5E5kPPELIua1dlS8oO7WFje+/0vp18587VWVhqnfG3FOtRhz6dKNVB
	 YupFft+R/HIk2w7q/3Q7anP2tj2ddWn6HqdSZjsF7iBrsGPQ0CD9LgJmol9JQ+2By9
	 PtP2EOZk4kDag==
Date: Fri, 24 Nov 2023 12:20:59 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie
 <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price
 <steven.price@arm.com>, Emma Anholt <emma@anholt.net>, Melissa Wen
 <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 08/26] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Message-ID: <20231124122059.244250c7@collabora.com>
In-Reply-To: <zdgmrdfugffy6ogvws3yatcebigylkalfiip2ch3cwgvjs5r65@hgakb26hmhsb>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-9-dmitry.osipenko@collabora.com>
	<zdgmrdfugffy6ogvws3yatcebigylkalfiip2ch3cwgvjs5r65@hgakb26hmhsb>
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

On Fri, 24 Nov 2023 11:47:57 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> On Mon, Oct 30, 2023 at 02:01:47AM +0300, Dmitry Osipenko wrote:
> > Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
> > lock if pages_use_count is non-zero, leveraging from atomicity of the
> > refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
> > 
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > index 6e02643ed87e..41b749bedb11 100644
> > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
> >  }
> >  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
> >  
> > +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> > +{
> > +	int ret;
> > +
> > +	if (refcount_inc_not_zero(&shmem->pages_use_count))
> > +		return 0;
> > +
> > +	dma_resv_lock(shmem->base.resv, NULL);
> > +	ret = drm_gem_shmem_get_pages_locked(shmem);
> > +	dma_resv_unlock(shmem->base.resv);
> > +
> > +	return ret;
> > +}
> > +  
> 
> Wait, so the locked suffix is to indicate that we need to take the lock
> before we call it? I think that's the opposite to all(?) the naming
> convention we have

If you grep for "_locked(" and "_unlocked(" in the DRM sub-tree, you'll
see it's actually mixed, with maybe a few more helpers suffixed
_locked() than we have suffixed with _unlocked().

> 
> Especially since the function name doesn't describe what the function
> does anymore, but the context in which to call it.

Well, that's the same for "_unlocked", and we do have to pick one of
the _locked/_unlocked pattern if we want to expose both flavors.

> I'm sure if I was to
> use it, I would have gotten it wrong, or at the very least been very
> confused about it.

I personally find both equally confusing tbh, but we do have cases
where we need to expose the exact same functionality without the extra
locking. I do have a slight preference for _locked though, because it's
two characters shorter ;-).
