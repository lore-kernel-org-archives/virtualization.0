Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8286AC433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Feb 2022 23:48:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29826812F2;
	Thu, 10 Feb 2022 23:48:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YlCV48W3CFIt; Thu, 10 Feb 2022 23:48:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E8C2C81258;
	Thu, 10 Feb 2022 23:48:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC274C001A;
	Thu, 10 Feb 2022 23:48:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACF5CC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 23:48:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 991C740291
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 23:48:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vsyGfwY8SPIT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 23:48:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A623D40160
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 23:48:34 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id u18so13715729edt.6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 15:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TmmqKhuTPY9owmmJ84jDjFdTO3yDaMpJkjT3FCR6jJc=;
 b=S/fCaC5/Hco3qfX4AibLzDFhvQGruPa7siKDOY9zUU4azDH4nVPNtPj5XkzHsFICPf
 5u6g7TBeOuEoQCy9bW40cY/J/Gb6gyFdUbNHTgtWpwZttn1635B+HQW+5/SRDw1zuPST
 HYqz/QiCKEUVgR7xLpoiuzXAhIY4A5ns0L9do6soZF/g4YPlTNwHvDwPYbmtD+GyUwbz
 9+5nBxWn1Y5zvV2JcbYcZfa0MFmhLD3ZU0oCGmYKD+6tUfxtJHPhZ/SoI9YEgR7lQwx4
 Tp14K/mjeImjt17NwRqszWh98SED/7CSveMxSk1mQDzgHlQajRXHnN7CTSBXLXq+BycF
 2bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TmmqKhuTPY9owmmJ84jDjFdTO3yDaMpJkjT3FCR6jJc=;
 b=Ik2Ml46XbkOXps1f1trBzBAMvn5FOREuUV5/cfCz2DXsKHOvAksTgQUnRcPXNVtQFf
 iRVRPKYh6+p6Wg3Pgzp/FcPePjMvqTFg/SvS6JCm9Nk07H7Fn0SL0lGCpf3Uc5899BDU
 4Z2o1gBVRNpvSi79eGSup+4isWygR7zr/KbD6MFItxa5vJCGrd9QKHlwrFg0rQ4wU9Mm
 70XqHE7qaJv8qmmdYWjWkUwOe4FdDcCKbZFB42nosGc0NqGZw0Em2InaExMjvjfSr4HJ
 KXN/K/u24mTnJDy6ota5RCOecW42+6iX07sr7UNU/moYwRvSukp/LtnkguA10GAhvbBw
 Ahzg==
X-Gm-Message-State: AOAM531r3flI8pOs2zfaEtoMgUY9kAv8B6ooiG7D1KQHDbvbU5hYHg/V
 w3IWvz3RHkWHwJwHmlepi66uJUbwzdw0eqPwGA4=
X-Google-Smtp-Source: ABdhPJzW1q6NHxslNvjiNTC3EI3YC5QZDvRheJ2DkNg8wG5kgPXRcPvXyCkHX7QvATaiqShBvyvJUA0GvesxrwIhJFY=
X-Received: by 2002:aa7:d69a:: with SMTP id d26mr10757102edr.50.1644536912787; 
 Thu, 10 Feb 2022 15:48:32 -0800 (PST)
MIME-Version: 1.0
References: <20220209155634.3994-1-tzimmermann@suse.de>
In-Reply-To: <20220209155634.3994-1-tzimmermann@suse.de>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Thu, 10 Feb 2022 15:48:21 -0800
Message-ID: <CAPaKu7T883JC0_KXhJcx7+cZrPdiv4XY=1gskBdQjYggw1c83w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/gem-shmem: Various improvements
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: robh@kernel.org, emma@anholt.net, Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 David Airlie <airlied@linux.ie>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, mripard@kernel.org,
 steven.price@arm.com, lima@lists.freedesktop.org, yuq825@gmail.com,
 Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>,
 "open list:VIRTIO CORE,
 NET AND BLOCK DRIVERS" <virtualization@lists.linux-foundation.org>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
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

On Wed, Feb 9, 2022 at 7:56 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Two patches for GEM's SHMEM-backed implementation.
>
> v2:
>         * update drivers after vm_ops change
>
> Thomas Zimmermann (2):
>   drm/gem-shmem: Set vm_ops in static initializer
>   drm/gem-shmem: Don't store mmap'ed buffers in core dumps
>
>  drivers/gpu/drm/drm_gem_shmem_helper.c  | 7 ++++---
>  drivers/gpu/drm/lima/lima_gem.c         | 1 +
>  drivers/gpu/drm/panfrost/panfrost_gem.c | 1 +
>  drivers/gpu/drm/v3d/v3d_bo.c            | 1 +
>  drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
>  include/drm/drm_gem_shmem_helper.h      | 2 ++
>  6 files changed, 10 insertions(+), 3 deletions(-)
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>


>
> --
> 2.34.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
