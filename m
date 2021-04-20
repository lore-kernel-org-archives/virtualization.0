Return-Path: <SRS0=4Agt=JR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78372C433B4
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 09:16:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E409D6135F
	for <virtualization@archiver.kernel.org>; Tue, 20 Apr 2021 09:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E409D6135F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7C02F6063F;
	Tue, 20 Apr 2021 09:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8W_zsixi-AHc; Tue, 20 Apr 2021 09:16:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D6A060602;
	Tue, 20 Apr 2021 09:16:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E31EC000E;
	Tue, 20 Apr 2021 09:16:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E364C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2476C60800
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vBK4oKL2gmBP
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:16:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6095860602
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 09:16:22 +0000 (UTC)
Received: by mail-vs1-f53.google.com with SMTP id u22so8040039vsu.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Apr 2021 02:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uP55GvNxmqa154x7zBMI5pifzTMvppax2nMlHT01uhQ=;
 b=buMMl6+EwIDQehS44IFOEo6v6s0/aP5XEBdt1KJbLet0uP/jPt7jd2yGkBNoDAkGI/
 o6iv2Y8bjQbWelPGJVzKNzeC2OMYsMO52h1ncinPA/j79syl2Vv3PAYmqZm23QQ6AgPI
 v7dPxEIjWHe7CA/WqhYusZNzNOAeCq2KKdkvKVt9kBsee22Yr+spRr0aL3SOp+LFQ2JS
 /ePRv3GbM9fR4RZ1OC2wcyf6q5ZNJHdX1f4CS8D8zrn0VjshnOkV+pGCHDx9hYAFElx1
 7thhXd8Nk+mm5U40rWXJcObFqUN4dpYvDafPlLZFTu8J0t2JIINBtR4/kTQryVZKs00F
 nhcw==
X-Gm-Message-State: AOAM530BUvscsGZPKBz3BM/tD0tsYNPHqQj4J1990ni9O0+QN1v/WEkw
 /azIRFL2ccRc03SUbl8HOZs4NNlrdJtqqBHw6lU=
X-Google-Smtp-Source: ABdhPJyqjmGX3OnB4biL5E0m5o4GJ98N03BW81GWgSF08q3NwpxNGSQhoujnYb0pAPeIay+ye8/EKvIXD8MRF5C4Bbw=
X-Received: by 2002:a67:fc57:: with SMTP id p23mr19084812vsq.40.1618910181231; 
 Tue, 20 Apr 2021 02:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210416090048.11492-1-tzimmermann@suse.de>
 <CAMuHMdWcC8O+UzQDQj7Bm4uK_myjFT5D2ccTmneTJYi4SMfCRQ@mail.gmail.com>
 <YH6U92Q71ntU6Z1R@phenom.ffwll.local>
In-Reply-To: <YH6U92Q71ntU6Z1R@phenom.ffwll.local>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Apr 2021 11:16:09 +0200
Message-ID: <CAMuHMdU7BXN0P29wqWo2w3BWr=vQ=UHZHUnfFbMC--29ZBph-w@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] drm: Support simple-framebuffer devices and
 firmware fbs
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Herring <robh@kernel.org>, bluescreen_avenger@verizon.net,
 Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>,
 Emil Velikov <emil.l.velikov@gmail.com>,
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

Hi Daniel,

On Tue, Apr 20, 2021 at 10:46 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Mon, Apr 19, 2021 at 10:00:56AM +0200, Geert Uytterhoeven wrote:
> > On Fri, Apr 16, 2021 at 11:00 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > > This patchset adds support for simple-framebuffer platform devices and
> > > a handover mechanism for native drivers to take-over control of the
> > > hardware.
> > >
> > > The new driver, called simpledrm, binds to a simple-frambuffer platform
> > > device. The kernel's boot code creates such devices for firmware-provided
> > > framebuffers, such as EFI-GOP or VESA. Typically the BIOS, UEFI or boot
> > > loader sets up the framebuffers. Description via device tree is also an
> > > option.
> >
> > I guess this can be used as a replacement for offb, too...
> >
> > > Patches 4 to 8 add the simpledrm driver. It's build on simple DRM helpers
> > > and SHMEM. It supports 16-bit, 24-bit and 32-bit RGB framebuffers. During
> >
> > .... if support for 8-bit frame buffers would be added?
>
> Is that 8-bit greyscale or 8-bit indexed with 256 entry palette? Former

8-bit indexed with 256 entry palette.

> shouldn't be a big thing, but the latter is only really supported by the
> overall drm ecosystem in theory. Most userspace assumes that xrgb8888
> works, and we keep that illusion up by emulating it in kernel for hw which
> just doesn't support it. But reformatting xrgb8888 to c8 is tricky at
> best. The uapis are all there for setting the palette, and C8 is a defined
> format even with atomic kms interface, but really there's not much
> userspace for it. In other words, it would work as well as current offb
> would, but that's at least that.

Oh, that's good to know!
Does this mean fbdev is not deprecated for anything <= C8? ;-)

A while ago, I was looking into converting an fbdev driver to drm, and
one of the things I ran into is lack of C4, C2, C1, Y8, Y4, Y2, and
monochrome support.  On top of that, lots of internal code seems to
assume pixels are never smaller than a byte (thus ignoring
char_per_block[]/block_w).  The lack of support for planar modes isn't
that bad, combined with the need for copying, as c2p conversion can be
done while copying, thus even making life easier for userspace
applications that can just always work on chunky data.
Then real work kicked in, before I got anything working...

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
