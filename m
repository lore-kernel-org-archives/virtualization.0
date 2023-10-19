Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA0BCDB465
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 08:25:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3048041517;
	Thu, 19 Oct 2023 08:25:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3048041517
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=AtTQDqe/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f2WjXqv0U8QC; Thu, 19 Oct 2023 08:25:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A3659410D5;
	Thu, 19 Oct 2023 08:25:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3659410D5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76731C0071;
	Thu, 19 Oct 2023 08:25:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22429C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E481B6FB18
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E481B6FB18
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com
 header.i=@fooishbar-org.20230601.gappssmtp.com header.a=rsa-sha256
 header.s=20230601 header.b=AtTQDqe/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fp2OzTyKf--1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:25:22 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F3ACA6FB17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 08:25:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F3ACA6FB17
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9be02fcf268so904539466b.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 01:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1697703920; x=1698308720;
 darn=lists.linux-foundation.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v8Difn/D+XiTI90dIkn0xG+fv+x0la3KPldZ4kHjxUY=;
 b=AtTQDqe/D9C4wx/hNjK+3a6sM7RL5OMBWt2Fi1Vkmyjxg+CVBa9dncmDZ4RjaG8rML
 Z9miGglLwHoADP6rBCrwlMaBaINjCxZR8wn+3IboGMt63atWDPPbpcsJK8/K1pL9Yf6/
 k+VR7NDVM5Q7uY7greaChBVPKUCAEg/H5fAwzi7B4XATho7wDFhIbV4A5A4LcvhvwEZ1
 33dj9ZDYAkc6sXzQSeGlZ7qj8QYqKYl70H4YR/e445VebCP1AfAX2EEW+wPK37lxq+R2
 mcIciZDczjSq8MvH8eEdWb0zIXufBMuBi+tz5EIOL1JB0YTTBWbkWG1KbW2S9wNixV25
 Zygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697703920; x=1698308720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v8Difn/D+XiTI90dIkn0xG+fv+x0la3KPldZ4kHjxUY=;
 b=Mt0o0KH6SYO9G40gOTUCbEB3hKkQNmNIMob4IdMLyoGZ3HA1oQDR+ZKGd3kK9ZC8Jr
 sVUudiQPrBzhm4h6RpSRK5xPlRryxzjB+HVfS437WRJGgSTqw8UShwh+xztIyb6p4je4
 5lMp+P8f84EE+H2m6InPvLQ3lDWWuFemTkfUq88plCc2Dvfs/q9tHtrGvni8iaurQORT
 jSITD3sNGolB6obN2ucuWtZ8JG0EoHJKmrchoDWzZLHCb3eHjvEPwaJ0uH4LKC3DfCx6
 u+VM+esGkYTE0dRjSfxvy/AhW/O3ZR8k4h69YMHLK21YxoYiEuxz+pDeuwzk/zkj6xez
 +8GA==
X-Gm-Message-State: AOJu0Yy5+JGesh4CFeJDJnZNKYX0Y/1QHjovjsf2JXFwcq7M8sjaaejT
 1LvaXSctGDjAQoUhdUzLuuw1wrD8Zxhc6eNmXZye0w==
X-Google-Smtp-Source: AGHT+IERXq0bO1AmEurHewxhpzh6tNz4IbqMPHu+sifIOgs6RxCQnRc88SwKIglHJnVB5fDIiwqiPj8rxg9FYRI0joA=
X-Received: by 2002:a17:907:97c2:b0:9c1:4343:60ab with SMTP id
 js2-20020a17090797c200b009c1434360abmr974298ejc.10.1697703919882; Thu, 19 Oct
 2023 01:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20231019070650.61159-1-vignesh.raman@collabora.com>
 <20231019070650.61159-10-vignesh.raman@collabora.com>
In-Reply-To: <20231019070650.61159-10-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 19 Oct 2023 10:25:07 +0200
Message-ID: <CAPj87rP=22Fw0h42U-p9fHd=6OHOu9Lj9kbpVMQVqL9U6BRE1A@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] drm: ci: Update xfails
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: daniels@collabora.com, emma@anholt.net, david.heidelberg@collabora.com,
 linux-arm-msm@vger.kernel.org, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 gustavo.padovan@collabora.com, helen.koike@collabora.com,
 linux-mediatek@lists.infradead.org, daniel@ffwll.ch, airlied@gmail.com
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

Hi Vignesh,

On Thu, 19 Oct 2023 at 09:07, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> +# Some tests crashes with malloc error and IGT tests floods
> +# the CI log with error messages and we end up with a warning message
> +# Job's log exceeded limit of 4194304 bytes.
> +# Job execution will continue but no more output will be collected.

This is just from GitLab warning that we have a huge log, so not
related to the actual fails here.

> +# Below is the error log:
> +# malloc(): corrupted top size
> +# Received signal SIGABRT.
> +# Stack trace:
> +#  #0 [fatal_sig_handler+0x17b]
> +#  #1 [__sigaction+0x40]
> +#  #2 [pthread_key_delete+0x14c]
> +#  #3 [gsignal+0x12]
> +#  #4 [abort+0xd3]
> +#  #5 [__fsetlocking+0x290]
> +#  #6 [timer_settime+0x37a]
> +#  #7 [__default_morecore+0x1f1b]
> +#  #8 [__libc_calloc+0x161]
> +#  #9 [drmModeGetPlaneResources+0x44]
> +#  #10 [igt_display_require+0x194]
> +#  #11 [__igt_unique____real_main1356+0x93c]
> +#  #12 [main+0x3f]
> +#  #13 [__libc_init_first+0x8a]
> +#  #14 [__libc_start_main+0x85]
> +#  #15 [_start+0x21]
> +# malloc(): corrupted top size

By the time we get this error, it indicates that there was previously
memory corruption, but it is only being noticed at a later point. The
skip lists here are way too big - stuff like drm_read is common
testing not affected by virtio at all - so we really need to isolate
the test which is actually breaking things.

The way to do this would be to use valgrind to detect where the memory
corruption is. VirtIO can be run locally so this is something you can
do on your machine.

Cheers,
Daniel
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
