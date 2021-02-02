Return-Path: <SRS0=DeSX=HE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26532C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 14:11:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB04B64EDA
	for <virtualization@archiver.kernel.org>; Tue,  2 Feb 2021 14:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB04B64EDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 902888523B;
	Tue,  2 Feb 2021 14:11:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id elWAx649pP2Q; Tue,  2 Feb 2021 14:11:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D42F585055;
	Tue,  2 Feb 2021 14:11:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB943C0174;
	Tue,  2 Feb 2021 14:11:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33EB6C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:11:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 21ED284BF1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Afsv+I1DhQ3p
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:11:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2114584B89
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Feb 2021 14:11:34 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id l12so1535542wmq.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Feb 2021 06:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=nNUotO5RGkqjnMAKfih0mDKNZwfN8WA2MKXbQdWQwII=;
 b=gXHqLI0koSbEE8gy/dWeNdoPMKa6qwjJp/K27iGcTda8+4K1udNDzYV4UCHXqvfiEe
 8STPzP5aLZCDibLuuyYZMusSRgXxr8fwj9vs4vYfcQREMnrUvG2HXxacNrVXl9hst3Ld
 nWRrHi9f242PVwqKR5XMY0Ms7ad4a0HJtIpb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nNUotO5RGkqjnMAKfih0mDKNZwfN8WA2MKXbQdWQwII=;
 b=M198HfExUNWCHkkTjsLwyfuBPIifruME+qhQJg5RyIcY1vck+FEOk6SCC3i8TnAWdr
 OL7hhhQowJAETYVUXA5V7mc5dB9zdlm9pCeexLzxRv9GZMqrLRGqaIK9Ke09pN+kSA4g
 dXAo0Jiyd0IBgv0OnAOGOokYalV1Em0nJo6edo9eKVaqdrRLhKIGM3ydQ/L7HapkhAyR
 0PGdiW5eg+6C9CpGOKsIeyTJrpW5X8B2uUf6rpQ/0jkjLl/POHnELsMdRGef1sgKisLF
 FJ0nUz3OR+U5eaPGdUiLqhCroGnLgh92UF2v4I49OY9d8czcOH/tmcEAdFwY3Ec8LW8+
 zRXQ==
X-Gm-Message-State: AOAM530Jhtm+3Qwqea0p06APxsTNnhNJSPbxtorOdGVjcX6i30yPuRAy
 4XJNzXa4hxQfIfPITTG9si/0EA==
X-Google-Smtp-Source: ABdhPJyKbCZyvz/F7BjnngYPMyYGLYOF0G/H26ZKHIgPG3MddYAgM4IDB8oQ1Wh+DC6w7Sd+YiS7JQ==
X-Received: by 2002:a1c:2c89:: with SMTP id s131mr3841413wms.176.1612275093141; 
 Tue, 02 Feb 2021 06:11:33 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id u10sm3201892wmj.40.2021.02.02.06.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 06:11:32 -0800 (PST)
Date: Tue, 2 Feb 2021 15:11:30 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 04/13] drm/shmem-helper: Provide a vmap function for
 short-term mappings
Message-ID: <YBldkhUXF+SFPaSy@phenom.ffwll.local>
References: <20210108094340.15290-1-tzimmermann@suse.de>
 <20210108094340.15290-5-tzimmermann@suse.de>
 <X/yB3LC79f/zWTwG@phenom.ffwll.local>
 <006b7d47-e7dd-8fa6-6cf1-eff194d7b30f@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <006b7d47-e7dd-8fa6-6cf1-eff194d7b30f@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: sean@poorly.run, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 hdegoede@redhat.com, Daniel Vetter <daniel@ffwll.ch>, airlied@redhat.com,
 sam@ravnborg.org, christian.koenig@amd.com, linux-media@vger.kernel.org
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

On Wed, Jan 27, 2021 at 01:08:05PM +0100, Thomas Zimmermann wrote:
> Hi
> =

> Am 11.01.21 um 17:50 schrieb Daniel Vetter:
> > On Fri, Jan 08, 2021 at 10:43:31AM +0100, Thomas Zimmermann wrote:
> > > Implementations of the vmap/vunmap GEM callbacks may perform pinning
> > > of the BO and may acquire the associated reservation object's lock.
> > > Callers that only require a mapping of the contained memory can thus
> > > interfere with other tasks that require exact pinning, such as scanou=
t.
> > > This is less of an issue with private SHMEM buffers, but may happen
> > > with imported ones.
> > > =

