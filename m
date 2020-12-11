Return-Path: <SRS0=HmZx=FP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346FDC4361B
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 14:00:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DAA23ECD
	for <virtualization@archiver.kernel.org>; Fri, 11 Dec 2020 14:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DAA23ECD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5DE4487368;
	Fri, 11 Dec 2020 14:00:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tbg6-r7GpUJb; Fri, 11 Dec 2020 14:00:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5E6B6871B1;
	Fri, 11 Dec 2020 14:00:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5163CC0893;
	Fri, 11 Dec 2020 14:00:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEA0CC013B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 14:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D2FDA2E0DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 14:00:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wT-FWPs+j1m4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 14:00:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 72D3C27233
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 14:00:24 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id a3so8675669wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Dec 2020 06:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=d8tFMCsanGJNlY0eo5T2OA58hKATRtq8341bLyQUv+8=;
 b=Fi1Tf3C/8K7v5WWvJtBcGeox3Ft1mlUyad1rkSHtHus3E0E8eRZ/XA6xE1vh9q59HN
 2GWqtExDpcUDzDk20mQQiEHawhPfGx7pHcAZcAs1/z013CnZeh7YSilWYci/bHdRebLL
 QL/Yj67AoKbm7MMrBU/nQlXhFkBMUBab5q0VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=d8tFMCsanGJNlY0eo5T2OA58hKATRtq8341bLyQUv+8=;
 b=ct7SF5N6GDOSP/hQwzHzAxa2YdGDPiWFryrHFWENZvjQ9xZz16SsMFQd/gSnyTm+c0
 zvK5HHuirxJ6Afm/FTbOBafkK3QjksoR9TCaG47CzlTNsJujpDWOviONIdNKpYjvKsqM
 U8to3SABFdqMJ64g2E8yFW2pV1SAdXaNNb02CXlVSSRiqnWVR/15PPtSWZK5KoiYpaPo
 L1JYlbjtQ2S6cb0fv8Gdf3I1Rindb4kiBd1igMYsZE6SQl7lCqLPnEIPqxA4ry3F7SBJ
 gtdSyBU0d1Hgx63Dwz3GDdUiBCFXd+tpDN7sDBzNxMs7MOJtkMUZ/qmvuJkhINfksUe2
 /fYg==
X-Gm-Message-State: AOAM531LAgcQhUG6Vpw+T+Hw48Sibfra+fYhkiShq9jfGbRmfEdRoW8O
 5TL0UaWx2P3GGx9GjiXyIk5kmg==
X-Google-Smtp-Source: ABdhPJy8r6Glu9Lw6Mp/XjSsYQ7YvWEXPIl2oivqQiMDXNDKTrOHyb+XfcH5y51l2KsyYgnp1WiIgw==
X-Received: by 2002:a1c:2182:: with SMTP id h124mr13725696wmh.25.1607695222434; 
 Fri, 11 Dec 2020 06:00:22 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id b14sm15061137wrx.77.2020.12.11.06.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Dec 2020 06:00:21 -0800 (PST)
Date: Fri, 11 Dec 2020 15:00:19 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 8/8] drm/fb-helper: Move BO locking from DRM client to
 fbdev damage worker
Message-ID: <20201211140019.GS401619@phenom.ffwll.local>
References: <20201209142527.26415-1-tzimmermann@suse.de>
 <20201209142527.26415-9-tzimmermann@suse.de>
 <20201211100134.GN401619@phenom.ffwll.local>
 <e1b4d35a-f624-bca2-cd12-ca6dbaf860d1@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1b4d35a-f624-bca2-cd12-ca6dbaf860d1@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: airlied@linux.ie, sean@poorly.run, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 hdegoede@redhat.com, Daniel Vetter <daniel@ffwll.ch>, sam@ravnborg.org,
 christian.koenig@amd.com, linux-media@vger.kernel.org
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

