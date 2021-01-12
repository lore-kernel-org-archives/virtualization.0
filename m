Return-Path: <SRS0=ALvA=GP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188BAC433E0
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 09:17:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EC9622D2A
	for <virtualization@archiver.kernel.org>; Tue, 12 Jan 2021 09:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EC9622D2A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 11863870E8;
	Tue, 12 Jan 2021 09:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rilJWcselfWG; Tue, 12 Jan 2021 09:17:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3C17D87097;
	Tue, 12 Jan 2021 09:17:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26E48C088B;
	Tue, 12 Jan 2021 09:17:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA47C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 09:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9BBD1870C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 09:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZlUq6uztRlU8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 09:17:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3813187097
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 09:17:14 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id t16so1672610wra.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 01:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=BkFPPAMUp2t1YrBY41qrS/Q9HpIRZgTIhFUpfiEfe3I=;
 b=cnwEUlV2QnvwNPkrS3zUaCdwjmeHQOssIIjMjbPTgCx7ymC6qa2UuAHdpQUkF7hMSu
 KSdMe9AaLfIe2eAvAxK6jNSO+4SAAKFPYG+xFYpsQ5xPpcXVnRpWpp5VWcxXOb2V4+62
 Rde1SXCDtujP5MblELcIKnpJEUx6jUPagkjrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BkFPPAMUp2t1YrBY41qrS/Q9HpIRZgTIhFUpfiEfe3I=;
 b=ONoO50HBvLkaAPZHMs6fV/g2J0XDQbbS/rZEQ7Dx1gp5aGSgO2I/Gy5y7d/7+cOYQt
 V73oHn6UvqlSl4jFtVoww7hpf0Gv7/K81I5gkEso/yAiQPgdrAOVtnm7L0SH64yS7CRQ
 fAmsK4wdUoZ1ucaNrsGaPhNcFc/YF1Mi3s2cx6gc1ubyzBcLGEFmdzRKk4FPLmVNWksX
 3QXfcYcklLq1A3Yc49Bdk9l7pcds2QIHfCppTy0aoO5F1siEXtLBXTPmo364gtwnfEgM
 gFMZF+JHcKPX86M1iCVCa1Hw8UWmkvCGf5WsB+wAW1MCuOqx9/crCn+szxmMk1i/uXiS
 BT1Q==
X-Gm-Message-State: AOAM533F8LZyW6LJLvDe01KDgSzNHR+pk0uDChPv7pgtioo2GVmmCXVA
 V78TgOsIG5H8q3CT3ZdgLMZU8g==
X-Google-Smtp-Source: ABdhPJx/V56gELooyGmDglikPZdA+XTA2xRFVdYCGu7EQxYoL6V/sTE/BkKNN5kG9dRt4iF6SIVi8g==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr3256036wrv.363.1610443032442; 
 Tue, 12 Jan 2021 01:17:12 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id l5sm3810117wrv.44.2021.01.12.01.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 01:17:11 -0800 (PST)
Date: Tue, 12 Jan 2021 10:17:09 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 11/13] drm/vboxvideo: Use drm_gem_vram_vmap_local() in
 cursor update
Message-ID: <X/1pFaa9I7WFjtJW@phenom.ffwll.local>
References: <20210108094340.15290-1-tzimmermann@suse.de>
 <20210108094340.15290-12-tzimmermann@suse.de>
 <X/yFj9zIdW52UKk4@phenom.ffwll.local>
 <a42dbfad-4280-eeea-5915-71061f732a4a@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a42dbfad-4280-eeea-5915-71061f732a4a@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: eric@anholt.net, sam@ravnborg.org, dri-devel@lists.freedesktop.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 christian.koenig@amd.com, linaro-mm-sig@lists.linaro.org, hdegoede@redhat.com,
 Daniel Vetter <daniel@ffwll.ch>, airlied@redhat.com,
 virtualization@lists.linux-foundation.org, sean@poorly.run,
 sumit.semwal@linaro.org, linux-media@vger.kernel.org
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

On Tue, Jan 12, 2021 at 08:54:02AM +0100, Thomas Zimmermann wrote:
> Hi
> =

