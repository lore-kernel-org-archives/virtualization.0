Return-Path: <SRS0=s1EX=B5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AA1C433DF
	for <virtualization@archiver.kernel.org>; Wed, 19 Aug 2020 02:18:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E71205CB
	for <virtualization@archiver.kernel.org>; Wed, 19 Aug 2020 02:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOZno89E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E71205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 198FD879F5;
	Wed, 19 Aug 2020 02:18:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X0ylKdbXwy8G; Wed, 19 Aug 2020 02:18:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C0F9876C3;
	Wed, 19 Aug 2020 02:18:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E018C088B;
	Wed, 19 Aug 2020 02:18:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86281C0051
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 02:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6AF13879F5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 02:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sTKaNuVTIjUN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 02:18:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 02CB2876C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Aug 2020 02:18:07 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id g19so24388679ejc.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Aug 2020 19:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+FtZ30xD7F4CZ/+/kanc2qcUjEGS85bRNmxMV0hbX3I=;
 b=kOZno89ECZj6jVLAofx0JYLgCM7bLIMxM7XAq01DXsTvgmE6+vdVEGINNrEw9CrO6q
 hhfO8Ok5Qpm+QcIsUzJsuG41E1oKzmHRFBnEiUpFzDcckhfTl1O9G3xk+0Xdt+lJ28Ox
 84NBsEtRgRyWygzMTkVyQumtvunuhdFgfFhKJIVrC6SG7EXgKptI16hgZNUmwwLfq9I/
 xFHPSL9epK5Li4EZbsDm/XaTwhnkDABhW04Y75nreWj3/71so6UT5DOYbEtPsIH7HG5Q
 adO0CW/3HzSrSI/8upvsKMdC4Exvwltwp+4ZLXg/rDj9yHJnztmi3x1f/uoi/Cfz9zqV
 SEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+FtZ30xD7F4CZ/+/kanc2qcUjEGS85bRNmxMV0hbX3I=;
 b=fGBDwm8xVUXJOxHIo2l5s+drHLuAxNi/p72STA6H5xHyVHrYFGmAHYfpjhqlLdm3YD
 OduUHZjs1dhCM/p57/HbQ/MIXBPVJv3EfB7aLtv6rEbhIH6qMWy2EZBoVi4WZrBCe5Vx
 jWo0yzZPcNQE5tWeLo8cybHtVH3V0OKLTJOm1tTAw6/3mmETrsRShdFmlU9PU69BM3HJ
 Q4gc+Sg/eCCUoM15f/ScXqSu59jnQHV3fsgoY27gTTLMklPkFFnLp/PWjxUOzyhgnNis
 Xi9GvpEWfGaQpdfXDS6+W54jqAQRjbSbYbqMOflsurx+ZPbXWY37DGcT+ln0S6UDEiK3
 JvvQ==
X-Gm-Message-State: AOAM532Ww3z7dzYlm4bTMYFGkCWGe379k104yIot9ZH+lt1Ika2jpB97
 qRgyeQVj6Fhi7h27y66wUofGqptwiTDuKySIzgM=
X-Google-Smtp-Source: ABdhPJwOVxXlhVZPhM/VXYOHCZ5BD7otzTxtw2JShtHqq7RtGHtTEeWNcWBFLQm5bLFs+h/OjcLMVfdYi9hE5ww2B8Y=
X-Received: by 2002:a17:906:d054:: with SMTP id
 bo20mr24181293ejb.9.1597803486353; 
 Tue, 18 Aug 2020 19:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200817195846.14076-1-sean@poorly.run>
 <20200817200521.GA1551172@ravnborg.org>
 <CAMavQKL2=Gx+XCbMYc5p08jRNtH5ju=oadhxBxzgNf+gzo3fnA@mail.gmail.com>
 <CAMavQK+zsBHoMc_C=-=v-43u=tZ_pJ6XSGBhD6MLQN01pjbyEA@mail.gmail.com>
 <20200818053150.pwkga4vzipk7pf6t@sirius.home.kraxel.org>
In-Reply-To: <20200818053150.pwkga4vzipk7pf6t@sirius.home.kraxel.org>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 19 Aug 2020 12:17:55 +1000
Message-ID: <CAPM=9txiz6k2k7SBtPRbvA3C6NvoyH2TCaLgGM+-08yoouoSUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: Fix build errors
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, "open list:VIRTIO CORE,
 NET..." <virtualization@lists.linux-foundation.org>,
 Sean Paul <seanpaul@chromium.org>,
 spice-devel <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>, Sidong Yang <realwakka@gmail.com>,
 Sean Paul <sean@poorly.run>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, 18 Aug 2020 at 15:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > I guess things are never quite so easy :-). It looks like Daniel's
> > patch is in drm-misc-fixes and Sidong's patch is in drm-misc-next. On
> > their own they're fine, but once they are merged in drm-tip the build
> > error shows up.
>
> Ah, ok.  I've already wondered how that got past my build testing.
> This explains it.
>
> thanks for looking into it,

I've fixed this in drm-tip with a fixup.

In future when we find these silent conflicts, can someone please
https://drm.pages.freedesktop.org/maintainer-tools/drm-tip.html

follow those instructions to fix it up.

Dave.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