On Fri, Dec 11, 2020 at 11:16:25AM +0100, Thomas Zimmermann wrote:
> Hi
> =

> Am 11.12.20 um 11:01 schrieb Daniel Vetter:
> > On Wed, Dec 09, 2020 at 03:25:27PM +0100, Thomas Zimmermann wrote:
> > > Fbdev emulation has to lock the BO into place while flushing the shad=
ow
> > > buffer into the BO's memory. Remove any interference with pinning by
> > > using vmap_local functionality (instead of full vmap). This requires
> > > BO reservation locking in fbdev's damage worker.
> > > =

> > > The new DRM client functions for locking and vmap_local functionality
> > > are added for consistency with the existing style.
> > > =

> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > =

> > The old vmap/vunmap in the client library aren't used anymore, please
> > delete. That will also make it clearer in the diff what's going on and
> > that it makes sense to have the client and fb-helper part in one patch.
> =

> They are still around for perma-mapped BOs where HW supports it (really o=
nly
> CMA-based drivers). See drm_fb_helper_generic_probe() and
> drm_fbdev_cleanup().

Ah right I didn't grep this carefully enough. I guess in that case
splitting this into the drm_client patch and fb-helper patch would be good
I think.

Also some kerneldoc commment addition for normal vmap that vmap_local is
preferred for short-term mappings, and for vmap_local that _vmap() gives
you the long term mapping. Just for more links and stuff in docs.

With that: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
-Daniel

> =

> Best regards
> Thomas
> =

> > =

> > With that: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > =

> > > ---
> > >   drivers/gpu/drm/drm_client.c    | 91 ++++++++++++++++++++++++++++++=
+++
> > >   drivers/gpu/drm/drm_fb_helper.c | 41 +++++++--------
> > >   include/drm/drm_client.h        |  4 ++
> > >   3 files changed, 116 insertions(+), 20 deletions(-)
> > > =

