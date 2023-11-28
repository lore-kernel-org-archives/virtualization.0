Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075F74D5AB
	for <virtualization@lists.linux-foundation.org>; Tue, 28 Nov 2023 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HUrtoyW3"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5EF2D819F6
	for <virtualization@lists.linux-foundation.org>; Tue, 28 Nov 2023 12:37:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EF2D819F6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=HUrtoyW3
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f8yOefyh5s_Y
	for <virtualization@lists.linux-foundation.org>;
	Tue, 28 Nov 2023 12:37:21 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E44ED8196A
	for <virtualization@lists.linux-foundation.org>; Tue, 28 Nov 2023 12:37:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E44ED8196A
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id A64ED66017A7;
	Tue, 28 Nov 2023 12:37:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1701175037;
	bh=lUwoFImFc7lmJuNp+eDWdZh4k60TMdNkbVoZ37tKKEw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HUrtoyW334hiwg7m6r5OfJ6YeexY97cVAVI65jSfGGtKi2cQGPChvF/mG/sPrzlPe
	 12pG3bmFU6VIeHioT6XVnB5p/960z2qXw2zHZLwtS5glXm0ocPUB+hh9gB8vJn0Weh
	 VclkMRGrHBkMIHngWijmK+LaxJuziOSEZy15w7FC6XOeLNMMIj9mx7wv4y/IEP+Qdq
	 xs0ClHlst7tTwSa//pqMy4kjbA27QQByAtVEMIM5ZcCN64cWlptpuUxbtZ59X57seX
	 xO2+ND2rg6Ok9FIIXw0k9khxJEg2s+xrd4x5a04kN3QR2c/4s4d8/o0OF8OK/86gzo
	 wGCqvXwihns4A==
Date: Tue, 28 Nov 2023 13:37:12 +0100
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
Subject: Re: [PATCH v18 04/26] drm/shmem-helper: Refactor locked/unlocked
 functions
Message-ID: <20231128133712.53a6f6cb@collabora.com>
In-Reply-To: <kw5bho3jx73d3glvtewmjvqt4qty4khju6dcwypuh25ya3gi4b@7slmijjqdi4p>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-5-dmitry.osipenko@collabora.com>
	<wboljiwogeus7pwgaqzxaltt3xdavy2dzisygn6pdpoiwlnwgc@mwaiukjguzat>
	<20231124115911.79ab24af@collabora.com>
	<kw5bho3jx73d3glvtewmjvqt4qty4khju6dcwypuh25ya3gi4b@7slmijjqdi4p>
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

