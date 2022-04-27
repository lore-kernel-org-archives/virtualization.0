Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845F2C433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Apr 2022 14:12:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A426408B6;
	Wed, 27 Apr 2022 14:12:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SC-k-KxjAreB; Wed, 27 Apr 2022 14:12:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AFC82404D0;
	Wed, 27 Apr 2022 14:12:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82B13C0039;
	Wed, 27 Apr 2022 14:12:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D60E8C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:12:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3DA360F08
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IQiOILDTgHKq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:12:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B2EA460EF8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 14:12:16 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id p18so2089120edr.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=11Ehteq4IMxQiJPEAvQ0GJFJcB0Vx+nhzT9rMTdF62k=;
 b=QF3G9fLMgv8G/oXNKkd4GDP5NWz2waO7sDY4PO/cTtUGRGllF8p1t7kpMLLgNJ0CX9
 enKU60/wL6m3m7mzlczohGqKtJelB7GCuJDfaaVraG8mh/xhS+Tyk6xdD/0q8JLCl2sv
 9KwpunEOeZpfBI8oAZD5LrHQgfAYqMCxOpNQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=11Ehteq4IMxQiJPEAvQ0GJFJcB0Vx+nhzT9rMTdF62k=;
 b=1OU9U0p+ncbTYW7FYrzbEiYca997vDs9jSL3EuJuyqbsrPJfpRfMP2Y6vaXumuNMvp
 7rQAU8ByyLyc6j6P1fRQuMDlqqFokhlgsw5l2RbwR+RHmdTd6YTfGri+eELVYmGXKlic
 tanLc5aDvOvGj/QQzQdnhzygp1r3zRNlJE9kXVpL8d/mUWrlZQnNNOLGpEpIed/zw3Q1
 VlHdaogGITG9GUDDi2ERa147IL7n+WCHeOvaB3C22q/kQXH86wwGT7h9x0ySy1EZYMs+
 syPjMwGWijGguxbz2dO38/+9tQNXdJXTl7BrD+8/EzywTSNw0X1ZSqM2K18NAVvlPmJd
 glRQ==
X-Gm-Message-State: AOAM531UmFoxrEs5H35zHOW7icJcySyj+0MPLf2pZ2vQiqAp3MLYDS03
 2eSAkEQrojB5kyoZqcPsv1AUMA==
X-Google-Smtp-Source: ABdhPJzCb4UFfXZb/lSePgQFoouOvEjD5kyOPL/2slbGY02bkLk0DvoToYrQuRAByxQFD7v/Eu6zXg==
X-Received: by 2002:a05:6402:17c7:b0:425:d52c:8907 with SMTP id
 s7-20020a05640217c700b00425d52c8907mr22237794edy.15.1651068734818; 
 Wed, 27 Apr 2022 07:12:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a170906700a00b006efdb748e8dsm6842956ejj.88.2022.04.27.07.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 07:12:14 -0700 (PDT)
Date: Wed, 27 Apr 2022 16:12:12 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/bochs: Explicitly include linux/module.h
Message-ID: <YmlPPM93q04uNnlU@phenom.ffwll.local>
References: <20220413161259.1854270-1-michel@daenzer.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220413161259.1854270-1-michel@daenzer.net>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

On Wed, Apr 13, 2022 at 06:12:59PM +0200, Michel D=E4nzer wrote:
> From: Michel D=E4nzer <mdaenzer@redhat.com>
> =

> Instead of relying on it getting pulled in indirectly.
> =

> Signed-off-by: Michel D=E4nzer <mdaenzer@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/tiny/bochs.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index ed971c8bb446..4f8bf86633df 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  =

> +#include <linux/module.h>
>  #include <linux/pci.h>
>  =

>  #include <drm/drm_aperture.h>
> -- =

> 2.35.1
> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
