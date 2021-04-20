Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD0C433ED
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 08:47:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5506101D
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 08:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5506101D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B8F860663;
	Tue, 20 Apr 2021 08:46:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2pRJdYiYBdFV; Tue, 20 Apr 2021 08:46:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFF806063F;
	Tue, 20 Apr 2021 08:46:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B677AC000F;
	Tue, 20 Apr 2021 08:46:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4349DC000F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 08:46:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2454A404C8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 08:46:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dMR3Qy16XxVA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 08:46:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 129E74026F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 08:46:51 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id g5so50348787ejx.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 01:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vuclwn4vyYALU0qWvo6KCdEtoH/58AhLvrs6PmwRMkU=;
 b=d6k/+pMNRaJAPmCwZIx46LdCjEclIZQZIiqmt5R+9oE2HbK/SUZCyy9PgG7R/SdRV5
 +qqmMuLhWyBlELzXKxtTUWe/a/F923nSFKxOiKEcHGTTAXjjfYZKxixldu4HVwNbjrvS
 goh8h0wa7opFwUTqajn0mk7R0ka7M8qA/THy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vuclwn4vyYALU0qWvo6KCdEtoH/58AhLvrs6PmwRMkU=;
 b=k4ITSwrlaBkWndY4hdcRlUljde5UxY775aIItzAschR9AdT9lU/VJ4VQj5s9VSYx1Y
 tzWKkyMJp402RUq3rbtp+7f3M2vk43CRtY7l6D/hBWHxl2P5tUOP3MpSd40pNdW5p+FV
 QscvKEllGlNZfgDJmfjrigbkOKEa5I2mPdPNsAJFeffI9dVje9CCYBRhr5JOVH84Wa3s
 zkhhxdZsHgWDHKHVoB0aGsT3j+trf4KfuCCT3JRNklwJrOXOw3OrGcXVcCGM/I8Y3YMB
 1IaiM4fT4Yhocnkw/ZD/Opgbgc9IzAsMXKI5ui4LFWliNsBOQ6duloxDocetBaTX3vPR
 KU0Q==
X-Gm-Message-State: AOAM531TeAubsboeWMAZmM1lKJ92y2oWab52BRBiStp6Ijhe7v2N3k2g
 RK7fghQk8W425SUGsvgkl9bclw==
X-Google-Smtp-Source: ABdhPJyhF872h1aJTtsSGthH1G/y01DLyqPuLLT/uw2mQIUL7MPcOuFmVGGTl/E/UJzUQ97XvDsuxw==
X-Received: by 2002:a17:906:53cd:: with SMTP id
 p13mr26254640ejo.379.1618908410246; 
 Tue, 20 Apr 2021 01:46:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id n14sm11973365ejy.90.2021.04.20.01.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 01:46:49 -0700 (PDT)
Date: Tue, 20 Apr 2021 10:46:47 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 0/9] drm: Support simple-framebuffer devices and
 firmware fbs
Message-ID: <YH6U92Q71ntU6Z1R@phenom.ffwll.local>
References: <20210416090048.11492-1-tzimmermann@suse.de>
 <CAMuHMdWcC8O+UzQDQj7Bm4uK_myjFT5D2ccTmneTJYi4SMfCRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdWcC8O+UzQDQj7Bm4uK_myjFT5D2ccTmneTJYi4SMfCRQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: Rob Herring <robh@kernel.org>, bluescreen_avenger@verizon.net,
 Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 virtualization@lists.linux-foundation.org, Hans de Goede <hdegoede@redhat.com>,
 Mark Brown <broonie@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Greg KH <gregkh@linuxfoundation.org>, Sam Ravnborg <sam@ravnborg.org>
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

On Mon, Apr 19, 2021 at 10:00:56AM +0200, Geert Uytterhoeven wrote:
> Hi Thomas,
> 
> On Fri, Apr 16, 2021 at 11:00 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > This patchset adds support for simple-framebuffer platform devices and
> > a handover mechanism for native drivers to take-over control of the
> > hardware.
> >
> > The new driver, called simpledrm, binds to a simple-frambuffer platform
> > device. The kernel's boot code creates such devices for firmware-provided
> > framebuffers, such as EFI-GOP or VESA. Typically the BIOS, UEFI or boot
> > loader sets up the framebuffers. Description via device tree is also an
> > option.
> 
> I guess this can be used as a replacement for offb, too...
> 
> > Patches 4 to 8 add the simpledrm driver. It's build on simple DRM helpers
> > and SHMEM. It supports 16-bit, 24-bit and 32-bit RGB framebuffers. During
> 
> .... if support for 8-bit frame buffers would be added?

Is that 8-bit greyscale or 8-bit indexed with 256 entry palette? Former
shouldn't be a big thing, but the latter is only really supported by the
overall drm ecosystem in theory. Most userspace assumes that xrgb8888
works, and we keep that illusion up by emulating it in kernel for hw which
just doesn't support it. But reformatting xrgb8888 to c8 is tricky at
best. The uapis are all there for setting the palette, and C8 is a defined
format even with atomic kms interface, but really there's not much
userspace for it. In other words, it would work as well as current offb
would, but that's at least that.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