> Am 11.01.21 um 18:06 schrieb Daniel Vetter:
> > On Fri, Jan 08, 2021 at 10:43:38AM +0100, Thomas Zimmermann wrote:
> > > Cursor updates in vboxvideo require a short-term mapping of the
> > > source BO. Use drm_gem_vram_vmap_local() and avoid the pinning
> > > operations.
> > > =

> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > =

> > All these drivers patches break the dma_resv_lock vs
> > dma_fence_begin/end_signalling nesting rules, so this doesn't work.
> > =

> > Generally this is what the prepare/cleanup_fb hooks are for, that's whe=
re
> > mappings (including vmaps) are meant to be set up, permanently.
> > =

> > I'm kinda not clear on why we need all these changes, I thought the
> > locking problem is just in the fb helper paths, because it's outside of
> > the atomic path and could conflict with an atomic update at the same ti=
me?
> > So only that one should get the vmap_local treatment, everything else
> > should keep the normal vmap treatment.
> =

> Kind of responding to all your comment on the driver changes:
> =

> These drivers only require short-term mappings, so using vmap_local would=
 be
> the natural choice. For SHMEM helpers, it's mostly a cosmetic thing. For
> VRAM helpers, I was hoping to remove the vmap/vunmap helpers entirely. One
> cannot really map the BOs for the long-term, so not having the helpers at
> all would make sense.
> =

> But reading all your comments on the driver patches, I'd rather not update
> the drivers here but later convert them to use prepare_fb/cleanup_fb in t=
he
> correct way.

Ack from me on this plan. I think I got all the other patches with an r-b
or ack?
-Daniel

> =

> Best regards
> Thomas
> =

> > -Daniel
> > > ---
> > >   drivers/gpu/drm/vboxvideo/vbox_mode.c | 15 +++++++++------
> > >   1 file changed, 9 insertions(+), 6 deletions(-)
> > > =

> > > diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/=
vboxvideo/vbox_mode.c
> > > index dbc0dd53c69e..215b37c78c10 100644
> > > --- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
> > > +++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
> > > @@ -381,7 +381,8 @@ static void vbox_cursor_atomic_update(struct drm_=
plane *plane,
> > >   		container_of(plane->dev, struct vbox_private, ddev);
> > >   	struct vbox_crtc *vbox_crtc =3D to_vbox_crtc(plane->state->crtc);
> > >   	struct drm_framebuffer *fb =3D plane->state->fb;
> > > -	struct drm_gem_vram_object *gbo =3D drm_gem_vram_of_gem(fb->obj[0]);
> > > +	struct drm_gem_object *obj =3D fb->obj[0];
> > > +	struct drm_gem_vram_object *gbo =3D drm_gem_vram_of_gem(obj);
> > >   	u32 width =3D plane->state->crtc_w;
> > >   	u32 height =3D plane->state->crtc_h;
> > >   	size_t data_size, mask_size;
> > > @@ -401,11 +402,12 @@ static void vbox_cursor_atomic_update(struct dr=
m_plane *plane,
> > >   	vbox_crtc->cursor_enabled =3D true;
> > > -	ret =3D drm_gem_vram_vmap(gbo, &map);
> > > +	ret =3D dma_resv_lock(obj->resv, NULL);
> > > +	if (ret)
> > > +		return;
> > > +	ret =3D drm_gem_vram_vmap_local(gbo, &map);
> > >   	if (ret) {
> > > -		/*
> > > -		 * BUG: we should have pinned the BO in prepare_fb().
> > > -		 */
> > > +		dma_resv_unlock(obj->resv);
> > >   		mutex_unlock(&vbox->hw_mutex);
> > >   		DRM_WARN("Could not map cursor bo, skipping update\n");
> > >   		return;
> > > @@ -421,7 +423,8 @@ static void vbox_cursor_atomic_update(struct drm_=
plane *plane,
> > >   	data_size =3D width * height * 4 + mask_size;
> > >   	copy_cursor_image(src, vbox->cursor_data, width, height, mask_size=
);
> > > -	drm_gem_vram_vunmap(gbo, &map);
> > > +	drm_gem_vram_vunmap_local(gbo, &map);
> > > +	dma_resv_unlock(obj->resv);
> > >   	flags =3D VBOX_MOUSE_POINTER_VISIBLE | VBOX_MOUSE_POINTER_SHAPE |
> > >   		VBOX_MOUSE_POINTER_ALPHA;
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
