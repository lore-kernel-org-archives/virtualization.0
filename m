Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087D1C25B0C
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 16:44:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F66B814BB;
	Tue,  9 Aug 2022 16:44:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F66B814BB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=IjvlDT3G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PStJmaK3kkAT; Tue,  9 Aug 2022 16:44:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0445580D50;
	Tue,  9 Aug 2022 16:44:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0445580D50
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B45BAC0033;
	Tue,  9 Aug 2022 16:44:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4B44C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 16:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EC91813DD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 16:44:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7EC91813DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xoLZeEU0DyZN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 16:44:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 64EED813AF
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 64EED813AF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 16:44:27 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id
 186-20020a1c02c3000000b003a34ac64bdfso6935495wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc;
 bh=kG73ZFGwpqA9MEsaOhGxOyq0S5W0g/PKck6MJrQJjh4=;
 b=IjvlDT3GgnKcWar5hWlV3kmPtlMIw3szkL6RRUTSuwPJE7rdHudxhXegyQLbP/fx1M
 NhNiueI3flr6TSRZBFjxGWtzcrHT0mmP3lo5PnjVx5SsmwuMN8QhC2d/mki5v4qH7HDx
 8w91tH2jhqzru340MMXj1N/ZvULmrkBUYw3Is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc;
 bh=kG73ZFGwpqA9MEsaOhGxOyq0S5W0g/PKck6MJrQJjh4=;
 b=Zz/CVFfxc/jJE3GTTmClTFqGQD+64xrNjFBcjx1Fxnfe9/8tI+jy3Mmak/eKqHc6Ct
 F+YzmiLPh8waX+KCd3J2KdiAS4Olpq69y8GtexUlm3MtntlYDGPYkdjU34MjEki2+6IH
 hyH/5U6dcJh8Njf/8TBrW41CUbtnuHnLo5PFYyU/gh6zyOGrKYV/pPtVXkBYIExINyhx
 cmHfLGmpLLP8KaAEA3dmQr41DQi55+jL0kv3dL7jRORUH4XzwWriuBsemZE0CC/jXUGQ
 1V+f5KCb9x71WHqF5GAzFifVPtSbrWX+v6zU9YTECgEoCXvg81rKnHhb1g5zWw6AErXB
 +iyw==
X-Gm-Message-State: ACgBeo3ta9qjV7pMZZsBB49u2enHjl0E+6ClhMwksuelesZVIQAPAJoa
 ZryxNQNFsP230m4/ZlWowNOvIQ==
X-Google-Smtp-Source: AA6agR7Mh8M3suAF/jwjxN+ICA7FrHXNw3HuqSciA+CCbg9rxGZ4/Yyg824wTV/ciSBKOP3NeoJYRQ==
X-Received: by 2002:a1c:f60f:0:b0:3a0:3e0c:1de1 with SMTP id
 w15-20020a1cf60f000000b003a03e0c1de1mr21550404wmc.56.1660063465672; 
 Tue, 09 Aug 2022 09:44:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c351300b003a501ad8648sm18098101wmq.40.2022.08.09.09.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 09:44:25 -0700 (PDT)
Date: Tue, 9 Aug 2022 18:44:22 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v8 1/2] drm/gem: Properly annotate WW context on
 drm_gem_lock_reservations() error
Message-ID: <YvKO5r5Sr56e9vBf@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas_os@shipmail.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-2-dmitry.osipenko@collabora.com>
 <a42237c9-6304-4b06-cede-2175c7e7b87d@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a42237c9-6304-4b06-cede-2175c7e7b87d@amd.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: dri-devel@lists.freedesktop.org,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Thomas Zimmermann <tzimmermann@suse.de>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Emil Velikov <emil.l.velikov@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-tegra@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
 kernel@collabora.com, virtualization@lists.linux-foundation.org,
 Chia-I Wu <olvaffe@gmail.com>
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

On Tue, Jul 05, 2022 at 01:33:51PM +0200, Christian K=F6nig wrote:
> Am 01.07.22 um 11:02 schrieb Dmitry Osipenko:
> > Use ww_acquire_fini() in the error code paths. Otherwise lockdep
> > thinks that lock is held when lock's memory is freed after the
> > drm_gem_lock_reservations() error. The ww_acquire_context needs to be
> > annotated as "released", which fixes the noisy "WARNING: held lock free=
d!"
> > splat of VirtIO-GPU driver with CONFIG_DEBUG_MUTEXES=3Dy and enabled lo=
ckdep.
> > =

> > Cc: stable@vger.kernel.org
> > Fixes: 7edc3e3b975b5 ("drm: Add helpers for locking an array of BO rese=
rvations.")
> > Reviewed-by: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> > Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> =

> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>

Also added this r-b tag when merging to drm-misc-next-fixes.
-Daniel

> =

> > ---
> >   drivers/gpu/drm/drm_gem.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > =

> > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > index eb0c2d041f13..86d670c71286 100644
> > --- a/drivers/gpu/drm/drm_gem.c
> > +++ b/drivers/gpu/drm/drm_gem.c
> > @@ -1226,7 +1226,7 @@ drm_gem_lock_reservations(struct drm_gem_object *=
*objs, int count,
> >   		ret =3D dma_resv_lock_slow_interruptible(obj->resv,
> >   								 acquire_ctx);
> >   		if (ret) {
> > -			ww_acquire_done(acquire_ctx);
> > +			ww_acquire_fini(acquire_ctx);
> >   			return ret;
> >   		}
> >   	}
> > @@ -1251,7 +1251,7 @@ drm_gem_lock_reservations(struct drm_gem_object *=
*objs, int count,
> >   				goto retry;
> >   			}
> > -			ww_acquire_done(acquire_ctx);
> > +			ww_acquire_fini(acquire_ctx);
> >   			return ret;
> >   		}
> >   	}
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
