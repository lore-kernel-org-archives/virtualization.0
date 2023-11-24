Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2CA15AD5
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H7NSrk1l"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE63A8215E
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 09:41:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE63A8215E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=H7NSrk1l
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 99VbPnAPmYsj
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 09:41:02 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB3CA82100
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 09:41:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB3CA82100
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id DD89166073A4;
	Fri, 24 Nov 2023 09:40:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700818857;
	bh=LDEJxxut8mOIXIweABuj+iaxliCKCshQ6GN/RJzXq3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H7NSrk1l6pFC5gIp3b4sLAuNshK1i+hDEsPF9psqr556lGfmm6VPTib3oS6SjJRzv
	 vtTYi9Q6C59/NU5ixzekg0Y4lUnMO/aifagrBcH46kstlhMVb5SF2o5//VUL0ALir3
	 lUZeEUnL8WccwKfHdnbn7yRxGxkD85LjZfAL4didUTQ5MmoWMoDeX1cx/koTK2ypq7
	 F9VhDWI2+/HDSiXO7QQOwH6FKHpizf1n8dqKhBDvSsWAtFnwftTgUyoiARM1xoZIi6
	 aSvIDqVKAsehRjUqqm6P1BCqeWutZVZlWC9onUm5sRn90ZEtl4msQ7NpbQwlFHksFq
	 zoq1XcE9f2v3A==
Date: Fri, 24 Nov 2023 10:40:53 +0100
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
Subject: Re: [PATCH v18 15/26] drm/panfrost: Explicitly get and put
 drm-shmem pages
Message-ID: <20231124104053.034496fb@collabora.com>
In-Reply-To: <20231123154848.034f4710@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-16-dmitry.osipenko@collabora.com>
	<20231123154848.034f4710@collabora.com>
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

On Thu, 23 Nov 2023 15:48:48 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Mon, 30 Oct 2023 02:01:54 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
> > To simplify the drm-shmem refcnt handling, we're moving away from
> > the implicit get_pages() that is used by get_pages_sgt(). From now on
> > drivers will have to pin pages while they use sgt. Panfrost's shrinker
> > doesn't support swapping out BOs, hence pages are pinned and sgt is valid
> > as long as pages' use-count > 0.
> > 
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_gem.c | 17 +++++++++++++++++
> >  drivers/gpu/drm/panfrost/panfrost_mmu.c |  6 ++----
> >  2 files changed, 19 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > index 6b77d8cebcb2..bb9d43cf7c3c 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_gem.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
> > @@ -47,8 +47,13 @@ static void panfrost_gem_free_object(struct drm_gem_object *obj)
> >  			}
> >  		}
> >  		kvfree(bo->sgts);
> > +
> > +		drm_gem_shmem_put_pages(&bo->base);
> >  	}
> >  
> > +	if (!bo->is_heap && !obj->import_attach)
> > +		drm_gem_shmem_put_pages(&bo->base);
> > +
> >  	drm_gem_shmem_free(&bo->base);
> >  }
> >  
> > @@ -269,6 +274,7 @@ panfrost_gem_create(struct drm_device *dev, size_t size, u32 flags)
> >  {
> >  	struct drm_gem_shmem_object *shmem;
> >  	struct panfrost_gem_object *bo;
> > +	int err;
> >  
> >  	/* Round up heap allocations to 2MB to keep fault handling simple */
> >  	if (flags & PANFROST_BO_HEAP)
> > @@ -282,7 +288,18 @@ panfrost_gem_create(struct drm_device *dev, size_t size, u32 flags)
> >  	bo->noexec = !!(flags & PANFROST_BO_NOEXEC);
> >  	bo->is_heap = !!(flags & PANFROST_BO_HEAP);
> >  
> > +	if (!bo->is_heap) {
> > +		err = drm_gem_shmem_get_pages(shmem);  
> 
> I really hate the fact we request pages here while we call
> panfrost_mmu_map() in panfrost_gem_open(), because ultimately, pages
> are requested for the MMU mapping. Also hate the quirk we have in shmem
> to call free_pages() instead of put_pages_locked() when the BO refcount
> dropped to zero, and I was hoping we could get rid of it at some point
> by teaching drivers to request pages when they actually need it instead
> of tying pages lifetime to the GEM object lifetime.
> 
> Maybe what we should do instead is move the get/put_pages() in
> panfrost_mmu_map/unmap() (as I suggested), but have a special mapping
> panfrost_mmu_evict/restore() helpers that kill/restore the MMU mappings
> without releasing/acquiring the pages ref.

Okay, so I played with your branch and did what I suggested here ^. The
end result is available here [1]. I also split this patch in two:

- A fix for the error path in panfrost_mmu_map_fault_addr() [2]
- The explicit get/put_pages() stuff with pages ref owned by the
  panfrost_gem_mapping object [3]

[1]https://gitlab.freedesktop.org/bbrezillon/linux/-/commits/virtio-gpu-shrinker-v18
[2]https://gitlab.freedesktop.org/bbrezillon/linux/-/commit/9d499e971fdae4d6e52f8871ca27c24b2a2c43d6
[3]https://gitlab.freedesktop.org/bbrezillon/linux/-/commit/ba3de65bf1cf0ca95710e743ec85ca67ff1aa223