> > > diff --git a/drivers/gpu/drm/drm_client.c b/drivers/gpu/drm/drm_clien=
t.c
> > > index ce45e380f4a2..795f5cb052ba 100644
> > > --- a/drivers/gpu/drm/drm_client.c
> > > +++ b/drivers/gpu/drm/drm_client.c
> > > @@ -288,6 +288,37 @@ drm_client_buffer_create(struct drm_client_dev *=
client, u32 width, u32 height, u
> > >   	return ERR_PTR(ret);
> > >   }
> > > +/**
> > > + * drm_client_buffer_lock - Locks the DRM client buffer
> > > + * @buffer: DRM client buffer
> > > + *
> > > + * This function locks the client buffer by acquiring the buffer
> > > + * object's reservation lock.
> > > + *
> > > + * Unlock the buffer with drm_client_buffer_unlock().
> > > + *
> > > + * Returns:
> > > + *	0 on success, or a negative errno code otherwise.
> > > + */
> > > +int
> > > +drm_client_buffer_lock(struct drm_client_buffer *buffer)
> > > +{
> > > +	return dma_resv_lock(buffer->gem->resv, NULL);
> > > +}
> > > +EXPORT_SYMBOL(drm_client_buffer_lock);
> > > +
> > > +/**
> > > + * drm_client_buffer_unlock - Unlock DRM client buffer
> > > + * @buffer: DRM client buffer
> > > + *
> > > + * Unlocks a client buffer. See drm_client_buffer_lock().
> > > + */
> > > +void drm_client_buffer_unlock(struct drm_client_buffer *buffer)
> > > +{
> > > +	dma_resv_unlock(buffer->gem->resv);
> > > +}
> > > +EXPORT_SYMBOL(drm_client_buffer_unlock);
> > > +
> > >   /**
> > >    * drm_client_buffer_vmap - Map DRM client buffer into address space
> > >    * @buffer: DRM client buffer
> > > @@ -348,6 +379,66 @@ void drm_client_buffer_vunmap(struct drm_client_=
buffer *buffer)
> > >   }
> > >   EXPORT_SYMBOL(drm_client_buffer_vunmap);
> > > +/**
> > > + * drm_client_buffer_vmap_local - Map DRM client buffer into address=
 space
> > > + * @buffer: DRM client buffer
> > > + * @map_copy: Returns the mapped memory's address
> > > + *
> > > + * This function maps a client buffer into kernel address space. If =
the
> > > + * buffer is already mapped, it returns the existing mapping's addre=
ss.
> > > + *
> > > + * Client buffer mappings are not ref'counted. Each call to
> > > + * drm_client_buffer_vmap_local() should be followed by a call to
> > > + * drm_client_buffer_vunmap_local(); or the client buffer should be =
mapped
> > > + * throughout its lifetime.
> > > + *
> > > + * The returned address is a copy of the internal value. In contrast=
 to
> > > + * other vmap interfaces, you don't need it for the client's vunmap
> > > + * function. So you can modify it at will during blit and draw opera=
tions.
> > > + *
> > > + * Returns:
> > > + *	0 on success, or a negative errno code otherwise.
> > > + */
> > > +int
> > > +drm_client_buffer_vmap_local(struct drm_client_buffer *buffer, struc=
t dma_buf_map *map_copy)
> > > +{
> > > +	struct dma_buf_map *map =3D &buffer->map;
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * FIXME: The dependency on GEM here isn't required, we could
> > > +	 * convert the driver handle to a dma-buf instead and use the
> > > +	 * backend-agnostic dma-buf vmap_local support instead. This would
> > > +	 * require that the handle2fd prime ioctl is reworked to pull the
> > > +	 * fd_install step out of the driver backend hooks, to make that
> > > +	 * final step optional for internal users.
> > > +	 */
> > > +	ret =3D drm_gem_vmap_local(buffer->gem, map);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*map_copy =3D *map;
> > > +
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL(drm_client_buffer_vmap_local);
> > > +
> > > +/**
> > > + * drm_client_buffer_vunmap_local - Unmap DRM client buffer
> > > + * @buffer: DRM client buffer
> > > + *
> > > + * This function removes a client buffer's memory mapping. Calling t=
his
> > > + * function is only required by clients that manage their buffer map=
pings
> > > + * by themselves.
> > > + */
> > > +void drm_client_buffer_vunmap_local(struct drm_client_buffer *buffer)
> > > +{
> > > +	struct dma_buf_map *map =3D &buffer->map;
> > > +
> > > +	drm_gem_vunmap_local(buffer->gem, map);
> > > +}
> > > +EXPORT_SYMBOL(drm_client_buffer_vunmap_local);
> > > +
> > >   static void drm_client_buffer_rmfb(struct drm_client_buffer *buffer)
> > >   {
> > >   	int ret;
> > > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb=
_helper.c
> > > index e82db0f4e771..a56a7d9f7e35 100644
> > > --- a/drivers/gpu/drm/drm_fb_helper.c
> > > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > > @@ -399,28 +399,34 @@ static int drm_fb_helper_damage_blit(struct drm=
_fb_helper *fb_helper,
> > >   	int ret;
> > >   	/*
> > > -	 * We have to pin the client buffer to its current location while
> > > -	 * flushing the shadow buffer. In the general case, concurrent
> > > -	 * modesetting operations could try to move the buffer and would
> > > -	 * fail. The modeset has to be serialized by acquiring the reservat=
ion
> > > -	 * object of the underlying BO here.
> > > -	 *
> > >   	 * For fbdev emulation, we only have to protect against fbdev mode=
set
> > >   	 * operations. Nothing else will involve the client buffer's BO. S=
o it
> > >   	 * is sufficient to acquire struct drm_fb_helper.lock here.
> > >   	 */
> > >   	mutex_lock(&fb_helper->lock);
> > > -	ret =3D drm_client_buffer_vmap(buffer, &map);
> > > +	/*
> > > +	 * We have to keep the client buffer at its current location while
> > > +	 * flushing the shadow buffer. Concurrent operations could otherwise
> > > +	 * try to move the buffer. Therefore acquiring the reservation
> > > +	 * object of the underlying BO here.
> > > +	 */
> > > +	ret =3D drm_client_buffer_lock(buffer);
> > > +	if (ret)
> > > +		goto out_mutex_unlock;
> > > +
> > > +	ret =3D drm_client_buffer_vmap_local(buffer, &map);
> > >   	if (ret)
> > > -		goto out;
> > > +		goto out_drm_client_buffer_unlock;
> > >   	dst =3D map;
> > >   	drm_fb_helper_damage_blit_real(fb_helper, clip, &dst);
> > > -	drm_client_buffer_vunmap(buffer);
> > > +	drm_client_buffer_vunmap_local(buffer);
> > > -out:
> > > +out_drm_client_buffer_unlock:
> > > +	drm_client_buffer_unlock(buffer);
> > > +out_mutex_unlock:
> > >   	mutex_unlock(&fb_helper->lock);
> > >   	return ret;
> > > @@ -946,15 +952,11 @@ static int setcmap_legacy(struct fb_cmap *cmap,=
 struct fb_info *info)
> > >   	drm_modeset_lock_all(fb_helper->dev);
> > >   	drm_client_for_each_modeset(modeset, &fb_helper->client) {
> > >   		crtc =3D modeset->crtc;
> > > -		if (!crtc->funcs->gamma_set || !crtc->gamma_size) {
> > > -			ret =3D -EINVAL;
> > > -			goto out;
> > > -		}
> > > +		if (!crtc->funcs->gamma_set || !crtc->gamma_size)
> > > +			return -EINVAL;
> > > -		if (cmap->start + cmap->len > crtc->gamma_size) {
> > > -			ret =3D -EINVAL;
> > > -			goto out;
> > > -		}
> > > +		if (cmap->start + cmap->len > crtc->gamma_size)
> > > +			return -EINVAL;
> > >   		r =3D crtc->gamma_store;
> > >   		g =3D r + crtc->gamma_size;
> > > @@ -967,9 +969,8 @@ static int setcmap_legacy(struct fb_cmap *cmap, s=
truct fb_info *info)
> > >   		ret =3D crtc->funcs->gamma_set(crtc, r, g, b,
> > >   					     crtc->gamma_size, NULL);
> > >   		if (ret)
> > > -			goto out;
> > > +			return ret;
> > >   	}
> > > -out:
> > >   	drm_modeset_unlock_all(fb_helper->dev);
> > >   	return ret;
> > > diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
> > > index f07f2fb02e75..df61e339a11c 100644
> > > --- a/include/drm/drm_client.h
> > > +++ b/include/drm/drm_client.h
> > > @@ -156,8 +156,12 @@ struct drm_client_buffer *
> > >   drm_client_framebuffer_create(struct drm_client_dev *client, u32 wi=
dth, u32 height, u32 format);
> > >   void drm_client_framebuffer_delete(struct drm_client_buffer *buffer=
);
> > >   int drm_client_framebuffer_flush(struct drm_client_buffer *buffer, =
struct drm_rect *rect);
> > > +int drm_client_buffer_lock(struct drm_client_buffer *buffer);
> > > +void drm_client_buffer_unlock(struct drm_client_buffer *buffer);
> > >   int drm_client_buffer_vmap(struct drm_client_buffer *buffer, struct=
 dma_buf_map *map);
> > >   void drm_client_buffer_vunmap(struct drm_client_buffer *buffer);
> > > +int drm_client_buffer_vmap_local(struct drm_client_buffer *buffer, s=
truct dma_buf_map *map);
> > > +void drm_client_buffer_vunmap_local(struct drm_client_buffer *buffer=
);
> > >   int drm_client_modeset_create(struct drm_client_dev *client);
> > >   void drm_client_modeset_free(struct drm_client_dev *client);
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
