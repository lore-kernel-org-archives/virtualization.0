Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FCEC433ED
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 11:11:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACCC61354
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 11:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACCC61354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04A7F402ED;
	Tue, 20 Apr 2021 11:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Px0ysdaOZ1R6; Tue, 20 Apr 2021 11:11:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF8764022C;
	Tue, 20 Apr 2021 11:11:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3BAAC000E;
	Tue, 20 Apr 2021 11:11:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22FCFC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11FC9838D3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:11:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=ffwll.ch
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RYeI0kh9rvFL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:11:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 80C6183AC7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 11:11:26 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id y3so8275419eds.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 04:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=jZ2eCCMOz5RQFGcMqABMs+NIPaISx90MnYdaa+4iJS4=;
 b=FM+Z0jxuKLuWqzMDiIIpznohSRbkVF0ze4zmO28EWSf6ZjMeujfuLQ5s6VDHnDcm/K
 QU8yO+sOwRVKh3hdafBoNIsc/gP7v9copWR1Rn7HUWD0nrWFklpexLRi09fejVvnSQEN
 4OwuLMwFfc5sCodNSUwxqUjChjVPFzC8w6KXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jZ2eCCMOz5RQFGcMqABMs+NIPaISx90MnYdaa+4iJS4=;
 b=D+Jn9LS5p03fUMUEqxYst+MR/kxr8/g85ocOQqnIdHqfFHG/Ll7aVL/Ln/B8nIN+j7
 0HocmgiImit8lhM/XJSBrq7VAMcIzc8ZN6H5Egv4vRjIDn0Gx9B+Jxxfz6RllZi4WmOj
 B5ehQfy+RSm4jWr29VRyD7ypEzcUhNveKARN4IM3YGx4XO/AiRgpl0mlHzkzE2t88ajB
 LG0cBt3SryBQvq1A0qnMB+ZoIDG7hdSkxrrN/MsN3JbiernNyl9gTso81enk06j3mqrt
 x5Rfzqr8i1Po4qIj/ukHVmRtwshnsYqEV3Yef4SixnIxAHL1a+DmW8zVflRK7lM+0gE1
 rwaw==
X-Gm-Message-State: AOAM532GTRPSr8rBZTP5S0MY19s72sRfgJQ5xf/9TqYnTRZkSh2NrnmZ
 s/7s1jHurIktkaRzgPf8Ep3xzw==
X-Google-Smtp-Source: ABdhPJxNr3fYdRNIJHqqw2j6y005xSkYU/6DyrQLB/+bgKJiESX3b+DWZMriP/Dad33tkhxlyM6NCg==
X-Received: by 2002:a50:fd13:: with SMTP id i19mr16959833eds.375.1618917084518; 
 Tue, 20 Apr 2021 04:11:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id go38sm12118273ejc.40.2021.04.20.04.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Apr 2021 04:11:23 -0700 (PDT)
Date: Tue, 20 Apr 2021 13:11:21 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 0/9] drm: Support simple-framebuffer devices and
 firmware fbs
Message-ID: <YH622Ri2YJbNfBdA@phenom.ffwll.local>
References: <20210416090048.11492-1-tzimmermann@suse.de>
 <CAMuHMdWcC8O+UzQDQj7Bm4uK_myjFT5D2ccTmneTJYi4SMfCRQ@mail.gmail.com>
 <YH6U92Q71ntU6Z1R@phenom.ffwll.local>
 <CAMuHMdU7BXN0P29wqWo2w3BWr=vQ=UHZHUnfFbMC--29ZBph-w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdU7BXN0P29wqWo2w3BWr=vQ=UHZHUnfFbMC--29ZBph-w@mail.gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Cc: Rob Herring <robh@kernel.org>, bluescreen_avenger@verizon.net,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>,
 DRI Development <dri-devel@lists.freedesktop.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 virtualization@lists.linux-foundation.org, Hans de Goede <hdegoede@redhat.com>,
 Mark Brown <broonie@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
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

On Tue, Apr 20, 2021 at 11:16:09AM +0200, Geert Uytterhoeven wrote:
> Hi Daniel,
> 
> On Tue, Apr 20, 2021 at 10:46 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Mon, Apr 19, 2021 at 10:00:56AM +0200, Geert Uytterhoeven wrote:
> > > On Fri, Apr 16, 2021 at 11:00 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > > This patchset adds support for simple-framebuffer platform devices and
> > > > a handover mechanism for native drivers to take-over control of the
> > > > hardware.
> > > >
> > > > The new driver, called simpledrm, binds to a simple-frambuffer platform
> > > > device. The kernel's boot code creates such devices for firmware-provided
> > > > framebuffers, such as EFI-GOP or VESA. Typically the BIOS, UEFI or boot
> > > > loader sets up the framebuffers. Description via device tree is also an
> > > > option.
> > >
> > > I guess this can be used as a replacement for offb, too...
> > >
> > > > Patches 4 to 8 add the simpledrm driver. It's build on simple DRM helpers
> > > > and SHMEM. It supports 16-bit, 24-bit and 32-bit RGB framebuffers. During
> > >
> > > .... if support for 8-bit frame buffers would be added?
> >
> > Is that 8-bit greyscale or 8-bit indexed with 256 entry palette? Former
> 
> 8-bit indexed with 256 entry palette.
> 
> > shouldn't be a big thing, but the latter is only really supported by the
> > overall drm ecosystem in theory. Most userspace assumes that xrgb8888
> > works, and we keep that illusion up by emulating it in kernel for hw which
> > just doesn't support it. But reformatting xrgb8888 to c8 is tricky at
> > best. The uapis are all there for setting the palette, and C8 is a defined
> > format even with atomic kms interface, but really there's not much
> > userspace for it. In other words, it would work as well as current offb
> > would, but that's at least that.
> 
> Oh, that's good to know!
> Does this mean fbdev is not deprecated for anything <= C8? ;-)

Nope. It just means you wont be able to use drm-only userspace with it
most likely, without also investing a ton of effort into porting those
over.

> A while ago, I was looking into converting an fbdev driver to drm, and
> one of the things I ran into is lack of C4, C2, C1, Y8, Y4, Y2, and
> monochrome support.  On top of that, lots of internal code seems to
> assume pixels are never smaller than a byte (thus ignoring
> char_per_block[]/block_w).  The lack of support for planar modes isn't
> that bad, combined with the need for copying, as c2p conversion can be
> done while copying, thus even making life easier for userspace
> applications that can just always work on chunky data.
> Then real work kicked in, before I got anything working...

We support drm_fourcc, so adding more pixel formats is not problem at all.
Anything indexed/paletted will simply not work great with unchanged drm
userspace, because you can't really convert it over from the common
denominator of xrgb888. But if it's just about adding support, adding more
fourcc codes isn't a big deal. The fbdev layer hasn't been taught about
fourcc codes yet, but that's also just for lack of need by anyone.

Also we support abitrary uneven pixel packing too, with some generic
support for anything that's at least somewhat regular. That's been the
case for a while now. It was added for fancy tiling and compression
formats, but works equally well for anything else that's aligned different
than what can be described with simplistic bytes-per-pixel only.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