> > > Therefore provide the new interfaces drm_gem_shmem_vmap_local() and
> > > drm_gem_shmem_vunmap_local(), which only perform the vmap/vunmap
> > > operations. Callers have to hold the reservation lock while the mappi=
ng
> > > persists.
> > > =

> > > This patch also connects GEM SHMEM helpers to GEM object functions wi=
th
> > > equivalent functionality.
> > > =

> > > v4:
> > > 	* call dma_buf_{vmap,vunmap}_local() where necessary (Daniel)
> > > 	* move driver changes into separate patches (Daniel)
> > > =

> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > ---
> > >   drivers/gpu/drm/drm_gem_shmem_helper.c | 90 +++++++++++++++++++++++=
---
> > >   include/drm/drm_gem_shmem_helper.h     |  2 +
> > >   2 files changed, 84 insertions(+), 8 deletions(-)
> > > =

> > > diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm=
/drm_gem_shmem_helper.c
> > > index 9825c378dfa6..298832b2b43b 100644
> > > --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > > @@ -32,6 +32,8 @@ static const struct drm_gem_object_funcs drm_gem_sh=
mem_funcs =3D {
> > >   	.get_sg_table =3D drm_gem_shmem_get_sg_table,
> > >   	.vmap =3D drm_gem_shmem_vmap,
> > >   	.vunmap =3D drm_gem_shmem_vunmap,
> > > +	.vmap_local =3D drm_gem_shmem_vmap_local,
> > > +	.vunmap_local =3D drm_gem_shmem_vunmap_local,
> > >   	.mmap =3D drm_gem_shmem_mmap,
> > >   };
> > > @@ -261,7 +263,8 @@ void drm_gem_shmem_unpin(struct drm_gem_object *o=
bj)
> > >   }
> > >   EXPORT_SYMBOL(drm_gem_shmem_unpin);
> > > -static int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *sh=
mem, struct dma_buf_map *map)
> > > +static int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *sh=
mem, struct dma_buf_map *map,
> > > +				     bool local)
> > =

> > This is a bit spaghetti and also has the problem that we're not changing
> > shmem->vmap_use_count under different locks, depending upon which path
> > we're taking.
> > =

