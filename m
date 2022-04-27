Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19707C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 14:50:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A28C260FE1;
	Wed, 27 Apr 2022 14:50:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bKdTAPeIjcx3; Wed, 27 Apr 2022 14:50:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1905660783;
	Wed, 27 Apr 2022 14:50:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9652C0039;
	Wed, 27 Apr 2022 14:50:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00E6EC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:50:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB2DD4003D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:50:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zldVsx1EYOfH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:50:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 96D1340888
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:50:09 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id y21so2248847edo.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to; bh=2ukhvq6UCkilr6qtjyCJGVeLtyAJOtLrDnxOLi9CaTw=;
 b=EVO0ouyrgiZootRwq5voIFao1mlr3tWZKAxywItZk5du+HZwD4P2s5o/P/joQkbtwK
 QooStUd0Yx0O2Z+XDGfydzdAP/FbPjNWO4WxY8O0nGE72bfq4ax7/ehYBzkWh7TclOP5
 VxcoSpLJg9f3J4Dh6xWwfRPO1gbuX/nryjY1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to;
 bh=2ukhvq6UCkilr6qtjyCJGVeLtyAJOtLrDnxOLi9CaTw=;
 b=lYE0ZKh7RtWGejPutyNq6hJqBo4juW3F32zO/FFiUZFnpqPaumJ/6zwUKpg5FixIDo
 JcWwRScSMpc4mjfZBYbc8vT5U4q0gKYERI3nqSXC8mELqIOTPt7W3J9otung5aD4cL0W
 oIcezkLsjiZ2Q7/9RIAIU3OMU5DuLBTfLzn+MAO/xOf3DtQ30LqgRQ7SqGSCeMYpitOJ
 8Hx3jb7YkjXjDMFQTfSJOKS430owclM2dtidcDeta0ak+PF9wVAk+RifBvuBnOd11kWd
 TpGmQh5td2hLJ8kTRCeS5UYzHHkD+BNvbsiMii9XP/kbXd9gEhxLJEDcrI+8Y5iXlKv8
 ereA==
X-Gm-Message-State: AOAM530BhmhdQzmRtBhtsmNAXGy6Zdvo0Cc6jRe0+Kbe9GOcg66Ox2gd
 bFyJuhQyMLcHt0nKuNT+UtjgPA==
X-Google-Smtp-Source: ABdhPJxMlHpjWS0SulDJ6s+ciG4icei4dr6Xqjg815QsDmVCoJLzvCGXG89ebz4XatZjLaBdvYNUnQ==
X-Received: by 2002:a05:6402:34d2:b0:423:e6c4:3e9 with SMTP id
 w18-20020a05640234d200b00423e6c403e9mr31451583edc.372.1651071007653; 
 Wed, 27 Apr 2022 07:50:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a1709066d1100b006f39b1d3addsm3963081ejr.196.2022.04.27.07.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 07:50:06 -0700 (PDT)
Date: Wed, 27 Apr 2022 16:50:04 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH v4 10/15] drm/shmem-helper: Take reservation lock instead
 of drm_gem_shmem locks
Message-ID: <YmlYHNlcmNMfOeyy@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
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
 <20220417223707.157113-11-dmitry.osipenko@collabora.com>
 <248083d2-b8f2-a4d7-099d-70a7e7859c11@suse.de>
 <d9e7bec1-fffb-e0c4-8659-ef3ce2c31280@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d9e7bec1-fffb-e0c4-8659-ef3ce2c31280@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Osipenko <digetx@gmail.com>, Rob Herring <robh@kernel.org>,
 Daniel Stone <daniel@fooishbar.org>, Steven Price <steven.price@arm.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, virtualization@lists.linux-foundation.org,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Emil Velikov <emil.l.velikov@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
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

On Mon, Apr 18, 2022 at 10:18:54PM +0300, Dmitry Osipenko wrote:
> Hello,
> =

> On 4/18/22 21:38, Thomas Zimmermann wrote:
> > Hi
> > =

