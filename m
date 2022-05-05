Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1ECC433F5
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 12:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0643E61103;
	Thu,  5 May 2022 12:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vVGS9WR1vGqZ; Thu,  5 May 2022 12:00:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0A81A610DE;
	Thu,  5 May 2022 12:00:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD9BCC0032;
	Thu,  5 May 2022 12:00:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89DA2C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 11:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5974984078
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 11:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pKaJbE7MsylO
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 11:59:57 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 934E084073
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 11:59:56 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id g20so4915169edw.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 04:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=Q+IpshQKCrEVcU73sFIgxuBvD2eLsdSODYcp0YNNZBQ=;
 b=KbH5ussPtjNqusImQqmtx/HT8A59E7SHN19+GXPmljy8p0dSfBtSG2dBy1/KrHhwGC
 PJoG9Q9RCU2cPr4oQh1/wi47mVv+4z4rJPYvAIx/HoI0yRGG+nllbZjce1fMrLnAje9h
 UzUjn1DNYwPvZIRMNig23eALx8svVvHJtb6rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=Q+IpshQKCrEVcU73sFIgxuBvD2eLsdSODYcp0YNNZBQ=;
 b=I0WIuebYmtH5wuObXbKd+tXmpP5cbAjmH80PJvfc3YKTf8qkR3HC2DH9dU6CO0XC4m
 +64aBktiQ1/zLU3sikavJHq1SacwMI+j5lbYY5Nm4TXhrUjOPdl+ZQHZsphcgc/efgPn
 l0X8VBeSxXeIZrHlQWL0/Wb/ooTSlRKOiiTlYWFMUQhfPNYX3m7jf3q+R5S0+MWToeUX
 WVgb595g5DlnUhmRY9jWYvejydfZOtM5/QnK9CREOaTAXvf+GjovtkSY4mG97HdFcpww
 nup3qEm1ZKOFkirp5rhN1KRo7VBFrIcc7tSSzP/MmQqeldmxOrrJ/TjuBB7AEqRCnrfx
 lu4g==
X-Gm-Message-State: AOAM531CBXR1MwA/A53y4+WO24ipF6mNZvhHJUyZCFbL5/9PBOjFyLq4
 4yN7yTn3VRrPG08iicnB/dy1qg==
X-Google-Smtp-Source: ABdhPJwnDUaNFFdd1vGkU7C4/rICSgQS743Y1kJ3rDdgpvma4jTSBGVZZ11+69vn/QRUxufCu/dnqA==
X-Received: by 2002:a05:6402:26d3:b0:427:c571:86fe with SMTP id
 x19-20020a05640226d300b00427c57186femr21701959edd.133.1651751994464; 
 Thu, 05 May 2022 04:59:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 mm27-20020a170906cc5b00b006f3ef214e1csm670226ejb.130.2022.05.05.04.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 May 2022 04:59:53 -0700 (PDT)
Date: Thu, 5 May 2022 13:59:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 11/15] drm/shmem-helper: Add generic memory shrinker
Message-ID: <YnO8NxZftIF8sW1T@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Rob Clark <robdclark@gmail.com>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
References: <20220417223707.157113-1-dmitry.osipenko@collabora.com>
 <20220417223707.157113-12-dmitry.osipenko@collabora.com>
 <e6108e9c-6e67-2d71-0665-654e11d9c3a5@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e6108e9c-6e67-2d71-0665-654e11d9c3a5@suse.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <digetx@gmail.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, virtualization@lists.linux-foundation.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, May 05, 2022 at 10:34:02AM +0200, Thomas Zimmermann wrote:
> Hi
> =

> Am 18.04.22 um 00:37 schrieb Dmitry Osipenko:
> > Introduce a common DRM SHMEM shrinker. It allows to reduce code
> > duplication among DRM drivers that implement theirs own shrinkers.
> > This is initial version of the shrinker that covers basic needs of
> > GPU drivers, both purging and eviction of shmem objects are supported.
> > =

> > This patch is based on a couple ideas borrowed from Rob's Clark MSM
> > shrinker and Thomas' Zimmermann variant of SHMEM shrinker.
> > =

> > In order to start using DRM SHMEM shrinker drivers should:
> > =

> > 1. Implement new purge(), evict() + swap_in() GEM callbacks.
> > 2. Register shrinker using drm_gem_shmem_shrinker_register(drm_device).
> > 3. Use drm_gem_shmem_set_purgeable_and_evictable(shmem) and alike API
> >     functions to activate shrinking of GEMs.
> =

> Honestly speaking, after reading the patch and the discussion here I real=
ly
> don't like where all tis is going. The interfaces and implementation are
> overengineered.  Descisions about evicting and purging should be done by =
the
> memory manager. For the most part, it's none of the driver's business.
> =

> I'd like to ask you to reduce the scope of the patchset and build the
> shrinker only for virtio-gpu. I know that I first suggested to build upon
> shmem helpers, but it seems that it's easier to do that in a later patchs=
et.

We have a few shrinkers already all over, so extracting that does make
sense I think. I do agree that there's probably a few more steps than
necessary involved right now in all this for the helper<->driver
interface.
-Daniel

> =

> Best regards
> Thomas
> =

> > =

> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > ---
> >   drivers/gpu/drm/drm_gem_shmem_helper.c | 765 ++++++++++++++++++++++++-
> >   include/drm/drm_device.h               |   4 +
> >   include/drm/drm_gem.h                  |  35 ++
> >   include/drm/drm_gem_shmem_helper.h     | 105 +++-
> >   4 files changed, 877 insertions(+), 32 deletions(-)
> > =

> > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/d=
rm_gem_shmem_helper.c
> > index 3ecef571eff3..3838fb8d6f3a 100644
> > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > @@ -88,6 +88,13 @@ __drm_gem_shmem_create(struct drm_device *dev, size_=
t size, bool private)
> >   	INIT_LIST_HEAD(&shmem->madv_list);
> > +	/*
> > +	 * Eviction and purging are disabled by default, shmem user must enab=
le
> > +	 * them explicitly using drm_gem_shmem_set_evictable/purgeable().
> > +	 */
> > +	shmem->eviction_disable_count =3D 1;
> > +	shmem->purging_disable_count =3D 1;
> > +
> >   	if (!private) {
> >   		/*
> >   		 * Our buffers are kept pinned, so allocating them
> > @@ -126,6 +133,107 @@ struct drm_gem_shmem_object *drm_gem_shmem_create=
(struct drm_device *dev, size_t
> >   }
> >   EXPORT_SYMBOL_GPL(drm_gem_shmem_create);
> > +static void
> > +drm_gem_shmem_add_pages_to_shrinker(struct drm_gem_shmem_object *shmem)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +	struct drm_gem_shmem_shrinker *gem_shrinker =3D obj->dev->shmem_shrin=
ker;
> > +	size_t page_count =3D obj->size >> PAGE_SHIFT;
> > +
> > +	if (!shmem->pages_shrinkable) {
> > +		WARN_ON(gem_shrinker->shrinkable_count + page_count < page_count);
> > +		gem_shrinker->shrinkable_count +=3D page_count;
> > +		shmem->pages_shrinkable =3D true;
> > +	}
> > +}
> > +
> > +static void
> > +drm_gem_shmem_remove_pages_from_shrinker(struct drm_gem_shmem_object *=
shmem)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +	struct drm_gem_shmem_shrinker *gem_shrinker =3D obj->dev->shmem_shrin=
ker;
> > +	size_t page_count =3D obj->size >> PAGE_SHIFT;
> > +
> > +	if (shmem->pages_shrinkable) {
> > +		WARN_ON(gem_shrinker->shrinkable_count < page_count);
> > +		gem_shrinker->shrinkable_count -=3D page_count;
> > +		shmem->pages_shrinkable =3D false;
> > +	}
> > +}
> > +
> > +static void
> > +drm_gem_shmem_set_pages_state_locked(struct drm_gem_shmem_object *shme=
m,
> > +				     enum drm_gem_shmem_pages_state new_state)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +	struct drm_gem_shmem_shrinker *gem_shrinker =3D obj->dev->shmem_shrin=
ker;
> > +
> > +	lockdep_assert_held(&gem_shrinker->lock);
> > +	lockdep_assert_held(&obj->resv->lock.base);
> > +
> > +	if (new_state >=3D DRM_GEM_SHMEM_PAGES_STATE_PINNED) {
> > +		if (drm_gem_shmem_is_evictable(shmem))
> > +			new_state =3D DRM_GEM_SHMEM_PAGES_STATE_EVICTABLE;
> > +
> > +		if (drm_gem_shmem_is_purgeable(shmem))
> > +			new_state =3D DRM_GEM_SHMEM_PAGES_STATE_PURGEABLE;
> > +
> > +		if (!shmem->pages)
> > +			new_state =3D DRM_GEM_SHMEM_PAGES_STATE_UNPINNED;
> > +
> > +		if (shmem->evicted)
> > +			new_state =3D DRM_GEM_SHMEM_PAGES_STATE_EVICTED;
> > +	}
> > +
> > +	if (shmem->pages_state =3D=3D new_state)
> > +		return;
> > +
> > +	switch (new_state) {
> > +	case DRM_GEM_SHMEM_PAGES_STATE_UNPINNED:
> > +	case DRM_GEM_SHMEM_PAGES_STATE_PURGED:
> > +		drm_gem_shmem_remove_pages_from_shrinker(shmem);
> > +		list_del_init(&shmem->madv_list);
> > +		break;
> > +
> > +	case DRM_GEM_SHMEM_PAGES_STATE_PINNED:
> > +		drm_gem_shmem_remove_pages_from_shrinker(shmem);
> > +		list_move_tail(&shmem->madv_list, &gem_shrinker->lru_active);
> > +		break;
> > +
> > +	case DRM_GEM_SHMEM_PAGES_STATE_PURGEABLE:
> > +		drm_gem_shmem_add_pages_to_shrinker(shmem);
> > +		list_move_tail(&shmem->madv_list, &gem_shrinker->lru_purgeable);
> > +		break;
> > +
> > +	case DRM_GEM_SHMEM_PAGES_STATE_EVICTABLE:
> > +		drm_gem_shmem_add_pages_to_shrinker(shmem);
> > +		list_move_tail(&shmem->madv_list, &gem_shrinker->lru_evictable);
> > +		break;
> > +
> > +	case DRM_GEM_SHMEM_PAGES_STATE_EVICTED:
> > +		drm_gem_shmem_remove_pages_from_shrinker(shmem);
> > +		list_move_tail(&shmem->madv_list, &gem_shrinker->lru_evicted);
> > +		break;
> > +	}
> > +
> > +	shmem->pages_state =3D new_state;
> > +}
> > +
> > +static void
> > +drm_gem_shmem_set_pages_state(struct drm_gem_shmem_object *shmem,
> > +			      enum drm_gem_shmem_pages_state new_state)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +	struct drm_gem_shmem_shrinker *gem_shrinker =3D obj->dev->shmem_shrin=
ker;
> > +
> > +	if (!gem_shrinker)
> > +		return;
> > +
> > +	mutex_lock(&gem_shrinker->lock);
> > +	drm_gem_shmem_set_pages_state_locked(shmem, new_state);
> > +	mutex_unlock(&gem_shrinker->lock);
> > +}
> > +
> >   /**
> >    * drm_gem_shmem_free - Free resources associated with a shmem GEM ob=
ject
> >    * @shmem: shmem GEM object to free
> > @@ -137,6 +245,9 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object=
 *shmem)
> >   {
> >   	struct drm_gem_object *obj =3D &shmem->base;
> > +	/* take out shmem GEM object from the memory shrinker */
> > +	drm_gem_shmem_madvise(shmem, -1);
> > +
> >   	WARN_ON(shmem->vmap_use_count);
> >   	if (obj->import_attach) {
> > @@ -148,7 +259,7 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object=
 *shmem)
> >   			sg_free_table(shmem->sgt);
> >   			kfree(shmem->sgt);
> >   		}
> > -		if (shmem->pages)
> > +		if (shmem->pages_use_count)
> >   			drm_gem_shmem_put_pages(shmem);
> >   	}
> > @@ -159,18 +270,226 @@ void drm_gem_shmem_free(struct drm_gem_shmem_obj=
ect *shmem)
> >   }
> >   EXPORT_SYMBOL_GPL(drm_gem_shmem_free);
> > -static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object =
*shmem)
> > +static void drm_gem_shmem_update_pages_state_locked(struct drm_gem_shm=
em_object *shmem)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +	struct drm_gem_shmem_shrinker *gem_shrinker =3D obj->dev->shmem_shrin=
ker;
> > +	enum drm_gem_shmem_pages_state new_state;
> > +
> > +	if (!gem_shrinker || obj->import_attach)
> > +		return;
> > +
> > +	mutex_lock(&gem_shrinker->lock);
> > +
> > +	if (!shmem->madv)
> > +		new_state =3D DRM_GEM_SHMEM_PAGES_STATE_PINNED;
> > +	else if (shmem->madv > 0)
> > +		new_state =3D DRM_GEM_SHMEM_PAGES_STATE_PURGEABLE;
> > +	else
> > +		new_state =3D DRM_GEM_SHMEM_PAGES_STATE_PURGED;
> > +
> > +	drm_gem_shmem_set_pages_state_locked(shmem, new_state);
> > +
> > +	mutex_unlock(&gem_shrinker->lock);
> > +}
> > +
> > +static void drm_gem_shmem_update_pages_state(struct drm_gem_shmem_obje=
ct *shmem)
> > +{
> > +	dma_resv_lock(shmem->base.resv, NULL);
> > +	drm_gem_shmem_update_pages_state_locked(shmem);
> > +	dma_resv_unlock(shmem->base.resv);
> > +}
> > +
> > +static int
> > +drm_gem_shmem_set_evictable_locked(struct drm_gem_shmem_object *shmem)
> > +{
> > +	int ret =3D 0;
> > +
> > +	WARN_ON_ONCE(!shmem->eviction_disable_count--);
> > +
> > +	if (shmem->madv < 0)
> > +		ret =3D -ENOMEM;
> > +
> > +	drm_gem_shmem_update_pages_state_locked(shmem);
> > +
> > +	return ret;
> > +}
> > +
> > +static int
> > +drm_gem_shmem_set_unevictable_locked(struct drm_gem_shmem_object *shme=
m)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +	int err;
> > +
> > +	if (shmem->madv < 0)
> > +		return -ENOMEM;
> > +
> > +	if (shmem->evicted) {
> > +		err =3D obj->funcs->swap_in(obj);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	shmem->eviction_disable_count++;
> > +
> > +	drm_gem_shmem_update_pages_state_locked(shmem);
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +drm_gem_shmem_set_purgeable_locked(struct drm_gem_shmem_object *shmem)
> > +{
> > +	int ret =3D 0;
> > +
> > +	WARN_ON_ONCE(!shmem->purging_disable_count--);
> > +
> > +	if (shmem->madv < 0)
> > +		ret =3D -ENOMEM;
> > +
> > +	drm_gem_shmem_update_pages_state_locked(shmem);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * drm_gem_shmem_set_purgeable() - Make GEM purgeable by memory shrink=
er
> > + * @shmem: shmem GEM object
> > + *
> > + * Tell memory shrinker that this GEM can be purged. Initially purging=
 is
> > + * disabled for all GEMs. Each set_pureable() call must have correspon=
ding
> > + * set_unpureable() call. If GEM was purged, then -ENOMEM is returned.
> > + *
> > + * Returns:
> > + * 0 on success or a negative error code on failure.
> > + */
> > +int drm_gem_shmem_set_purgeable(struct drm_gem_shmem_object *shmem)
> > +{
> > +	int ret;
> > +
> > +	dma_resv_lock(shmem->base.resv, NULL);
> > +	ret =3D drm_gem_shmem_set_purgeable_locked(shmem);
> > +	dma_resv_unlock(shmem->base.resv);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(drm_gem_shmem_set_purgeable);
> > +
> > +static int
> > +drm_gem_shmem_set_unpurgeable_locked(struct drm_gem_shmem_object *shme=
m)
> > +{
> > +	if (shmem->madv < 0)
> > +		return -ENOMEM;
> > +
> > +	shmem->purging_disable_count++;
> > +
> > +	drm_gem_shmem_update_pages_state_locked(shmem);
> > +
> > +	return 0;
> > +}
> > +
> > +static int
> > +drm_gem_shmem_set_purgeable_and_evictable_locked(struct drm_gem_shmem_=
object *shmem)
> > +{
> > +	int ret;
> > +
> > +	ret =3D drm_gem_shmem_set_evictable_locked(shmem);
> > +	if (!ret) {
> > +		ret =3D drm_gem_shmem_set_purgeable_locked(shmem);
> > +		if (ret)
> > +			drm_gem_shmem_set_unevictable_locked(shmem);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int
> > +drm_gem_shmem_set_unpurgeable_and_unevictable_locked(struct drm_gem_sh=
mem_object *shmem)
> > +{
> > +	int ret;
> > +
> > +	ret =3D drm_gem_shmem_set_unpurgeable_locked(shmem);
> > +	if (!ret) {
> > +		ret =3D drm_gem_shmem_set_unevictable_locked(shmem);
> > +		if (ret)
> > +			drm_gem_shmem_set_purgeable_locked(shmem);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * drm_gem_shmem_set_purgeable_and_evictable() - Make GEM unpurgeable =
and
> > + * 						 unevictable by memory shrinker
> > + * @shmem: shmem GEM object
> > + *
> > + * Tell memory shrinker that this GEM can't be purged and evicted. Each
> > + * set_purgeable_and_evictable() call must have corresponding
> > + * unpurgeable_and_unevictable() call. If GEM was purged, then -ENOMEM
> > + * is returned.
> > + *
> > + * Returns:
> > + * 0 on success or a negative error code on failure.
> > + */
> > +int drm_gem_shmem_set_purgeable_and_evictable(struct drm_gem_shmem_obj=
ect *shmem)
> > +{
> > +	int ret;
> > +
> > +	dma_resv_lock(shmem->base.resv, NULL);
> > +	ret =3D drm_gem_shmem_set_purgeable_and_evictable_locked(shmem);
> > +	dma_resv_unlock(shmem->base.resv);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(drm_gem_shmem_set_purgeable_and_evictable);
> > +
> > +/**
> > + * drm_gem_shmem_set_unpurgeable_and_unevictable() - Make GEM purgeabl=
e and
> > + * 						     evictable by memory shrinker
> > + * @shmem: shmem GEM object
> > + *
> > + * Tell memory shrinker that this GEM can be purged and evicted. Each
> > + * unpurgeable_and_unevictable() call must have corresponding
> > + * set_purgeable_and_evictable() call. If GEM was purged, then -ENOMEM
> > + * is returned.
> > + *
> > + * Returns:
> > + * 0 on success or a negative error code on failure.
> > + */
> > +int drm_gem_shmem_set_unpurgeable_and_unevictable(struct drm_gem_shmem=
_object *shmem)
> > +{
> > +	int ret;
> > +
> > +	ret =3D dma_resv_lock_interruptible(shmem->base.resv, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D drm_gem_shmem_set_unpurgeable_and_unevictable_locked(shmem);
> > +	dma_resv_unlock(shmem->base.resv);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(drm_gem_shmem_set_unpurgeable_and_unevictable);
> > +
> > +static int
> > +drm_gem_shmem_acquire_pages_locked(struct drm_gem_shmem_object *shmem)
> >   {
> >   	struct drm_gem_object *obj =3D &shmem->base;
> >   	struct page **pages;
> > -	if (shmem->pages_use_count++ > 0)
> > +	if (shmem->madv < 0) {
> > +		WARN_ON(shmem->pages);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	if (shmem->pages) {
> > +		WARN_ON(!shmem->evicted);
> >   		return 0;
> > +	}
> >   	pages =3D drm_gem_get_pages(obj);
> >   	if (IS_ERR(pages)) {
> >   		DRM_DEBUG_KMS("Failed to get pages (%ld)\n", PTR_ERR(pages));
> > -		shmem->pages_use_count =3D 0;
> >   		return PTR_ERR(pages);
> >   	}
> > @@ -189,6 +508,25 @@ static int drm_gem_shmem_get_pages_locked(struct d=
rm_gem_shmem_object *shmem)
> >   	return 0;
> >   }
> > +static int drm_gem_shmem_get_pages_locked(struct drm_gem_shmem_object =
*shmem)
> > +{
> > +	int err;
> > +
> > +	if (shmem->madv < 0)
> > +		return -ENOMEM;
> > +
> > +	if (shmem->pages_use_count++ > 0)
> > +		return 0;
> > +
> > +	err =3D drm_gem_shmem_acquire_pages_locked(shmem);
> > +	if (err) {
> > +		shmem->pages_use_count =3D 0;
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   /*
> >    * drm_gem_shmem_get_pages - Allocate backing pages for a shmem GEM o=
bject
> >    * @shmem: shmem GEM object
> > @@ -209,21 +547,38 @@ int drm_gem_shmem_get_pages(struct drm_gem_shmem_=
object *shmem)
> >   	if (ret)
> >   		return ret;
> >   	ret =3D drm_gem_shmem_get_pages_locked(shmem);
> > +
> > +	drm_gem_shmem_update_pages_state_locked(shmem);
> > +
> >   	dma_resv_unlock(shmem->base.resv);
> >   	return ret;
> >   }
> >   EXPORT_SYMBOL(drm_gem_shmem_get_pages);
> > -static void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object=
 *shmem)
> > +static void drm_gem_shmem_get_pages_no_fail(struct drm_gem_shmem_objec=
t *shmem)
> >   {
> > -	struct drm_gem_object *obj =3D &shmem->base;
> > +	WARN_ON(shmem->base.import_attach);
> > -	if (WARN_ON_ONCE(!shmem->pages_use_count))
> > -		return;
> > +	dma_resv_lock(shmem->base.resv, NULL);
> > -	if (--shmem->pages_use_count > 0)
> > +	if (drm_gem_shmem_get_pages_locked(shmem))
> > +		shmem->pages_use_count++;
> > +
> > +	drm_gem_shmem_update_pages_state_locked(shmem);
> > +
> > +	dma_resv_unlock(shmem->base.resv);
> > +}
> > +
> > +static void
> > +drm_gem_shmem_release_pages_locked(struct drm_gem_shmem_object *shmem)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +
> > +	if (!shmem->pages) {
> > +		WARN_ON(!shmem->evicted && shmem->madv >=3D 0);
> >   		return;
> > +	}
> >   #ifdef CONFIG_X86
> >   	if (shmem->map_wc)
> > @@ -236,6 +591,21 @@ static void drm_gem_shmem_put_pages_locked(struct =
drm_gem_shmem_object *shmem)
> >   	shmem->pages =3D NULL;
> >   }
> > +static void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object=
 *shmem)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +
> > +	lockdep_assert_held(&obj->resv->lock.base);
> > +
> > +	if (WARN_ON(!shmem->pages_use_count))
> > +		return;
> > +
> > +	if (--shmem->pages_use_count > 0)
> > +		return;
> > +
> > +	drm_gem_shmem_release_pages_locked(shmem);
> > +}
> > +
> >   /*
> >    * drm_gem_shmem_put_pages - Decrease use count on the backing pages =
for a shmem GEM object
> >    * @shmem: shmem GEM object
> > @@ -246,6 +616,7 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem_o=
bject *shmem)
> >   {
> >   	dma_resv_lock(shmem->base.resv, NULL);
> >   	drm_gem_shmem_put_pages_locked(shmem);
> > +	drm_gem_shmem_update_pages_state_locked(shmem);
> >   	dma_resv_unlock(shmem->base.resv);
> >   }
> >   EXPORT_SYMBOL(drm_gem_shmem_put_pages);
> > @@ -262,9 +633,21 @@ EXPORT_SYMBOL(drm_gem_shmem_put_pages);
> >    */
> >   int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem)
> >   {
> > +	int err;
> > +
> >   	WARN_ON(shmem->base.import_attach);
> > -	return drm_gem_shmem_get_pages(shmem);
> > +	err =3D drm_gem_shmem_set_unpurgeable_and_unevictable(shmem);
> > +	if (err)
> > +		return err;
> > +
> > +	err =3D drm_gem_shmem_get_pages(shmem);
> > +	if (err) {
> > +		drm_gem_shmem_set_purgeable_and_evictable(shmem);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> >   }
> >   EXPORT_SYMBOL(drm_gem_shmem_pin);
> > @@ -280,6 +663,7 @@ void drm_gem_shmem_unpin(struct drm_gem_shmem_objec=
t *shmem)
> >   	WARN_ON(shmem->base.import_attach);
> >   	drm_gem_shmem_put_pages(shmem);
> > +	drm_gem_shmem_set_purgeable_and_evictable(shmem);
> >   }
> >   EXPORT_SYMBOL(drm_gem_shmem_unpin);
> > @@ -359,7 +743,18 @@ int drm_gem_shmem_vmap(struct drm_gem_shmem_object=
 *shmem,
> >   	ret =3D dma_resv_lock_interruptible(shmem->base.resv, NULL);
> >   	if (ret)
> >   		return ret;
> > +
> > +	ret =3D drm_gem_shmem_set_unpurgeable_and_unevictable_locked(shmem);
> > +	if (ret)
> > +		goto unlock;
> > +
> >   	ret =3D drm_gem_shmem_vmap_locked(shmem, map);
> > +	if (ret)
> > +		drm_gem_shmem_set_purgeable_and_evictable_locked(shmem);
> > +	else
> > +		drm_gem_shmem_update_pages_state_locked(shmem);
> > +
> > +unlock:
> >   	dma_resv_unlock(shmem->base.resv);
> >   	return ret;
> > @@ -404,9 +799,9 @@ void drm_gem_shmem_vunmap(struct drm_gem_shmem_obje=
ct *shmem,
> >   {
> >   	dma_resv_lock(shmem->base.resv, NULL);
> >   	drm_gem_shmem_vunmap_locked(shmem, map);
> > +	drm_gem_shmem_update_pages_state_locked(shmem);
> > +	drm_gem_shmem_set_purgeable_and_evictable_locked(shmem);
> >   	dma_resv_unlock(shmem->base.resv);
> > -
> > -	drm_gem_shmem_update_purgeable_status(shmem);
> >   }
> >   EXPORT_SYMBOL(drm_gem_shmem_vunmap);
> > @@ -447,29 +842,140 @@ int drm_gem_shmem_madvise(struct drm_gem_shmem_o=
bject *shmem, int madv)
> >   	madv =3D shmem->madv;
> > +	drm_gem_shmem_update_pages_state_locked(shmem);
> > +
> >   	dma_resv_unlock(shmem->base.resv);
> >   	return (madv >=3D 0);
> >   }
> >   EXPORT_SYMBOL(drm_gem_shmem_madvise);
> > -void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem)
> > +/**
> > + * drm_gem_shmem_swap_in_pages_locked() - Moves shmem pages back to me=
mory
> > + * @shmem: shmem GEM object
> > + *
> > + * This function moves pages back to memory if they were previously ev=
icted
> > + * by the memory shrinker.
> > + *
> > + * Returns:
> > + * 0 on success or a negative error code on failure.
> > + */
> > +int drm_gem_shmem_swap_in_pages_locked(struct drm_gem_shmem_object *sh=
mem)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +	struct sg_table *sgt;
> > +	int ret;
> > +
> > +	lockdep_assert_held(&obj->resv->lock.base);
> > +
> > +	if (shmem->evicted) {
> > +		ret =3D drm_gem_shmem_acquire_pages_locked(shmem);
> > +		if (ret)
> > +			return ret;
> > +
> > +		sgt =3D drm_gem_shmem_get_sg_table(shmem);
> > +		if (IS_ERR(sgt))
> > +			return PTR_ERR(sgt);
> > +
> > +		ret =3D dma_map_sgtable(obj->dev->dev, sgt,
> > +				      DMA_BIDIRECTIONAL, 0);
> > +		if (ret) {
> > +			sg_free_table(sgt);
> > +			kfree(sgt);
> > +			return ret;
> > +		}
> > +
> > +		shmem->sgt =3D sgt;
> > +		shmem->evicted =3D false;
> > +		shmem->pages_state =3D DRM_GEM_SHMEM_PAGES_STATE_PINNED;
> > +
> > +		drm_gem_shmem_update_pages_state_locked(shmem);
> > +	}
> > +
> > +	return shmem->pages ? 0 : -ENOMEM;
> > +}
> > +EXPORT_SYMBOL_GPL(drm_gem_shmem_swap_in_pages_locked);
> > +
> > +/**
> > + * drm_gem_shmem_swap_in_locked() - Moves shmem GEM back to memory
> > + * @shmem: shmem GEM object
> > + *
> > + * This function moves shmem GEM back to memory if it was previously e=
victed
> > + * by the memory shrinker. The GEM is ready to use on success.
> > + *
> > + * Returns:
> > + * 0 on success or a negative error code on failure.
> > + */
> > +int drm_gem_shmem_swap_in_locked(struct drm_gem_shmem_object *shmem)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +
> > +	lockdep_assert_held(&obj->resv->lock.base);
> > +
> > +	if (shmem->evicted)
> > +		return obj->funcs->swap_in(obj);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(drm_gem_shmem_swap_in_locked);
> > +
> > +static void drm_gem_shmem_unpin_pages_locked(struct drm_gem_shmem_obje=
ct *shmem)
> >   {
> >   	struct drm_gem_object *obj =3D &shmem->base;
> >   	struct drm_device *dev =3D obj->dev;
> > -	WARN_ON(!drm_gem_shmem_is_purgeable(shmem));
> > +	if (shmem->evicted)
> > +		return;
> >   	dma_unmap_sgtable(dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
> > +	drm_gem_shmem_release_pages_locked(shmem);
> > +	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
> > +
> >   	sg_free_table(shmem->sgt);
> >   	kfree(shmem->sgt);
> >   	shmem->sgt =3D NULL;
> > +}
> > -	drm_gem_shmem_put_pages_locked(shmem);
> > +/**
> > + * drm_gem_shmem_evict_locked - Evict shmem pages
> > + * @shmem: shmem GEM object
> > + *
> > + * This function unpins shmem pages, allowing them to be swapped out f=
rom
> > + * memory.
> > + */
> > +void drm_gem_shmem_evict_locked(struct drm_gem_shmem_object *shmem)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > -	shmem->madv =3D -1;
> > +	lockdep_assert_held(&obj->resv->lock.base);
> > -	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
> > +	WARN_ON(!drm_gem_shmem_is_evictable(shmem));
> > +	WARN_ON(shmem->madv < 0);
> > +	WARN_ON(shmem->evicted);
> > +
> > +	drm_gem_shmem_unpin_pages_locked(shmem);
> > +
> > +	shmem->evicted =3D true;
> > +	drm_gem_shmem_set_pages_state(shmem, DRM_GEM_SHMEM_PAGES_STATE_EVICTE=
D);
> > +}
> > +EXPORT_SYMBOL_GPL(drm_gem_shmem_evict_locked);
> > +
> > +/**
> > + * drm_gem_shmem_purge_locked - Purge shmem pages
> > + * @shmem: shmem GEM object
> > + *
> > + * This function permanently releases shmem pages.
> > + */
> > +void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem)
> > +{
> > +	struct drm_gem_object *obj =3D &shmem->base;
> > +
> > +	lockdep_assert_held(&obj->resv->lock.base);
> > +
> > +	WARN_ON(!drm_gem_shmem_is_purgeable(shmem));
> > +	WARN_ON(shmem->madv < 0);
> > +
> > +	drm_gem_shmem_unpin_pages_locked(shmem);
> >   	drm_gem_free_mmap_offset(obj);
> >   	/* Our goal here is to return as much of the memory as
> > @@ -480,6 +986,9 @@ void drm_gem_shmem_purge_locked(struct drm_gem_shme=
m_object *shmem)
> >   	shmem_truncate_range(file_inode(obj->filp), 0, (loff_t)-1);
> >   	invalidate_mapping_pages(file_inode(obj->filp)->i_mapping, 0, (loff_=
t)-1);
> > +
> > +	shmem->madv =3D -1;
> > +	drm_gem_shmem_set_pages_state(shmem, DRM_GEM_SHMEM_PAGES_STATE_PURGED=
);
> >   }
> >   EXPORT_SYMBOL(drm_gem_shmem_purge_locked);
> > @@ -543,22 +1052,31 @@ static vm_fault_t drm_gem_shmem_fault(struct vm_=
fault *vmf)
> >   	vm_fault_t ret;
> >   	struct page *page;
> >   	pgoff_t page_offset;
> > +	bool pages_inactive;
> > +	int err;
> >   	/* We don't use vmf->pgoff since that has the fake offset */
> >   	page_offset =3D (vmf->address - vma->vm_start) >> PAGE_SHIFT;
> >   	dma_resv_lock(shmem->base.resv, NULL);
> > -	if (page_offset >=3D num_pages ||
> > -	    WARN_ON_ONCE(!shmem->pages) ||
> > -	    shmem->madv < 0) {
> > +	pages_inactive =3D shmem->pages_state < DRM_GEM_SHMEM_PAGES_STATE_PIN=
NED;
> > +	WARN_ON_ONCE(!shmem->pages ^ pages_inactive);
> > +
> > +	if (page_offset >=3D num_pages || (!shmem->pages && !shmem->evicted))=
 {
> >   		ret =3D VM_FAULT_SIGBUS;
> >   	} else {
> > +		err =3D drm_gem_shmem_swap_in_locked(shmem);
> > +		if (err) {
> > +			ret =3D VM_FAULT_OOM;
> > +			goto unlock;
> > +		}
> > +
> >   		page =3D shmem->pages[page_offset];
> >   		ret =3D vmf_insert_pfn(vma, vmf->address, page_to_pfn(page));
> >   	}
> > -
> > +unlock:
> >   	dma_resv_unlock(shmem->base.resv);
> >   	return ret;
> > @@ -568,13 +1086,8 @@ static void drm_gem_shmem_vm_open(struct vm_area_=
struct *vma)
> >   {
> >   	struct drm_gem_object *obj =3D vma->vm_private_data;
> >   	struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(obj);
> > -	int ret;
> > -
> > -	WARN_ON(shmem->base.import_attach);
> > -
> > -	ret =3D drm_gem_shmem_get_pages(shmem);
> > -	WARN_ON_ONCE(ret !=3D 0);
> > +	drm_gem_shmem_get_pages_no_fail(shmem);
> >   	drm_gem_vm_open(vma);
> >   }
> > @@ -716,6 +1229,8 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struc=
t drm_gem_shmem_object *shmem)
> >   	shmem->sgt =3D sgt;
> > +	drm_gem_shmem_update_pages_state(shmem);
> > +
> >   	return sgt;
> >   err_free_sgt:
> > @@ -762,6 +1277,202 @@ drm_gem_shmem_prime_import_sg_table(struct drm_d=
evice *dev,
> >   }
> >   EXPORT_SYMBOL_GPL(drm_gem_shmem_prime_import_sg_table);
> > +static struct drm_gem_shmem_shrinker *
> > +to_drm_shrinker(struct shrinker *shrinker)
> > +{
> > +	return container_of(shrinker, struct drm_gem_shmem_shrinker, base);
> > +}
> > +
> > +static unsigned long
> > +drm_gem_shmem_shrinker_count_objects(struct shrinker *shrinker,
> > +				     struct shrink_control *sc)
> > +{
> > +	struct drm_gem_shmem_shrinker *gem_shrinker =3D to_drm_shrinker(shrin=
ker);
> > +	u64 count =3D READ_ONCE(gem_shrinker->shrinkable_count);
> > +
> > +	if (count >=3D SHRINK_EMPTY)
> > +		return SHRINK_EMPTY - 1;
> > +
> > +	return count ?: SHRINK_EMPTY;
> > +}
> > +
> > +static unsigned long
> > +drm_gem_shmem_shrinker_run_objects_scan(struct shrinker *shrinker,
> > +					unsigned long nr_to_scan,
> > +					bool *lock_contention,
> > +					bool evict)
> > +{
> > +	struct drm_gem_shmem_shrinker *gem_shrinker =3D to_drm_shrinker(shrin=
ker);
> > +	struct drm_gem_shmem_object *shmem;
> > +	struct list_head still_in_list;
> > +	struct drm_gem_object *obj;
> > +	unsigned long freed =3D 0;
> > +	struct list_head *lru;
> > +	size_t page_count;
> > +
> > +	INIT_LIST_HEAD(&still_in_list);
> > +
> > +	mutex_lock(&gem_shrinker->lock);
> > +
> > +	if (evict)
> > +		lru =3D &gem_shrinker->lru_evictable;
> > +	else
> > +		lru =3D &gem_shrinker->lru_purgeable;
> > +
> > +	while (freed < nr_to_scan) {
> > +		shmem =3D list_first_entry_or_null(lru, typeof(*shmem), madv_list);
> > +		if (!shmem)
> > +			break;
> > +
> > +		obj =3D &shmem->base;
> > +		page_count =3D obj->size >> PAGE_SHIFT;
> > +		list_move_tail(&shmem->madv_list, &still_in_list);
> > +
> > +		if (evict && get_nr_swap_pages() < page_count)
> > +			continue;
> > +
> > +		/*
> > +		 * If it's in the process of being freed, gem_object->free()
> > +		 * may be blocked on lock waiting to remove it.  So just
> > +		 * skip it.
> > +		 */
> > +		if (!kref_get_unless_zero(&obj->refcount))
> > +			continue;
> > +
> > +		mutex_unlock(&gem_shrinker->lock);
> > +
> > +		/* prevent racing with job-submission code paths */
> > +		if (!dma_resv_trylock(obj->resv)) {
> > +			*lock_contention |=3D true;
> > +			goto shrinker_lock;
> > +		}
> > +
> > +		/* prevent racing with the dma-buf exporting */
> > +		if (!mutex_trylock(&gem_shrinker->dev->object_name_lock)) {
> > +			*lock_contention |=3D true;
> > +			goto resv_unlock;
> > +		}
> > +
> > +		/* check whether h/w uses this object */
> > +		if (!dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_WRITE))
> > +			goto object_name_unlock;
> > +
> > +		/* GEM may've become unpurgeable while shrinker was unlocked */
> > +		if (evict) {
> > +			if (!drm_gem_shmem_is_evictable(shmem))
> > +				goto object_name_unlock;
> > +		} else {
> > +			if (!drm_gem_shmem_is_purgeable(shmem))
> > +				goto object_name_unlock;
> > +		}
> > +
> > +		if (evict)
> > +			freed +=3D obj->funcs->evict(obj);
> > +		else
> > +			freed +=3D obj->funcs->purge(obj);
> > +object_name_unlock:
> > +		mutex_unlock(&gem_shrinker->dev->object_name_lock);
> > +resv_unlock:
> > +		dma_resv_unlock(obj->resv);
> > +shrinker_lock:
> > +		drm_gem_object_put(&shmem->base);
> > +		mutex_lock(&gem_shrinker->lock);
> > +	}
> > +
> > +	list_splice_tail(&still_in_list, lru);
> > +
> > +	mutex_unlock(&gem_shrinker->lock);
> > +
> > +	return freed;
> > +}
> > +
> > +static unsigned long
> > +drm_gem_shmem_shrinker_scan_objects(struct shrinker *shrinker,
> > +				    struct shrink_control *sc)
> > +{
> > +	unsigned long nr_to_scan =3D sc->nr_to_scan;
> > +	bool lock_contention =3D false;
> > +	unsigned long freed;
> > +
> > +	/* purge as many objects as we can */
> > +	freed =3D drm_gem_shmem_shrinker_run_objects_scan(shrinker, nr_to_sca=
n,
> > +							&lock_contention, false);
> > +	nr_to_scan -=3D freed;
> > +
> > +	/* evict as many objects as we can */
> > +	if (freed < nr_to_scan)
> > +		freed +=3D drm_gem_shmem_shrinker_run_objects_scan(shrinker,
> > +								 nr_to_scan,
> > +								 &lock_contention,
> > +								 true);
> > +
> > +	return (!freed && !lock_contention) ? SHRINK_STOP : freed;
> > +}
> > +
> > +/**
> > + * drm_gem_shmem_shrinker_register() - Register shmem shrinker
> > + * @dev: DRM device
> > + *
> > + * Returns:
> > + * 0 on success or a negative error code on failure.
> > + */
> > +int drm_gem_shmem_shrinker_register(struct drm_device *dev)
> > +{
> > +	struct drm_gem_shmem_shrinker *gem_shrinker;
> > +	int err;
> > +
> > +	if (WARN_ON(dev->shmem_shrinker))
> > +		return -EBUSY;
> > +
> > +	gem_shrinker =3D kzalloc(sizeof(*gem_shrinker), GFP_KERNEL);
> > +	if (!gem_shrinker)
> > +		return -ENOMEM;
> > +
> > +	gem_shrinker->base.count_objects =3D drm_gem_shmem_shrinker_count_obj=
ects;
> > +	gem_shrinker->base.scan_objects =3D drm_gem_shmem_shrinker_scan_objec=
ts;
> > +	gem_shrinker->base.seeks =3D DEFAULT_SEEKS;
> > +	gem_shrinker->dev =3D dev;
> > +
> > +	INIT_LIST_HEAD(&gem_shrinker->lru_purgeable);
> > +	INIT_LIST_HEAD(&gem_shrinker->lru_evictable);
> > +	INIT_LIST_HEAD(&gem_shrinker->lru_evicted);
> > +	INIT_LIST_HEAD(&gem_shrinker->lru_active);
> > +	mutex_init(&gem_shrinker->lock);
> > +
> > +	dev->shmem_shrinker =3D gem_shrinker;
> > +
> > +	err =3D register_shrinker(&gem_shrinker->base);
> > +	if (err) {
> > +		dev->shmem_shrinker =3D NULL;
> > +		kfree(gem_shrinker);
> > +		return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(drm_gem_shmem_shrinker_register);
> > +
> > +/**
> > + * drm_gem_shmem_shrinker_unregister() - Unregister shmem shrinker
> > + * @dev: DRM device
> > + */
> > +void drm_gem_shmem_shrinker_unregister(struct drm_device *dev)
> > +{
> > +	struct drm_gem_shmem_shrinker *gem_shrinker =3D dev->shmem_shrinker;
> > +
> > +	if (gem_shrinker) {
> > +		unregister_shrinker(&gem_shrinker->base);
> > +		WARN_ON(!list_empty(&gem_shrinker->lru_purgeable));
> > +		WARN_ON(!list_empty(&gem_shrinker->lru_evictable));
> > +		WARN_ON(!list_empty(&gem_shrinker->lru_evicted));
> > +		WARN_ON(!list_empty(&gem_shrinker->lru_active));
> > +		mutex_destroy(&gem_shrinker->lock);
> > +		dev->shmem_shrinker =3D NULL;
> > +		kfree(gem_shrinker);
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(drm_gem_shmem_shrinker_unregister);
> > +
> >   MODULE_DESCRIPTION("DRM SHMEM memory-management helpers");
> >   MODULE_IMPORT_NS(DMA_BUF);
> >   MODULE_LICENSE("GPL v2");
> > diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> > index 9923c7a6885e..929546cad894 100644
> > --- a/include/drm/drm_device.h
> > +++ b/include/drm/drm_device.h
> > @@ -16,6 +16,7 @@ struct drm_vblank_crtc;
> >   struct drm_vma_offset_manager;
> >   struct drm_vram_mm;
> >   struct drm_fb_helper;
> > +struct drm_gem_shmem_shrinker;
> >   struct inode;
> > @@ -277,6 +278,9 @@ struct drm_device {
> >   	/** @vram_mm: VRAM MM memory manager */
> >   	struct drm_vram_mm *vram_mm;
> > +	/** @shmem_shrinker: SHMEM GEM memory shrinker */
> > +	struct drm_gem_shmem_shrinker *shmem_shrinker;
> > +
> >   	/**
> >   	 * @switch_power_state:
> >   	 *
> > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > index 9d7c61a122dc..390d1ce08ed3 100644
> > --- a/include/drm/drm_gem.h
> > +++ b/include/drm/drm_gem.h
> > @@ -172,6 +172,41 @@ struct drm_gem_object_funcs {
> >   	 * This is optional but necessary for mmap support.
> >   	 */
> >   	const struct vm_operations_struct *vm_ops;
> > +
> > +	/**
> > +	 * @purge:
> > +	 *
> > +	 * Releases the GEM object's allocated backing storage to the system.
> > +	 *
> > +	 * Returns the number of pages that have been freed by purging the GE=
M object.
> > +	 *
> > +	 * This callback is used by the GEM shrinker.
> > +	 */
> > +	unsigned long (*purge)(struct drm_gem_object *obj);
> > +
> > +	/**
> > +	 * @evict:
> > +	 *
> > +	 * Unpins the GEM object's allocated backing storage, allowing shmem =
pages
> > +	 * to be swapped out.
> > +	 *
> > +	 * Returns the number of pages that have been unpinned.
> > +	 *
> > +	 * This callback is used by the GEM shrinker.
> > +	 */
> > +	unsigned long (*evict)(struct drm_gem_object *obj);
> > +
> > +	/**
> > +	 * @swap_in:
> > +	 *
> > +	 * Pins GEM object's allocated backing storage if it was previously e=
victed,
> > +	 * moving swapped out pages back to memory.
> > +	 *
> > +	 * Returns 0 on success, or -errno on error.
> > +	 *
> > +	 * This callback is used by the GEM shrinker.
> > +	 */
> > +	int (*swap_in)(struct drm_gem_object *obj);
> >   };
> >   /**
> > diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_s=
hmem_helper.h
> > index 70889533962a..a65557b446e6 100644
> > --- a/include/drm/drm_gem_shmem_helper.h
> > +++ b/include/drm/drm_gem_shmem_helper.h
> > @@ -6,6 +6,7 @@
> >   #include <linux/fs.h>
> >   #include <linux/mm.h>
> >   #include <linux/mutex.h>
> > +#include <linux/shrinker.h>
> >   #include <drm/drm_file.h>
> >   #include <drm/drm_gem.h>
> > @@ -15,8 +16,18 @@
> >   struct dma_buf_attachment;
> >   struct drm_mode_create_dumb;
> >   struct drm_printer;
> > +struct drm_device;
> >   struct sg_table;
> > +enum drm_gem_shmem_pages_state {
> > +	DRM_GEM_SHMEM_PAGES_STATE_PURGED =3D -2,
> > +	DRM_GEM_SHMEM_PAGES_STATE_EVICTED =3D -1,
> > +	DRM_GEM_SHMEM_PAGES_STATE_UNPINNED =3D 0,
> > +	DRM_GEM_SHMEM_PAGES_STATE_PINNED =3D 1,
> > +	DRM_GEM_SHMEM_PAGES_STATE_EVICTABLE =3D 2,
> > +	DRM_GEM_SHMEM_PAGES_STATE_PURGEABLE =3D 3,
> > +};
> > +
> >   /**
> >    * struct drm_gem_shmem_object - GEM object backed by shmem
> >    */
> > @@ -43,8 +54,8 @@ struct drm_gem_shmem_object {
> >   	 * @madv: State for madvise
> >   	 *
> >   	 * 0 is active/inuse.
> > +	 * 1 is not-needed/can-be-purged
> >   	 * A negative value is the object is purged.
> > -	 * Positive values are driver specific and not used by the helpers.
> >   	 */
> >   	int madv;
> > @@ -91,6 +102,40 @@ struct drm_gem_shmem_object {
> >   	 * @map_wc: map object write-combined (instead of using shmem defaul=
ts).
> >   	 */
> >   	bool map_wc;
> > +
> > +	/**
> > +	 * @eviction_disable_count:
> > +	 *
> > +	 * The shmem pages are disallowed to be evicted by the memory shrinker
> > +	 * while count is non-zero. Used internally by memory shrinker.
> > +	 */
> > +	unsigned int eviction_disable_count;
> > +
> > +	/**
> > +	 * @purging_disable_count:
> > +	 *
> > +	 * The shmem pages are disallowed to be purged by the memory shrinker
> > +	 * while count is non-zero. Used internally by memory shrinker.
> > +	 */
> > +	unsigned int purging_disable_count;
> > +
> > +	/**
> > +	 * @pages_state: Current state of shmem pages. Used internally by
> > +	 * memory shrinker.
> > +	 */
> > +	enum drm_gem_shmem_pages_state pages_state;
> > +
> > +	/**
> > +	 * @evicted: True if shmem pages were evicted by the memory shrinker.
> > +	 * Used internally by memory shrinker.
> > +	 */
> > +	bool evicted;
> > +
> > +	/**
> > +	 * @pages_shrinkable: True if shmem pages can be evicted or purged
> > +	 * by the memory shrinker. Used internally by memory shrinker.
> > +	 */
> > +	bool pages_shrinkable;
> >   };
> >   #define to_drm_gem_shmem_obj(obj) \
> > @@ -111,15 +156,33 @@ int drm_gem_shmem_mmap(struct drm_gem_shmem_objec=
t *shmem, struct vm_area_struct
> >   int drm_gem_shmem_madvise(struct drm_gem_shmem_object *shmem, int mad=
v);
> > +int drm_gem_shmem_set_purgeable(struct drm_gem_shmem_object *shmem);
> > +int drm_gem_shmem_set_purgeable_and_evictable(struct drm_gem_shmem_obj=
ect *shmem);
> > +int drm_gem_shmem_set_unpurgeable_and_unevictable(struct drm_gem_shmem=
_object *shmem);
> > +
> > +static inline bool drm_gem_shmem_is_evictable(struct drm_gem_shmem_obj=
ect *shmem)
> > +{
> > +	return (shmem->madv >=3D 0) && !shmem->eviction_disable_count &&
> > +		shmem->base.funcs->evict && shmem->base.funcs->swap_in &&
> > +		!shmem->vmap_use_count && !shmem->base.dma_buf &&
> > +		!shmem->base.import_attach && shmem->sgt;
> > +}
> > +
> >   static inline bool drm_gem_shmem_is_purgeable(struct drm_gem_shmem_ob=
ject *shmem)
> >   {
> > -	return (shmem->madv > 0) &&
> > -		!shmem->vmap_use_count && shmem->sgt &&
> > -		!shmem->base.dma_buf && !shmem->base.import_attach;
> > +	return (shmem->madv > 0) && !shmem->purging_disable_count &&
> > +		!shmem->vmap_use_count && shmem->base.funcs->purge &&
> > +		!shmem->base.dma_buf && !shmem->base.import_attach &&
> > +		shmem->sgt;
> >   }
> > -void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem);
> > +int drm_gem_shmem_swap_in_pages_locked(struct drm_gem_shmem_object *sh=
mem);
> > +int drm_gem_shmem_swap_in_locked(struct drm_gem_shmem_object *shmem);
> > +
> > +void drm_gem_shmem_evict_locked(struct drm_gem_shmem_object *shmem);
> > +
> >   bool drm_gem_shmem_purge(struct drm_gem_shmem_object *shmem);
> > +void drm_gem_shmem_purge_locked(struct drm_gem_shmem_object *shmem);
> >   struct sg_table *drm_gem_shmem_get_sg_table(struct drm_gem_shmem_obje=
ct *shmem);
> >   struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_obj=
ect *shmem);
> > @@ -262,6 +325,38 @@ static inline int drm_gem_shmem_object_mmap(struct=
 drm_gem_object *obj, struct v
> >   	return drm_gem_shmem_mmap(shmem, vma);
> >   }
> > +/**
> > + * struct drm_gem_shmem_shrinker - Generic memory shrinker for shmem G=
EMs
> > + */
> > +struct drm_gem_shmem_shrinker {
> > +	/** @base: Shrinker for purging shmem GEM objects */
> > +	struct shrinker base;
> > +
> > +	/** @lock: Protects @lru_* */
> > +	struct mutex lock;
> > +
> > +	/** @lru_purgeable: List of shmem GEM objects available for purging */
> > +	struct list_head lru_purgeable;
> > +
> > +	/** @lru_active: List of active shmem GEM objects */
> > +	struct list_head lru_active;
> > +
> > +	/** @lru_evictable: List of shmem GEM objects that can be evicted */
> > +	struct list_head lru_evictable;
> > +
> > +	/** @lru_evicted: List of evicted shmem GEM objects */
> > +	struct list_head lru_evicted;
> > +
> > +	/** @dev: DRM device that uses this shrinker */
> > +	struct drm_device *dev;
> > +
> > +	/** @shrinkable_count: Count of shmem GEM pages to be purged and evic=
ted */
> > +	u64 shrinkable_count;
> > +};
> > +
> > +int drm_gem_shmem_shrinker_register(struct drm_device *dev);
> > +void drm_gem_shmem_shrinker_unregister(struct drm_device *dev);
> > +
> >   /*
> >    * Driver ops
> >    */
> =

> -- =

> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> (HRB 36809, AG N=FCrnberg)
> Gesch=E4ftsf=FChrer: Ivo Totev




-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