> > I think the cleanest would be if we pull the if (import_attach) case out
> > of the _locked() version completely, for all cases, and also outside of
> > the shmem->vmap_lock. This means no caching of vmaps in the shmem layer
> > anymore for imported buffers, but this is no longer a problem: We cache
> > them in the exporters instead (I think at least, if not maybe need to f=
ix
> > that where it's expensive).
> =

> There's no vmap refcounting in amdgpu AFAICT. So importing pages from the=
re
> into an SHMEM object has the potential of breaking. IIRC same fro radeon =
and
> nouveau.

As long as the pinning is refcounted I think it should be fine, it's just
that if you have multiple vmaps (e.g. 2 udl devices plugged in) we'll set
up 2 vmaps. Which is a point pointless, but not really harmful. At least
on 64bit where there's enough virtual address space.

> So I'm somewhat reluctant to making this change. I guess I'll look elsewh=
ere
> first to fix some of the locking issues (e.g., my recent ast cursor
> patches).

If this would break for amdgpu/radeon/nouveau then we already have a bug,
since 2 udl devices can provoke this issue already as-is. So I don't think
this should be a blocker.
-Daniel

> =

> Best regards
> Thomas
> =

> > =

> > Other option would be to unly pull it out for the _vmap_local case, but
> > that's a bit ugly because no longer symmetrical in the various paths.
> > =

> > >   {
> > >   	struct drm_gem_object *obj =3D &shmem->base;
> > >   	int ret =3D 0;
> > > @@ -272,7 +275,10 @@ static int drm_gem_shmem_vmap_locked(struct drm_=
gem_shmem_object *shmem, struct
> > >   	}
> > >   	if (obj->import_attach) {
> > > -		ret =3D dma_buf_vmap(obj->import_attach->dmabuf, map);
> > > +		if (local)
> > > +			ret =3D dma_buf_vmap_local(obj->import_attach->dmabuf, map);
> > > +		else
> > > +			ret =3D dma_buf_vmap(obj->import_attach->dmabuf, map);
> > >   		if (!ret) {
> > >   			if (WARN_ON(map->is_iomem)) {
> > >   				ret =3D -EIO;
> > > @@ -313,7 +319,7 @@ static int drm_gem_shmem_vmap_locked(struct drm_g=
em_shmem_object *shmem, struct
> > >   	return ret;
> > >   }
> > > -/*
> > > +/**
> > >    * drm_gem_shmem_vmap - Create a virtual mapping for a shmem GEM ob=
ject
> > >    * @shmem: shmem GEM object
> > >    * @map: Returns the kernel virtual address of the SHMEM GEM object=
's backing
> > > @@ -339,15 +345,53 @@ int drm_gem_shmem_vmap(struct drm_gem_object *o=
bj, struct dma_buf_map *map)
> > >   	ret =3D mutex_lock_interruptible(&shmem->vmap_lock);
> > >   	if (ret)
> > >   		return ret;
> > > -	ret =3D drm_gem_shmem_vmap_locked(shmem, map);
> > > +	ret =3D drm_gem_shmem_vmap_locked(shmem, map, false);
> > >   	mutex_unlock(&shmem->vmap_lock);
> > >   	return ret;
> > >   }
> > >   EXPORT_SYMBOL(drm_gem_shmem_vmap);
> > > +/**
> > > + * drm_gem_shmem_vmap_local - Create a virtual mapping for a shmem G=
EM object
> > > + * @shmem: shmem GEM object
> > > + * @map: Returns the kernel virtual address of the SHMEM GEM object'=
s backing
> > > + *       store.
> > > + *
> > > + * This function makes sure that a contiguous kernel virtual address=
 mapping
> > > + * exists for the buffer backing the shmem GEM object.
> > > + *
> > > + * The function is called with the BO's reservation object locked. C=
allers must
> > > + * hold the lock until after unmapping the buffer.
> > > + *
> > > + * This function can be used to implement &drm_gem_object_funcs.vmap=
_local. But
> > > + * it can also be called by drivers directly, in which case it will =
hide the
> > > + * differences between dma-buf imported and natively allocated objec=
ts.
> > =

> > So for the other callbacks I tried to make sure we have different entry
> > points for this, since it's not really the same thing and because of the
> > locking mess we have with dma_resv_lock vs various pre-existing local
> > locking scheme, it's easy to get a mess.
> > =

> > I think the super clean version here would be to also export just the
> > internal stuff for the ->v(un)map_local hooks, but that's maybe a bit t=
oo
> > much boilerplate for no real gain.
> > -Daniel
> > =

> > > + *
> > > + * Acquired mappings should be cleaned up by calling drm_gem_shmem_v=
unmap_local().
> > > + *
> > > + * Returns:
> > > + * 0 on success or a negative error code on failure.
> > > + */
> > > +int drm_gem_shmem_vmap_local(struct drm_gem_object *obj, struct dma_=
buf_map *map)
> > > +{
> > > +	struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(obj);
> > > +	int ret;
> > > +
> > > +	dma_resv_assert_held(obj->resv);
> > > +
> > > +	ret =3D mutex_lock_interruptible(&shmem->vmap_lock);
> > > +	if (ret)
> > > +		return ret;
> > > +	ret =3D drm_gem_shmem_vmap_locked(shmem, map, true);
> > > +	mutex_unlock(&shmem->vmap_lock);
> > > +
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL(drm_gem_shmem_vmap_local);
> > > +
> > >   static void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object=
 *shmem,
> > > -					struct dma_buf_map *map)
> > > +					struct dma_buf_map *map, bool local)
> > >   {
> > >   	struct drm_gem_object *obj =3D &shmem->base;
> > > @@ -358,7 +402,10 @@ static void drm_gem_shmem_vunmap_locked(struct d=
rm_gem_shmem_object *shmem,
> > >   		return;
> > >   	if (obj->import_attach)
> > > -		dma_buf_vunmap(obj->import_attach->dmabuf, map);
> > > +		if (local)
> > > +			dma_buf_vunmap_local(obj->import_attach->dmabuf, map);
> > > +		else
> > > +			dma_buf_vunmap(obj->import_attach->dmabuf, map);
> > >   	else
> > >   		vunmap(shmem->vaddr);
> > > @@ -366,7 +413,7 @@ static void drm_gem_shmem_vunmap_locked(struct dr=
m_gem_shmem_object *shmem,
> > >   	drm_gem_shmem_put_pages(shmem);
> > >   }
> > > -/*
> > > +/**
> > >    * drm_gem_shmem_vunmap - Unmap a virtual mapping fo a shmem GEM ob=
ject
> > >    * @shmem: shmem GEM object
> > >    * @map: Kernel virtual address where the SHMEM GEM object was mapp=
ed
> > > @@ -384,11 +431,38 @@ void drm_gem_shmem_vunmap(struct drm_gem_object=
 *obj, struct dma_buf_map *map)
> > >   	struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(obj);
> > >   	mutex_lock(&shmem->vmap_lock);
> > > -	drm_gem_shmem_vunmap_locked(shmem, map);
> > > +	drm_gem_shmem_vunmap_locked(shmem, map, false);
> > >   	mutex_unlock(&shmem->vmap_lock);
> > >   }
> > >   EXPORT_SYMBOL(drm_gem_shmem_vunmap);
> > > +/**
> > > + * drm_gem_shmem_vunmap_local - Unmap a virtual mapping fo a shmem G=
EM object
> > > + * @shmem: shmem GEM object
> > > + * @map: Kernel virtual address where the SHMEM GEM object was mapped
> > > + *
> > > + * This function cleans up a kernel virtual address mapping acquired=
 by
> > > + * drm_gem_shmem_vmap_local(). The mapping is only removed when the =
use count
> > > + * drops to zero.
> > > + *
> > > + * The function is called with the BO's reservation object locked.
> > > + *
> > > + * This function can be used to implement &drm_gem_object_funcs.vmap=
_local.
> > > + * But it can also be called by drivers directly, in which case it w=
ill hide
> > > + * the differences between dma-buf imported and natively allocated o=
bjects.
> > > + */
> > > +void drm_gem_shmem_vunmap_local(struct drm_gem_object *obj, struct d=
ma_buf_map *map)
> > > +{
> > > +	struct drm_gem_shmem_object *shmem =3D to_drm_gem_shmem_obj(obj);
> > > +
> > > +	dma_resv_assert_held(obj->resv);
> > > +
> > > +	mutex_lock(&shmem->vmap_lock);
> > > +	drm_gem_shmem_vunmap_locked(shmem, map, true);
> > > +	mutex_unlock(&shmem->vmap_lock);
> > > +}
> > > +EXPORT_SYMBOL(drm_gem_shmem_vunmap_local);
> > > +
> > >   struct drm_gem_shmem_object *
> > >   drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
> > >   				 struct drm_device *dev, size_t size,
> > > diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem=
_shmem_helper.h
> > > index 434328d8a0d9..3f59bdf749aa 100644
> > > --- a/include/drm/drm_gem_shmem_helper.h
> > > +++ b/include/drm/drm_gem_shmem_helper.h
> > > @@ -114,7 +114,9 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem=
_object *shmem);
> > >   int drm_gem_shmem_pin(struct drm_gem_object *obj);
> > >   void drm_gem_shmem_unpin(struct drm_gem_object *obj);
> > >   int drm_gem_shmem_vmap(struct drm_gem_object *obj, struct dma_buf_m=
ap *map);
> > > +int drm_gem_shmem_vmap_local(struct drm_gem_object *obj, struct dma_=
buf_map *map);
> > >   void drm_gem_shmem_vunmap(struct drm_gem_object *obj, struct dma_bu=
f_map *map);
> > > +void drm_gem_shmem_vunmap_local(struct drm_gem_object *obj, struct d=
ma_buf_map *map);
> > >   int drm_gem_shmem_madvise(struct drm_gem_object *obj, int madv);
> > > -- =

> > > 2.29.2
> > > =

> > =

> =

> -- =

> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 N=FCrnberg, Germany
> (HRB 36809, AG N=FCrnberg)
> Gesch=E4ftsf=FChrer: Felix Imend=F6rffer
> =





-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