On Tue, 28 Nov 2023 12:14:42 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> Hi,
> 
> On Fri, Nov 24, 2023 at 11:59:11AM +0100, Boris Brezillon wrote:
> > On Fri, 24 Nov 2023 11:40:06 +0100
> > Maxime Ripard <mripard@kernel.org> wrote:
> >   
> > > On Mon, Oct 30, 2023 at 02:01:43AM +0300, Dmitry Osipenko wrote:  
> > > > Add locked and remove unlocked postfixes from drm-shmem function names,
> > > > making names consistent with the drm/gem core code.
> > > > 
> > > > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> > > > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>    
> > > 
> > > This contradicts my earlier ack on a patch but...
> > >   
> > > > ---
> > > >  drivers/gpu/drm/drm_gem_shmem_helper.c        | 64 +++++++++----------
> > > >  drivers/gpu/drm/lima/lima_gem.c               |  8 +--
> > > >  drivers/gpu/drm/panfrost/panfrost_drv.c       |  2 +-
> > > >  drivers/gpu/drm/panfrost/panfrost_gem.c       |  6 +-
> > > >  .../gpu/drm/panfrost/panfrost_gem_shrinker.c  |  2 +-
> > > >  drivers/gpu/drm/panfrost/panfrost_mmu.c       |  2 +-
> > > >  drivers/gpu/drm/v3d/v3d_bo.c                  |  4 +-
> > > >  drivers/gpu/drm/virtio/virtgpu_object.c       |  4 +-
> > > >  include/drm/drm_gem_shmem_helper.h            | 36 +++++------
> > > >  9 files changed, 64 insertions(+), 64 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > > index 0d61f2b3e213..154585ddae08 100644
> > > > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > > @@ -43,8 +43,8 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
> > > >  	.pin = drm_gem_shmem_object_pin,
> > > >  	.unpin = drm_gem_shmem_object_unpin,
> > > >  	.get_sg_table = drm_gem_shmem_object_get_sg_table,
> > > > -	.vmap = drm_gem_shmem_object_vmap,
> > > > -	.vunmap = drm_gem_shmem_object_vunmap,
> > > > +	.vmap = drm_gem_shmem_object_vmap_locked,
> > > > +	.vunmap = drm_gem_shmem_object_vunmap_locked,    
> > > 
> > > While I think we should indeed be consistent with the names, I would
> > > also expect helpers to get the locking right by default.  
> > 
> > Wait, actually I think this patch does what you suggest already. The
> > _locked() prefix tells the caller: "you should take care of the locking,
> > I expect the lock to be held when this is hook/function is called". So
> > helpers without the _locked() prefix take care of the locking (which I
> > guess matches your 'helpers get the locking right' expectation), and
> > those with the _locked() prefix don't.  
> 
> What I meant by "getting the locking right" is indeed a bit ambiguous,
> sorry. What I'm trying to say I guess is that, in this particular case,
> I don't think you can expect the vmap implementation to be called with
> or without the locks held. The doc for that function will say that it's
> either one or the other, but not both.
> 
> So helpers should follow what is needed to provide a default vmap/vunmap
> implementation, including what locking is expected from a vmap/vunmap
> implementation.

Hm, yeah, I think that's a matter of taste. When locking is often
deferrable, like it is in DRM, I find it beneficial for funcions and
function pointers to reflect the locking scheme, rather than relying on
people properly reading the doc, especially when this is the only
outlier in the group of drm_gem_object_funcs we already have, and it's
not event documented at the drm_gem_object_funcs level [1] :P.

> 
> If that means that vmap is always called with the locks taken, then
> drm_gem_shmem_object_vmap can just assume that it will be called with
> the locks taken and there's no need to mention it in the name (and you
> can probably sprinkle a couple of lockdep assertion to make sure the
> locking is indeed consistent).

Things get very confusing when you end up having drm_gem_shmem helpers
that are suffixed with _locked() to encode the fact locking is the
caller's responsibility and no suffix for the
callee-takes-care-of-the-locking semantics, while other helpers that are
not suffixed at all actually implement the
caller-should-take-care-of-the-locking semantics.

> 
> > > I'm not sure how reasonable it is, but I think I'd prefer to turn this
> > > around and keep the drm_gem_shmem_object_vmap/unmap helpers name, and
> > > convert whatever function needs to be converted to the unlock suffix so
> > > we get a consistent naming.  
> > 
> > That would be an _unlocked() prefix if we do it the other way around. I
> > think the main confusion comes from the names of the hooks in
> > drm_gem_shmem_funcs. Some of them, like drm_gem_shmem_funcs::v[un]map()
> > are called with the GEM resv lock held, and locking is handled by the
> > core, others, like drm_gem_shmem_funcs::[un]pin() are called
> > without the GEM resv lock held, and locking is deferred to the
> > implementation. As I said, I don't mind prefixing hooks/helpers with
> > _unlocked() for those that take care of the locking, and no prefix for
> > those that expects locks to be held, as long as it's consistent, but I
> > just wanted to make sure we're on the same page :-).  
> 
> What about _nolock then? It's the same number of characters than
> _locked, plus it expresses what the function is (not) doing, not what
> context it's supposed to be called in?

Just did a quick

  git grep _nolock drivers/gpu/drm

and it returns zero result, where the _locked/_unlocked pattern seems
to already be widely used. Not saying we shouldn't change that, but it
doesn't feel like a change we should do as part of this series.

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v6.7-rc3/source/include/drm/drm_gem.h#L155
