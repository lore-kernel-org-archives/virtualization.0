Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810BDC433F5
	for <virtualization@archiver.kernel.org>; Wed,  4 May 2022 09:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1FA548138E;
	Wed,  4 May 2022 09:27:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lGNVvgpaIE7Q; Wed,  4 May 2022 09:27:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A6A4481386;
	Wed,  4 May 2022 09:27:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 806FFC0039;
	Wed,  4 May 2022 09:27:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F4EFC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 09:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DB40040343
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 09:27:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0yMENBjIEOl8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 09:27:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9BD8C40319
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 May 2022 09:27:23 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id p18so1019745edr.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 May 2022 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ujA9Ei7p7js6ZRLVyhuGMYvuef/eHfjkXNE1xkCGCac=;
 b=a2QDIAsL8PjnNIlU96E9OKFb5JRWo/5cimilEnfUCl42Vwbi50OfKnghbRpmhwTRVy
 6uQ1OGyqHCyuVffyEXeE44qK+++U2SkGWgzhPeMPe9bcDHS+YFs9vRim6dX1DrQDfb3k
 dzSaD0Hcb05rsquh/Edr3uLN7e5BAC+QstFhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ujA9Ei7p7js6ZRLVyhuGMYvuef/eHfjkXNE1xkCGCac=;
 b=L/zrLXZa21+4cb0eTaB6gp7gE0myMGQ0o8BjAPbu4ttsXJlSNj/8lPKJuv7IH//S6S
 KwZA/n7YC/3EY7g0kiw2hxovSNlVEngmQS5FzKyqzIEdOqGzTwbsakR8V9zwYtC2jefv
 KRckc2JEmTFD6b8Ds/o5GxbOf0tkN0AtRU0i7w2h7YDuLaHiaKoMIEWqd/9mJ+MEOLuJ
 nFU07tb/ddE5A7KJwq2tvpSynorydnTVDHR2yVx55lQliPtfRUbllop1JJo4UToZt8Am
 gwZN9vIlwafAX3UldaMmbHygcLd7lxh9qv3N4ynu52FBkA8grg0FcugaJTXkKam8DPy7
 Dyuw==
X-Gm-Message-State: AOAM531AaAy6UTsJwqi+5C39QJ2TOE/53E79JSfBnMANOF3DF8n5cYKH
 l4lt1PUUCFzE8+tGAIQS6XnZfA==
X-Google-Smtp-Source: ABdhPJztK+2f8hOmkj7yIY4OpPJD1pbs3HlTum+Il1H0W7eQxxllCRg40sUx50M/6m9W12KizlDa1g==
X-Received: by 2002:aa7:dcd5:0:b0:425:e49f:db86 with SMTP id
 w21-20020aa7dcd5000000b00425e49fdb86mr22083537edu.202.1651656441895; 
 Wed, 04 May 2022 02:27:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a170906845000b006f3ef214dc7sm5370091ejy.45.2022.05.04.02.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 May 2022 02:27:21 -0700 (PDT)
Date: Wed, 4 May 2022 11:27:19 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 4/4] drm/qxl: add drm_gem_plane_helper_prepare_fb
Message-ID: <YnJG95uJDD6tK8RN@phenom.ffwll.local>
References: <20220429134230.24334-1-christian.koenig@amd.com>
 <20220429134230.24334-4-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220429134230.24334-4-christian.koenig@amd.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org,
 Dave Airlie <airlied@redhat.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
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

On Fri, Apr 29, 2022 at 03:42:30PM +0200, Christian K=F6nig wrote:
> We could need to wait for the pin to complete here.
> =

> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: spice-devel@lists.freedesktop.org

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_=
display.c
> index 9a9c29b1d3e1..9a64fa4c7530 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -34,6 +34,7 @@
>  #include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_gem_atomic_helper.h>
>  =

>  #include "qxl_drv.h"
>  #include "qxl_object.h"
> @@ -829,6 +830,7 @@ static int qxl_plane_prepare_fb(struct drm_plane *pla=
ne,
>  	struct qxl_device *qdev =3D to_qxl(plane->dev);
>  	struct drm_gem_object *obj;
>  	struct qxl_bo *user_bo;
> +	int ret;
>  =

>  	if (!new_state->fb)
>  		return 0;
> @@ -852,7 +854,11 @@ static int qxl_plane_prepare_fb(struct drm_plane *pl=
ane,
>  		qxl_free_cursor(old_cursor_bo);
>  	}
>  =

> -	return qxl_bo_pin(user_bo);
> +	ret =3D qxl_bo_pin(user_bo);
> +	if (ret)
> +		return ret;
> +
> +	return drm_gem_plane_helper_prepare_fb(plane, new_state);
>  }
>  =

>  static void qxl_plane_cleanup_fb(struct drm_plane *plane,
> -- =

> 2.25.1
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