> > Am 18.04.22 um 00:37 schrieb Dmitry Osipenko:
> >> Replace drm_gem_shmem locks with the reservation lock to make GEM
> >> lockings more consistent.
> >>
> >> Previously drm_gem_shmem_vmap() and drm_gem_shmem_get_pages() were
> >> protected by separate locks, now it's the same lock, but it doesn't
> >> make any difference for the current GEM SHMEM users. Only Panfrost
> >> and Lima drivers use vmap() and they do it in the slow code paths,
> >> hence there was no practical justification for the usage of separate
> >> lock in the vmap().
> >>
> >> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> ---
> ...
> >> =A0 @@ -310,7 +306,7 @@ static int drm_gem_shmem_vmap_locked(struct
> >> drm_gem_shmem_object *shmem,
> >> =A0=A0=A0=A0=A0 } else {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 pgprot_t prot =3D PAGE_KERNEL;
> >> =A0 -=A0=A0=A0=A0=A0=A0=A0 ret =3D drm_gem_shmem_get_pages(shmem);
> >> +=A0=A0=A0=A0=A0=A0=A0 ret =3D drm_gem_shmem_get_pages_locked(shmem);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto err_zero_use;
> >> =A0 @@ -360,11 +356,11 @@ int drm_gem_shmem_vmap(struct
> >> drm_gem_shmem_object *shmem,
> >> =A0 {
> >> =A0=A0=A0=A0=A0 int ret;
> >> =A0 -=A0=A0=A0 ret =3D mutex_lock_interruptible(&shmem->vmap_lock);
> >> +=A0=A0=A0 ret =3D dma_resv_lock_interruptible(shmem->base.resv, NULL);
> >> =A0=A0=A0=A0=A0 if (ret)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;
> >> =A0=A0=A0=A0=A0 ret =3D drm_gem_shmem_vmap_locked(shmem, map);
> > =

> > Within drm_gem_shmem_vmap_locked(), there's a call to dma_buf_vmap() for
> > imported pages. If the exporter side also holds/acquires the same
> > reservation lock as our object, the whole thing can deadlock. We cannot
> > move dma_buf_vmap() out of the CS, because we still need to increment
> > the reference counter. I honestly don't know how to easily fix this
> > problem. There's a TODO item about replacing these locks at [1]. As
> > Daniel suggested this patch, we should talk to him about the issue.
> > =

> > Best regards
> > Thomas
> > =

> > [1]
> > https://www.kernel.org/doc/html/latest/gpu/todo.html#move-buffer-object=
-locking-to-dma-resv-lock
> =

> Indeed, good catch! Perhaps we could simply use a separate lock for the
> vmapping of the *imported* GEMs? The vmap_use_count is used only by
> vmap/vunmap, so it doesn't matter which lock is used by these functions
> in the case of imported GEMs since we only need to protect the
> vmap_use_count.

Apologies for the late reply, I'm flooded.

I discussed this with Daniel Stone last week in a chat, roughly what we
need to do is:

1. Pick a function from shmem helpers.

2. Go through all drivers that call this, and make sure that we acquire
dma_resv_lock in the top level driver entry point for this.

3. Once all driver code paths are converted, add a dma_resv_assert_held()
call to that function to make sure you have it all correctly.

4. Repeate 1-3 until all shmem helper functions are converted over.

5. Ditch the 3 different shmem helper locks.

The trouble is that I forgot that vmap is a thing, so that needs more
work. I think there's two approaches here:
- Do the vmap at import time. This is the trick we used to untangle the
  dma_resv_lock issues around dma_buf_attachment_map()
- Change the dma_buf_vmap rules that callers must hold the dma_resv_lock.
- Maybe also do what you suggest and keep a separate lock for this, but
  the fundamental issue is that this doesn't really work - if you share
  buffers both ways with two drivers using shmem helpers, then the
  ordering of this vmap_count_mutex vs dma_resv_lock is inconsistent and
  you can get some nice deadlocks. So not a great approach (and also the
  reason why we really need to get everyone to move towards dma_resv_lock
  as _the_ buffer object lock, since otherwise we'll never get a
  consistent lock nesting hierarchy).

The trouble here is that trying to be clever and doing the conversion just
in shmem helpers wont work, because there's a lot of cases where the
drivers are all kinds of inconsistent with their locking.

Adding Daniel S, also maybe for questions it'd be fastest to chat on irc?
-Daniel
-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
