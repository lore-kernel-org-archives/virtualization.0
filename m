Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F36A8C25B0C
	for <virtualization@archiver.kernel.org>; Tue,  9 Aug 2022 16:41:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 672C440A8E;
	Tue,  9 Aug 2022 16:41:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 672C440A8E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=iX9Se9Ti
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sY-nyiIABb-Z; Tue,  9 Aug 2022 16:41:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DEA7840644;
	Tue,  9 Aug 2022 16:41:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEA7840644
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B664FC007D;
	Tue,  9 Aug 2022 16:41:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F03D8C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 16:41:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D5CEF409AB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 16:41:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5CEF409AB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch
 header.a=rsa-sha256 header.s=google header.b=iX9Se9Ti
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IjdkdC09mga3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 16:41:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A3F0408CD
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1A3F0408CD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Aug 2022 16:41:13 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id k26so23227612ejx.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Aug 2022 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:from:to:cc;
 bh=naNpYkxE68tX1ARbD3iQv+CO+kO6ut9LpVz/MEIjf2U=;
 b=iX9Se9TiI3Acb0PyhnYkVRNdA7lVQuf4CJDx2D6WpGaKbYqVnU4KX3GTPDDKS7PYVg
 gZCH6sdLyyngWxfgd5D+yNp6kzG+ewgTuTXqWMqSckX17sr8zonXMCWzvhLjGrjQGv/c
 ell5/FxG7+4Gqy9X+TsWsq7ykFiSjP9m/Frk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:mail-followup-to:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc;
 bh=naNpYkxE68tX1ARbD3iQv+CO+kO6ut9LpVz/MEIjf2U=;
 b=XIYgoWe1j4BgmMsHAf17CMrLhmTJvo3yfhiv2RGPnp9WknA/2JSHRui1xjHTCyodSZ
 FpAG19oqsFfJdgKgtiBCTUlYzP5PhXWrWS3Vi7ui4tc6I9b+DUiksfS+1uhUUHOHdog/
 zm3DGrBzZj4BsvJzyP6I41VWF9XHqA0JFWwbS7gnXA4dgI3PFs6OhtoE5fKnrwjdlC/t
 3jstZPubZ6Az8Nuc0my2KJi5aup2yPQPc2PqfMEyivrBhhSjMczfZy071enfDwEUUinq
 4OgdOJP496a0f55sU/ppIYNfS4ozGFUSacT2WgdpPTNQZ8ABmSeT7q9ph4kkJM5bVRxA
 b3HQ==
X-Gm-Message-State: ACgBeo0h6zknll3aF0N2JgBgdQ22YqQAVGXGv5GL7LO6xjAhCXFZhMfz
 A49XraW+/qKF5TwMhwpsS1Hhmw==
X-Google-Smtp-Source: AA6agR5JiN6PB/2pP/tfQ4vgKWFUin1cCx29k5oNnI6uFJ+xd5aN1v/0W1ws1t92QMVelRHOPdZjFw==
X-Received: by 2002:a17:907:3f98:b0:730:cfce:9c0f with SMTP id
 hr24-20020a1709073f9800b00730cfce9c0fmr18168166ejc.475.1660063272111; 
 Tue, 09 Aug 2022 09:41:12 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 n25-20020a056402515900b0043d1a9f6e4asm6277567edd.9.2022.08.09.09.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Aug 2022 09:41:11 -0700 (PDT)
Date: Tue, 9 Aug 2022 18:41:09 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v7 1/2] drm/gem: Properly annotate WW context on
 drm_gem_lock_reservations() error
Message-ID: <YvKOJRbTsBk91aPO@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas_os@shipmail.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>, linux-tegra@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20220630200405.1883897-1-dmitry.osipenko@collabora.com>
 <20220630200405.1883897-2-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220630200405.1883897-2-dmitry.osipenko@collabora.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
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

On Thu, Jun 30, 2022 at 11:04:04PM +0300, Dmitry Osipenko wrote:
> Use ww_acquire_fini() in the error code paths. Otherwise lockdep
> thinks that lock is held when lock's memory is freed after the
> drm_gem_lock_reservations() error. The ww_acquire_context needs to be
> annotated as "released", which fixes the noisy "WARNING: held lock freed!"
> splat of VirtIO-GPU driver with CONFIG_DEBUG_MUTEXES=3Dy and enabled lock=
dep.
> =

> Cc: stable@vger.kernel.org
> Fixes: 7edc3e3b975b5 ("drm: Add helpers for locking an array of BO reserv=
ations.")
> Reviewed-by: Thomas Hellstr=F6m <thomas.hellstrom@linux.intel.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

I merged this one to drm-misc-next-fixes. The other one looks like there's
still opens pending, pls resubmit appropriately (and maybe with some
analysis in the commit message of how exactly this impacts other drivers).
-Daniel

> ---
>  drivers/gpu/drm/drm_gem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index eb0c2d041f13..86d670c71286 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1226,7 +1226,7 @@ drm_gem_lock_reservations(struct drm_gem_object **o=
bjs, int count,
>  		ret =3D dma_resv_lock_slow_interruptible(obj->resv,
>  								 acquire_ctx);
>  		if (ret) {
> -			ww_acquire_done(acquire_ctx);
> +			ww_acquire_fini(acquire_ctx);
>  			return ret;
>  		}
>  	}
> @@ -1251,7 +1251,7 @@ drm_gem_lock_reservations(struct drm_gem_object **o=
bjs, int count,
>  				goto retry;
>  			}
>  =

> -			ww_acquire_done(acquire_ctx);
> +			ww_acquire_fini(acquire_ctx);
>  			return ret;
>  		}
>  	}
> -- =

> 2.36.1
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
